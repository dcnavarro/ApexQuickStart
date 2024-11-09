// The EmailManager class has a public method (sendMail()) that sends email and uses built-in Messaging methods of the Apex class library. Also, this class has a private helper method (inspectResults()), which can’t be called externally because it is private but is used only within the class. This helper method inspects the results of the email send call and is called by sendMail().

public class EmailManager {
    // Public method

    // We can change sendEmail to a static method by adding the static keyword to its declaration. Static methods are easier to call than instance methods because they don’t need to be called on an instance of the class but are called directly on the class name.
    // public static void sendMail(String address, String subject, String body)

    public void sendMail(String address, String subject, String body) {
        // Create an email message object
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {address};
        mail.setToAddresses(toAddresses);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        // Pass this email message to the built-in sendEmail method
        // of the Messaging class
        Messaging.SendEmailResult[] results = Messaging.sendEmail(
                                 new Messaging.SingleEmailMessage[] { mail });
        // Call a helper method to inspect the returned results
        inspectResults(results);
    }
    // Helper method
    private static Boolean inspectResults(Messaging.SendEmailResult[] results) {
        Boolean sendResult = true;
        // sendEmail returns a list of result objects.
        // Iterate through the list to inspect results.
        // In this class, the methods send only one email,
        // so we should have only one result.
        for (Messaging.SendEmailResult res : results) {
            if (res.isSuccess()) {
                System.debug('Email sent successfully');
            }
            else {
                sendResult = false;
                System.debug('The following errors occurred: ' + res.getErrors());
            }
        }
        return sendResult;
    }
}

//Debug: Anonymous window
// EmailManager em = new EmailManager();
// em.sendMail('Your email address', 'Trailhead Tutorial', '123 body');

// Or, for an static method:
// EmailManager.sendMail('Your email address', 'Trailhead Tutorial', '123 body');

// public class EmailManager {
//     // Public method
//     public static void sendMail(String address, String subject, String body) {
//         // Create an email message object
//         Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
//         String[] toAddresses = new String[] {address};
//         mail.setToAddresses(toAddresses);
//         mail.setSubject(subject);
//         mail.setPlainTextBody(body);
//         // Pass this email message to the built-in sendEmail method
//         // of the Messaging class
//         Messaging.SendEmailResult[] results = Messaging.sendEmail(
//                                   new Messaging.SingleEmailMessage[] { mail });
//         // Call a helper method to inspect the returned results
//         inspectResults(results);
//     }
//     // Helper method
//     private static Boolean inspectResults(Messaging.SendEmailResult[] results) {
//         Boolean sendResult = true;
//         // sendEmail returns an array of result objects.
//         // Iterate through the list to inspect results.
//         // In this class, the methods send only one email,
//         // so we should have only one result.
//         for (Messaging.SendEmailResult res : results) {
//             if (res.isSuccess()) {
//                 System.debug('Email sent successfully');
//             }
//             else {
//                 sendResult = false;
//                 System.debug('The following errors occurred: ' + res.getErrors());
//             }
//         }
//         return sendResult;
//     }
// }