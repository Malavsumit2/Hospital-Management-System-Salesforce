public class EmployeeProfile {
       public static ID InsertEmployee(String name , String age , ID recordtypeID )
       {
         Employee_Profile__c emp = new Employee_Profile__c();
           
           emp.Name = name;          							//If there are two record types on Emplyoyee profile Than use Record ID of these Record Types
           emp.Age__c = age;								    // to insert records on Employee profile
           emp.RecordTypeId = recordtypeID ;
           insert emp;
           return emp.Id ;
       }
    
    public static void InsertPersonalDetail( String address , string country , ID profileID)
    {
       Employee_Personel_Detail__c data = new Employee_Personel_Detail__c();
        data.Address__c = address;
        data.Country__c = country;
        data.Employee_Profile__c = profileID;
        insert data ;
    }
    
}