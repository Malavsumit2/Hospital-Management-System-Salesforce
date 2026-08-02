//Copy Billing address of Account to all related contacts Where Billing Country = United States
public class UpdateContactMailingAddress_BatchApex 
implements Database.Batchable<sObject> , Database.Stateful
{
   INTEGER recordCount=0;
    public Database.QueryLocator start(Database.BatchableContext bc)  //start
    {
        return Database.getQueryLocator([SELECT ID,BillingCountry , BillingStreet , BillingCity, BillingState , 
                                        (SELECT ID ,MailingCountry, MailingStreet,MailingCity,MailingState FROM Contacts) FROM Account
                                        WHERE BillingCountry = 'United States']);
    }
    
    
    public void execute(Database.BatchableContext bc , List<Account> accList)
    {    
        List<Contact> conList = new List<Contact>();
        for(Account acc : accList)
        {
            for(Contact con : acc.contacts)
            {   con.MailingCountry = acc.BillingCountry;
                con.MailingStreet = acc.BillingStreet;
                con.MailingCity = acc.BillingCity;
                con.MailingState = acc.BillingState;
                
                conList.add(con);
                recordCount++;
            }
            
        } 
        if(!conList.isEmpty())
        {
          update conList;  
        }
        
    }
    
    public void finish(Database.BatchableContext bc)
    {
        System.debug('Total Record Processed : '+recordCount);
    }
    
}