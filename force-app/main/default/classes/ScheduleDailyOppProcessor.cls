public class ScheduleDailyOppProcessor implements Schedulable {
    
    public void execute(SchedulableContext sc)
    {
        List<Opportunity> oppList = [SELECT ID , LeadSource FROM Opportunity WHERE LeadSource = null ];
        
        for(Opportunity opp : oppList)
        {
            opp.LeadSource = 'Web';
        }
        if(!oppList.isEmpty())
        {
            update oppList ;
        }
        
        
    }

}