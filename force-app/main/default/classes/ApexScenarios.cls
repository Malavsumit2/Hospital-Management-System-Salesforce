public class ApexScenarios {
    //Scenario 1 
    public static void Scenario1()
    {
        LIST<Account> Acclist = new LIST<Account>();
        AccList = [SELECT ID , Name , Phone  , (SELECT ID  , FirstName , LastName FROM Contacts) FROM Account WHERE Phone != NULL] ;
        for(Account acc : AccList)
        {
            if(!AccList.isEmpty())
            {
                System.debug(acc.Name+' has '+acc.Contacts.size()+ ' contacts') ;
            }
        }
    }
    
    //Scenario2
    public static void Scenario2()
    {
        LIST<Account> AccList = new LIST<Account>();
        AccList = [SELECT ID , Name , Phone  , (SELECT ID , Amount FROM Opportunities ) 
                   FROM Account WHERE Phone != NULL] ;
        if(!AccList.isEmpty())
        {
            for(Account acc : AccList)
            {
                DECIMAL Total_Amount = 0;
                for(Opportunity opp : acc.Opportunities)
                {    if(opp.Amount != NULL)
                {
                    Total_Amount = Total_Amount + opp.amount ;                    
                }
                 
                }
                system.debug(acc.Name+' has total amount of : '+Total_Amount +'worth of opportunities ');
            }
        }
    }
    
    //Scenario3 
    public static void Scenario3()
    {
        LIST<Opportunity> oppList = new LIST<Opportunity>() ; 
        oppList = [SELECT ID , StageName 
                   FROM Opportunity
                   WHERE CreatedDate = THIS_YEAR] ;
        if(!oppList.isEmpty())
        {
            for(Opportunity opp : oppList)
            {
                if(opp.StageName == 'Closed Won')
                {
                    opp.Description = 'Opportunity is Closed Won !!!!' ;
                }
                else if(opp.StageName == 'Closed Lost')
                {
                    opp.Description = 'Opportunity is Closed Lost !!!!';
                }
                else
                {
                    opp.Description = 'Opportunity is Open!!!!';
                }
            }
            update oppList ;
        }
        
    }
    //Scenario 4
    public static void Scenario4()
    {
        LIST<Account> accList = new LIST<Account>();
        accList = [SELECT Name , (SELECT ID FROM Contacts) 
                   FROM Account WHERE CreatedDate = THIS_YEAR] ;
        if(!accList.isEmpty())
        {
            for(Account acc : accList)
            {   
                if(acc.Contacts.size() > 0)
                {
                    acc.Total_Contacts__c = acc.Contacts.size();
                }
                else
                {
                    acc.Total_Contacts__c = 0;
                }
                
            }
            update accList ;
        }
    }
    //Scenario 5
    public static void Scenario5()
    {
        LIST<Contact> conList = new LIST<Contact>();
        conList = [SELECT ID , FirstName , LastName , MobilePhone , Account.Phone FROM Contact WHERE CreatedDate = THIS_YEAR];
        for(Contact Cont :conList)
        {
            if(!conList.isEmpty())
            {
                if(Cont.MobilePhone == NULL && Account.Phone != NULL)
                {
                    Cont.MobilePhone = Cont.Account.Phone ;
                }
            }
        }
        update conList ;  
    }
    //Q1
    public static void UpdateEmployee()
    {
        LIST<Account> AccList = new LIST<Account>();
        AccList = [SELECT ID , Name , (SELECT Name , Salary__c ,Phone__c FROM Employees__r) FROM Account WHERE CreatedDate = THIS_YEAR];
        if(!AccList.isEmpty())
        {   
            for(Account acc : AccList)
            {
                Decimal totalSalary = 0;
                for(Employee__c emp : acc.Employees__r)
                {
                    if(emp.Salary__c != NULL)
                    {
                        totalSalary = totalSalary + emp.Salary__c ;
                    }
                }
               acc.Total_Salary__c =  totalSalary;
            }
            update AccList;
        }
        
    }
    //Delete Accounts starting with Demo
    public static void DeleteAccounts()
    {
        LIST<Account> AccList = new LIST<Account>();
        AccList = [SELECT Name , ID FROM Account WHERE Name LIKE  'Account%'];
        Delete AccList ;
    }
}