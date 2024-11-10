public class AccountProcessor {
    @future
    public static void countContacts(Set<Id> accountIds) {
        // Map to store the number of contacts per account
        Map<Id, Integer> accountContactCounts = new Map<Id, Integer>();

        // Query to get the count of contacts for each account
        List<AggregateResult> results = [SELECT AccountId, COUNT(Id) contactCount 
                                         FROM Contact 
                                         WHERE AccountId IN :accountIds 
                                         GROUP BY AccountId];

        // Populate the map with the contact counts
        for (AggregateResult result : results) {
            Id accountId = (Id)result.get('AccountId');
            Integer contactCount = (Integer)result.get('contactCount');
            accountContactCounts.put(accountId, contactCount);
        }

        // List to hold accounts for update
        List<Account> accountsToUpdate = new List<Account>();

        // Iterate through the account IDs to update the Number_Of_Contacts__c field
        for (Id accountId : accountIds) {
            // Check if the account is in the map
            if (accountContactCounts.containsKey(accountId)) {
                accountsToUpdate.add(new Account(Id = accountId, Number_Of_Contacts__c = accountContactCounts.get(accountId)));
            } else {
                // If no contacts are found, set the field to 0
                accountsToUpdate.add(new Account(Id = accountId, Number_Of_Contacts__c = 0));
            }
        }

        // Update the accounts
        update accountsToUpdate;
    }
}
