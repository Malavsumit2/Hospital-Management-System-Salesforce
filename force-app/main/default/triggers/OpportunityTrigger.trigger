trigger OpportunityTrigger on Opportunity (before insert , after insert , before update  , after update ,before delete , after delete ,after undelete) {
    if (Trigger.isBefore)
    {
        if(Trigger.isInsert)
        {
            //OpportunityTriggerHandler.showAlert(Trigger.New) ;
        }
    }
    if(Trigger.isAfter)
    {
        if(Trigger.isInsert)
        {
            //OpportunityTriggerHandler.UpdateAmmount(Trigger.New);
            //OpportunityTriggerHandler.UpdateTotalOppAmount(Trigger.New,null);
        }
        else if (Trigger.isUpdate)
        {
            //OpportunityTriggerHandler.createTaskOnOpp(Trigger.New , Trigger.oldMap) ;
            //OpportunityTriggerHandler.UpdateTotalOppAmount(Trigger.New , Trigger.oldMap);
        }
        else if(Trigger.isDelete)
        {
            //OpportunityTriggerHandler.UpdateTotalOppAmount(Trigger.old , null);
        }
        else if (Trigger.isUndelete)
        {
            //OpportunityTriggerHandler.UpdateTotalOppAmount(Trigger.new , null);
        }
    }
    
    if(Trigger.isBefore  && Trigger.isUpdate)
    {
        //OpportunityTriggerHandler.updateOppDescription(Trigger.New , Trigger.oldMap);
        //OpportunityTriggerHandler.customValidationClosedLostReason(Trigger.New , Trigger.oldMap);
    }
    else if(Trigger.isBefore  && Trigger.isInsert)
    {
        //OpportunityTriggerHandler.updateOppDescription(Trigger.New , null);
    }
    
    
}