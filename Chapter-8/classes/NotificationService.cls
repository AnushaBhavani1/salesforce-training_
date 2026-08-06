public class NotificationService {

    @future
    public static void sendApplicationEmail(Id applicationId) {

        System.debug('Sending Email for Application: ' + applicationId);

    }

    public static void sendSelectionNotification(Id applicationId) {

        sendApplicationEmail(applicationId);

    }
}