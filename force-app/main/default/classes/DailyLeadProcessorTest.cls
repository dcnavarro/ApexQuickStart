@isTest
public class DailyLeadProcessorTest {
    
    @isTest
    public static void testDailyLeadProcessor() {
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

        // Schedule the DailyLeadProcessor class
        Test.startTest();
        String cronExp = '0 0 0 * * ?'; // Run once at midnight
        DailyLeadProcessor job = new DailyLeadProcessor();
        System.schedule('Daily Lead Processor Job', cronExp, job);
        Test.stopTest();

        // Simulate the execution of the scheduled job
        Test.startTest();
        Id jobId = System.enqueueJob(job);
        Test.stopTest();

        // Verify that LeadSource is updated to 'Dreamforce' for all leads
        List<Lead> updatedLeads = [SELECT LeadSource FROM Lead WHERE Id IN :leads];
        for (Lead lead : updatedLeads) {
            System.assertEquals('Dreamforce', lead.LeadSource, 'LeadSource should be updated to "Dreamforce"');
        }
    }
}
