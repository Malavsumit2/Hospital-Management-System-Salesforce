public class OppClass {
  public static void GetOpp()
  {
      LIST<Opportunity> oppList = new LIST<Opportunity>();
      oppList = [SELECT Name , StageName FROM Opportunity WHERE StageName = 'Closed Won'  ] ;
      system.debug(oppList);  
       for (Opportunity opp : oppList) {
            opp.StageName = 'Qualification';
        }
      system.debug(oppList);
  }
}