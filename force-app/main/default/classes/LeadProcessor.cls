public class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful {
    // instance member to retain state across transactions
    public Integer recordsProcessed = 0;

    // QueryLocator to collect all Lead records in the org
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id FROM Lead');
    }

    // Execute method to update LeadSource for all leads
    public void execute(Database.BatchableContext bc, List<sObject> scope) {
        List<Lead> leadsToUpdate = new List<Lead>();

        for (sObject obj : scope) {
            Lead lead = (Lead)obj;
            lead.LeadSource = 'Dreamforce';
            leadsToUpdate.add(lead);
        }

        update leadsToUpdate;

        // Track number of records processed
        recordsProcessed += leadsToUpdate.size();
    }

    // Finish method
    public void finish(Database.BatchableContext bc) {
        System.debug(recordsProcessed + ' records processed. Shazam!');
    }
}
