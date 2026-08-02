trigger ContactTrigger on Contact (before insert , after insert , after update , after delete ,after unDelete , before update) {
    if(Trigger.isInsert && Trigger.isBefore)
    {
        ContactTriggerHandler.preventDuplicate(Trigger.New , null);
    }
    else if(Trigger.isUpdate && Trigger.isBefore)
    {
        ContactTriggerHandler.preventDuplicate(Trigger.New , Trigger.oldMap);
    }
        
        
    if(Trigger.isInsert && Trigger.isAfter)
    {
        //ContactTriggerHandler.updateRatingOnAccount(Trigger.New , null);
        ContactTriggerHandler.UpdateAccountRating(Trigger.New , null);
        //ContactTriggerHandler.updateTotalContacts(Trigger.New , null);
        //ContactTriggerHandler.update_Total_Contacts(Trigger.New , null);
        
        //ContactTriggerHandler.updateTotal(Trigger.New , null);//practise
        ContactTriggerHandler.sendEmail(Trigger.New);
    }
    else if(Trigger.isAfter && Trigger.isUpdate)
    {   ContactTriggerHandler.UpdateAccountRating(Trigger.New , Trigger.oldMap);
         //ContactTriggerHandler.updateTotalContacts(Trigger.New, Trigger.oldMap);
        //ContactTriggerHandler.update_Total_Contacts(Trigger.New , Trigger.oldMap);
        //ContactTriggerHandler.updateTotal(Trigger.New , Trigger.oldMap); //practise
    }
    else if(Trigger.isAfter && Trigger.isDelete)
    {
        
        //ContactTriggerHandler.updateTotalContacts(Trigger.old ,oldMap);
        //ContactTriggerHandler.update_Total_Contacts(Trigger.old , oldMap);
        
        //ContactTriggerHandler.updateTotal(Trigger.old , Trigger.oldMap);//practise
    }
    
    else if(Trigger.isAfter && Trigger.isUndelete)
    {
        //ContactTriggerHandler.updateTotalContacts(Trigger.New , null);
        //ContactTriggerHandler.update_Total_Contacts(Trigger.New , null);
        
        //ContactTriggerHandler.updateTotal(Trigger.New, null);//practise
    }
}