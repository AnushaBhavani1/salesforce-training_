public with sharing class ApplicationTriggerHandler {

    public static void beforeInsert(List<Application__c> applications) {

        ApplicationService.validateApplications(applications);

    }

    public static void afterUpdate(
        List<Application__c> newList,
        Map<Id, Application__c> oldMap
    ) {

        ApplicationService.handleStatusUpdates(
            newList,
            oldMap
        );

    }

}