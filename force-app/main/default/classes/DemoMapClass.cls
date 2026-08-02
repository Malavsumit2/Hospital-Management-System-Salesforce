public class DemoMapClass {
    
    public static void SobjectDemo()
    {  // Adding a list of SObjects to map as key value pairs 
        
        Map<ID,Account>  accMap = new Map<ID,Account>();
        List<Account> accList = new List<Account>() ;
        accList = [SELECT ID , Name From Account Limit 5];
        system.debug('accList: '+accList);
        accMap.putAll(accList);
        
        /* for(Account acc : accList)
{
System.debug('Name:'+acc.Name);
System.debug('ID:'+acc.ID);
}   */
        
        
        
        System.debug('AccMap:'+ accMap); /*The output is like {
001xx000...=Account:{Id=001xx000..., Name=ABC},
001xx000...=Account:{Id=001xx000..., Name=XYZ}    */
        //Print this for ID and Name 
        for(ID accID : accMap.keySet())
        {
            System.debug( 'ID : '+accID + ' ' + 'Name: '+ accMap.get(accID).Name);
        }
    }
    
    
    public static void Demomap()
    {
        Map<Integer,String> EmpMap = new Map<Integer,String>() ;
        EmpMap.put(1,'Emp1') ;
        EmpMap.put(2,'Emp2');
        EmpMap.put(3,'Emp3');
        EmpMap.put(4, 'Emp1');   //Key should be unique , value can be duplicate
        system.debug('EmpMap contains  : '+EmpMap);
        
        EmpMap.put(3,'Emp5');  // It will override the value of key 3
        system.debug('EmpMap contains  : '+EmpMap);
        
        
        Map<INTEGER,String> EmpMap2 = new Map<INTEGER,String>();
        EmpMap2.put(50 , 'Emp_6');
        EmpMap2.put(60, 'Emp_7');
        EmpMap2.put(70 , 'Emp_8');
        
        
        system.debug('EmpMap2 contains  : '+EmpMap2);
        
        //PutAll function : when we want to merge two maps
        EmpMap.putAll(EmpMap2);   
        system.debug('EmpMap contains  : '+ EmpMap);
        
        EmpMap2.put(1 , 'Emp_9'); // because there is already 1,'Emp1' in EmpMap so EmpMap2 will override it 
        EmpMap.putAll(EmpMap2);
        system.debug('EmpMap contains  : '+ EmpMap);
        
        //Remove method : removes pair on the given key
        EmpMap.remove(1);
        system.debug('EmpMap contains  : '+ EmpMap);
        
        //size of map : 
        system.debug('Size of the map is : ' + EmpMap.size());
        
        //values function : It will shows the value not the keys in the map
        system.debug('The Values from the EmpMap is : ' + EmpMap.values());
        
        //clone function : It is used to create same type of map 
        Map<Integer, String> ClonedMap = new Map<Integer, String>();
        ClonedMap = EmpMap.clone();
        system.debug('Cloned Map contains : ' + ClonedMap);
        
        //containsKey function : It checks whether the key is present or not 
        system.debug('EmpMap contains key 1 or not : '+ EmpMap.containsKey(1));
        system.debug('EmpMap contains key 1 or not : '+ EmpMap.containsKey(2));
        
        //equals : this function checks if the two maps are equal or not 
        system.debug('EmpMap equals to ClonedMap or not  : '+ EmpMap.equals(ClonedMap));
        
        //get(key)  It gives the value at specific key
        system.debug('The value at key 2 is  : '+ EmpMap.get(2));
        
        //isEmpty checks if the map is empty or not 
        //EmpMap.clear();
        system.debug('EmpMap is empty or not : '+ EmpMap.isEmpty());
        
        //keySet() : It will return all the keys like value function return all the values 
        system.debug('Keys in EmpMap are :'+ EmpMAp.keySet());
        
        //How to store the keys into a set from the map and values in the list from the map
        Set<Integer> IntSet = new Set<Integer>();
        List<String> StrList = new List<String>();
        IntSet = EmpMap.keySet();
        StrList = EmpMap.values();
        system.debug('Intset contains :'+IntSet);
        system.debug('StrList contains: '+StrList);
        
    }
}