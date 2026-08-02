public class AggregateMethods {
    //Q1. Count Total Accounts
    public static void CountAccounts()
    {
        Integer totalAccounts = [SELECT COUNT() FROM Account];
        
        System.debug('Total Accounts : ' + totalAccounts);
    }
    
    //Q2. Count Accounts where Industry is not Null
    public static void CountIndustry()
    {
        AggregateResult ar =
            [
                SELECT COUNT(Industry) totalIndustry
                FROM Account
            ];
        
        Integer totalIndustry = (Integer)ar.get('totalIndustry');
        
        System.debug('Total Industry Accounts :'+ totalIndustry);
    }
    
    //Count Accounts where Industry is not Null
    public static void CountAccountType()
    {
        AggregateResult ar1 = [
            SELECT COUNT(Type) TotalType
            FROM Account
        ];
        Integer totalType = (Integer)ar1.get('TotalType');
        System.debug('Total Type Accounts : '+ totalType);
    }
    
    //Q3. Count Distinct Industries
    public static void CountDistinctIndustry()
    {
        AggregateResult ar =
            [SELECT COUNT_DISTINCT(Industry) totalIndustry
             FROM Account];
        
        Integer countIndustry = (Integer)ar.get('totalIndustry');
        
        System.debug('Distinct Industries : ' + countIndustry);
    }
    //Q4. Find Maximum Annual Revenue
    public static void MaxRevenue()
    {
        AggregateResult ar =
            [SELECT MAX(AnnualRevenue) MaxRevenue
             FROM Account];
        
        Decimal revenue = (Decimal)ar.get('MaxRevenue');
        
        System.debug('Maximum Revenue : ' + revenue);
    }
    //Q5 Avg of Annual Revenue
    public static void AvgRevenue()
    {
        AggregateResult ar = [SELECT Avg(AnnualRevenue) AvgAnnRevenue FROM Account];
        Decimal AvgRevenue = (Decimal)ar.get('AvgAnnRevenue');
        System.debug('Average Revenue : ' + AvgRevenue);
        
    }
    
    //Q6. Find Minimum Annual Revenue
    public static void MiniRevenue()
    {
        AggregateResult ar = [SELECT MIN(AnnualRevenue) MinRevenue FROM Account];
        Decimal minimumRevenue = (Decimal)ar.get('MinRevenue');
        system.debug('Minimum Revenue:'+ minimumRevenue);
        
    }
}