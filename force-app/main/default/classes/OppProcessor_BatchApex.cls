//Update Lead Source as Web on All opportunities Through Batch Apex
public class OppProcessor_BatchApex
implements Database.Batchable<sObject> , Database.stateful {
    public integer recordCount = 0 ;
    
    public Database.QueryLocator start (Database.BatchableContext bc)   //start method
    {
        return Database.getQueryLocator([SELECT ID , LeadSource From Opportunity]);
    }
    
    public void execute(Database.BatchableContext bc , List<Opportunity> oppList)   //Execute Method
    {
        if(!oppList.isEmpty())
        {
            for(Opportunity opp : oppList)
            {
                opp.LeadSource = 'Web';
            }
            update oppList ;
            recordCount = recordCount + oppList.size() ;
        }
    }
    
    public void finish(Database.BatchableContext bc)    //Finish Method
    {
        System.debug('Total records Procssed : ' + recordCount) ;
    }
    
}