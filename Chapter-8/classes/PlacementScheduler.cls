global class PlacementScheduler implements Schedulable {

    global void execute(SchedulableContext sc) {

        Database.executeBatch(new PlacementBatch(), 200);

    }
}