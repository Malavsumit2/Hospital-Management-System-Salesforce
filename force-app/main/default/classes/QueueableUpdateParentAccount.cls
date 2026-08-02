//Update Parent Account Through Queueable Apex
public class QueueableUpdateParentAccount implements Queueable {
    //Class variable
    private List<Account> accList ;
    Private ID parentAccId ;
    
    //Constructor 
    public QueueableUpdateParentAccount(List<Account> accRecords , ID accId)
    {
        this.accList = accRecords ;
        this.parentAccId = accId ;
    }
    
    //Method
    public void execute(QueueableContext context)
    {
        for(Account acc : accList)
        {
            acc.ParentId = parentAccId ;
        }
        update accList ;
    }
    
    

}