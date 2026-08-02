public class AggregateFunctionsDemo {
  public static void AggDemo()
  {
		AggregateResult[] arGroup = [SELECT Account.Name , SUM(Amount) AmountSum 
                                    FROM Opportunity GROUP BY Account.Name];
      System.debug('arGroup : ' + arGroup ) ;
      For(AggregateResult ar : arGroup )
      {
          system.debug('Account Name : '+ ar.get('Name')+' '+'Sum : '+ ar.get('AmountSum'));
      }
       //Uses of LIKE statements
     INTEGER CountName = [SELECT COUNT() FROM Account WHERE Name LIKE 's%'];
      system.debug(CountName);
      
      String s='test';
      s='%'+s+'%';
      LIST<Account> accList =[SELECT ID , Name
                             FROM Account 
                             WHERE Name LIKE :s]; 
      system.debug('AccList : '+accList);
  }
}