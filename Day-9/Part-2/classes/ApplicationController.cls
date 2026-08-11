public with sharing class ApplicationController {

    @AuraEnabled
    public static String submitApplication(Id studentId, Id jobId) {

        return ApplicationService.submitApplication(
            studentId,
            jobId
        );
    }
}