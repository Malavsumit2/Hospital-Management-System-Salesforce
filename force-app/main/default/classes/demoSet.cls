public class demoSet {
       public static void demo ()
    {
        Set<INTEGER> Intset = new Set<INTEGER>();
        Intset.add(11);
        Intset.add(78);
        Intset.add(89);
        Intset.add(78);
        system.debug('Set of Integers are : '+ Intset);
        
        Set<Integer> Intset2 = new Set<Integer>{1,2,3};
        List<INTEGER> IntList = new List<INTEGER>{1,2,3};
        IntList.add(80);
        
        Intset.addAll(IntList);  //We can add list to set
        IntList.addAll(Intset);  //We can add set to list
        Intset.addAll(Intset2);  //we can also add set to list
        system.debug('Set of Integers are : '+ Intset);
        
        
        Intset2.add(11);
        Intset2.add(12);
        Intset2.add(80);
        
        
        Set<INTEGER> clonedSet = new Set<INTEGER>() ; 
        clonedSet = Intset2.clone();
        system.debug('Cloned Set of Integers are : '+ clonedSet);
        
        system.debug('IntSet2 contains 1 or not :'+ IntSet2.contains(1));
        
        system.debug('Set of Integers are IntSet2 : '+ IntSet2);
        system.debug('List of Integers are IntList : '+ IntList);
        system.debug('IntSet2 contains IntList or not  :'+ IntSet2.containsAll(IntList));
        
        system.debug('IntSet2 and cloned set is equal or not :'+ intSet2.equals(clonedSet));
        
        system.debug('Set of Integers are IntSet2 : '+ IntSet2);
        
        system.debug('IntSet2 set is empty or not :'+ intSet2.isEmpty());
        //system.debug('Remove 80 from the Intset2 :'+ intSet2.remove(80));
        
        system.debug('Set of Integers are IntSet2 : '+ IntSet2);
        //IntSet2.clear();
        system.debug('Set of Integers are IntSet2 : '+ IntSet2);
        system.debug('IntSet2 set is empty or not :'+ intSet2.isEmpty());
        //system.debug('IntSet2 contains IntList or not  :'+ IntSet2.removeAll(IntList));  // the Inlist elements are present in the Intset2 than they will be removed
        system.debug('List of Integers are IntList : '+ IntList);
        System.debug('Retain all from IntList to IntSet2'+ IntSet2.retainAll(IntList));
        system.debug('Set of Integers are IntSet2 : '+ IntSet2);
        
        
        Set<ID> AccId = new Set<ID>();
        List<Account> accList = new List<Account>();
        
        accList = [SELECT ID , Name FROM Account Limit 5];
        
        for(Account acc : accList)
        {
           AccId.add(acc.ID);
        }
        
        system.debug('Set Contains : '+AccId);
        
        
        
        Set<ID> ContID = new Set<ID>();
        Set<String> ContName = new Set<String>();
        List<Contact> ContList = new List<Contact>();
        
        ContList = [Select ID , Name From Contact limit 3];
        for(Contact Cont : ContList)
        {
            ContID.add(Cont.ID) ;
            ContName.add(Cont.Name);
        }
        system.debug('ContSet Set Contains : '+ContID);
        system.debug('ContSet Set Contains : '+ContName);
        
        
        Set<INTEGER> Set1 = new Set<INTEGER>{1,2,3,4};
            Set<INTEGER> set2 = new Set<INTEGER>{4,3,2,1};
                System.debug('Set1 and set2 are equal or not : ' + Set1.equals(set2));
        
        }
}