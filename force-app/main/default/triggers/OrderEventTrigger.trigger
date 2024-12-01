trigger OrderEventTrigger on Order_Event__e (after insert) {
    // List to hold all tasks to be created.
    List<Task> tasksToCreate = new List<Task>();

    // Set to hold CreatedByIds to query related Groups
    Set<Id> createdByIds = new Set<Id>();
    for (Order_Event__e event : Trigger.New) {
        createdByIds.add(event.CreatedById);
    }

    // Query for users and groups based on CreatedByIds
    Map<Id, User> usersMap = new Map<Id, User>([SELECT Id FROM User WHERE Id IN :createdByIds]);
    Map<Id, Group> groupsMap = new Map<Id, Group>([SELECT Id, OwnerId FROM Group WHERE OwnerId IN :createdByIds]);

    // Iterate through each event and create tasks for shipped orders
    for (Order_Event__e event : Trigger.New) {
        if (event.Has_Shipped__c == true) {
            Id ownerId = null;
            if (usersMap.containsKey(event.CreatedById)) {
                ownerId = event.CreatedById;
            } else if (groupsMap.containsKey(event.CreatedById)) {
                ownerId = groupsMap.get(event.CreatedById).OwnerId;
            }

            if (ownerId != null) {
                // Create a new task for the owner
                Task task = new Task(
                    Priority='Medium',
                    Subject='Follow up on shipped order ' + event.Order_Number__c,
                    OwnerId = ownerId
                );
                tasksToCreate.add(task);
            }
        }
    }

    // Insert all tasks corresponding to events received.
    if (!tasksToCreate.isEmpty()) {
        insert tasksToCreate;
    }
}
