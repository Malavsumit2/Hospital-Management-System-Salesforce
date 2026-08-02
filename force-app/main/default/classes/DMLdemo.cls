public class DMLdemo {
    public static void InsertDemo()
    {   
        //Always use List to insert multiple Accounts
        //Inserting Related Records 
        List<Account> accList = new List<Account>();
        List<Contact> conList = new List<Contact>();
        
        
        Account acc1 = new Account();
        acc1.Name = 'Testing Account3';
        acc1.Active__c = 'Yes';
        accList.add(acc1);
        
        Account acc2 = new Account();
        acc2.Name = 'Testing Account4';
        acc2.Active__c = 'No';
        accList.add(acc2);
        
        //insert accList;   //To get the Account ID first you have to insert Accounts
        //Than only you get the ID to connect Contacts with Account
        Contact con1 = new Contact();
        con1.FirstName = acc1.Name ;
        con1.LastName = acc1.Name;
        con1.AccountId = acc1.ID ;
        conList.add(con1);
        
        Contact con2 = new Contact();
        con2.FirstName = acc2.Name ;
        con2.LastName = acc2.Name;
        con2.AccountId = acc2.ID ;
        conList.add(con2);
        
        //insert conList ;
        
        //Inserting Multiple Accounts Through loop
        for(INTEGER i=1 ;i<=10 ;i++)
        {
            Account acc = new Account();
            acc.Name = 'Testing Account00'+i;
            acc.Active__c = 'Yes';
            accList.add(acc);
        }
        insert accList ;   //INSERT DML
        
        
        //Now I want to insert contacts for these Accounts 
        
        for (Account acc : accList)
        {
            Contact cont = new Contact();
            cont.FirstName=acc.Name;
            cont.LastName='Contact';
            Cont.AccountId=acc.Id;
            conList.add(Cont) ;
            
        }
        insert conList;   //INSERT DML
        
        
    }
    //Update DML 
    
    public static void UpdateDML()
    {
        LIST<Account> accListDemo = new LIST<Account>();
        accListDemo = [SELECT ID , Name , Rating FROM Account
                       WHERE Rating = 'Hot'];
        if(!accListDemo.isEmpty()){
            for(Account acc : accListDemo)
            {
                acc.Industry = 'Media';
            }
            Update accListDemo;
        }
        
    }
    
    //UpSert DML
    public static void UpsertDemo()
    {
        LIST<Account> accList = new LIST<Account>();
        accList = [SELECT ID , Name , Rating FROM Account 
                   WHERE Rating = 'Hot'] ;
        
        if(!accList.isEmpty())
        {    //updating accList
            for(Account acc : accList)
            {
                acc.Rating = 'Cold';
            }
        }
        
        
        //Insertion
        for(INTEGER i=1 ; i<=5 ; i++)
        {
            Account acc = new Account();
            acc.Name = 'Testing Upsert'+i ;
            acc.Rating = 'Hot';
            acc.Industry = 'Chemicals';
            accList.add(acc);
        }
        
        if(!accList.isEmpty())
        {
            upsert accList; 
        }
        
    }
    //Delete DML : Deleting simultaneously after Insert
    public Static void DeleteDML()
    {   List<Account> accList11 = new List<Account>();
     for(INTEGER i=1 ;i<=10 ;i++)
     {
         Account acc11 = new Account();
         acc11.Name = 'Acc00'+i;
         acc11.Active__c = 'Yes';
         accList11.add(acc11);
     }
     
     System.debug(accList11);
     
     insert accList11;
     System.debug(accList11);
     
     Delete accList11 ;
     System.debug(accList11);
     System.debug('Delete Successfull');
       
    }
    
    //Delete DML
    public static void DeleteAcc()
    {
      LIST<Account> acclists = new LIST<Account>();
      acclists = [SELECT ID , Name , Rating FROM Account
                       WHERE Name LIKE 'Testing Account%'];
        System.debug(accLists);
        delete accLists ;
    }
    
    //Undelete DML
    public static void UnDeleteAcc()
    {
      LIST<Account> acclists = new LIST<Account>();
      acclists = [SELECT ID , Name , Rating FROM Account
                       WHERE Name LIKE 'Testing Account%' ALL ROWS];
        System.debug(accLists);
        undelete accLists ;
    }
    
    
    //Exception Handling :
    public static void ExcepHandling()
    {
     LIST<Account> accList = new LIST<Account>();
        accList = [SELECT ID , Name , Rating FROM Account 
                   WHERE Rating = 'Hot'] ;  
        
          if(!accList.isEmpty())
        {    //updating accList
            for(Account acc : accList)
            {
                acc.Rating = 'Cold';
            }
        }
        update accList ;
        
        
        
        
        try{
           for(INTEGER i=1 ; i<=5 ; i++)
        {
            Account acc = new Account();
            //acc.Name = 'Testing Upsert'+i ;   Let we forget this and try to insert account without this
            acc.Rating = 'Hot';
            acc.Industry = 'Chemicals';
            accList.add(acc);
            
        }
            if(!accList.isEmpty())
            {
                Insert accList ;
            }
            
        }
        catch(DMLException e)
        {
           System.debug(e) ; 
        }
    }
    
    
}