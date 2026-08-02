public class AccountTriggerHandler {
    //Updating Description through Trigger
    public static void UpdateDesc(LIST<Account> accList)
    {
        for(Account acc : accList)
        {
            acc.Description = 'Account is Created Through Trigger called from TriggerHandler';
            
        }
    }
    
    //Update Rating Through Trigger During a newly Account creation
    public static void UpdateRating(LIST<Account> accList)
    {
        for(Account acc : accList)
        {
            acc.Rating = 'Warm';
        }
    }
    //Update Industry Through Trigger During a newly Account creation
    public static void UpdateIndustry(List<Account> accList)
    {
        for(Account acc : accList)
        {
            acc.Industry = 'IT';
        }
    }
    //Convert Name of Account to upper case
    public static void UpperCase(List<Account> accList)
    {
        for(Account acc : accList)
        {
            acc.Name = acc.Name.toUppercase() ;
        }
    }
    //Add Prefix to Account Name 
    public static void AddPrefix(List<Account> accList)
    {
        for(Account acc : accList)
        {
            acc.Name = 'Acc'+acc.Name;
        }
    }
    // Show Alert while saving if Phone field is blank
    public static void ShowAlert(List<Account> accList)
    {
        for(Account acc : accList)
        {
            if(acc.Phone == NULL)
            {
                acc.Phone.addError('You cant save record if Phone is Blank') ; //addError is Reserved Keyword to Block  
                // saving of the record
            }
        }
    }
    //If Account Industry is Not Null and having value as Media than populate rating as hot
    public static void updateAccRating(List<Account> accList)
    {
        for(Account acc : accList)
        {
            if(!accList.isEmpty() && acc.Industry != NULL && acc.Industry == 'Media')
            {
                acc.Rating = 'Hot';
            }
        }
    }
    //Creating Opportunity when an account is created 
    public static void createOpp(List<Account> accList)
    {   LIST<Opportunity> oppList = new LIST<Opportunity>() ;
     if(!accList.isEmpty())
     {   
         
         for(Account acc : accList)
         {
             Opportunity opp = new Opportunity();
             opp.Name = acc.Name+'opp' ;
             opp.StageName = 'Needs Analysis' ;
             opp.CloseDate = date.today() ;
             opp.AccountId = acc.Id ;
             oppList.add(opp);
             
         }
         if(!oppList.isEmpty())
         {
             insert oppList ;
         }
         
     }
     
    }
    
    //copy billing address to shiping address when account is created 
    public static void copyBillingAddress(List<Account> accList)
    {
        if(!accList.isEmpty())
        {
            for(Account acc : accList)
            {
                if(String.isBlank(acc.ShippingStreet)   //Since Shipping Address is having multiple compound fields so
                   //we check blank fields through String.isBlank(--fieldName--);
                   && String.isBlank(acc.ShippingCity)
                   && String.isBlank(acc.ShippingState)
                   && String.isBlank(acc.ShippingPostalCode)
                   && String.isBlank(acc.ShippingCountry))
                {   
                    acc.ShippingStreet = acc.BillingStreet ;
                    acc.ShippingCity = acc.BillingCity ;
                    acc.ShippingCountry = acc.BillingCountry;
                    acc.ShippingCountryCode = acc.BillingCountryCode ;
                    acc.ShippingState = acc.BillingState;
                    acc.ShippingPostalCode = acc.BillingPostalCode;
                }
            }
        }
    }
    
    //Before Update : If Account Phone is Updated then put update message in Description 
    public static void UpdateAccDesc(List<Account> accList , Map < ID , Account> accOldMap )  //here accList will store new phone number and 
        //map will store old values 
    {
        for(Account acc : accList)
        {
            if(acc.Phone != accOldMap.get(acc.ID).Phone)
            {
                acc.Description = 'Account Phone is Updated | old value was: '+accOldMap.get(acc.ID).Phone + ' | New value was : '+acc.Phone ;
            }
        }
    }
    
    //upon Account Creation or updation if account industry is not null and having
    //a value as MEDIA than populate Rating as HOT
    public static void updateAccRating(List<Account> accList, Map<Id, Account> oldAccMap)
    {
        for(Account acc : accList)
        {
            // Before Insert  : //It checks when a new account is created
            if(oldAccMap == null)
            {
                if(acc.Industry == 'Media')
                {
                    acc.Rating = 'Hot';
                }
            }
            
            // Before Update  : It checks when an Account is updated
            else
            {
                if(acc.Industry == 'Media' && acc.Industry != oldAccMap.get(acc.Id).Industry)
                {
                    acc.Rating = 'Hot';
                }
            }
        }
    }
    
    //After Update | If Account Phone is Updated then populate phone number on all related contacts
    public static void Update_Home_Phone_on_Contact(List<Account> accList , Map<ID , Account> accOldMap)
    {
        
        Map<ID , Account> accMap = new Map<ID,Account>(); //This will store information of Updated Account.Phone
        
        
        
        for(Account acc : accList)
        {
            if(acc.Phone != accOldMap.get(acc.ID).Phone)
            {
                accMap.put(acc.ID , acc);
            }
        }
        
        List<Contact> conList_AccID = [SELECT ID , HomePhone , AccountID
                                       FROM Contact WHERE AccountID IN : accMap.Keyset()] ; //This list will store all the Contacts related to AccountID
        
        
        List<Contact> conList = new List<Contact>() ;  // newly created List to store updated Contacts
        
        for(Contact con :conList_AccID )
        {
            con.HomePhone = accMap.get(con.AccountID).Phone ;
            conList.add(con);
        }
        if(!conList.isEmpty())
        {
            update conList ;
        }
    }
    
    // After Update | If Account AnnualRevenue is Updated, update Amount_Rating__c on all 
    // related Opportunities based on AnnualRevenue (Low/Medium/High).
    public static void UpdateAmountRating(List<Account> accList, Map<ID, Account> accOldMap)
    {
        Map<ID, Account> acc_ID_Map = new Map<ID, Account>();
        
        if(!accList.isEmpty())
        {
            for(Account acc : accList)
            {
                if(acc.AnnualRevenue != accOldMap.get(acc.ID).AnnualRevenue)
                {
                    acc_ID_Map.put(acc.ID, acc);
                }
            }
        }
        
        List<Opportunity> oppList_to_Store_AccID = [
            SELECT Amount_Rating__c, AccountID
            FROM Opportunity
            WHERE AccountID IN :acc_ID_Map.keySet()
        ];
        
        List<Opportunity> oppList = new List<Opportunity>();
        
        if(!oppList_to_Store_AccID.isEmpty())
        {
            for(Opportunity opp : oppList_to_Store_AccID)
            {
                if(acc_ID_Map.get(opp.AccountId).AnnualRevenue <= 2000)
                {
                    opp.Amount_Rating__c = 'Low';
                    oppList.add(opp);
                }
                else if(acc_ID_Map.get(opp.AccountId).AnnualRevenue > 2000 &&
                        acc_ID_Map.get(opp.AccountId).AnnualRevenue <= 5000)
                {
                    opp.Amount_Rating__c = 'Medium';
                    oppList.add(opp);
                }
                else
                {
                    opp.Amount_Rating__c = 'High';
                    oppList.add(opp);
                }
            }
            
            if(!oppList.isEmpty())
            {
                update oppList;
            }
        }
    }
    
    //Before Update | Copy Billing Address to Shipping Address on Account Creation And Updation
    public static void Copy_Billing_Address(List<Account> accList , Map<ID , Account> accOldMap)
    {
        for(Account acc : accList)
        {   
            if(accOldMap == NULL)
            {
                if(acc.Copy_Billing_Address_to_Shipping_Address__c)  //When a new Account is creted
                {
                    acc.ShippingCity = acc.BillingCity ;
                    acc.ShippingCountry = acc.BillingCountry ;
                    acc.ShippingCountryCode = acc.BillingCountryCode ;
                    acc.ShippingState = acc.BillingState ;
                    acc.ShippingPostalCode = acc.BillingPostalCode ;
                    acc.ShippingStreet = acc.BillingStreet ;
                    
                } 
            }
            else if (accOldMap != null)
            {
                if(acc.Copy_Billing_Address_to_Shipping_Address__c 
                   && acc.Copy_Billing_Address_to_Shipping_Address__c !=  accOldMap.get(acc.ID).Copy_Billing_Address_to_Shipping_Address__c)
                {
                    acc.ShippingCity = acc.BillingCity ;
                    acc.ShippingCountry = acc.BillingCountry ;
                    acc.ShippingCountryCode = acc.BillingCountryCode ;
                    acc.ShippingState = acc.BillingState ;
                    acc.ShippingPostalCode = acc.BillingPostalCode ;
                    acc.ShippingStreet = acc.BillingStreet ; 
                }
            }  
            
        }
    }
    //After Update | when Account Billing Address is updated than populate Account Billing Address on all related contacts Mailing Address
    public static void updateMailingAddressOnContacts(List<Account> accList , Map<ID,Account> accOldMap)
    {
        Map<ID , Account> accMap = new Map<ID,Account>();
        
        if(!accList.isEmpty() && accOldMap != null)
        {
            for(Account acc : accList)
            {
                if(acc.BillingCity != accOldMap.get(acc.ID).BillingCity  ||
                   acc.BillingCountry != accOldMap.get(acc.ID).BillingCountry  ||                 
                   acc.BillingState != accOldMap.get(acc.ID).BillingState  ||
                   acc.BillingStreet != accOldMap.get(acc.ID).BillingStreet)
                {
                    accMap.put(acc.ID , acc);
                }
            }
        }
        List<Contact> conList = [SELECT MailingAddress , AccountID
                                 FROM Contact WHERE AccountID IN: accMap.Keyset()] ;
        
        List<Contact> conListNew = new List<Contact>();
        
        if(!conList.isEmpty())
        {
            for(Contact con : conList)
            {
                con.MailingCity = accMap.get(con.AccountId).BillingCity ;
                con.MailingCountry = accMap.get(con.AccountId).BillingCountry ;
                con.MailingState = accMap.get(con.AccountId).BillingState ;
                con.MailingStreet = accMap.get(con.AccountId).BillingStreet ;
                conListNew.add(con);        
            }
            if(!ConListNew.isEmpty())
            {
                update ConListNew ;
            }
        }
    }
    //After Update | When rating is updated on Account , Copy Rating to Amount Rating field on All related Contacts
    public static void copyRatingOnContact(List<Account> accList , Map<ID,Account> accOldMap)
    {
        Map<ID,Account> accMap = new Map<ID , Account>();
        if(!accList.isEmpty() && accOldMap != null)
        {
            for(Account acc : accList)
            {
                if(acc.Rating != accOldMap.get(acc.ID).Rating )
                {
                    accMap.put(acc.ID , acc);
                }
            }
            
            List<Contact> conList = [SELECT AmountRating__c , AccountID 
                                     FROM Contact WHERE AccountID IN : accMap.keySet()];
            
            List<Contact> conListNew = new List<Contact>();
            if(!conList.isEmpty())
            {
                for(Contact con : conList)
                {
                    con.AmountRating__c = accMap.get(con.AccountId).Rating ;
                    conListNew.add(con);
                }
                
                if(!conListNew.isEmpty())
                {
                    update conListNew ;
                }
            }
            
            
        }
    }
    // Before Update | Prevent updating Account if account is created 7 days before today 
    public static void preventAccount(List<Account> accList)
    {
        for(Account acc : accList)
        {
            if(acc.CreatedDate > (date.Today() - 7))  //Is condition ko samajne ke liye paper par date likh ke implement kro
            {
                acc.addError('You cant update Account which are created within last 7 days') ;
               
            }
        }
    }
    
    //Before delete | Prevent Deletion of the Account if Active is Yes . Use Custom label to show Error
    //Allow System Administrator to Delete 
    public static void preventDeletion(List<Account> accList)  //Here List will store Old values as we are using Delete 
    {   
        Profile prof = [SELECT ID FROM Profile WHERE Name  = 'System Administrator'] ;
        for(Account acc : accList)
        {
            if(userInfo.getProfileId() != prof.Id   ||     acc.Active__c == 'Yes')
            {
                acc.addError(Label.Prevent_Account_Deletion) ;
            }
        }
    }
    //-----------------------------------------------------------Practise-----------------------------------------------------------------------------------------------------------
    //After Update | If Account Phone is Updated then populate phone number on all related contacts
    public static void populatePhone(List<Account> accList , Map<ID,Account> accOldMap)
    {
        Map<ID , Account> accMap = new Map<ID,Account>();
        for(Account acc : accList)
        {
            if(acc.Phone != accOldMap.get(acc.ID).Phone )
            {
                accMap.put(acc.ID , acc);
            }
        }
        if(accMap.isEmpty())
        {
            return ;
        }
        
       List<Contact> conList = [SELECT ID ,AccountId ,  HomePhone FROM Contact Where AccountId IN : accMap.keyset() ];
        for(Contact con : conList)
        {
            con.HomePhone  = accMap.get(con.AccountId).Phone ;
        }
        
        if(!conList.isEmpty())
        {
            update conList ;
        }
       
        
    }
    //After Update | If Account AnnualRevenue is Updated, update Amount_Rating__c on all 
    // related Opportunities based on AnnualRevenue (Low/Medium/High).
    public static void updateOppRating(List<Account> accList , Map<ID , Account> accOldMap)
    {
        Map<ID,Account> accMap = new Map<ID,Account>();
        
        for(Account acc : accList)
        {
            if(acc.AnnualRevenue != accOldMap.get(acc.ID).AnnualRevenue)
            {
                accMap.put(acc.ID , acc) ;
            }
        }
        
        List<Opportunity> oppList = [SELECT ID , AccountId FROM Opportunity Where AccountId IN : accMap.keySet()];
        for(Opportunity opp : oppList)
        {
            if(accMap.get(opp.AccountId).AnnualRevenue  < 2000 )
            {
                opp.Amount_Rating__c = 'Low';
            }
            else if(accMap.get(opp.AccountId).AnnualRevenue  >= 2000 && accMap.get(opp.AccountId).AnnualRevenue  < 5000)
            {
                opp.Amount_Rating__c = 'Medium';
            }
            else
            {
                opp.Amount_Rating__c = 'High';
            }
        }
        if(!oppList.isEmpty())
        {
            update oppList ;
        }
    }
}