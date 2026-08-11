@IsTest
private class ApplicationControllerTest {

    @IsTest
    static void testSubmitApplication() {

        Student__c student = new Student__c(
            Name = 'Test Student',
            CGPA__c = 8.5
        );
        insert student;

        Job__c job = new Job__c(
            Name = 'Test Developer',
            Minimum_CGPA__c = 7.0,
            Last_Date__c = Date.today().addDays(10)
        );
        insert job;

        Test.startTest();

        String result = ApplicationController.submitApplication(
            student.Id,
            job.Id
        );

        Test.stopTest();

        System.assertEquals(
            'Application submitted successfully.',
            result
        );
    }
}