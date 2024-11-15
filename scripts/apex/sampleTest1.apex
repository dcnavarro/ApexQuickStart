// Question 1: Apex Basics
// Write a simple Apex method that calculates the sum of two integers.

// public class MathOperations {
//     public static Integer sumOfTwoIntegers(Integer a, Integer b) {
//         return a + b;
//     }
// }

// Integer result = MathOperations.sumOfTwoIntegers(5, 10);
// System.debug('The sum is: ' + result); // This will output: The sum is: 15

// Question 2: SOQL Queries
// Write a SOQL query to fetch the first name and last name of all Contacts where the Account name is "Acme".

// SELECT FirstName, LastName 
// FROM Contact 
// WHERE Account.Name = 'Acme'

// Question 3: Triggers
// Create an Apex trigger on the Contact object that updates the LastModifiedDate of the parent Account whenever a Contact is inserted or updated.

// trigger ContactTrigger on Contact (after insert, after update) {
//     Set<Id> accountIds = new Set<Id>();
    
//     // Collect Account Ids from inserted or updated Contacts
//     for (Contact contact : Trigger.new) {
//         if (contact.AccountId != null) {
//             accountIds.add(contact.AccountId);
//         }
//     }
    
//     // Update the LastModifiedDate of the related Accounts
//     if (!accountIds.isEmpty()) {
//         List<Account> accountsToUpdate = new List<Account>();
        
//         for (Id accountId : accountIds) {
//             accountsToUpdate.add(new Account(
//                 Id = accountId,
//                 LastModifiedDate = System.now() // Set LastModifiedDate to current time
//             ));
//         }
        
//         // Update the Accounts
//         update accountsToUpdate;
//     }
// }

// Question 4: Batch Apex
// Write a Batch Apex class that updates the 'LastModifiedBy' field of all Accounts to the current user.

// global class UpdateLastModifiedByBatch implements Database.Batchable<sObject> {
//     global Database.QueryLocator start(Database.BatchableContext BC) {
//         return Database.getQueryLocator([SELECT   
//  Id FROM Account]);
//     }

//     global void execute(Database.BatchableContext   
//  BC, List<Account> scope) {
//         List<Account> accountsToUpdate = new List<Account>();
//         for (Account   
//  acct : scope) {
//             acct.LastModifiedById = UserInfo.getUserId();
//             accountsToUpdate.add(acct);
//         }
//         update accountsToUpdate;
//     }

//     global void finish(Database.BatchableContext BC) {
//         // Optional: You can add any post-processing logic here, such as sending notifications or logging completion
//     }
// }

// Database.executeBatch(new UpdateLastModifiedByBatch());

// Question 5: Future Methods
// Create a Future method that performs a callout to a specified URL and logs the response to a custom object called CalloutLog__c.

// @future(callout=true)
// public static void makeCallout(String url) {
//     Http http = new Http();
//     HttpRequest request = new HttpRequest();
//     request.setEndpoint(url);
//     request.setMethod('GET');

//     HttpResponse response = http.send(request);

//     if (response.getStatusCode()   
//  == 200) {
//         CalloutLog__c log = new CalloutLog__c();
//         log.CalloutUrl__c = url;
//         log.Response__c = response.getBody();
//         insert log;
//     } else {
//         // Handle error, e.g., log to a custom object or send an email alert
//         System.debug('Callout failed with status code: ' + response.getStatusCode() + ' and body: ' + response.getBody());
//     }
// }

// How to Use This Method:

// Create a Custom Object:

// Create a custom object called CalloutLog__c with fields like CalloutUrl__c (Text) and Response__c (Long Text Area).
// Call the Future Method:

// From your Apex class or trigger, call the makeCallout method with the desired URL:
// makeCallout('https://api.example.com/data');

// Question 6: Queueable Apex
// Write a Queueable class that updates the 'LeadSource' field of all Leads created today to 'Web'.

// global class UpdateLeadSource implements Queueable {
//     global void execute(QueueableContext qc) {
//         List<Lead> leadsToUpdate = [SELECT Id FROM Lead WHERE CreatedDate = TODAY];

//         for (Lead lead : leadsToUpdate) {
//             lead.LeadSource = 'Web';
//         }

//         update leadsToUpdate;
//     }
// }

// System.enqueueJob(new UpdateLeadSource());

// Question 7: Test Classes
// Create a test class for the following method:
// public class AccountUtils {
//     public static void updateAccountNames() {
//         List<Account> accounts = [SELECT Id, Name FROM Account];
//         for (Account acc : accounts) {
//             acc.Name += ' - Updated';
//         }
//         update accounts;
//     }
// }

