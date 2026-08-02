@isTest
public class TestScheduleOppRemainder {
    @isTest
    public static void createTask()
    {   
        String sch = '0 0 0 ? * * *';
        
        List<Opportunity> oppList = new List<Opportunity>();
        for(INTEGER i = 1 ; i<=200 ; i++)
        {
            Opportunity opp = new Opportunity();
            opp.Name = 'TaskTestingOpp'+i;
            opp.CloseDate = date.Today().addDays(-2);
            opp.StageName = 'Prospecting' ;
            oppList.add(opp);
        }
        
        insert oppList ;
        Test.startTest();
        ScheduleOppRemainder createTask = new ScheduleOppRemainder() ;
        String jobID = system.schedule('createTask' , sch , createTask);
        Test.stopTest();
        
       List<Task> taskList = [SELECT ID FROM Task];
        System.assertEquals(200 , taskList.size()) ;
    }
}