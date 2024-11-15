// 1.- Apex Programming:

// Syntax and basic constructs (loops, conditionals, etc.)
// Object-Oriented Programming (OOP) concepts
// SOQL and SOSL queries
// Trigger and batch apex
// Exception handling
// Testing (unit and integration)

// 2.- Salesforce Platform:

// Standard objects and fields
// Record types and sharing rules
// Workflow rules and process builder
// Validation rules and formula fields
// Reports and dashboards

// 3.- Salesforce Configuration:

// Profiles and permission sets
// Page layouts and record types
// Custom objects and fields


// Mock Test Questions
// Here are some example questions to get you started:

// Apex Programming

// Write a trigger to update a related record whenever a record on the Account object is created or edited.

// trigger AccountTrigger on Account (after insert, after update) {
//     // List to hold CustomObject__c records to update
//     List<CustomObject__c> relatedRecordsToUpdate = new List<CustomObject__c>();
    
//     // Query related records for the accounts in Trigger.new
//     Set<Id> accountIds = new Set<Id>();
//     for (Account acc : Trigger.new) {
//         accountIds.add(acc.Id);
//     }
    
//     // Fetch related CustomObject__c records
//     List<CustomObject__c> relatedRecords = [SELECT Id, Account__c, CustomField__c FROM CustomObject__c WHERE Account__c IN :accountIds];
    
//     // Update related records
//     for (CustomObject__c relatedRecord : relatedRecords) {
//         // Example: Update a custom field on the related record
//         relatedRecord.CustomField__c = 'Updated Value';
//         relatedRecordsToUpdate.add(relatedRecord);
//     }
    
//     // Perform the update DML operation
//     if (!relatedRecordsToUpdate.isEmpty()) {
//         update relatedRecordsToUpdate;
//     }
// }

// Create a batch Apex class to update a large number of records efficiently.

// public class LeadStatusUpdater implements Database.Batchable<sObject> {
    
//     // QueryLocator method to fetch Lead records
//     public Database.QueryLocator start(Database.BatchableContext bc) {
//         return Database.getQueryLocator('SELECT Id, Status FROM Lead WHERE Status != \'Qualified\'');
//     }
    
//     // Execute method to process each batch of records
//     public void execute(Database.BatchableContext bc, List<Lead> scope) {
//         for (Lead lead : scope) {
//             lead.Status = 'Qualified';
//         }
//         update scope;
//     }
    
//     // Finish method to handle post-processing or cleanup
//     public void finish(Database.BatchableContext bc) {
//         System.debug('Batch job completed successfully.');
//     }
// }

// LeadStatusUpdater leadBatch = new LeadStatusUpdater();
// Database.executeBatch(leadBatch, 200);

// Write a SOQL query to retrieve all Opportunities with a closed date in the current fiscal year.

// SELECT Id, Name, CloseDate 
// FROM Opportunity 
// WHERE CALENDAR_YEAR(CloseDate) = THIS_FISCAL_YEAR

// SELECT Id, Name, CloseDate 
// FROM Opportunity 
// WHERE CloseDate = THIS_FISCAL_YEAR

// Implement a test class to cover a specific Apex class and trigger.
// Apex Class Example:

// public class AccountHelper { public static void updateAccountNames(List<Account> accounts) { for (Account acc : accounts) { acc.Name = acc.Name + ' - Updated'; } update accounts; } }

// Trigger Example:
// trigger AccountTrigger on Account (after insert, after update) { AccountHelper.updateAccountNames(Trigger.new); }

// Test Class for the Apex Class and Trigger:
// @isTest
// public class AccountHelperTest {
    
//     @isTest
//     static void testUpdateAccountNames() {
//         // Create test data
//         Account acc1 = new Account(Name = 'Test Account 1');
//         Account acc2 = new Account(Name = 'Test Account 2');
//         List<Account> accounts = new List<Account>{acc1, acc2};
//         insert accounts;
        
//         // Query the inserted accounts to get their IDs
//         accounts = [SELECT Id, Name FROM Account WHERE Id IN :accounts];
        
