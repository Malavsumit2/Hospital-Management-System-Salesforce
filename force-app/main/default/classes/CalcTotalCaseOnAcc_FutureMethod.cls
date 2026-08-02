//Calculate Case based on Origin On Account through Future Method using nested loop
public class CalcTotalCaseOnAcc_FutureMethod {
@future
    public static void countCaseOrigin(List<ID> accIDs)
    {
        List<Account> accList = [SELECT ID ,Case_Through_Email__c,Case_Through_Phone__c,Case_Through_Web__c , (SELECT ID , Origin FROM Cases)
                                FROM Account 
                                WHERE ID IN : accIDs] ;
        
        for(Account acc : accList)
        {
            INTEGER Email = 0 , Phone = 0 ,Web = 0;
            for(Case ca : acc.Cases)
            {
                if(ca.origin == 'Phone')
                {
                    Phone++;
                }
                else if(ca.origin =='Email')
                {
                    Email++;
                }
                else if(ca.origin == 'Web')
                {
                    Web++;
                }
            }
            acc.Case_Through_Email__c = Email;
            acc.Case_Through_Phone__c = Phone;
            acc.Case_Through_Web__c = Web;
        }
        if(!accList.isEmpty())
        {
            update accList ;
        }
    }
}