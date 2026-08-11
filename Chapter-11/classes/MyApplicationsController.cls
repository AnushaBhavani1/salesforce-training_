public with sharing class MyApplicationsController {

    @AuraEnabled(cacheable=true)
    public static List<Application__c> getMyApplications() {

        String userEmail = UserInfo.getUserEmail();

        List<Student__c> students = [
            SELECT Id
            FROM Student__c
            WHERE Email__c = :userEmail
            LIMIT 1
        ];

        if (students.isEmpty()) {
            return new List<Application__c>();
        }

        Id studentId = students[0].Id;

        return [
            SELECT Id,
                   Name,
                   Application_Date__c,
                   Status__c,
                   Student__c,
                   Job__c,
                   Job__r.Name,
                   Job__r.Company_Name__c,
                   Job__r.Package__c
            FROM Application__c
            WHERE Student__c = :studentId
            ORDER BY Application_Date__c DESC
        ];
    }
}