public class Insert_Account {
     public static void InsertAccountDetails()
     {
        List<Account>  accList = new List<Account> () ;
        Account acc = new Account();
         acc.Name = 'Sumitdemo';
         acc.Active__c = 'Yes';
         accList.add(acc);
         
         Account acc1 = new Account(Name = 'Sumitdemo2' , Active__c = ' Yes ');
         accList.add(acc1);
         
         insert accList;
     
     }
}