// @isTest
// public class AccountUtilsTest {
//     @testSetup
//     static void setup() {
//         Account acc1 = new Account(Name = 'Test Account 1');
//         insert acc1;
//         Account acc2 = new Account(Name = 'Test Account 2');
//         insert acc2;
//     }

//     @isTest
//     static void testUpdateAccountNames() {
//         AccountUtils.updateAccountNames();

//         List<Account> updatedAccounts = [SELECT Id, Name FROM Account];
        
//         // Assert that all accounts have been updated
//         System.assertEquals(2, updatedAccounts.size(), 'Number of updated accounts does not match');
        
//         // Assert that each account name has been appended with "- Updated"
//         for (Account account : updatedAccounts) {
//             String expectedName = account.Name.left(account.Name.length() - 11) + ' - Updated';
//             System.assertEquals(expectedName, account.Name, 'Account name not updated correctly: ' + account.Id);
//         }
//     }
// }

// Question 8: SOSL Queries
// Write a SOSL query to find any Contact whose name starts with 'John' or whose Email contains '@example.com'.

// FIND {Contact(Name:John* OR Email:*example.com*)} 

// Question 9: Validation Rules
// Create a validation rule on the Opportunity object to ensure that the Close Date is always in the future.

// Navigate to the Opportunity Object: Go to Setup > Object Manager > Opportunity.
// Create a New Validation Rule: Under the Validation Rules section, click New.
// Enter Rule Details:
// Error Condition Formula: Paste the formula CloseDate < TODAY into the formula editor.
// Error Message: Enter the error message "The Close Date must be in the future."
// Active: Check the box to activate the rule.
// Save the Rule: Click Save to save the validation rule.

// Question 10: Workflow Rules
// Explain how to create a workflow rule that sends an email alert when an Account's industry is changed to 'Technology'.

// 1. Create a Workflow Rule:
// Navigate to Workflow Rules: Go to Setup > Workflows & Approvals.
// Create a New Rule: Click New to create a new workflow rule.
// Rule Criteria:
// Object: Select Account.
// Rule Name: Enter a descriptive name, like "Technology Industry Change Alert."
// Evaluates To: Choose Changed.
// Conditions: Add a new condition:
// Field: Industry
// Operator: equals
// Value: Technology

// 2. Create a Workflow Action:
// Create a New Action: Click New Action.
// Action Type: Select Email Alert.
// Email Template: Create a new email template or select an existing one.
// Sender: Specify the sender's email address.
// Recipient Type: Select Specific Users.
// Recipients: Add the desired recipients (e.g., specific users or a queue).
// Subject: Set the email subject, such as "Account Industry Changed to Technology."
// Email Body: Customize the email body to include relevant information about the changed Account. You can use merge fields to dynamically populate the email with account details.

// 3. Activate the Workflow Rule:
// Activate the Workflow: Click Activate to activate the workflow rule.
// Set Workflow Entry Criteria: If needed, you can set criteria for when the workflow should be evaluated (e.g., when a record is created or edited).

// Question 11: Process Builder
// Describe how to use Process Builder to automatically update a Contact's 'Lead Source' field to 'Referral' when the associated Account's 'Type' field is changed to 'Customer'.

// 1. Create a New Process:
// Navigate to Process Builder: Go to Setup > Process Automation > Process Builder.
// Create a New Process: Click New.
// Start the Process with a Record Change: Select Start the process with a record change.
// Object: Select Account.

// 2. Define the Start Criteria:
// Start the process when: Select A record is created, edited, or deleted.
// Filter Criteria: Add a filter to ensure the process only triggers when the Account Type is changed to 'Customer':
// Field: Type
// Operator: Equals
// Value: Customer

// 3. Create the Immediate Action:
// Add a New Action: Click Add Action.
// Action Name: Give it a descriptive name, such as "Update Related Contacts."
// Action Type: Select Update Records.

// Find Records:
// Record Type: Select Contact.
// Filter Criteria: Add a filter to find Contacts related to the Account:
// Field: AccountId
// Operator: Equals
// Value: {!Account.Id}

// Update Fields:
// Add a new update field:
// Field: Lead Source
// Value: 'Referral'

// 4. Activate the Process:
// Activate the Process: Click Activate.

// Question 12: Lightning Components
// Explain the difference between Aura components and Lightning Web Components (LWC).

// Both Aura Components and Lightning Web Components (LWC) are frameworks used to build user interfaces in Salesforce. However, they have distinct differences in terms of architecture, performance, and development approach.

// Aura Components

