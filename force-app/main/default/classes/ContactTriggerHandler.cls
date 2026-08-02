public class ContactTriggerHandler {
    //After Update | After Insert : When A contact is created or update a AmountRating field
    //than automatically copy that value to Rating in Account
    public static void updateRatingOnAccount(List<Contact> conList , Map<ID,Contact> conOldMap)
    {   List<Account> accList = new List<Account>() ;
     for(Contact con : conList)
     {
         if(con.AccountId != null && (conOldMap==null || con.AmountRating__c != conOldMap.get(con.ID).AmountRating__c))
         {
             Account acc = new Account () ;
             acc.Rating = con.AmountRating__c ;
             acc.ID = con.AccountId ;
             accList.add(acc);
         }
     }
     if(!accList.isEmpty())
     {
         update accList ;
     }
    }
    
    // After Insert | After Delete : Update total Contact field on Account When a contact is created or deleted
    public static void updateTotalContacts(List<Contact> conList , Map<ID , Contact>oldConMap)
    {
        Set<ID> accIds = new Set<ID>();
        for(Contact con : conList)
        {
            if(oldConMap == null) //This is for insertion and Deletion only
                
            {
                if(con.AccountId != Null)
                {
                    accIds.add(con.AccountId);
                }
            }
            
            //This is for Updation And here we have to add new acc ID and Old acc ID to set
            else if (oldConMap != null )
            {   
                if (con.AccountId != null )//Adding newly updated Account ID to the set
                {
                    accIds.add(con.AccountId);   
                }
                
                Contact oldContact = oldConMap.get(con.ID) ;//Adding previous Account ID to the Set
                if(oldContact.AccountId != null)
                {
                    accIds.add(oldContact.AccountId); 
                }
            }
            
            
        }
        
        List<Account> accList = [SELECT ID , (SELECT ID FROM Contacts) FROM Account
                                 WHERE ID IN: accIds] ;
        
        for(Account acc : accList)
        {
            acc.Total_Contacts__c = acc.Contacts.Size() ;
        }
        
        if(!accList.isEmpty())
        {
            update accList ; 
        }
    }
    
    // After Insert | After Delete | After Update | After Undelete: Update total Contact field on 
    // Account When a contact is created updated deleted or undeletedthrough Aggregate Function 
    public static void update_Total_Contacts(List<Contact> conList , Map<ID , Contact> conOldMap)
    {
        set<ID> accIds = new set<ID>();
        for(Contact con : conList )
        {
            if(conOldMap == null)
            {
                if(con.AccountId != null)
                {
                    accIds.add(con.AccountId);
                }
            }
            
            else if(conOldMap != null)
            {
                if(con.AccountId != null) //Adding Newly Account Updated ID into the set
                {
                    accIds.add(con.AccountId);
                }
                
                //If the Account on Contact is updated 
                Contact oldContact = conOldMap.get(con.ID);
                if(oldContact.AccountId != null)
                {
                    accIds.add(oldContact.AccountId); //Adding old or previous Account ID before update
                }
                
            }
        }
        
        List<AggregateResult> arList = [SELECT AccountID , Count(ID) TotalContacts
                                        FROM Contact 
                                        WHERE AccountID IN: accIds GROUP BY AccountID];
        
        Map<ID , INTEGER> CountContactMap = new Map<ID,Integer> ();
        
        for(AggregateResult ar : arList)
        {
            ID accID = (ID)ar.get('AccountID');
            INTEGER countContact = (Integer)ar.get('TotalContacts');
            CountContactMap.put(accID , countContact);
        }
        
        //List of Account where Contacts are related 
        List<Account> accList = new List<Account>();
        for(ID accID : accIDs)
        {
            Account acc = new Account();
            acc.ID = accID ;
            if(CountContactMap.containsKey(accID))
            {
                acc.Total_Contacts__c = CountContactMap.get(accID);
                
            }
            else
            {
                acc.Total_Contacts__c = 0;  
            }
            accList.add(acc);
        }
        
        if(!accList.isEmpty())
        {
            update accList ; 
        }
    }
    
    //-------------------------------------------------------------------PRACTISE-----------------------------------------------------------------------------------------------------
    //Q1
    //After Update | After Insert : When A contact is created or update a AmountRating field
    //than automatically copy that value to Rating in Account
    
    public static void UpdateAccountRating(List<Contact> conList , Map<ID,Contact> oldConMap)
    {
        List<Account> accList = new List<Account>();
        for(Contact con : conList)
        {   //It is for Insertion
            if(con.AccountId != null ) //&& oldConMap ==null)
            {
                Account acc = new Account();
                acc.ID = con.AccountId ;
                acc.Rating = con.AmountRating__c ;
                accList.add(acc);
            }
            if(con.AccountID != null && oldConMap!=null)
            {
                if(con.AmountRating__c != oldConMap.get(con.ID).AmountRating__c)
                {
                    Account acc = new Account();
                    acc.Rating = con.AmountRating__c;
                    acc.ID = con.AccountId ;
                    accList.add(acc);
                }
            }   
        }
        if(!accList.isEmpty())
        {
            update accList ;
        }
    }
    
    //Q2
    // After Insert | After Delete | After Update | After Undelete: Update total Contact field on 
    // Account When a contact is created updated deleted or undeletedthrough Aggregate Function 
    
    public static void updateTotalCon (List<Contact> conList , Map<ID,Contact> oldConMap )
    { 
        set<ID> accIds = new set<ID>();
        
        for(Contact con : conList)
        {   if(oldConMap == null)
        {
            if(con.AccountId != null)
            {
                accIds.add(con.AccountId);
            } 
        }
         
         else if(oldConMap != null)
         {
             if(con.AccountId != null)
             {
                 accIds.add(con.AccountId);
             }
             
             if (con.AccountId != oldConMap.get(Con.ID).AccountID  && oldConMap.get(Con.ID).AccountID != null)
             {
                 accIds.add(oldConMap.get(Con.ID).AccountID);
             }
         }
         
        }
        
        List<AggregateResult> arList = [SELECT AccountId , Count(ID) totalCon FROM Contact WHERE AccountId IN : accIds GROUP BY AccountId];
        Map<ID,INTEGER> CountContacts = new Map <ID,INTEGER>();
        for(AggregateResult ar : arList)
        {
            CountContacts.put((ID)ar.get('AccountId') , (INTEGER)ar.get('totalCon')) ;
        }
        
        List<Account> accList = new List<Account>();
        for(ID accID  : accIds)
        {
            Account acc = new Account();
            acc.ID = accID ;
            if(CountContacts.containsKey(accID))
            {
                acc.Total_Contacts__c = CountContacts.get(accID) ;
            }
            else
            {
                acc.Total_Contacts__c = 0;
            }
            
            accList.add(acc);            
        }
        if(!accList.isEmpty())
        {
            update accList ;
        }
    }
    //Q3 by contact.size()
    // After Insert | After Delete | After Update | After Undelete: Update total Contact field on 
    // Account When a contact is created updated deleted or undeletedthrough Aggregate Function
    public static void updateTotal(List<Contact> conList , Map<ID,Contact> oldConMap)
    {    set<ID> accIds = new set<ID>() ;
     for(Contact con : conList)
     {   if(oldConMap == null)
     {
         if(con.AccountId != null)
         {
             accIds.add(con.AccountId); 
         }
     }
      
      if(oldConMap!=null )
      {
          if(con.AccountId != null)
          {
              accIds.add(con.AccountId) ;
          }
          
          if(con.AccountId != oldConMap.get(con.ID).AccountId  && oldConMap.get(con.ID).AccountId != null)
          {
              accIds.add(oldConMap.get(con.ID).AccountId) ;
          }
      }
     }
     
     List<Account> accList = [SELECT ID , (SELECT ID FROM Contacts) FROM Account Where ID IN : accIds ] ;
     for(Account acc : accList)
     {
         acc.Total_Contacts__c = acc.Contacts.size() ;
     }
     if(!accList.isEmpty())
     {
         update accList ;
     }
    }
    //Sending Email to contactID when contact is inserted  //After Inert 
    public static void sendEmail(List<Contact> conList)
    {
        System.debug('Inside sendEmail Method');
        
        EmailTemplate et = [SELECT ID FROM EmailTemplate WHERE DeveloperName = 'DemoEmailTemplate' LIMIT 1] ;
        List<Messaging.SingleEmailMessage> email = new List<Messaging.SingleEmailMessage>();
        
        for(Contact con : conList)
        {
            if(con.Email != null)
            {   
                System.debug(con.Email);
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setTargetObjectId(con.ID);
                mail.setTemplateId(et.ID);
                mail.setSaveAsActivity(false);
                email.add(mail);
            }
        }
        if(!email.isEmpty())
        {
            Messaging.sendEmail(email);
        }
          
    }
    //Write a trigger on Contact to prevent duplicate records based on contact email and phone 
    public static void preventDuplicate(List<Contact> conList , Map<ID , Contact> conOldMap)
    {
        Set<String> newEmailSet = new Set<String>() ;
        Set<String> newPhoneSet = new Set<String>() ; 
        for(Contact con : conList)
        {
           
                if(con.Email != null)
                {
                    newEmailSet.add(con.Email.toLowercase());
                }
                if(con.Phone != null)
                {
                    newPhoneSet.add(con.Phone);
                }
         
        }
    
       List<Contact> contactList = [
    SELECT Email, Phone
    FROM Contact
    WHERE Email IN :newEmailSet
       OR Phone IN :newPhoneSet
];

Set<String> existingEmails = new Set<String>();
Set<String> existingPhones = new Set<String>();

for(Contact c : contactList){
    if(c.Email != null){
        existingEmails.add(c.Email.toLowerCase());
    }
    if(c.Phone != null){
        existingPhones.add(c.Phone);
    }
}

for(Contact con : conList){
    if(con.Email != null && existingEmails.contains(con.Email.toLowerCase())){
        con.addError('Email already exists.');
    }

    if(con.Phone != null && existingPhones.contains(con.Phone)){
        con.addError('Phone already exists.');
    }
}
    }
               
    
}