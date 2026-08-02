public class PractiseDML {
    //Insert 5 Accounts with different Account Names and Phone 123456
    public static void Q1class()
    {
        LIST<Account> accList = new LIST<Account>() ;
        for(INTEGER i=1 ; i<=5 ;i++)
        {
            Account acc = new Account();
            acc.Name = 'Account00'+i ;
            acc.Phone = '123456';
            accList.add(acc);
        }
        insert accList ;
        
    }
    
    //Q2Insert 5 different opportunity with different name ,Close date = today,stage = 'Prospecting
    public static void Q2class()
    {
		LIST<Opportunity> oppList = new LIST<Opportunity>();
        for(INTEGER i=1;i<=5;i++)
        {
            Opportunity opp = new Opportunity() ;
            opp.Name = 'DemoOpp00'+i ;
            opp.CloseDate = date.today() ;
            opp.StageName = 'Prospecting';
            oppList.add(opp);
        }
        insert oppList ; 
    }
    
    //Q3Insert an Account along with 1 related contact
    public static void Q3Class()
    {
		Account acc = new Account();
        acc.Name = 'PractiseAcc';
        acc.Active__c = 'Yes';
        insert acc;
        
        Contact cont = new Contact();
        cont.FirstName = 'Practise';
        cont.LastName = 'Cont';
        cont.AccountId = acc.ID;
        insert cont;
    }
    
    //Q5.Insert 5 Accounts with atleast 1 opportunity
    public static void Q5Class()
    {
        LIST<Account> AccList = new LIST<Account>();
        for(INTEGER i=1;i<=5;i++)
        {
            Account acc = new Account();
            acc.Name = 'AccQ'+i;
            acc.Active__c= 'Yes';
            AccList.add(acc);
        }
        insert accList ;
        
        LIST<Opportunity> oppList = new LIST<Opportunity>() ;
        INTEGER i=1;
        for(Account acc : accList)
        {   
            Opportunity opp = new Opportunity();
            opp.AccountId = acc.Id ;
            opp.Name = 'AccOpp'+i;
            opp.StageName = 'Prospecting';
            opp.CloseDate = date.today() ;
            oppList.add(opp);
            i++;
        }
        insert oppList;
        
    }
    //Q8 : Query contacts where email is null
    public static void ClassQ8()
    {
        LIST<Contact> ContList = new LIST<Contact>();
        ContList = [SELECT FirstName ,LastName FROM Contact WHERE Email = NULL ];
        System.debug(ContList.size());
        if(!ContList.isEmpty())
        {
           for(Contact Con : ContList )
        {
            Con.Email = 'test@test.com' ;
        } 
            update ContList ;
        }
        
    }
}