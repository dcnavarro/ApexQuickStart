public class UpdateParentAccount implements Queueable {
    private List<Account> accounts;
    private ID parent;
    public UpdateParentAccount(List<Account> records, ID id) {
        this.accounts = records;
        this.parent = id;
    }
    public void execute(QueueableContext context) {
        for (Account account : accounts) {
          account.parentId = parent;
          // perform other processing or callout
        }
        update accounts;
    }
}

// To add this class as a job on the queue, execute the following code:
// // find all accounts in ‘NY’
// List<Account> accounts = [select id from account where billingstate = ‘NY’];
// // find a specific parent account for all records
// Id parentId = [select id from account where name = 'ACME Corp'][0].Id;
// // instantiate a new instance of the Queueable class
// UpdateParentAccount updateJob = new UpdateParentAccount(accounts, parentId);
// // enqueue the job for processing
// ID jobID = System.enqueueJob(updateJob);
// After you submit your queueable class for execution, the job is added to the queue and will be processed when system resources become available.

// To chain a job to another job, submit the second job from the execute() method of your queueable class. You can add only one job from an executing job, which means that only one child job can exist for each parent job. For example, if you have a second class called SecondJob that implements the Queueable interface, you can add this class to the queue in the execute() method as follows:
// public class FirstJob implements Queueable {
//     public void execute(QueueableContext context) {
//         // Awesome processing logic here
//         // Chain this job to next job by submitting the next job
//         System.enqueueJob(new SecondJob());
//     }
// }