trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
  Set<Id> opportunityIdsToCreateTasks = new Set<Id>();

  for (Opportunity opportunity : Trigger.new) {
    if (opportunity.StageName == 'Closed Won') {
      opportunityIdsToCreateTasks.add(opportunity.Id);
    }
  }

  if (!opportunityIdsToCreateTasks.isEmpty()) {
    List<Task> tasksToInsert = new List<Task>();
    for (Id opportunityId : opportunityIdsToCreateTasks) {
      Task task = new Task();
      task.Subject = 'Follow Up Test Task';
      task.WhatId = opportunityId;
      // Set other task fields as needed (e.g., Priority, Due Date, OwnerId)
      tasksToInsert.add(task);
    }
    insert tasksToInsert;
  }
}

// trigger AddRelatedRecord on Account(after insert, after update) {
//     List<Opportunity> oppList = new List<Opportunity>();
//     // Add an opportunity for each account if it doesn't already have one.
//     // Iterate over accounts that are in this trigger but that don't have opportunities.
//     List<Account> toProcess = null;
//     switch on Trigger.operationType {
//         when AFTER_INSERT {
//         // All inserted Accounts will need the Opportunity, so there is no need to perform the query
//             toProcess = Trigger.New;
//         }
//         when AFTER_UPDATE {
//             toProcess = [SELECT Id,Name FROM Account
//                          WHERE Id IN :Trigger.New AND
//                          Id NOT IN (SELECT AccountId FROM Opportunity WHERE AccountId in :Trigger.New)];
//         }
//     }
//     for (Account a : toProcess) {
//         // Add a default opportunity for this account
//         oppList.add(new Opportunity(Name=a.Name + ' Opportunity',
//                                     StageName='Prospecting',
//                                     CloseDate=System.today().addMonths(1),
//                                     AccountId=a.Id));
//     }
//     if (oppList.size() > 0) {
//         insert oppList;
//     }
// }