//         // Call the method directly
//         Test.startTest();
//         AccountHelper.updateAccountNames(accounts);
//         Test.stopTest();
        
//         // Verify the update
//         List<Account> updatedAccounts = [SELECT Id, Name FROM Account WHERE Id IN :accounts];
//         for (Account acc : updatedAccounts) {
//             System.assert(acc.Name.endsWith(' - Updated'), 'Account name should be updated');
//         }
//     }
    
//     @isTest
//     static void testTrigger() {
//         // Create test data
//         Account acc1 = new Account(Name = 'Trigger Test Account 1');
//         Account acc2 = new Account(Name = 'Trigger Test Account 2');
//         List<Account> accounts = new List<Account>{acc1, acc2};
        
//         // Insert accounts to trigger the after insert
//         Test.startTest();
//         insert accounts;
//         Test.stopTest();
        
//         // Verify the trigger update
//         List<Account> updatedAccounts = [SELECT Id, Name FROM Account WHERE Id IN :accounts];
//         for (Account acc : updatedAccounts) {
//             System.assert(acc.Name.endsWith(' - Updated'), 'Account name should be updated by trigger');
//         }
        
//         // Update accounts to trigger the after update
//         for (Account acc : updatedAccounts) {
//             acc.Name = acc.Name.replace(' - Updated', '');
//         }
        
//         Test.startTest();
//         update updatedAccounts;
//         Test.stopTest();
        
//         // Verify the trigger update after update
//         List<Account> reUpdatedAccounts = [SELECT Id, Name FROM Account WHERE Id IN :updatedAccounts];
//         for (Account acc : reUpdatedAccounts) {
//             System.assert(acc.Name.endsWith(' - Updated'), 'Account name should be updated by trigger after update');
//         }
//     }
// }

// Salesforce Platform

// Explain the difference between a workflow rule and a process builder.
// Workflow Rule
// Workflow rules are automated processes in Salesforce that evaluate records as they are created or updated and trigger predefined actions based on specified criteria.
// Key Features:
// Actions: Workflow rules can perform four types of actions:
// Field Updates: Update a field on the record that triggered the workflow.
// Email Alerts: Send an email to designated recipients.
// Tasks: Create a task for a user.
// Outbound Messages: Send a secure, configurable API message (in XML format) to a designated listener.
// Evaluation Criteria: You can specify whether the rule runs when a record is created, created and every time its edited, or created and edited to meet subsequently criteria.
// Limitations: Workflow rules cannot create records or perform more complex logic. They also only support a single if-then statement.

// Process Builder
// Process Builder is a more advanced and flexible automation tool in Salesforce that can perform more complex logic and multiple actions. It allows you to automate processes based on various criteria and is considered an extension of workflow rules.
// Key Features:
// Actions: Process Builder supports all actions available in workflow rules and adds more:
// Create Records: Create new records.
// Update Related Records: Update fields on any related record.
// Quick Actions: Use global or object-specific actions.
// Submit for Approval: Submit the record for approval.
// Post to Chatter: Post a message to a Chatter feed.
// Invoke Processes: Call another process.
// Call Apex: Invoke an Apex class.
// Complex Logic: Process Builder allows you to create multiple if-then branches in a single process, supporting more complex logic and decision-making.
// User Interface: It provides a visual interface for building processes, making it easier to see the flow and understand the logic.

// How would you create a validation rule to ensure that a specific field is not null?

// Navigate to the Object Manager:
// Go to Setup.
// In the Quick Find box, type Object Manager and select it.
// Choose the object for which you want to create the validation rule (e.g., Contact, Account, etc.).
// Create a New Validation Rule:
// In the object page, click on Validation Rules in the left sidebar.
// Click New to create a new validation rule.
// Define the Validation Rule:
// Rule Name: Give your validation rule a descriptive name (e.g., Ensure_Field_Not_Null).
// Description: Optionally, add a description for what the rule does.
// Set the Error Condition Formula:
// In the formula editor, enter the following formula to check if a specific field is null:
// ISBLANK(Field_Name__c)
// Set the Error Message:
// Error Message: Enter a message that will be displayed to the user when they try to save a record with the specified field left blank (e.g., The Field_Name__c field cannot be empty.).
// Error Location: Choose where to display the error message (e.g., Field or Top of Page). If you choose Field, select the specific field to which the error message will be attached.
// Save the Validation Rule:
// Click Save to save your new validation rule.

