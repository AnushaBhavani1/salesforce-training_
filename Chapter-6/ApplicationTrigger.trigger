trigger ApplicationTrigger on Application__c (before insert, after update) {

    if (Trigger.isBefore && Trigger.isInsert) {
        ApplicationService.validateApplications(Trigger.new);
    }

    if (Trigger.isAfter && Trigger.isUpdate) {
        ApplicationService.handleStatusUpdates(
            Trigger.new,
            Trigger.oldMap
        );
    }
}