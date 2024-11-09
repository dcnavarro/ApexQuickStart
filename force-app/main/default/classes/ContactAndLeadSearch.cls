
public class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String searchString) {
        List<List<SObject>>
 results = new List<List<SObject>>();

        // Query for Contacts
        String contactQuery = 'SELECT Id, Name FROM Contact WHERE FirstName LIKE \'' + searchString + '%\' OR LastName LIKE \'' + searchString + '%\'';
        List<Contact> contacts = Database.query(contactQuery);
        results.add(contacts);

        // Query for Leads
        String leadQuery = 'SELECT Id, Name FROM Lead WHERE FirstName LIKE \'' + searchString + '%\' OR LastName LIKE \'' + searchString + '%\'';
        List<Lead> leads = Database.query(leadQuery);
        results.add(leads);

        return results;
    }
}