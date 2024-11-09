// trigger SoqlTriggerBulk on Account(after update) {
//     // Perform SOQL query once.
//     // Get the accounts and their related opportunities.
//     List<Account> acctsWithOpps =
//         [SELECT Id,(SELECT Id,Name,CloseDate FROM Opportunities)
//          FROM Account WHERE Id IN :Trigger.new];
//     // Iterate over the returned accounts
//     for(Account a : acctsWithOpps) {
//         Opportunity[] relatedOpps = a.Opportunities;
//         // Do some other processing
//     }
// }

// trigger SoqlTriggerBulk on Account(after update) {
//     // Perform SOQL query once.
//     // Get the related opportunities for the accounts in this trigger.
//     List<Opportunity> relatedOpps = [SELECT Id,Name,CloseDate FROM Opportunity
//         WHERE AccountId IN :Trigger.new];
//     // Iterate over the related opportunities
//     for(Opportunity opp : relatedOpps) {
//         // Do some other processing
//     }
// }

// trigger SoqlTriggerBulk on Account(after update) {
//     // Perform SOQL query once.
//     // Get the related opportunities for the accounts in this trigger,
//     // and iterate over those records.
//     for(Opportunity opp : [SELECT Id,Name,CloseDate FROM Opportunity
//         WHERE AccountId IN :Trigger.new]) {
//         // Do some other processing
//     }
// }

// trigger DmlTriggerNotBulk on Account(after update) {
//     // Get the related opportunities for the accounts in this trigger.
//     List<Opportunity> relatedOpps = [SELECT Id,Name,Probability FROM Opportunity
//         WHERE AccountId IN :Trigger.new];
//     // Iterate over the related opportunities
//     for(Opportunity opp : relatedOpps) {
//         // Update the description when probability is greater
//         // than 50% but less than 100%
//         if ((opp.Probability >= 50) && (opp.Probability < 100)) {
//             opp.Description = 'New description for opportunity.';
//             // Update once for each opportunity -- not efficient!
//             update opp;
//         }
//     }
// }

// trigger DmlTriggerBulk on Account(after update) {
//     // Get the related opportunities for the accounts in this trigger.
//     List<Opportunity> relatedOpps = [SELECT Id,Name,Probability FROM Opportunity
//         WHERE AccountId IN :Trigger.new];
//     List<Opportunity> oppsToUpdate = new List<Opportunity>();
//     // Iterate over the related opportunities
//     for(Opportunity opp : relatedOpps) {
//         // Update the description when probability is greater
//         // than 50% but less than 100%
//         if ((opp.Probability >= 50) && (opp.Probability < 100)) {
//             opp.Description = 'New description for opportunity.';
//             oppsToUpdate.add(opp);
//         }
//     }
//     // Perform DML on a collection
//     update oppsToUpdate;
// }