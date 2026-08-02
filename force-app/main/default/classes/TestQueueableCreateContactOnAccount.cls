@isTest
public class TestQueueableCreateContactOnAccount {
    
    @isTest
    public static void testContactCreate()
    {   List<Account> accList = new List<Account>();
     for(INTEGER i=1 ; i<=50 ;i++)
     {
         Account acc = new Account();
         acc.Name = 'TestConCreate'+i ;
         acc.Industry = 'Media';
         accList.add(acc);
     }
     insert accList ;
     
     QueueableCreateContactOnAccount  createContact = new QueueableCreateContactOnAccount();
     Test.startTest();
     System.enqueueJob(createContact);
     Test.stopTest();     
     
     List<Contact> conList = [SELECT ID , FirstName , LastName , AccountId FROM Contact WHERE FirstName = 'Seeta'] ;
     System.assertEquals(51 , conList.size());
     
     
    }
    
}