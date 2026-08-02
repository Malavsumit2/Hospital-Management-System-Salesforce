//Update Priority on Contacts based on the Rating field on Account
//if rating == hot than Priority is High and if Rating is cold than priority is Low
public class UpdateContactPriorityBatchApex implements Database.Batchable<sObject> , Database.Stateful {
    
    INTEGER totalRecord = 0 ;
    public Database.QueryLocator start(Database.BatchableContext bx)
    {
        return Database.getQueryLocator([SELECT ID , Rating FROM Account WHERE Rating IN ('Hot' , 'Cold')]) ;
    }
    public void execute(Database.BatchableContext bx , List<Account> accList)
    {
        Map<ID,String> accMap = new Map<ID,String>();
        for(Account acc : accList)
        {
            accMap.put(acc.ID , acc.Rating);
        }
        
        List<Contact> conList = [SELECT ID , AccountId , Priority__c FROM Contact WHERE AccountId IN : accMap.Keyset()] ;
        
        for(Contact con : conList)
        {
            if(accMap.get(con.AccountId) == 'Hot')
            {
                con.Priority__c = 'High' ;
            }
            else if (accMap.get(con.AccountId) == 'Cold')
            {
                con.Priority__c = 'Low';
            }
            
        }
        if(!conList.isEmpty())
        {
            update conList ;
            totalRecord = totalRecord + conList.size();
        }
    }
    public void finish(Database.BatchableContext bx)
    {
        System.debug(totalRecord + ' Contacts updated');
        Messaging.SingleEmailMessage Email = new Messaging.SingleEmailMessage () ;
        List<String> toAddressList = new List<String> ();
        toAddressList.add('Malavsumit2@gmail.com');
        toAddressList.add('sumitmalavdhakar9664288512@gmail.com');
        
        
        Email.setToAddresses(toAddressList);
        Email.setSubject('Contact Priority Updated!!!');
        Email.setPlainTextBody(
        'Contact priority field is updated successfully\n\n'+
            'Total '+totalRecord+' contacts are updated' 
        ) ;
        
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {Email});
            Database.executeBatch(new Update_Account_BatchApex()) ;
    }

}