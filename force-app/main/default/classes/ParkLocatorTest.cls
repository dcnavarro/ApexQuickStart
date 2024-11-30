@isTest
private class ParkLocatorTest {
    
    @isTest
    static void testcountry() {
        // Set mock callout class
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        
        // Test with different valid countries
        List<String> parksGermany = ParkLocator.country('Germany');
        List<String> parksIndia = ParkLocator.country('India');
        List<String> parksJapan = ParkLocator.country('Japan');
        List<String> parksUSA = ParkLocator.country('United States');
        
        // Verify that the responses received contain the expected values
        System.assertEquals(new List<String>{'Berlin Park', 'Munich Park'}, parksGermany, 'Expected parks in Germany');
        System.assertEquals(new List<String>{'National Park', 'Tiger Reserve'}, parksIndia, 'Expected parks in India');
        System.assertEquals(new List<String>{'Tokyo Park', 'Osaka Park'}, parksJapan, 'Expected parks in Japan');
        System.assertEquals(new List<String>{'Yosemite', 'Grand Canyon'}, parksUSA, 'Expected parks in United States');
        
        // Test with an unknown country
        List<String> parksUnknown = ParkLocator.country('Unknown');
        System.assertEquals(new List<String>(), parksUnknown, 'Expected no parks for unknown country');
    }
}
