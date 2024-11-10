@isTest
public class AccountProcessorTest {
    
    @isTest
    public static void testCountContacts() {
        // Create test data
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 3; i++) {
            accounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert accounts;
        
        List<Contact> contacts = new List<Contact>();
        contacts.add(new Contact(FirstName = 'Contact', LastName = 'One', AccountId = accounts[0].Id));
        contacts.add(new Contact(FirstName = 'Contact', LastName = 'Two', AccountId = accounts[1].Id));
        contacts.add(new Contact(FirstName = 'Contact', LastName = 'Three', AccountId = accounts[1].Id));
        insert contacts;

        // Create a set of account IDs for the test
        Set<Id> accountIds = new Set<Id>();
        for (Account acc : accounts) {
            accountIds.add(acc.Id);
        }

        // Call the future method
        Test.startTest();
        AccountProcessor.countContacts(accountIds);
        Test.stopTest();

        // Query the accounts again to verify the updates
        accounts = [SELECT Id, Number_Of_Contacts__c FROM Account WHERE Id IN :accountIds];

        // Verify the counts
        System.assertEquals(1, accounts[0].Number_Of_Contacts__c, 'Account 0 should have 1 contact');
        System.assertEquals(2, accounts[1].Number_Of_Contacts__c, 'Account 1 should have 2 contacts');
        System.assertEquals(0, accounts[2].Number_Of_Contacts__c, 'Account 2 should have 0 contacts');
    }
}
