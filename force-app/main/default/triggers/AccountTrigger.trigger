trigger AccountTrigger on Account (
    before insert,
    after insert,
    before update,
    after update , 
    before delete , 
    after delete
) {

    
    // BEFORE INSERT
    
    if(Trigger.isBefore && Trigger.isInsert)
    {
        //AccountTriggerHandler.UpdateDesc(Trigger.new);
        //AccountTriggerHandler.UpdateRating(Trigger.new);
        //AccountTriggerHandler.UpdateIndustry(Trigger.new);
        //AccountTriggerHandler.UpperCase(Trigger.new);
        //AccountTriggerHandler.AddPrefix(Trigger.new);
        //AccountTriggerHandler.ShowAlert(Trigger.new);
        //AccountTriggerHandler.updateAccRating(Trigger.new);
        //AccountTriggerHandler.copyBillingAddress(Trigger.new);
        //AccountTriggerHandler.Copy_Billing_Address(Trigger.new, null);
    }

    
    // AFTER INSERT
    
    if(Trigger.isAfter && Trigger.isInsert)
    {
        //AccountTriggerHandler.createOpp(Trigger.new);
    }

   
    // BEFORE UPDATE
    
    if(Trigger.isBefore && Trigger.isUpdate)
    {
        //AccountTriggerHandler.UpdateAccDesc(Trigger.new, Trigger.oldMap);
        //AccountTriggerHandler.updateAccRating(Trigger.new, Trigger.oldMap);
        //AccountTriggerHandler.Copy_Billing_Address(Trigger.new, Trigger.oldMap);
        //AccountTriggerHandler.preventAccount(Trigger.New) ;
         
    }

   
    // AFTER UPDATE
    
    if(Trigger.isAfter && Trigger.isUpdate)
    {
         //AccountTriggerHandler.populatePhone(Trigger.new, Trigger.oldMap);
        //AccountTriggerHandler.updateOppRating(Trigger.new, Trigger.oldMap);
        //AccountTriggerHandler.updateMailingAddressOnContacts(Trigger.New , Trigger.oldMap);
        //AccountTriggerHandler.copyRatingOnContact(Trigger.New , Trigger.oldMap) ;
    }
    
    if(Trigger.isBefore && Trigger.isDelete)
    {
        //AccountTriggerHandler.preventDeletion(Trigger.old);
    }
}