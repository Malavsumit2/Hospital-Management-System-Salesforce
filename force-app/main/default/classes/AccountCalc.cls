//count total contacts on Accounts through Future Method Apex Asynchronous
public class AccountCalc {
@future
    public static void countContacts(List<ID> accIDs)
    {
        List<Account> accList = [SELECT ID , Total_Contacts__c , (SELECT ID FROM Contacts) FROM ACCOUNT 
                                WHERE ID IN : accIDs];
        
        for(Account acc : accList)
        {
            acc.Total_Contacts__c = acc.Contacts.size() ;
        }
        if(!accList.isEmpty())
        {
            update accList ;
        }
    }
}