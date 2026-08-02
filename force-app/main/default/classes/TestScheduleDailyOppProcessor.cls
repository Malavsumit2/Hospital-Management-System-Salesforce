@isTest
public class TestScheduleDailyOppProcessor {

    @isTest
    public static void updateOppLeadSource()
    {  String sch = '0 0 0 ? * * * ' ;
       List<Opportunity> oppList = new List<Opportunity>();
        for(INTEGER i=1 ; i<=200 ; i++)
        {
            if(i<=110)
            {
                opportunity opp = new opportunity();
                opp.Name = 'testOpp00'+i;
                opp.CloseDate = date.Today();
                opp.StageName = 'Prospecting';
                oppList.add(opp);
            }
            else
            {
                opportunity opp = new opportunity();
                opp.Name = 'testOpp00'+i;
                opp.CloseDate = date.Today();
                opp.StageName = 'Prospecting';
                opp.LeadSource = 'Email';
                oppList.add(opp);
            }
        }
        if(!oppList.isEmpty())
        {
            insert oppList ;
        }
        
        ScheduleDailyOppProcessor updateOpp = new ScheduleDailyOppProcessor();
        Test.startTest();
        String jobId = System.schedule('Process Opp' , sch , updateOpp);
        Test.stopTest();
     
       List<Opportunity> oppList1 = [SELECT ID , LeadSource FROM Opportunity WHERE LeadSource = 'Web'  ];
       System.assertEquals(110 , oppList1.size());
    }
}