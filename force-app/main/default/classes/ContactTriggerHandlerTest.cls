@isTest
public class ContactTriggerHandlerTest {
  @isTest
    public static void testUpdateRatingOnAccount()
    {
        Account acc = new Account();
        acc.Name = ' DemoAcc001';
        insert acc ;
        
        Contact con = new Contact();
        con.LastName = ' DemoCon';
        con.AccountId = acc.ID ;
        con.AmountRating__c = 'Hot';
        
		
                
        Test.startTest() ;
        insert con ;
        
        con.AmountRating__c = 'Warm';
        
        update con;
        
        
        
        List<Account> accList = [SELECT ID ,Total_Contacts__c , Rating FROM Account WHERE ID =:con.AccountId];
        System.assertEquals('Warm',accList[0].Rating,'Rating was not updated ');
        System.assertEquals(1 , accList[0].Total_Contacts__c);
        
        
        delete con ;
        
        test.stopTest();
        
        
        
        
        
        
    }
    /*@isTest
    public static void updateTotalContacts()
    {
        Account acc = new Account();
        acc.Name = 'DemoAcc0002';
        insert acc ;
        
        Contact con = new Contact();
        con.LastName = 'DemoCon2';
        con.AccountId = acc.ID ;
        
        Test.startTest();
        insert con;
        Test.stopTest();
        List<Account> accList = [SELECT ID , Total_Contacts__c FROM Account WHERE ID =: Con.AccountId];
        System.AssertEquals(1 , accList[0].Total_Contacts__c) ;
        
    } */
    
}