public class DemoSOQL {
    public static void queryDemo()
    {   
        //Using a Set in SOQL 
        SET<ID> accIDSet = new SET<ID>() ;
        LIST<Account> accList = [SELECT ID , Name , Industry ,Type,AnnualRevenue
                                 FROM Account LIMIT 10 ] ;
                                 
        
        for(Account acc : accList)
        {
            accIDSet.add(acc.ID);
        }
        
        LIST<Account> accList1 = [SELECT ID , Name , Type , AnnualRevenue 
                                  FROM Account 
                                  Where ID IN:accIDSet] ;  //If we use variable than we have to use : sign
        System.debug ( ' accList1 contains : '+ accList1 );
        
        //Using Count function in SOQL
        Integer countAccount = [SELECT COUNT() FROM Account];
		System.debug('Total Accounts : ' + countAccount);
    }
}