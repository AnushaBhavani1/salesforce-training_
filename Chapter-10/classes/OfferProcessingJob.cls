public class OfferProcessingJob implements Queueable {

    private Id applicationId;

    public OfferProcessingJob(Id applicationId){
        this.applicationId = applicationId;
    }

    public void execute(QueueableContext context){

    try{

        ExternalPlacementService.syncApplication(applicationId);

        System.enqueueJob(new PlacementNotificationJob(applicationId));

    }
    catch(Exception e){

        System.debug('Error : '+e.getMessage());

    }

}
}