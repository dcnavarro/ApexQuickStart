@isTest
public class AnimalLocatorTest {

    @isTest
    static void testGetAnimalNameById_MultipleCalls() {
        // Set mock callout class
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());

        // Test with valid IDs
        String animalName1 = AnimalLocator.getAnimalNameById(1);
        String animalName2 = AnimalLocator.getAnimalNameById(2);
        System.assertEquals('majestic badger', animalName1, 'Expected animal name to be "majestic badger"');
        System.assertEquals('fluffy kitten', animalName2, 'Expected animal name to be "fluffy kitten"');

        // Test with invalid ID
        String invalidAnimalName = AnimalLocator.getAnimalNameById(-1);
        System.assertEquals('Animal not found', invalidAnimalName, 'Expected animal name to be "Animal not found" for invalid ID');
    }
}
