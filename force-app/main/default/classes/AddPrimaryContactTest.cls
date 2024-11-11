@isTest
public class AddPrimaryContactTest {
    
    @isTest
    public static void testAddPrimaryContact() {
        // Create 50 Account records for NY
        List<Account> nyAccounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            nyAccounts.add(new Account(Name = 'NY Account ' + i, BillingState = 'NY'));
        }
        insert nyAccounts;

        // Create 50 Account records for CA
        List<Account> caAccounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            caAccounts.add(new Account(Name = 'CA Account ' + i, BillingState = 'CA'));
        }
        insert caAccounts;

        // Create a Contact to use in the Queueable class
        Contact newContact = new Contact(FirstName = 'John', LastName = 'Doe', Email = 'john.doe@example.com');

        // Enqueue the AddPrimaryContact job
        Test.startTest();
        AddPrimaryContact job = new AddPrimaryContact(newContact, 'CA');
        System.enqueueJob(job);
        Test.stopTest();

        // Verify that a Contact was inserted for each CA Account
        List<Contact> insertedContacts = [SELECT Id, AccountId FROM Contact WHERE Email = 'john.doe@example.com'];
        System.assertEquals(50, insertedContacts.size(), '50 Contacts should be inserted for CA Accounts');

        // Verify the contacts are associated with the correct accounts
        Set<Id> caAccountIds = new Set<Id>();
        for (Account acc : caAccounts) {
            caAccountIds.add(acc.Id);
        }

        for (Contact con : insertedContacts) {
            System.assert(caAccountIds.contains(con.AccountId), 'Contact should be associated with a CA Account');
        }
    }
}
