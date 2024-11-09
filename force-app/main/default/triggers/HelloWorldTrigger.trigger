trigger HelloWorldTrigger on Account (before insert) {
	System.debug('Hello World!');
}

// trigger HelloWorldTrigger on Account (before insert) {
//     for(Account a : Trigger.new) {
//         a.Description = 'New description';
//     }
// }

// trigger ContextExampleTrigger on Account (before insert, after insert, after delete) {
//     if (Trigger.isInsert) {
//         if (Trigger.isBefore) {
//             // Process before insert
//         } else if (Trigger.isAfter) {
//             // Process after insert
//         }
//     }
//     else if (Trigger.isDelete) {
//         // Process after delete
//     }
// }

// trigger ExampleTrigger on Contact (after insert, after delete) {
//     if (Trigger.isInsert) {
//         Integer recordCount = Trigger.new.size();
//         // Call a utility method from another class
//         EmailManager.sendMail('Your email address', 'Trailhead Trigger Tutorial',
//                     recordCount + ' contact(s) were inserted.');
//     }
//     else if (Trigger.isDelete) {
//         // Process after delete
//     }
// }