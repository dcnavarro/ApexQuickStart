@isTest
public class LeadProcessorTest {
    
    @isTest
    public static void testLeadProcessor() {
        // Create 200 Lead records
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            leads.add(new Lead(FirstName = 'Test', LastName = 'Lead' + i, Company = 'Test Company'));
        }
        insert leads;
        
        // Verify that LeadSource is initially null
        for (Lead lead : [SELECT LeadSource FROM Lead WHERE Id IN :leads]) {
            System.assertEquals(null, lead.LeadSource, 'LeadSource should initially be null');
        }

        // Execute the LeadProcessor batch
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        // Set the batch size to 200 to ensure it runs in a single batch
        Database.executeBatch(lp, 200);
        Test.stopTest();

        // Verify that LeadSource is updated to 'Dreamforce' for all leads
        for (Lead lead : [SELECT LeadSource FROM Lead WHERE Id IN :leads]) {
            System.assertEquals('Dreamforce', lead.LeadSource, 'LeadSource should be updated to "Dreamforce"');
        }

        // Check that the recordsProcessed variable is updated correctly
        LeadProcessor processor = (LeadProcessor) JSON.deserialize(JSON.serialize(lp), LeadProcessor.class);
        System.assertEquals(200, processor.recordsProcessed, 'Should have processed 200 records');
    }
}
