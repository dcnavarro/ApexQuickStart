public class ContactSearch {
    public static List<Contact> searchForContacts(String lastName, String zipCode) {
        // Dynamic SOQL query to match the provided parameters
        String query = 'SELECT Id, Name FROM Contact WHERE LastName LIKE \'' + lastName + '%\' AND MailingPostalCode = \'' + zipCode + '\'';

        // Execute the query and return the list of matching contacts
        return Database.query(query);
    }
}