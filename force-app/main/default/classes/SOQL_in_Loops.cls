public class SOQL_in_Loops {
     public static void loopsSOQl()
     {   
         SET<ID> AccID = new SET<ID>();
         Integer ar = 10000 ;
         for(Account acc : [SELECT ID 
                           FROM Account
                            ])
         {		System.debug ( AccID.add (acc.ID));
                                
                            }
         system.debug(AccID);
         
  
     }
}