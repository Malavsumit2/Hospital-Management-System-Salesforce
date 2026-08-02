@isTest
public class AccountCalcTest {  //test Class to cover the code coverage of Future method
    @isTest
    private static void countContactsTest()
    {
        List<Account> accList = new List<Account>();
        for(INTEGER i = 1 ; i<=50 ; i++)
        {
            Account acc = new Account();
            acc.Name = 'Test'+i ;
            accList.add(acc);
        }
        Test.startTest();
        insert accList ;
        
        List<Contact> conList = new List<Contact>();
        List<ID> accIDs = new List<ID>();
        
        for(Account acc : accList)
        {
            Contact Con = new Contact();
            Con.FirstName = 'Test';
            Con.LastName = acc.Name ;
            Con.AccountId = acc.ID;
            accIDs.add(acc.ID);
            conList.add(Con);
            
        }
        insert conList ;
        AccountCalc.countContacts(accIDs);
        
        Test.stopTest();
        
        Account acc = [
            SELECT Total_Contacts__c
            FROM Account
            WHERE Id = :accIds
        ];
        
        System.assertEquals(1, acc.Total_Contacts__c);
    }
}