public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer numberOfContacts, String contactsLastName) {
        List<Contact> newContacts = new List<Contact>();

        for (Integer i = 0; i < numberOfContacts; i++) {
            // Generate a unique first name based on the iterated number
            String firstName = 'Test ' + i;

            // Create a new contact with the generated first name and provided last name
            Contact newContact = new Contact(FirstName = firstName, LastName = contactsLastName);

            // Add the contact to the list of new contacts for later insertion
            newContacts.add(newContact);
        }

        // Return the list of new contacts
        return newContacts;
    }
}
