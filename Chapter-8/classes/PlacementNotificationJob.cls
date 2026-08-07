public class PlacementNotificationJob implements Queueable {

    private Id applicationId;

    public PlacementNotificationJob(Id applicationId){
        this.applicationId = applicationId;
    }

    public void execute(QueueableContext context){

        System.debug('Preparing notification for Application: ' + applicationId);

    }
}