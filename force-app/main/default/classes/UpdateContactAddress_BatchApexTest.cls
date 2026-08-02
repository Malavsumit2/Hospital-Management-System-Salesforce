@isTest    //Test Class to update the Mailing Address of all the Contacts 
public class UpdateContactAddress_BatchApexTest {
@isTest
    public static void UpdateContAddress()
    {
       List<Account> accList = new List<Account>();
        for(INTEGER i=1;i<=10;i++)
        {
            Account acc = new Account();
            acc.Name = 'TestAcc0000'+i ;
            acc.BillingCountry = 'United States';
            acc.BillingCity = 'London';
            acc.BillingState = 'Alaska';
            acc.BillingStreet = 'Street no 001';
            accList.add(acc);
        }
        insert accList;
        
        List<Contact> conList = new List<Contact>();
        for(Account acc :accList )
        {
            Contact con = new Contact();
            con.FirstName = acc.Name ;
            con.LastName = 'Contact';
            con.AccountId = acc.ID;
            conList.add(con);
        }
        insert conList;
        
        Test.startTest();
        UpdateContactMailingAddress_BatchApex updateContact = new UpdateContactMailingAddress_BatchApex();
        ID batchID = Database.executeBatch(updateContact);
        Test.stopTest();
        
        List<Contact> conListupdated = [SELECT ID , MailingCountry FROM Contact Where MailingCountry = 'United States'];
        System.assertEquals(10 ,conListupdated.size() );
    }
}