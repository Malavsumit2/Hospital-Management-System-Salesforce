public class ScheduleOppRemainder implements Schedulable {
    
    public void execute(SchedulableContext sc)
    {
        List<Opportunity> oppList = [SELECT ID , StageName , CloseDate 
                                    FROM Opportunity WHERE isClosed = false AND CloseDate < TODAY];
        
        List<Task> taskList = new List<Task>();
        for(Opportunity opp : oppList)
        {
            Task tsk = new Task();
            tsk.Subject = 'Remainder for opp';
            tsk.Priority = 'Normal' ;
            tsk.Status = 'Open';
            tsk.WhatId = opp.ID;
            taskList.add(tsk);
        }
        
        insert taskList ;
        
    }

}