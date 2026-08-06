global class PlacementBatch implements Database.Batchable<SObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {

        return Database.getQueryLocator(
            'SELECT Id, Status__c FROM Application__c'
        );
    }

    global void execute(Database.BatchableContext bc, List<Application__c> scope) {

        for (Application__c app : scope) {
            System.debug('Processing Application: ' + app.Id);
        }
    }

    global void finish(Database.BatchableContext bc) {

        System.debug('Batch Completed');
    }
}