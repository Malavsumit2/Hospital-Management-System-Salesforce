@isTest   //Test class to update the totalContacts on Account
public class TestUpdateAccountTotalContacts {
	@isTest
    public static void updateTotalContact()
    {
        Account acc = new Account();
        acc.Name = 'Testing Account 001';
        insert acc ;
         
        List<Contact> conList = new List<Contact>();
        for(INTEGER i=1	 ; i<=5 ;i++)
        {
            Contact con = new Contact();
            con.AccountId = acc.ID ;
            con.FirstName = acc.Name ;
            con.lastName = 'Contact';
            conList.add(con);
        }
        
        Test.startTest();
        insert conList ;
        Update_Account_BatchApex updateAccount = new Update_Account_BatchApex();
        ID jobId = Database.executeBatch(updateAccount);
        Test.stopTest();
        
        Account updatedAccount = [SELECT ID ,Total_Contacts__c FROM Account WHERE ID =: acc.ID ];
        System.assertEquals(5 , updatedAccount.Total_Contacts__c);
        
           
    }
   
}