public class Aggregate_Functions_Demo {
    //Q1 Total Contacts in your Org
    public static void AggregateDemo()
    {
        Integer TotalContact = [SELECT Count() FROM Contact];
        System.debug('Total Contacts are : ' + TotalContact );
        
        
        //Q2 On opportunities Calculate the total Amount on All Closed Won opportunities
        AggregateResult ar = [SELECT SUM(Amount) TotalAmount FROM Opportunity WHERE StageName = 'Closed Won'];
        Decimal Total_Amount = (Decimal)ar.get('TotalAmount') ;
        System.Debug('Total_Amount: '+Total_Amount);
    }
}