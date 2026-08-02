public class DemoSObjectMap {

    public static void SobjectMap()
    {   //Q1 without Loop
        
		List<Account> AccList = new List<Account>();
        AccList = [SELECT ID , Name from Account Limit 3];
        System.debug('AccList : '+ AccList);
        
        Map<ID , Account> DemoMap = new Map<ID , Account>() ; 
        DemoMap.putAll(AccList);
        System.debug('DemoMap:'+ DemoMap);
        System.debug('DemoMap keysets are :'+ DemoMap.keyset());
        System.debug('DemoMap:'+ DemoMap.Values());
        
    }
    //Q1 with loop
    public static void SobjectMapwithLoop()
    {
        List<Account> AccList = new List<Account>();
        AccList = [SELECT ID , Name from Account Limit 3];
        System.debug('AccList : '+ AccList);
        Map<ID , Account> DemoMap = new Map<ID , Account>() ; 
        for(Account acc : AccList)
        {
            DemoMap.put(acc.ID , acc);   //Here acc.ID will be Key and acc will be values
        }
        System.debug('DemoMap:'+ DemoMap);
        System.debug('DemoMap keysets are :'+ DemoMap.keyset());
        System.debug('DemoMap:'+ DemoMap.Values());
    }
    
    //Q2 : Custom Object
    public static void CustomobjectMap()
    {
        List<Support_Ticket__c> Support_Ticket_List = new List<Support_Ticket__c>();
        Support_Ticket_List = [SELECT 	Name , Subject__c from Support_Ticket__c Limit 3];  //In Support Ticket Object the ID api name is "Name" 
        System.debug('Support_Ticket_List : '+ Support_Ticket_List);
        Map<ID , Support_Ticket__c> CustomMap = new Map<ID , Support_Ticket__c>() ; 
        for(Support_Ticket__c supTic : Support_Ticket_List)
        {
            CustomMap.put(supTic.ID , supTic);   //Here acc.ID will be Key and acc will be values
        }
        System.debug('CustomMap:'+ CustomMap);
        System.debug('CustomMap keysets are :'+ CustomMap.keyset());
        System.debug('CustomMap:'+ CustomMap.Values());
    }
    
    //Passing list inside map 
    public static void ListInsideMap(){
    Map<String, List<String>> studentMap = new Map<String, List<String>>();
    studentMap.put(
        'Class A',
        new List<String>{'Sumit', 'Rahul', 'Aman'}
    );
    studentMap.put(
        'Class B',
        new List<String>{'Rohit', 'Karan'}
    ); 
    System.debug(studentMap);
    }
}