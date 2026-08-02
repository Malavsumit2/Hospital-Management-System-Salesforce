//Calculate Case based on Origin On Account through Future Method using map and list

public class UpdateTotalCaseOnAcc_FutureMethod {
@future
    public static void updateCaseTotal(List<ID> accIDs)
    {
        List<Account> accList = [SELECT ID ,Case_Through_Email__c,Case_Through_Phone__c,Case_Through_Web__c
                                FROM Account 
                                WHERE ID IN : accIDs] ;
        
        List<Case> CaseList = [SELECT AccountID , Origin  FROM Case WHERE AccountID IN : accIDs] ;
        
        Map<ID,Account> accMap = new Map<ID,Account>();
        
        for(Account acc : accList)
        {
            accMap.put(acc.ID , acc);
            acc.Case_Through_Email__c =0;
            acc.Case_Through_Phone__c = 0;
            acc.Case_Through_Web__c =0;
        }
        
        
        for(Case cs : CaseList)
        {   
            
            
            if(cs.Origin == 'Email')
            {
                accMap.get(cs.AccountId).Case_Through_Email__c++ ;
            }
            else if (cs.Origin == 'Phone')
            {
                accMap.get(cs.AccountId).Case_Through_Phone__c++;
            }
            else if(cs.Origin == 'Web')
            {
                accMap.get(cs.AccountId).Case_Through_Web__c++;
            }
            
            
        }
        if(!accList.isEmpty())
        {
            update accList ;
        }
    }
}