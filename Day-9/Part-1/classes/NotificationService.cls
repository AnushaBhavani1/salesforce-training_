public class NotificationService {

    @future
     public static void sendApplicationEmail(Id applicationId) {

        System.debug('=== FUTURE METHOD START ===');
        System.debug('Sending email for Application: ' + applicationId);
        System.debug('=== FUTURE METHOD END ===');

    }

    public static void sendSelectionNotification(Id applicationId) {

        sendApplicationEmail(applicationId);

    }
}