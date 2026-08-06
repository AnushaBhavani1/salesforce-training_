public class OfferProcessingJob implements Queueable {

    private Id applicationId;

    public OfferProcessingJob(Id appId) {
        this.applicationId = appId;
    }

    public void execute(QueueableContext context) {

        System.debug('Queueable Job Started');

        StatisticsService.updatePlacementStatistics();

        NotificationService.sendApplicationEmail(applicationId);

        System.debug('Queueable Job Completed');
    }
}