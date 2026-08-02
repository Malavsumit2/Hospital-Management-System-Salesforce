//After Insert | after case creation populate latest case no. on Account 
public class CaseTriggerHandler {
    public static void UpdateCaseNumber(LIST<Case> caseList)
    {
         
        LIST<Account> accList = new LIST<Account>() ;
        
        if(!caseList.isEmpty())
        {
            for(Case c : caseList)
            {
                if(c.AccountId != NULL)
                {
                    Account acc = new Account();
                    acc.ID = c.AccountId ;
                    acc.Latest_Case_Number__c = c.CaseNumber ;
                    acclist.add(acc);
                }
            }
            if(!accList.isEmpty())
            {
                update acclist ;
            }
        }
    }
    
}