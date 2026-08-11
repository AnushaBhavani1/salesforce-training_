public class PlacementBatch implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Status__c FROM Application__c'
        );
    }

    public void execute(Database.BatchableContext bc, List<Application__c> scope) {
        System.debug('Processing ' + scope.size() + ' applications');
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('===== BATCH COMPLETED =====');
    }
}