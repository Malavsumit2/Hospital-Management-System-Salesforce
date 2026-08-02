public class CaseTriggerHandlerr {
    
    public static void UpdateAccountRating(List<Case> caseList)
    {
        Set<ID> accIds = new Set<ID>();
        for(Case cs : caseList)
        {
            
            if(cs.status == 'New' && cs.AccountId != null)
                
            {
                accIds.add(cs.AccountId) ;
            }
            
        }
        
        
        List<Account> accList = [
            SELECT Id, Rating,
            (SELECT Id, Status FROM Cases WHERE Status = 'New')
            FROM Account WHERE ID IN : accIds
        ];
        
        for(Account acc : accList){
            
            
            
            if(acc.Cases.size() > 5){
                acc.Rating = 'Hot';
            }
            else if(acc.Cases.size() > 3 && acc.Cases.size() <= 5){
                acc.Rating = 'Warm';
            }
            else{
                acc.Rating = 'Cold';
            }
            
        }
        
        if(!accList.isEmpty()){
            update accList;
        }
    }
    
    public static void updateRatingOnAccount(List<Case> caseList)
    {  
       Set<ID> accIds = new Set<ID>();
        for(Case cs : caseList)
        {
            
            if(cs.status == 'New' && cs.AccountId != null)
                
            {
                accIds.add(cs.AccountId) ;
            }
            
        }
        
        
        
        List<AggregateResult> arList = [SELECT  AccountId , Count(ID) totalCount FROM Case WHERE AccountId IN : accIds AND Status = 'New' GROUP BY AccountId  ] ;
        Map<ID , INTEGER> countMap  = new Map<ID,INTEGER>();
        
        for(AggregateResult ar : arList)
        {
            ID accId = (ID) ar.get('AccountId');
            INTEGER countCase = (INTEGER)ar.get('totalCount');
            countMap.put(accId,countCase);       
        }
        
        List<Account> accList = [Select ID , Rating FROM Account WHERE ID IN : accIds];
        for(Account acc : accList)
        {
            if(countMap.get(acc.ID) < 3)
            {
                acc.Rating = 'Cold';
            }
            else if (countMap.get(acc.ID) >= 3 && countMap.get(acc.ID) < 5 )
            {
                acc.Rating = 'Warm';
            }
            else
            {
                acc.Rating = 'Hot';
            }
        }
        
        if(!accList.isEmpty())
        {
            update accList ;
        }
    }
    
    
}