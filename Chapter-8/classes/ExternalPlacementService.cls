public class ExternalPlacementService {

    @future(callout=true)
    public static void syncApplication(Id applicationId) {

        System.debug('=== FUTURE METHOD START ===');
        System.debug('Synchronizing Application with External System: ' + applicationId);

        // Simulate external API call

        System.debug('=== FUTURE METHOD END ===');
    }
}