// What are the different types of sharing rules in Salesforce?
// Types of Sharing Rules
// Owner-Based Sharing Rules:
// These rules share records based on the record owner.
// They grant access to records owned by users in a specific role, public group, or territory.
// For example, you might create a sharing rule that shares all records owned by users in the Sales department with users in the Support department.
// Criteria-Based Sharing Rules:
// These rules share records based on the values of fields within records.
// They allow for more granular sharing because they share records that meet specific criteria.
// For example, you could create a sharing rule that shares all Opportunities with an amount greater than $1,000,000 with a certain role or group.
// Manual Sharing:
// Although not a sharing rule per se, manual sharing allows individual users to share specific records with other users or groups.
// This is done by clicking the "Share" button on the record and specifying the users, roles, or groups to share with.
// Apex Managed Sharing: Custom sharing via Apex code.
// Territory-Based Sharing: Share records based on territories.

// How can you create a custom report type to combine data from multiple objects?
// Steps to Create a Custom Report Type
// Navigate to Report Types:
// Go to Setup.
// In the Quick Find box, type Report Types and select it.
// Create a New Report Type:
// Click the New Custom Report Type button.
// Primary Object: Choose the primary object you want to report on (e.g., Accounts).
// Report Type Label: Enter a label for your report type (e.g., Accounts with Opportunities).
// Report Type Name: This will be auto-filled based on your label.
// Description: Provide a description of what the report type will be used for.
// Stor
// Deployment Status: Set to Deployed to make it available for use.
// Click Next.
// Define Relationships:
// Primary Object: The primary object is already selected (e.g., Accounts).
// Related Object: Choose a related object that has a relationship with the primary object (e.g., Opportunities).
// Specify the relationship by selecting one of the options:
// "A" records may or may not have related "B" records: This includes all primary object records, whether or not they have related records.
// "A" records must have related "B" records: This includes only primary object records that have related records.
// Add Fields to Layout:
// After defining the relationship, click Save & Next.
// Edit Layout: You can customize the layout to add or remove fields.
// Drag and drop fields from the available fields list to the selected fields list.
// Save the Report Type:
// Click Save to create the custom report type.

// Salesforce Configuration

// How do you create a custom object with a lookup relationship to the Account object?
// Create the Custom Object:
// Go to Setup.
// In the Quick Find box, type Objects and select Objects under Create.
// Click New Custom Object.
// Label: Enter a label for the custom object (e.g., CustomRecord).
// Plural Label: Enter the plural label for the custom object (e.g., CustomRecords).
// Object Name: This will auto-populate based on the label (e.g., CustomRecord).
// Record Name: Enter a name for the record (e.g., CustomRecord Number).
// Data Type: Choose the data type for the record name (e.g., Auto Number or Text).
// Optional Features: Select the optional features you need (e.g., Allow Reports, Track Field History).
// Click Save.
// Create the Lookup Relationship:
// After saving the custom object, you'll be taken to the detail page of the new object.
// In the Fields & Relationships section, click New.
// Data Type: Select Lookup Relationship and click Next.
// Related To: Choose Account from the list of objects and click Next.
// Field Label: Enter a field label (e.g., Account Lookup).
// Field Name: This will auto-populate based on the field label.
// Related List Label: Enter the label for the related list on the Account object (e.g., CustomRecords).
// Click Next and set the field-level security as needed.
// Click Next and decide if you want to add the lookup field to the page layout.
// Click Save.

// What are the different types of page layouts in Salesforce?

