public with sharing class EligibleJobsController {

    @AuraEnabled(cacheable=true)
    public static List<Job__c> getJobs() {

        return [
            SELECT Id,
                   Name,
                   Company_Name__c,
                   Package__c,
                   Last_Date__c,
                   Minimum_CGPA__c,
                   Eligible_Branch__c,
                   Allowed_Backlogs__c
            FROM Job__c
        ];
    }


    @AuraEnabled
    public static String applyForJob(
        Id studentId,
        Id jobId
    ) {

        return ApplicationService.submitApplication(
            studentId,
            jobId
        );
    }
}