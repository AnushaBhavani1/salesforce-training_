public with sharing class ApplicationService {

    public static String submitApplication(Id studentId, Id jobId) {

        // Check duplicate application
        List<Application__c> existing = [
            SELECT Id
            FROM Application__c
            WHERE Student__c = :studentId
            AND Job__c = :jobId
        ];

        if (!existing.isEmpty()) {
            return 'Application already exists.';
        }

        // Fetch Student
        Student__c student = [
            SELECT Id, CGPA__c
            FROM Student__c
            WHERE Id = :studentId
            LIMIT 1
        ];

        // Fetch Job
        Job__c job = [
            SELECT Id, Minimum_CGPA__c
            FROM Job__c
            WHERE Id = :jobId
            LIMIT 1
        ];

        // Eligibility Check
        if (student.CGPA__c < job.Minimum_CGPA__c) {
            return 'Student is not eligible.';
        }

        // Create Application
        Application__c app = new Application__c();

        app.Student__c = studentId;
        app.Job__c = jobId;
        app.Application_Date__c = Date.today();
        app.Status__c = 'Applied';

        insert app;

        return 'Application submitted successfully.';
    }
}