// 1. Standard Page Layouts
// These are the default layouts provided by Salesforce for standard and custom objects. They are used to:
// Customize the fields and related lists visible on the record detail and edit pages.
// Control which fields are read-only, required, or hidden.
// Define the layout and organization of buttons, actions, and related lists.
// 2. Mini Page Layouts
// Mini page layouts are used to control the fields displayed in the mini view of a record, which appears in the:
// Console tab highlights panel.
// Lookup hover details.
// Related list hover details.
// 3. Compact Layouts
// Compact layouts control which fields appear in the record’s highlights panel at the top of the page and in the expanded lookup card:
// They are designed to provide a quick, concise view of a record’s key fields.
// Typically used in Salesforce mobile app and Lightning Experience.
// 4. Mobile Card Layouts
// Mobile card layouts are used specifically in the Salesforce mobile app to:
// Group fields into sections called cards for better organization and user experience on mobile devices.
// Define the order and grouping of fields within these cards.
// Can you help me with this? 'What are the different types of page layouts in Salesforce?' This is part of a mock test for Salesforce Developer.
// Absolutely! Page layouts in Salesforce are used to customize the layout and organization of fields, related lists, and other components on record detail and edit pages. Here are the different types of page layouts you can create and use in Salesforce:
// 1. Standard Page Layouts
// These are the default layouts provided by Salesforce for standard and custom objects. They are used to:
// Customize the fields and related lists visible on the record detail and edit pages.
// Control which fields are read-only, required, or hidden.
// Define the layout and organization of buttons, actions, and related lists.
// 2. Mini Page Layouts
// Mini page layouts are used to control the fields displayed in the mini view of a record, which appears in the:
// Console tab highlights panel.
// Lookup hover details.
// Related list hover details.
// 3. Compact Layouts
// Compact layouts control which fields appear in the record’s highlights panel at the top of the page and in the expanded lookup card:
// They are designed to provide a quick, concise view of a record’s key fields.
// Typically used in Salesforce mobile app and Lightning Experience.
// 4. Mobile Card Layouts
// Mobile card layouts are used specifically in the Salesforce mobile app to:
// Group fields into sections called cards for better organization and user experience on mobile devices.
// Define the order and grouping of fields within these cards.
// 5. Visualforce Pages
// While not a type of page layout per se, Visualforce pages can be used to create highly customized and branded user interfaces for record detail and edit pages:
// They offer the flexibility to include custom logic, styling, and components.
// Often used when standard page layouts do not meet specific business requirements.

// How do you assign permissions to a specific profile or permission set?
// Assigning Permissions to a Profile
// Navigate to Profiles:
// Go to Setup.
// In the Quick Find box, type Profiles and select it.
// Select the Profile:
// Click on the name of the profile you want to modify (e.g., Sales User).
// Edit Profile Permissions:
// Click Edit at the top of the profile detail page.
// Scroll down to the Administrative Permissions, General User Permissions, Standard Object Permissions, or Custom Object Permissions sections depending on what you want to modify.
// Check or uncheck the permissions you want to assign or revoke.
// Save Changes:
// After making the necessary changes, click Save.
// Assigning Permissions to a Permission Set
// Navigate to Permission Sets:
// Go to Setup.
// In the Quick Find box, type Permission Sets and select it.
// Create or Select a Permission Set:
// To create a new permission set, click New. Fill in the necessary details and click Save.
// To modify an existing permission set, click on its name.
// Assign Permissions:
// In the permission set detail page, click on Object Settings, App Permissions, System Permissions, or other relevant sections to assign permissions.
// For object settings, click on the specific object (e.g., Account), then click Edit. Set the object permissions as needed (e.g., Read, Create, Edit, Delete, etc.).
// For app and system permissions, click Edit, and then check or uncheck the permissions you want to assign.
// Save Changes:
// After making the necessary changes, click Save.
// Assigning Users to the Permission Set
// Navigate to Permission Sets:
// Go to Setup.
// In the Quick Find box, type Permission Sets and select it.
// Click on the name of the permission set you want to assign to users.
// Manage Assignments:
// Click Manage Assignments.
// Click Add Assignments.
// Select the users you want to assign the permission set to and click Assign.
// Click Done.