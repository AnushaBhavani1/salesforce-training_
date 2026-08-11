public class OfferProcessingJob implements Queueable {

    private Id applicationId;

    public OfferProcessingJob(Id applicationId) {
        this.applicationId = applicationId;
    }

    public void execute(QueueableContext context) {

        try {

            // Send selected candidate to external recruitment API
            System.enqueueJob(
                new CandidateSyncQueueable(applicationId)
            );

        } catch (Exception e) {

            System.debug(
                'OfferProcessingJob Error: ' +
                e.getMessage()
            );
        }
    }
}