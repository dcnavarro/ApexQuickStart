public class AccountHandler {
    public static void insertAccount(Integer value){
        Integer N = 1;
        //create a list to add our accounts
        List<Account> addAccounts = new List<Account>();
        while(N <= value){
            //display the current N value
            System.debug('N Value before Incrementing ' + N);
            //create a new account
            Account accountNew = new Account();
            accountNew.Name = 'Acme Inc'+ ' ' + N;
            accountNew.AccountNumber = 'A000' +  N;
            addAccounts.add(accountNew);
            System.debug(addAccounts);
            //increment the N
            N = N + 1;
            System.debug('N Value after incrementing ' + N);
        }
        System.debug('Size of Account List: ' + addAccounts.size() );
        System.debug('Elements in Account List: ' + addAccounts);
        //insert all of the accounts in the list
        insert addAccounts;
    }
}

// // Set the number of accounts to create
// Integer numAccounts = 3;

// // Call the insertAccount method
// AccountHandler.insertAccount(numAccounts);

// public class AccountHandler {
//     public static Account insertAccount(Integer value) {
//          Integer N = 1;
// List<Account> addAccounts = new List<Account>();
// while(N <= value){
//             //display the current N value
//             System.debug('N Value before Incrementing ' + N);
//             //create a new account
//        Account store = new Account();
//             store.Name = 'Acme Inc N' + N;
//             store.AccountNumber = 'A000N' + N;
//             addAccounts.add(store);
//             System.debug(addAccounts);
//             //increment the N
//             N = N + 1;
//             System.debug('N Value after incrementing ' + N);
//         }
//         System.debug('Size of Account List: ' + addAccounts.size() );
//         System.debug('Elements in Account List: ' + addAccounts);
//         //insert all of the accounts in the list
//         insert addAccounts;
//         return addAccounts;
//     }
// }

// public with sharing class AccountHandler {
//     public static Account insertNewAccount(String accName) {
//         if (String.isBlank(accName)) {
//             return null;
//         }

//         Account acct = new Account(Name=accName);
//         insert acct;
//         return acct;
//     }
// }

// public class StringListTest {
//     public static List<String> generateStringList(Integer n) {
//         List<String> stringList = new List<String>();
//         for (Integer i = 0; i < n; i++) {
//             stringList.add('Test ' + i);
//         }
//         return stringList;
//     }
// }