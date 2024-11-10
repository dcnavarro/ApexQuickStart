@isTest
public class TestRestrictContactByName {
    
    @isTest
    public static void testInvalidLastName() {
        // Create a contact with an invalid last name
        Contact invalidContact = new Contact(FirstName = 'Test', LastName = 'INVALIDNAME');
        
        Test.startTest();
        try {
            // Attempt to insert the invalid contact and expect an exception
            insert invalidContact;
            System.assert(false, 'Expected exception was not thrown');
        } catch (DmlException e) {
            // Verify the error message
            System.assert(e.getMessage().contains('The Last Name "INVALIDNAME" is not allowed for DML'));
        }
        Test.stopTest();
    }

    @isTest
    public static void testValidLastName() {
        // Create a contact with a valid last name
        Contact validContact = new Contact(FirstName = 'Test', LastName = 'VALIDNAME');
        
        Test.startTest();
        // Attempt to insert the valid contact
        insert validContact;
        Test.stopTest();
        
        // Verify the contact was inserted
        System.assertNotEquals(null, validContact.Id, 'Contact was not inserted');
    }
}
