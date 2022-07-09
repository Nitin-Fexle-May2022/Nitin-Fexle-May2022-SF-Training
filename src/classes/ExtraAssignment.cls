public class ExtraAssignment {
    
    public static Map<String,Map<String,String>> MapOfStateWithCity = new Map<String,Map<String,String>>();
    public static void extraAssignmentMethod(){
        
        //Map to hold Acoount id with Contact 
        Map<Id, List<Contact>> mapOfAccountIdWithConatcts = new Map<Id, List<Contact>>();
        
        //Asignment Ist Account to Contact
        // List to Hold Account with List Of Contacts
        List<Account> listofAccount = [Select Id, Name, (Select Id, LastName from Contacts) from Account limit 5];
        if(!listofAccount.isEmpty())
        {
        	for(Account acc : listofAccount)
        	{   
            	System.debug('Account Name is: '+acc.Name);
            	if(!acc.Contacts.isEmpty())
            	{   
                    //Assignment 3rd
                	//Filling map <id,List<Contact>>
                	mapOfAccountIdWithConatcts.put(acc.id, acc.Contacts);
                	for(Contact con: acc.Contacts)
                	{
                    	System.debug('Last Name is: '+con.LastName);
                	}
            	}
        	}
        }
        
        //Assignment 2nd 
        //List to Hold Conatcts With Parent Account
		List<Contact> listOfContacts =  [SELECT Id, LastName, AccountId, Account.Name FROM Contact limit 5];
        if(!listOfContacts.isEmpty())
        {
    		for(Contact objContact: listOfContacts)
    		{   
  				system.debug('====Account Name======'+objContact.Account.Name);
			}
        }
        
        //Assignment 4th
    
        //List with 5 methods
        List<Integer> myList = new List<Integer>();
        //add() Method
        myList.add(5);
        myList.add(6);
        //add(index,list Element)
        myList.add(0,7);
        //get() Method
        Integer j = myList.get(0);
        System.debug(j);
        //addAll() method
        List<Integer> myList1 = new List<Integer>{1,2,3,4,5};
        myList.addAll(myList1);
        System.debug(myList);
        //clear() Method
        myList.clear();
        System.debug(myList);
        
        //5 Method of Maps 
        Map<Integer, String> m1 = new Map<Integer, String>();
        //put() Method
        m1.put(1, 'First item');
		m1.put(2, 'Second item');
        //get() Method
        String str = m1.get(1);
        System.debug(str);
        //containsKey() Method
        Boolean contains = m1.containsKey(1);
        System.debug(contains);
        //keySet() Method
        Set <String> setofMapKeys = new Set<String>();
        System.debug(m1.keySet());
        //Clear() Method
        m1.Clear();
        
        //5 Methods of Set
        //add() Method
        Set<String> s1 = new Set<String>();
        s1.add('Item1');
        s1.add('Item2');
        //addAll() Method
        Set<String> myString = new Set<String>{'a', 'b', 'c'};
        s1.addAll(myString);
        //remove() Method
        s1.remove('Item1');
        System.debug(s1);
        //contains() Method
        Boolean result = myString.contains('a');
        System.debug(result);
        //clear() Method
        s1.clear();
        System.debug(s1);
        
        //Assignment 5
        Map<String,String> MapOfCityWithPersonDummy = new Map<String,String>();
        
        MapOfStateWithCity.put('Rajasthan',new Map<String , String>());
        //adding city and Persons in MapOfCityWithPersonDummy
        MapOfCityWithPersonDummy.put('Jaipur','Ankit Arya');
        MapOfCityWithPersonDummy.put('Ajmer','Sunil Singh');
        MapOfCityWithPersonDummy.put('Udaipur','Vikas Khandelwal');
        MapOfCityWithPersonDummy.put('Sikar','Pankaj Sogan');
        MapOfCityWithPersonDummy.put('Bharatput','Nitin Rajput');
        MapOfStateWithCity.get('Rajasthan').putAll(MapOfCityWithPersonDummy);
        MapOfCityWithPersonDummy.clear();
              
        MapOfStateWithCity.put('Haryana',new Map<String , String>());
        MapOfCityWithPersonDummy.put('Hisar','Pramod Kaushik');
        MapOfCityWithPersonDummy.put('Bhiwani','Sumit Sihag');
        MapOfCityWithPersonDummy.put('Faridabad','Sameer Rajput');
        MapOfCityWithPersonDummy.put('Gurugram ','Juhi Sharma');
        MapOfCityWithPersonDummy.put('Fatehabad','Saleem Khan');
        MapOfStateWithCity.get('Haryana').putAll(MapOfCityWithPersonDummy);
        MapOfCityWithPersonDummy.clear();
        
        MapOfStateWithCity.put('UP',new Map<String , String>());
        MapOfCityWithPersonDummy.put('Aligarh','Rohit Rajput');
        MapOfCityWithPersonDummy.put('Mathura','Gaurav Kumar');
        MapOfCityWithPersonDummy.put('Vrindavan','Harendra Kumar');
        MapOfCityWithPersonDummy.put('Agra ','Deeksha Singh');
        MapOfCityWithPersonDummy.put('Noida','Shubham Sharma');
        MapOfStateWithCity.get('UP').putAll(MapOfCityWithPersonDummy);
        MapOfCityWithPersonDummy.clear();
        
        MapOfStateWithCity.put('Punjab',new Map<String , String>());
        MapOfCityWithPersonDummy.put('Ludhiana','Rajat Pachauri');
        MapOfCityWithPersonDummy.put('Amritsar','Kunal Jain');
        MapOfCityWithPersonDummy.put('Patiala','Ram Sharma');
        MapOfCityWithPersonDummy.put('Bathinda ','Nishant Sharma');
        MapOfCityWithPersonDummy.put('Hoshiarpur','Jayant Yadav');
        MapOfStateWithCity.get('Punjab').putAll(MapOfCityWithPersonDummy);
        MapOfCityWithPersonDummy.clear();
        
        MapOfStateWithCity.put('MP',new Map<String , String>());
        MapOfCityWithPersonDummy.put('Indore','Devansh Sharma');
        MapOfCityWithPersonDummy.put('Bhopal','Nitin Singh');
        MapOfCityWithPersonDummy.put('Jabalpur','Jai Choudhary');
        MapOfCityWithPersonDummy.put('Gwalior ','Harendra Thakur');
        MapOfCityWithPersonDummy.put('Katni','Kritika Gehlot');
        MapOfStateWithCity.get('MP').putAll(MapOfCityWithPersonDummy);
        MapOfCityWithPersonDummy.clear();
        
        System.debug(MapOfStateWithCity);
        
        
        
        
        //6th Assisgnment
        List<Account> listOfAccountToBeInsert = new List<Account>();
        List<Contact> listOfContactToBeInsert = new List<Contact>();
        for(Integer i=0 ; i<5; i++)
        {
            listOfAccountToBeInsert.add(new Account(Name='Test'+i));
        }
        if(!listOfAccountToBeInsert.isEmpty())
        {
            insert listOfAccountToBeInsert;
        }
        for(Integer i=0 ; i<5; i++)
        {
            listOfContactToBeInsert.add(new Contact(LastName ='TestLast'+i,
                                                    AccountId = listOfAccountToBeInsert[i].id));
        }
        if(!listOfContactToBeInsert.isEmpty())
        {
            insert listOfContactToBeInsert;
        }
    }  
}