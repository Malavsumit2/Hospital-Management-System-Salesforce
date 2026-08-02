public class ConditionalStatements {
    //Q1 Finding max number from given two numbers 
    public static void MaxNum(INTEGER num1 , INTEGER num2)
    {
        if (num1 > num2)
        {
            system.debug(num1 + ' is greater than '+num2);
        }
        else
        {
            system.debug(num2 + ' is greater than '+num1);
        }
    }
    
    //Q2 Check eligibility for votting
    public Static void VoteCriteria(INTEGER Age)
    {
        if(Age > 18)
        {
            system.debug('You are eligible to Vote...');
        }
        else
        {
            system.debug('You are not eligible to vote...');
        }
    }
    
    //Q3 Check given number is even or odd
    public static void EvenOdd(INTEGER num)
    {
        if(Math.mod(num , 2) == 0)
        {
            system.debug(num+' is even');  
        }
        else
            system.debug(num+' is odd'); 
        
    }
    //Q4 check whether a number is positive negative or zero through else if ladder
    public static void CheckNum(INTEGER num)
    {
        if(num > 0)
        {
            system.debug(num + ' is positive');
        }
        else if (num < 0 )
        {
            system.debug(num + ' is negative');
        }
        else
            system.debug(num + ' is Zero') ;
    }
    //Q5 check whether a number is positive negative or zero through nested if ladder
    public static void CheckNumWithNestedIf(INTEGER num)
    {
        if(num >= 0)
        {
            if(num > 0)
            {
                system.debug('num is positive');
            } else {
                system.debug('num is Zero');
            }
        }
        else
        {
            system.debug('num is Negative');
        }
    }
    //Q6 comparing 3 numbers using logical operators
    public Static void LogicalOperatorAND( INTEGER num1 , INTEGER num2 , INTEGER num3)
    {
        if (num1 > num2 && num1 >num3)
        {
            system.debug('num1 is greatest from the Three numbers');
        }
        else if (num2 >num1 && num2>num3)
        {
            system.debug('num2 is greatest from the Three numbers');
        }
        else
            system.debug('num3 is greatest from the Three numbers');
    }
   
    //Q7 Logical operator OR
    public Static void LogicalOperatorOR( STRING city)
    {

        if(city == 'Jaipur' || city == 'Kota')
        {
            System.debug('Rajasthan');
        }
        else {
            System.debug('State is not Rajasthan');
        }
    }
    //Q8 Checking List is empty or not with NULL operator 
      public static void CheckListWithNull()
      {
          List<Account> acclist = new List<Account>();
          acclist = [SELECT ID , Name from Account Limit 5];
          if(!acclist.isEmpty())     //here ! is null operator
          {
              System.debug('List Contains : '+acclist);
          }
          else
          {
              System.debug('accList is empty');
          }
      }
   
}