public class OpportunityTriggerHandler {
    //Apply Custom Validation on Opportunity creation when Amount field is Null 
    public static void showAlert(List<Opportunity> oppList)
    {
        for(Opportunity opp : oppList)
        {
            if(opp.Amount == null)
            {
                opp.addError('Amount field cannot be Null') ;
            }
        }
    }
    
    //Before Update | When Opp stage is updated to Closed Lost than Closed Lost Reason cannot be null
    public static void customValidationClosedLostReason(List<Opportunity> oppList , Map<ID , Opportunity> oppOldMap)
    {
       if(!oppOldMap.isEmpty())
       {
           for(Opportunity opp : oppList)
           {
               if(opp.StageName != oppOldMap.get(opp.ID).StageName && opp.StageName == 'Closed Lost' && opp.Close_Lost_reason__c == Null)
               {
                   opp.AddError('Closed Lost Reason cannot be Null if stage is Closed Lost ') ;
               }
           } 
              
       }
    }
    //After Insert | populate Latest opp amount on Account when opp created 
    public static void UpdateAmmount(LIST<Opportunity> oppList)
    {
        List<Account> accList = new List<Account>();
        if(!oppList.isEmpty())
        {
            for(Opportunity opp : oppList)
            {
                Account acc = new Account();
                acc.Latest_Opportunity_Amount__c = opp.Amount ;
                acc.Id = opp.AccountId ;
                accList.add(acc);
            }
            if(!accList.isEmpty())
            {
                update accList ;
            }
        }
    }
    //Before Insert | Before Update : Upon Opportunity insert or update , 
    //update the description according to opportunity stage
    public static void updateOppDescription(List<Opportunity> oppList , Map<ID , Opportunity> oppOldMap)
    {
        if(oppOldMap == null)
        {
            for(Opportunity opp : oppList)
            {
                if(opp.StageName == 'Prospecting')
                {
                    opp.Description = 'Status is Prospecting' ;
                    
                }
                else if(opp.StageName == 'Qualification')
                {
                    opp.Description = 'Status is Qualification';
                    
                }
                
            }
        }
        else if (oppOldMap != null)
        {   for(Opportunity opp : oppList)
        {
            if(opp.StageName != oppOldMap.get(opp.ID).StageName)
            {
                if(opp.StageName == 'Prospecting')
                {
                    opp.Description = 'Status is Prospecting' ;
                }
                else if (opp.StageName =='Qualification')
                {
                    opp.Description = 'Status is Qualification';
                }
            } 
        }
         
        }
    }
    //After update | Create a task when stage on opportunity is updated 
    public static void createTaskOnOpp(List<Opportunity> oppList , Map<ID ,Opportunity> oppOldMap)
    {
        List<Task> taskList = new List<Task>() ;
        for(Opportunity opp : oppList)
        {   
            if(opp.StageName != oppOldMap.get(opp.ID).StageName)
            {
                Task tsk = new Task() ; 
                tsk.Subject = 'Follow up for opportunity' ;
                tsk.Priority = 'Priority' ;
                tsk.Status = 'Not Started' ; 
                tsk.WhatId = opp.ID ;
                tsk.OwnerId = opp.OwnerId ; // = userInfo.getUserID() ;
                taskList.add(tsk);
            }
            
        }
        if(!taskList.isEmpty())
        {
            insert taskList ;
        }
        
    }
    //After Insert | After Update |After Delete : Update Total opp amount on Account When an opportunity is created,updated,deleted
    //Also update total opportunities on particular Account
    public static void UpdateTotalOppAmount(List<Opportunity> oppList , Map<ID, Opportunity> oldOppMap)
    {
        set<ID> accIds = new set<ID>();
        for(opportunity opp : oppList)
        {
            if(oldOppMap == null)
            {
                if(opp.AccountId != null)
                {
                    accIds.add(opp.AccountId);
                }
            }
            
            else
            {
                if(opp.AccountId != null) //When we update the Account of an opportunity Than we get New Account ID 
                    					//And also we get Old Account ID but Opp.ID will remain same 
                {
                    accIds.add(opp.AccountId); //New AccountID
                }
                
                Opportunity oldOpp = oldOppMap.get(opp.Id) ;
                if(oldOpp.AccountId != null)
                {
                    accIds.add(oldOpp.AccountId);
                }
            }
        }
        
        //Quering that opportunity which are related to the Account ID in the above set
        List<AggregateResult> arList = [SELECT  AccountId , Count(ID) countOpp , SUM(Amount) TotalAmountSum 
                                       FROM opportunity where AccountId IN:accIds GROUP BY AccountId] ;
        Map<ID,Decimal> calculateSum = new Map<ID,Decimal>();
        Map<ID,Integer> calculateCount = new Map<ID,Integer>();
        
        for(AggregateResult ar : arList)
        {
            ID accID = (ID)ar.get('AccountId') ;
            Decimal AmountSum = (Decimal)ar.get('TotalAmountSum');
            Integer countOpp = (Integer)ar.get('countOpp');
            calculateSum.put(accID , AmountSum);
            calculateCount.put(accID ,countOpp ) ;
            
        }
        
        List<Account> accList = new List<Account>();
        for(ID accID : accIds)
        {
            Account acc = new Account();
            if(calculateSum.containsKey(accID))
            {
                acc.Total_Opp_Amount__c = calculateSum.get(accID);
            }
            else
            {
                acc.Total_Opp_Amount__c = 0 ;
            }
            
            if(calculateCount.containsKey(accID))
            {
                acc.TotalOpp__c = calculateCount.get(accID);
            }
            
            acc.ID = accID;
            accList.add(acc);
        }
        if(!accList.isEmpty())
        {
            update accList ;
        }
            
    }
    
    
}