//Update total Contacts on Account using Batch Apex
public class Update_Account_BatchApex implements Database.Batchable<sObject> , Database.Stateful

{   
    INTEGER totalRecordsUpdated = 0;  
    public Database.QueryLocator start (Database.BatchableContext bx)
    {
        return Database.getQueryLocator([SELECT ID , Total_Contacts__c ,(SELECT ID FROM Contacts) FROM Account ]);
    }
    
    public void execute(Database.BatchableContext bx , List<Account> accList)
    {
        for(Account acc : accList)
        {
            acc.Total_Contacts__c = acc.Contacts.size();
        }
        
        if(!accList.isEmpty())
        {
            update accList;
            totalRecordsUpdated = totalRecordsUpdated + accList.size();
            
        }
    }
    
    public void finish(Database.BatchableContext bx)
    {   
        System.debug('Accounts updated successfully');
        System.debug('Finish Method = ' + totalRecordsUpdated);
        Messaging.SingleEmailMessage Email = new Messaging.SingleEmailMessage();
        List<String> mailAddressList = new List<String>();
        mailAddressList.add('malavsumit2@gmail.com');
        mailAddressList.add('sumitmalavdhakar9664288512@gmail.com');
        Email.setToAddresses(mailAddressList) ;
        Email.setSubject('Batch Apex Completed');
        Email.setPlainTextBody(
        'Batch Completed Successfully. \n\n'+
            'All Accounts updated : '+ totalRecordsUpdated
        );
            Messaging.sendEmail( new Messaging.SingleEmailMessage[] {Email});
    }
}