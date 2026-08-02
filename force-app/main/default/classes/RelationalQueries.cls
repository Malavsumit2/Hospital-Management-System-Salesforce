public class RelationalQueries {
    public static void RelatedContacts(){
        LIST<Account> accList = new LIST<Account>();
        accList = [SELECT ID , Name , (SELECT ID,FirstName,LastName FROM Contacts) FROM Account WHERE Rating = 'Hot'] ;
        System.debug(accList);
        
        for(Account acc : accList)
        {
            System.debug('Account Name:'+acc.Name);
            for(Contact Cont : acc.Contacts)
            {
                System.debug(Cont.FirstName+ ' '+Cont.LastName);
            }
            
        }
        
        List<Employee_Profile__c> empProfile = new List<Employee_Profile__c>();
        empProfile = [SELECT Name , Email__c , (SELECT Name , Date_of_Birth__c ,Country__c FROM Employee_Personel_Details__r) FROM Employee_Profile__c LIMIT 10 ];
        System.debug(empProfile);
        for(Employee_Profile__c prof : empProfile)
        {
            System.debug(' Name:' + prof.Name);
            for(Employee_Personel_Detail__c per1 : prof.Employee_Personel_Details__r)
            {
                System.debug(per1.Name+ ' '+ per1.Date_of_Birth__c+ ' '+per1.Country__c);
            }
            
        }
        
        //fetching all accounts and related contacts 
        List<Account> accList1 = new List<Account>();
        accList1 = [SELECT Name , (SELECT FirstName , LastName , Email FROM Contacts) FROM Account];
        for(Account acc1 : accList1)
        {
            system.debug ('Account ID : '+ acc1.ID + ' , Account Name : '+ acc1.Name) ;
            system.debug('Total Contacts : '+acc1.contacts.size());
            for (Contact Cont1 : acc1.Contacts)
            {
                System.debug('Contact Name : '+ Cont1.FirstName + ' '+Cont1.LastName);
                System.debug('Contact Email :'+Cont1.Email);   
            }
            
        }
        
        //Fetching all Accounts and their opportunities
        List<Account> accList2 = new List<Account> ();
        accList2 = [SELECT Name , (SELECT Name , 	StageName , Amount FROM Opportunities) FROM Account] ; 
        for(Account acc2 : accList2 )
        {
            system.debug('Account Name :'+ acc2.Name);
            system.debug('Total Opportunities : '+ acc2.Opportunities.size());
            for(Opportunity opp : acc2.opportunities)
            {
                system.debug('Opp Name :'+ opp.Name);
                system.debug('Opp Stage:'+ opp.StageName);
                system.debug('Opp Amount:'+ opp.Amount);
            }
        }
    }
    
    public static void ChildParentRelation()
    {
        List<Contact> ConList = new List<Contact> () ;
        ConList = [SELECT FirstName , LastName , Account.Name FROM Contact];
        for(Contact Cont : ConList)
        {
            system.debug('Contact Name :'+Cont.FirstName + ' '+Cont.LastName);
            system.debug('Account Name : '+Cont.Account.Name);
        }
        
        List<Opportunity> oppList = new List<Opportunity>() ;
        oppList = [SELECT Name ,StageName , Amount , Account.Name FROM Opportunity ];
        for(Opportunity opp : oppList)
        {
            system.debug('opp Name :'+opp.Name );
            system.debug('StageName :'+opp.StageName);
            system.debug('Amount :'+opp.Amount);
            system.debug('Account Name : '+opp.Account.Name);
            
        }
        
    }
    public static void CustomObjectRelations()
    {   //Parent to Child
        LIST<Employee_Profile__c> emp = new LIST<Employee_Profile__c>();
        emp = [SELECT Name,Email__c , (SELECT Name , Date_of_Birth__c ,Country__c FROM Employee_Personel_Details__r) FROM Employee_Profile__c];
        for(Employee_Profile__c empDetail : emp)
        {
            system.debug('Employee Profile Name : '+empDetail.Name);
            system.debug('Employee Profile Email : '+empDetail.Email__c);
            for(Employee_Personel_Detail__c pr1 : empDetail.Employee_Personel_Details__r)
            {
                System.debug('Emp Name : '+pr1.Name);
                System.debug('Emp Date_of_Birth :'+pr1.Date_of_Birth__c);
                System.debug('Emp Country : '+pr1.Country__c);
                
            }
            
        }
        
        //Child to Parent
        
    }
    
    
}