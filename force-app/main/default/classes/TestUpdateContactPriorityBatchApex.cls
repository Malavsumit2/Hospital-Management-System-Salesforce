//Test Class to test the update on priority field of Contact based on Account
@isTest
public class TestUpdateContactPriorityBatchApex {
    @isTest
    public static void updatePriority()
    {
        Account acc = new Account();
        acc.Rating = 'Hot';
        acc.Name = 'Testing Account 002';
        insert acc;
        
        List<Contact> conList = new List<Contact>();
        
        for(INTEGER i=1 ; i<=5 ; i++ )
        {
            Contact con = new Contact();
            con.FirstName = acc.Name ;
            con.LastName = 'Contact';
            con.AccountId = acc.ID;
            conList.add(con);
        }
        insert conList;
        
        Test.startTest() ;
        UpdateContactPriorityBatchApex updateContact = new UpdateContactPriorityBatchApex() ;
        ID jobID = Database.executeBatch(updateContact);
        Test.stopTest() ;
        
        List<Contact> conList2 = [SELECT ID , Priority__c , AccountId FROM Contact WHERE AccountId =: acc.ID];
        System.assertEquals('High' , conList2[0].Priority__c);
        
    }
}