public class LoopsDemo {
    
    //=========================================================
    // Q0 - Find Greater Number using Ternary Operator
    //=========================================================
    public static void TernaryOperator(Integer num1, Integer num2)
    {
        // Ternary Operator
        // Syntax:
        // condition ? true_value : false_value
        
        Integer result = num1 > num2 ? num1 : num2;
        
        System.debug(result + ' is greater');
    }
    
    
    //=========================================================
    // Q1 - Print Table of a Number
    // Example:
    // Input : 5
    // Output:
    // 5*1=5
    // 5*2=10
    // ...
    // 5*10=50
    //=========================================================
    public static void Table(Integer num)
    {
        for(Integer i = 1; i <= 10; i++)
        {
            System.debug(num + ' * ' + i + ' = ' + (num * i));
        }
    }
    
    
    //=========================================================
    // Q2 - Print Even Numbers
    // Method 2 (Using Mod Function)
    //
    // Example:
    // Input : 10
    // Output:
    // 2
    // 4
    // 6
    // 8
    // 10
    //=========================================================
    public static void PrintEven(Integer num)
    {
        for(Integer i = 1; i <= num; i++)
        {
            // Even Number => remainder = 0
            if(Math.mod(i,2) == 0)
            {
                System.debug(i);
            }
        }
    }
    
    
    //=========================================================
    // Q3 - Print Odd Numbers
    //
    // Example:
    // Input : 10
    // Output:
    // 1
    // 3
    // 5
    // 7
    // 9
    //=========================================================
    public static void PrintOdd(Integer num)
    {
        for(Integer i = 1; i <= num; i++)
        {
            // Odd Number => remainder != 0
            if(Math.mod(i,2) != 0)
            {
                System.debug(i);
            }
        }
    }
    
    
    //=========================================================
    // Q4 - Sum of Natural Numbers (Using FOR Loop)
    //
    // Example:
    // Input : 5
    // Output : 15
    //=========================================================
    public static void SumNaturalNum(Integer num)
    {
        Integer sum = 0;
        
        for(Integer i = 0; i <= num; i++)
        {
            sum += i;
        }
        
        System.debug('Sum of first ' + num + ' natural numbers is : ' + sum);
    }
    
    
    //=========================================================
    // Q5 - Sum of Natural Numbers (Using WHILE Loop)
    //
    // Example:
    // Input : 5
    // Output : 15
    //=========================================================
    public static void SumByWhileLoop(Integer num)
    {
        Integer i = 0;
        Integer sum = 0;
        
        while(i <= num)
        {
            sum += i;
            i++;
        }
        
        System.debug('Sum of first ' + num + ' natural numbers is : ' + sum);
    }
    
    
    //=========================================================
    // Q6 - Iterate List<Account>
    // Display Account Id and Name
    //
    // Steps:
    // 1. Fetch records using SOQL
    // 2. Check List is not empty
    // 3. Iterate List
    // 4. Display Account Id and Name
    //=========================================================
    public static void ShowAcc()
    {   
        system.debug('Display Data through List...');
        List<Account> accList = [SELECT Id, Name FROM Account LIMIT 5];
        
        if(!accList.isEmpty())
        {
            for(Account acc : accList)
            {
                System.debug(acc.Id + ' - ' + acc.Name);
            }
        }
    }
    
    
    //=========================================================
    // Q7 - Create Set of Account Ids
    //
    // Steps:
    // 1. Fetch Accounts
    // 2. Create Set<Id>
    // 3. Add Account Id into Set
    // 4. Print Set
    //
    // Note:
    // Set stores only unique values.
    //=========================================================
    
    public static void CreateIdSet()
    {           
        system.debug('Display Data through Set...');
        
        List<Account> accList = [SELECT Id, Name FROM Account LIMIT 5];
        
        Set<Id> accId = new Set<Id>();
        
        if(!accList.isEmpty())
        {
            for(Account acc : accList)
            {
                accId.add(acc.Id);
            }
        }
        
        System.debug('Account Id Set : ' + accId);
    }
    
    
    //=========================================================
    // Q8 - List -> Set -> Map Example
    //
    // Tasks:
    //
    // 1. Create Set of Account Ids
    // 2. Create Set of Account Names
    // 3. Create Map<Id,Account>
    // 4. Iterate Id Set
    // 5. Iterate Name Set
    // 6. Display Map
    //=========================================================
    public static void ShowAccSet()
    {            
        system.debug('Display Data through Set...');
        
        // Fetch Account Records
        List<Account> accList = [SELECT Id, Name FROM Account LIMIT 5];
        
        // Stores unique Account Ids
        Set<Id> accId = new Set<Id>();
        
        // Stores unique Account Names
        Set<String> accName = new Set<String>();
        
        // Key  -> Account Id
        // Value -> Complete Account Record
        Map<Id, Account> accMap = new Map<Id, Account>();
        
        
        if(!accList.isEmpty())
        {
            for(Account acc : accList)
            {
                // Add Account Id
                accId.add(acc.Id);
                
                // Add Account Name
                accName.add(acc.Name);
                
                // Add Account in Map
                accMap.put(acc.Id, acc);
            }
        }
        
        
        //=============================
        // Iterate Id Set
        //=============================
        if(!accId.isEmpty())
        {
            for(Id id : accId)
            {
                System.debug('Account Id : ' + id);
            }
        }
        
        
        //=============================
        // Iterate Name Set
        //=============================
        if(!accName.isEmpty())
        {
            for(String name : accName)
            {
                System.debug('Account Name : ' + name);
            }
        }
        
        
        //=============================
        // Display Map
        //=============================
        
        system.debug('Display Data through map...');
        
        if(!accMap.isEmpty())
        {
            System.debug(accMap);
        }
        
        // iterate through map on the basis of keys
        
        if(!accMap.isEmpty())
        {
            for(ID MapKey : accMap.keySet())
            {
                system.debug(MapKey);
            }
        }
        
        // iterate through map on the basis of values
        if(!accMap.isEmpty())
        {
            for(Account Mapval : accMap.Values())
            {
                system.debug(Mapval);
            }
        }
        
        
    }
    
}