@isTest    //Test Class 
public class OppProcessor_BatchApexTest {
@isTest
    public static void UpdateOppLeadSource()
    {
        List<Opportunity> oppList = new List<Opportunity> ();
        for(INTEGER i=1 ; i<=200 ; i++)
        {
            Opportunity opp = new Opportunity();
            opp.Name = 'Opp00'+i ;
            opp.CloseDate = System.Today();
            opp.StageName = 'Prospecting';
            oppList.add(opp);
        }
        
         Test.startTest();
        insert oppList;
        
        OppProcessor_BatchApex oppProcessor = new OppProcessor_BatchApex();
        ID batchID = Database.executeBatch(oppProcessor);
        
        Test.stopTest();
        
        List<Opportunity> oppL = [SELECT ID FROM Opportunity 
                                    WHERE LeadSource = 'Web'];
        System.AssertEquals(200 , oppL.size());
    }
}