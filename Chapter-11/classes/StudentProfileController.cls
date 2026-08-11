public with sharing class StudentProfileController {

    @AuraEnabled(cacheable=true)
    public static Student__c getCurrentStudent() {

        String userEmail =
            UserInfo.getUserEmail();


        List<Student__c> students = [
            SELECT Id,
                   Name,
                   Email__c,
                   Phone__c,
                   Roll_Number__c,
                   Department__c,
                   CGPA__c,
                   Active_Backlogs__c
            FROM Student__c
            WHERE Email__c = :userEmail
            LIMIT 1
        ];


        if (students.isEmpty()) {

            throw new AuraHandledException(
                'No Student record found for the logged-in user.'
            );
        }


        return students[0];
    }
}