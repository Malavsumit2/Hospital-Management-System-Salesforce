public class AppointmentTriggerHandler {
    //Task 10.1    
    public static void setConsultationFee(List<Appointment__c> appList)
    {
        for(Appointment__c doc : appList)
        {
            if(doc.Consultation_Fee__c == null)
            {
                if(doc.hospital_department__c == 'Cardiology')
                {
                    doc.Consultation_Fee__c = 1000;
                }
                else if(doc.hospital_department__c == 'Neurology')
                {
                    doc.Consultation_Fee__c = 1200;
                }
                else if(doc.hospital_department__c == 'Orthopedics')
                {
                    doc.Consultation_Fee__c = 900;
                }
                else if(doc.hospital_department__c == 'Pediatrics')
                {
                    doc.Consultation_Fee__c = 700;
                }
                else
                {
                    doc.Consultation_Fee__c = 500;
                }
            }
        }
    }
    
 //Task 10.2
    public static void preventDelete(List<Appointment__c> oldList)
    {
        Set<Id> appointmentIds = new Set<Id>();

        for(Appointment__c app : oldList)
        {
            appointmentIds.add(app.Id);
        }

        Set<Id> finalizedAppointmentIds = new Set<Id>();

        for(Medical_Record__c mr : [SELECT Id, Appointment__c FROM Medical_Record__c WHERE Appointment__c IN :appointmentIds AND Status__c = 'Finalized'])
      
        {
            finalizedAppointmentIds.add(mr.Appointment__c);
        }

        for(Appointment__c app : oldList)
        {
            if(finalizedAppointmentIds.contains(app.Id))
            {
                app.addError('Cannot delete Appointment because it has Finalized Medical Records.');
            }
        }
    }
    
//task 10.3

public static void updateCompletedAppointments(List<Appointment__c> newList,
                                               Map<Id, Appointment__c> oldMap)
{
    Set<Id> doctorIds = new Set<Id>();

    for(Appointment__c app : newList)
    {
        if(app.Doctor__c != null &&
           app.Current_Status__c == 'Completed' &&
           oldMap.get(app.Id).Current_Status__c != 'Completed')
        {
            doctorIds.add(app.Doctor__c);
        }
    }

    if(doctorIds.isEmpty())
    {
        return;
    }

    Map<Id, Integer> doctorCountMap = new Map<Id, Integer>();

    for(AggregateResult ar : [
        SELECT Doctor__c doctorId, COUNT(Id) total
        FROM Appointment__c
        WHERE Doctor__c IN :doctorIds
        AND Current_Status__c = 'Completed'
        GROUP BY Doctor__c
    ])
    {
        doctorCountMap.put(
            (Id)ar.get('doctorId'),
            (Integer)ar.get('total')
        );
    }

    List<Contact> doctorList = [
        SELECT Id, Total_Appointments_Completed__c
        FROM Contact
        WHERE Id IN :doctorIds
    ];

    for(Contact con : doctorList)
    {
        con.Total_Appointments_Completed__c = doctorCountMap.get(con.Id);
    }

    if(!doctorList.isEmpty())
    {
        update doctorList;
    }
}
    
    //Task 10.4
    
    public static void createAuditRecord(List<Appointment__c> appointmentList)
    {
        List<Appointment_Audit__c> auditList = new List<Appointment_Audit__c>();

        for(Appointment__c app : appointmentList)
        {
            auditList.add(new Appointment_Audit__c(
              Appointment__c = app.Id,
               Patient_Name__c = app.Patient__c,
               Restored_By__c = UserInfo.getName(),
              Restored_Date__c = System.now()
            ));
        }

        if(!auditList.isEmpty())
        {
            insert auditList;
        }
    }

    
    //future
    
    public static void addDoctorToEmergencyTeam(List<Appointment__c> appList)
    {
        Set<Id> doctorIds = new Set<Id>();

        for(Appointment__c app : appList)
        {
            if(app.Priority__c == 'High' && app.Doctor__c != null)
            {
                doctorIds.add(app.Doctor__c);
            }
        }

        if(!doctorIds.isEmpty())
        {
            EmergencyTeamFuture.addDoctorsToGroup(doctorIds);
        }
    }


}