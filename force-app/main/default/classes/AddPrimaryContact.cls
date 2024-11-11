public class AddPrimaryContact implements Queueable {
    private Contact contact;
    private String stateAbbreviation;

    // Constructor
    public AddPrimaryContact(Contact contact, String stateAbbreviation) {
        this.contact = contact;
        this.stateAbbreviation = stateAbbreviation;
    }

    // Execute method
    public void execute(QueueableContext context) {
        // Query for accounts with the specified BillingState
        List<Account> accounts = [SELECT Id FROM Account WHERE BillingState = :stateAbbreviation LIMIT 200]; // Adjust LIMIT as needed

        // List to hold new contact records
        List<Contact> contactsToInsert = new List<Contact>();

        // Clone the contact for each account and associate it with the account
        for (Account account : accounts) {
            Contact clonedContact = contact.clone(false, true, true, true);
            clonedContact.AccountId = account.Id;
            contactsToInsert.add(clonedContact);
        }

        // Insert the new contact records
        if (!contactsToInsert.isEmpty()) {
            insert contactsToInsert;
        }
    }
}
