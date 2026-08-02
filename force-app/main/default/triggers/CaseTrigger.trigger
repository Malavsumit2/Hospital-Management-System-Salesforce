trigger CaseTrigger on Case ( after insert, after update , after Delete){
     
    if(Trigger.isInsert && Trigger.isAfter)
    {
        CaseTriggerHandlerr.updateRatingOnAccount(Trigger.new);
    }



}