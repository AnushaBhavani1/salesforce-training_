public with sharing class ApplicationService {

    // Submit Application
    public static String submitApplication(Id studentId, Id jobId) {

        if (isDuplicate(studentId, jobId)) {
            return 'Application already exists.';
        }

        Student__c student = getStudent(studentId);
        if (student == null) {
            return 'Student not found.';
        }

        Job__c job = getJob(jobId);
        if (job == null) {
            return 'Job not found.';
        }

        if (job.Last_Date__c != null && Date.today() > job.Last_Date__c) {
            return 'Application deadline has passed.';
        }

        if (student.CGPA__c < job.Minimum_CGPA__c) {
            return 'Student is not eligible.';
        }

        Application__c app = new Application__c(
            Student__c = studentId,
            Job__c = jobId,
            Application_Date__c = Date.today(),
            Status__c = 'Applied'
        );

        insert app;

        return 'Application submitted successfully.';
    }

    // Update Status
    public static String updateApplicationStatus(Id applicationId, String newStatus) {

        Application__c app = [
            SELECT Id, Status__c
            FROM Application__c
            WHERE Id=:applicationId
            LIMIT 1
        ];

        app.Status__c = newStatus;

        update app;

        return 'Application status updated successfully.';
    }

    // Get Student
    public static Student__c getStudent(Id studentId){

        List<Student__c> students=[
            SELECT Id,Name,CGPA__c
            FROM Student__c
            WHERE Id=:studentId
        ];

        return students.isEmpty() ? null : students[0];
    }

    // Get Job
    public static Job__c getJob(Id jobId){

        List<Job__c> jobs=[
            SELECT Id,Name,Minimum_CGPA__c,Last_Date__c
            FROM Job__c
            WHERE Id=:jobId
        ];

        return jobs.isEmpty() ? null : jobs[0];
    }

    // Duplicate Check
    public static Boolean isDuplicate(Id studentId, Id jobId){

        Integer countApp=[
            SELECT COUNT()
            FROM Application__c
            WHERE Student__c=:studentId
            AND Job__c=:jobId
        ];

        return countApp>0;
    }

    // Trigger Validation
    public static void validateApplications(List<Application__c> applications) {

    Set<Id> studentIds = new Set<Id>();
    Set<Id> jobIds = new Set<Id>();

    for (Application__c app : applications) {

        if (app.Student__c != null)
            studentIds.add(app.Student__c);

        if (app.Job__c != null)
            jobIds.add(app.Job__c);
    }

    Map<Id, Student__c> students = new Map<Id, Student__c>([
        SELECT Id,
               CGPA__c,
               Active_Backlogs__c,
               Department__c
        FROM Student__c
        WHERE Id IN :studentIds
    ]);

    Map<Id, Job__c> jobs = new Map<Id, Job__c>([
        SELECT Id,
               Minimum_CGPA__c,
               Allowed_Backlogs__c,
               Eligible_Branch__c
        FROM Job__c
        WHERE Id IN :jobIds
    ]);

    for (Application__c app : applications) {

        Student__c student = students.get(app.Student__c);
        Job__c job = jobs.get(app.Job__c);

        if (student == null) {
            app.addError('Student not found.');
            continue;
        }

        if (job == null) {
            app.addError('Job not found.');
            continue;
        }

        if (student.CGPA__c < job.Minimum_CGPA__c) {
            app.addError('CGPA is below the minimum requirement.');
        }

        if (student.Active_Backlogs__c > job.Allowed_Backlogs__c) {
            app.addError('Too many active backlogs.');
        }

        if (student.Department__c != job.Eligible_Branch__c) {
            app.addError('Student branch is not eligible.');
        }
    }
}
    // Trigger After Update
   public static void handleStatusUpdates(
    List<Application__c> newList,
    Map<Id,Application__c> oldMap){

    System.debug('=== HANDLE STATUS UPDATE START ===');

    for(Application__c app:newList){

        Application__c oldApp = oldMap.get(app.Id);

        System.debug('Old Status: ' + oldApp.Status__c);
        System.debug('New Status: ' + app.Status__c);

        if(oldApp.Status__c != app.Status__c &&
           app.Status__c == 'Selected'){

            System.debug('STATUS CHANGED TO SELECTED');

            StatisticsService.updatePlacementStatistics();

            NotificationService.sendSelectionNotification(app.Id);
        }
    }

    System.debug('=== HANDLE STATUS UPDATE END ===');
}
}