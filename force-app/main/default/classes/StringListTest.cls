public class StringListTest {
    public static List<String> generateStringList(Integer n) {
        List<String> stringList = new List<String>();
        for (Integer i = 0; i < n; i++) {
            stringList.add('Test ' + i);
        }
        return stringList;
    }
}

//Debug: Anonymous window
// List<String> myList = StringListTest.generateStringList(5);
// System.debug(myList)

// Apex Collections
// The colors variable can be declared as a list or as an array
// List<String> colors = new List<String>();
// String[] colors = new List<String>();
// The List.add() method can be used to add new elements
// Create a list and add elements to it in one step
// List<String> colors = new List<String> { 'red', 'green', 'blue' };
// Add elements to a list after it has been created
// List<String> moreColors = new List<String>();
// moreColors.add('orange');
// moreColors.add('purple');
// Get elements from a list
// String color1 = moreColors.get(0);
// String color2 = moreColors[0];
// System.assertEquals(color1, color2);
// Iterate over a list to read elements
// System.debug('Print out the colors in moreColors:');
// for(String color : moreColors) {
//     Write value to the debug log
//     System.debug(color);
// }
//Apex supports two other collection types: Set and Map.

// To create an sObject, you need to declare a variable and assign an sObject instance to it. The data type of the variable is the sObject type.
// The following example creates an sObject of type Account with the name Acme and assigns it to the acct variable.
// Account acct = new Account();
// acct.Name = 'Acme';
// acct.Phone = '(415)555-1212';
// acct.NumberOfEmployees = 100;
// A custom object with a label of Merchandise has an API name of Merchandise__c.
// A custom field with a label of Description has an API name of Description__c.
// A custom relationship field with a label of Items has an API name of Items__r.

// To be able to access fields using dot notation in an sObject, you should cast it:
// Cast a generic sObject to an Account
// Account acct = (Account)myGenericSObject;
// Now, you can use the dot notation to access fields on Account
// String name = acct.Name;
// String phone = acct.Phone;
// The fields of a generic sObject can be accessed only through the put() and get() methods.

// Create and modify records in Salesforce can be done by using the Data Manipulation Language. DML provides a straightforward way to manage records by providing simple statements to insert, update, merge, delete, and restore records.
// Create the account sObject
// Account acct = new Account(Name='Acme', Phone='(415)555-1212', NumberOfEmployees=100);
// Insert the account by using DML
// insert acct;
// Get the new ID on the inserted sObject argument
// ID acctID = acct.Id;
// Display this ID in the debug log
// System.debug('ID = ' + acctID);

// Bulk DML
// Create a list of contacts
// List<Contact> conList = new List<Contact> {
//     new Contact(FirstName='Joe',LastName='Smith',Department='Finance'),
//         new Contact(FirstName='Kathy',LastName='Smith',Department='Technology'),
//         new Contact(FirstName='Caroline',LastName='Roth',Department='Finance'),
//         new Contact(FirstName='Kim',LastName='Shain',Department='Education')};
// Bulk insert all contacts with one DML call
// insert conList;
// List to hold the new contacts to update
// List<Contact> listToUpdate = new List<Contact>();
// Iterate through the list and add a title only
// if the department is Finance
// for(Contact con : conList) {
//     if (con.Department == 'Finance') {
//         con.Title = 'Financial analyst';
//         Add updated contact sObject to the list.
//         listToUpdate.add(con);
//     }
// }
// Bulk update all contacts with one DML call
// update listToUpdate;

// If a relationship has already been defined between the two objects, such as a lookup or master-detail relationship. }
// Account acct = new Account(Name='SFDC Account');
// insert acct;
// // Once the account is inserted, the sObject will be
// // populated with an ID.
// // Get this ID.
// ID acctID = acct.ID;
// // Add a contact to this account.
// Contact mario = new Contact(
//     FirstName='Mario',
//     LastName='Ruiz',
//     Phone='415.555.1212',
//     AccountId=acctID);
// insert mario;

// Update related records
// // Query for the contact, which has been associated with an account.
// Contact queriedContact = [SELECT Account.Name
//                           FROM Contact
//                           WHERE FirstName = 'Mario' AND LastName='Ruiz'
//                           LIMIT 1];
// // Update the contact's phone number
// queriedContact.Phone = '(415)555-1213';
// // Update the related account industry
// queriedContact.Account.Industry = 'Technology';
// // Make two separate calls
// // 1. This call is to update the contact's phone.
// update queriedContact;
// // 2. This call is to update the related account's Industry field.
// update queriedContact.Account;

// Delete related records
// The delete operation supports cascading deletions. If you delete a parent object, you delete its children automatically, as long as each child record can be deleted.

//SOQL
// To read a record from Salesforce, you must write a query. Salesforce provides the Salesforce Object Query Language, or SOQL in short, that you can use to read saved records.
// Account[] accts = [SELECT Name,Phone FROM Account];
// Account[] accts = [SELECT Name,Phone FROM Account
//                    WHERE (Name='SFDC Computing' AND NumberOfEmployees>25)
//                    ORDER BY Name
//                    LIMIT 10];
// System.debug(accts.size() + ' account(s) returned.');
// // Write all account array info
// System.debug(accts);
// String targetDepartment = 'Wingo';
// Contact[] techContacts = [SELECT FirstName,LastName
//                           FROM Contact WHERE Department=:targetDepartment];