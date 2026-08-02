public class QueueableCreateContactOnAccount implements Queueable{
     
    public void execute(QueueableContext qc)
    {
        List<Account> accList = [SELECT ID FROM Account WHERE Industry = 'Media' ] ;
        List<Contact> conList = new List<Contact>();
        
        Contact masterCon  = new Contact();
        masterCon.FirstName = 'Seeta';
        masterCon.LastName = 'Agarwal' ;
        
        insert masterCon;
        
        
        for(Account acc : accList)
        {
            Contact con = masterCon.clone(false,false,false,false);
            con.AccountId = acc.ID ;
            conList.add(con);
            
        }
        
        insert conList ;
        
    }
}