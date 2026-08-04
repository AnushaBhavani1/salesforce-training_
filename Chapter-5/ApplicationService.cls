public with sharing class ApplicationService {

    // Submit Application
    public static String submitApplication(Id studentId, Id jobId) {

        // Check Duplicate
        List<Application__c> existingApplications = [
            SELECT Id
            FROM Application__c
            WHERE Student__c = :studentId
            AND Job__c = :jobId
        ];

        if (!existingApplications.isEmpty()) {
            return 'Application already exists.';
        }

        // Retrieve Student
        List<Student__c> students = [
            SELECT Id, Name, CGPA__c
            FROM Student__c
            WHERE Id = :studentId
        ];

        if (students.isEmpty()) {
            return 'Student not found.';
        }

        Student__c student = students[0];

        // Retrieve Job
        List<Job__c> jobs = [
            SELECT Id,
                   Name,
                   Minimum_CGPA__c,
                   Last_Date__c
            FROM Job__c
            WHERE Id = :jobId
        ];

        if (jobs.isEmpty()) {
            return 'Job not found.';
        }

        Job__c job = jobs[0];

        // Check Last Date
        if (job.Last_Date__c != null && Date.today() > job.Last_Date__c) {
            return 'Application deadline has passed.';
        }

        // Check CGPA
        if (student.CGPA__c < job.Minimum_CGPA__c) {
            return 'Student is not eligible.';
        }

        // Create Application
        Application__c app = new Application__c();
        app.Student__c = studentId;
        app.Job__c = jobId;
        app.Application_Date__c = Date.today();
        app.Status__c = 'Applied';

        try {
            insert app;
            return 'Application submitted successfully.';
        } catch (Exception e) {
            return 'Error: ' + e.getMessage();
        }
    }

    // Update Status
    public static String updateApplicationStatus(Id applicationId, String newStatus) {

        List<Application__c> apps = [
            SELECT Id, Status__c
            FROM Application__c
            WHERE Id = :applicationId
        ];

        if (apps.isEmpty()) {
            return 'Application not found.';
        }

        Application__c app = apps[0];
        app.Status__c = newStatus;

        update app;

        return 'Application status updated successfully.';
    }

    // Get Student
    public static Student__c getStudent(Id studentId) {

        List<Student__c> students = [
            SELECT Id, Name, CGPA__c
            FROM Student__c
            WHERE Id = :studentId
        ];

        if (students.isEmpty()) {
            return null;
        }

        return students[0];
    }

    // Get Job
    public static Job__c getJob(Id jobId) {

        List<Job__c> jobs = [
            SELECT Id, Name, Minimum_CGPA__c, Last_Date__c
            FROM Job__c
            WHERE Id = :jobId
        ];

        if (jobs.isEmpty()) {
            return null;
        }

        return jobs[0];
    }

    // Check Duplicate
    public static Boolean isDuplicate(Id studentId, Id jobId) {

        Integer countApplications = [
            SELECT COUNT()
            FROM Application__c
            WHERE Student__c = :studentId
            AND Job__c = :jobId
        ];

        return countApplications > 0;
    }
}