trigger AppointmentTrigger on Appointment__c (before insert , after insert) {
    if(Trigger.isBefore)
    {
        if(Trigger.isInsert)
        {
            //AppointmentTriggerHandler.createAppointment(Trigger.New);
        }
    }
    
    else if (Trigger.isAfter)
    {
        if(Trigger.isInsert)
        {
            //AppointmentTriggerHandler.createTask(Trigger.New);
        }
    }
}