// Framework: Older framework based on a custom MVC architecture.
// Performance: Can be less performant, especially in complex scenarios.
// Development Experience: Can be less developer-friendly due to its specific syntax and component structure. 
// Component Structure: Components are composed of three main parts:
// Component: Defines the component's properties, methods, and events.
// Controller: Handles component logic and interacts with server-side controllers. 
// Renderer: Defines the component's visual representation.
// Templating Language: Uses a custom templating language.

// Lightning Web Components

// Framework: Modern framework based on web standards (HTML, JavaScript, CSS).
// Performance: Generally more performant due to its lightweight architecture and efficient rendering.
// Development Experience: More developer-friendly, as it leverages familiar web development technologies.
// Component Structure: Components are composed of:
// HTML: Defines the component's structure.
// JavaScript: Handles component logic and data manipulation. 
// CSS: Styles the component's appearance.
// Templating Language: Uses HTML templates with custom tags and attributes.

// Question 13: Integration
// Describe the steps to integrate Salesforce with an external web service using RESTful APIs.

// 1. Identify the External API:

// Endpoint URL: Determine the URL of the external API endpoint you want to interact with.
// HTTP Method: Identify the appropriate HTTP method (GET, POST, PUT, DELETE) to use for the desired operation.
// Request Parameters: Understand the required parameters, headers, and body format for the API request.
// Response Format: Determine the expected format of the API response (JSON, XML, etc.).

// 2. Create an Apex Class to Handle the API Call:

// HTTP Request: Create an HttpRequest object to specify the endpoint URL, HTTP method, and request headers.
// HTTP Callout: Use the Http class to send the request and receive the response.
// Response Handling: Parse the response body to extract the desired data.
// Error Handling: Implement error handling to handle potential exceptions and API errors.
// Asynchronous Processing: For long-running or resource-intensive tasks, consider using asynchronous techniques like batch Apex or Queueable Apex to avoid blocking the user interface.

// public class ExternalApiCallout {
//     @Future(callout=true)
//     public static void makeApiCall(String url) {
//         Http http = new Http();
//         HttpRequest request = new HttpRequest();
//         request.setEndpoint(url);
//         request.setMethod('GET');
//         HttpResponse response = http.send(request);

//         if (response.getStatusCode()
//  == 200) {
//             // Process the response
//             System.debug(response.getBody());
//         } else {
//             // Handle error
//             System.debug('Error: ' + response.getStatusCode() + ' - ' + response.getBody());
//         }
//     }
// }

// 3. Implement Security Considerations:

// Authentication: Use appropriate authentication mechanisms (OAuth, basic authentication, API keys) to secure API calls.
// Data Encryption: Encrypt sensitive data before sending it over the network.
// Rate Limiting: Be aware of API rate limits and implement strategies to avoid exceeding them.

// 4. Test the Integration:

// Unit Tests: Write unit tests to verify the correctness of the Apex class and the API call.
// Integration Tests: Test the integration with the external web service in a realistic environment.
// Performance Testing: Evaluate the performance of the integration to identify potential bottlenecks.

// Question 14: Data Management
// Explain how to perform a data import using the Data Loader and the Data Import Wizard in Salesforce.

// Data Loader and Data Import Wizard are two primary methods for importing data into Salesforce. Each method has its own strengths and is suitable for different use cases.

// Data Loader is a command-line tool that offers more flexibility and control over the import process. It's ideal for large data imports and complex scenarios.

// Download and Install: Download Data Loader from Salesforce and install it on your machine.
// Create a Data File: Create a CSV or Excel file with the data to be imported. The file should contain the same fields as the Salesforce object you're importing into.
// Configure Data Loader:
// Select Object: Choose the Salesforce object you want to import data into.
// Select Data File: Specify the path to your data file.
// Map Fields: Map the fields in your data file to the corresponding fields in the Salesforce object.
// Set Import Options: Configure options like error handling, batch size, and external ID field.
// Run the Import: Start the import process. Data Loader will read the data file, map the fields, and create or update records in Salesforce.
// Review the Import Results: Check the import log to review any errors or warnings.

// Data Import Wizard is a user-friendly web-based tool that is suitable for smaller data imports. It's simpler to use but offers less flexibility than Data Loader.

// Navigate to Data Import Wizard: Go to Setup > Data Import.
// Select Object: Choose the Salesforce object you want to import data into.
// Select Data Source: Choose the data source (e.g., CSV file, Excel file).
// Map Fields: Map the fields in your data file to the corresponding fields in the Salesforce object.
// Start Import: Start the import process. The wizard will process the data and create or update records in Salesforce.
// Review Import Results: Check the import job status and review any errors or warnings.