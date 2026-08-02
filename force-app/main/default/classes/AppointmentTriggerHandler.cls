public class AppointmentTriggerHandler {
        //Whenever a new Appointment__c record is created:
        //If Appointment_Date__c is blank, populate it with Today's Date.
        //If Priority__c is blank, set it to Medium.
        //If Status__c is blank, set it to Scheduled.
        
        public static void createAppointment(List <Appointment__c> appList)
        {   if(!appList.isEmpty())
        {
            for(Appointment__c app : appList )
            {
                if(app.Appointment_Date__c == NULL )
                {
                    app.Appointment_Date__c = date.Today() ; 
                }
                if (app.Priority__c == NULL)
                {
                    app.Priority__c = 'Medium';  
                }
                if (app.Current_Status__c == NULL)
                {
                    app.Current_Status__c = 'Cancelled';
                }
                
            }
        }  
        }
        
    //Whenever a new Medical_Record__c record is created:
    //Automatically create a Task.
    //Task Subject = Review Medical Record
    //Status = Not Started
    //Priority = High
    //Relate the Task to the newly created Medical Record (using WhatId).
    public static void createTask(List<Appointment__c> appList)
    {
        List<Task> TaskList = new List<Task>();
        if(!appList.isEmpty())
        {
            for(Appointment__c app : appList )
            {
                Task Demotask = new Task();
                Demotask.Subject = 'Review Medical Record';
                Demotask.Status = 'Not Started';
                Demotask.Priority = 'High';
                Demotask.WhatId = app.Id ;
                TaskList.add(Demotask);
            }
            if(!TaskList.isEmpty())
            {
               insert TaskList ; 
            }
            
        }
    }
    }