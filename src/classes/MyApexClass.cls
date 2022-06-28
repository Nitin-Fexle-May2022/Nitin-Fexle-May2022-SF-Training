public class MyApexClass {
    
    public MyApexClass(){
        //Boolean
        Boolean isWinner = true;
        System.debug(isWinner);
                
        // Double
        Double d = 3.14;
        System.debug(d);
        
        //Id
        ID id='00300000003T2PGAA0';
        System.debug(id);
        
        //Integer
        Integer i = 1;
        System.debug(i);
        
        //Long
        Long l = 2147483648L;
        System.debug(l);
        
        //Objects
        Object obj = 10;
        System.debug(obj);
        
        // Cast the object to an integer.
        Integer j = (Integer)obj;
        System.debug(j);
        
        //Date
        date myDate = date.newInstance(1989, 4, 21);
        System.debug(myDate);
        
        //addDays(additionalDays)
        date newDate = myDate.addDays(2);
        System.debug(newDate);
        
        //addMonths(additionalMonths)
        date myDate1 = date.newInstance(1990, 11, 21);
        date newDate1 = myDate1.addMonths(3);
        date expectedDate = date.newInstance(1991, 2, 21);
        system.assertEquals(expectedDate, newDate1);
        
        //addYears(additionalYears)
        date myDate2 = date.newInstance(1983, 7, 15);
        date newDate2 = myDate2.addYears(2);
        date expectedDate1 = date.newInstance(1985, 7, 15);
        system.assertEquals(expectedDate1, newDate2);
        
        //day
        date myDate3 = date.newInstance(1989, 4, 21);
        Integer day = myDate3.day();
        system.assertEquals(21, day);
        
        //dayOfYear
        date myDate4 = date.newInstance(1998, 10, 21);
        Integer day1 = myDate4.dayOfYear();
        system.assertEquals(294, day1);
        System.debug(day1);
        
        //daysBetween(secondDate)
        Date startDate = Date.newInstance(2008, 1, 1);
        Date dueDate = Date.newInstance(2008, 1, 30);
        Integer numberDaysDue = startDate.daysBetween(dueDate);
        
        //daysInMonth(year, month)
        Integer numberDays = date.daysInMonth(1960, 2);
        System.debug(numberDays);

        //format()
        date myDate5 = date.newInstance(2001, 3, 21);
        String dayString = myDate5.format();
        system.assertEquals('3/21/2001', dayString);
        System.debug(dayString);
        
        //isLeapYear(year)
        system.assert(Date.isLeapYear(2004));
		System.debug(Date.isLeapYear(2004));
        
        //isSameDay(dateToCompare)
		date myDate6 = date.today();
        date dueDate1 = date.newInstance(2022, 06, 24);
        boolean dueNow = myDate6.isSameDay(dueDate1);
        System.debug(dueNow);
        
        //month()
		date myDate7 = date.newInstance(2004, 11, 21);
        Integer month = myDate7.month();
        system.assertEquals(11, month);
        System.debug(month);
        
        //monthsBetween(secondDate)
        Date firstDate = Date.newInstance(2006, 12, 2);
        Date secondDate = Date.newInstance(2012, 12, 8);
        Integer monthsBetween = firstDate.monthsBetween(secondDate);
        System.assertEquals(72, monthsBetween);
        System.debug(monthsBetween);
        
        //newInstance(year, month, day)
        Date myDate8 = date.newinstance(1960, 2, 17);
        System.debug(myDate8);
        
        //parse(stringDate)
        date mydate9 = date.parse('12/27/2009');
        System.debug(mydate9);
        
        //today()
        date myDate10 = date.newInstance(1987, 12, 17);
        date firstDate2 = myDate10.toStartOfMonth();
        date expectedDate2 = date.newInstance(1987, 12, 1);
        system.assertEquals(expectedDate2, firstDate2);
        System.debug(expectedDate2);
        
        //toStartOfMonth()
		date myDate11 = date.newInstance(1987, 12, 17);
        date firstDate3 = myDate11.toStartOfMonth();
        date expectedDate3 = date.newInstance(1987, 12, 1);
        system.assertEquals(expectedDate3, firstDate3);
        
        //toStartOfWeek()
		Date myDate12 = Date.today();
        Date weekStart = myDate12.toStartofWeek();
        System.debug(weekStart);
        
        //valueOf(stringDate)
		string year = '2008';
        string month2 = '10';
        string day2 = '5';
        string hour = '12';
        string minute = '20';
        string second = '20';
        string stringDate = year + '-' + month2
         + '-' + day2 + ' ' + hour + ':' + 
        minute + ':' + second;
        
        Date myDate13 = date.valueOf(stringDate);
		System.debug(myDate13);
        
        //valueOf(fieldValue)
        List<AccountHistory> ahlist = [SELECT Field,OldValue,NewValue FROM AccountHistory];
        for(AccountHistory ah : ahlist) {
          System.debug('Field: ' + ah.Field);
          if (ah.field == 'MyDate__c') {
            Date oldValue = Date.valueOf(ah.OldValue);
            Date newValue = Date.valueOf(ah.NewValue);              
          }
        }        
        
        //year()
        date myDate14 = date.newInstance(1988, 12, 17);
        system.assertEquals(1988, myDate14.year());
		System.debug(myDate14);       
        
        //Datetime
        DateTime myDateTime = DateTime.newInstance(1997, 1, 31, 7, 8, 16);
        System.debug(myDateTime);
               
   		//addHours(additionalHours)
        DateTime newDateTime = myDateTime.addHours(3);
        DateTime expected = DateTime.newInstance(1997, 1, 31, 10, 8, 16);
        System.assertEquals(expected, newDateTime);
                
        //addMinutes(additionalMinutes)
      	DateTime myDateTime1 = DateTime.newInstance(1999, 2, 11, 8, 6, 16);
        DateTime newDateTime1 = myDateTime1.addMinutes(7);
        DateTime expected1 = DateTime.newInstance(1999, 2, 11, 8, 13, 16);
        System.assertEquals(expected1, newDateTime1);
        
        //addSeconds(additionalSeconds)
        DateTime myDateTime2 = DateTime.newInstance(2001, 7, 19, 10, 7, 12);
        DateTime newDateTime2 = myDateTime2.addSeconds(4);
        DateTime expected2 = DateTime.newInstance(2001, 7, 19, 10, 7, 16);
        System.assertEquals(expected2, newDateTime2);
        
        //date()
		DateTime myDateTime3 = DateTime.newInstance(2006, 3, 16, 12, 6, 13);
		Date myDate15 = myDateTime3.date();	
		Date expected3 = Date.newInstance(2006, 3, 16);
		System.assertEquals(expected3, myDate15);
        
        //dateGMT()
        DateTime myDateTime4 = DateTime.newInstance(2006, 3, 16, 23, 0, 0);
        Date myDate16 = myDateTime4.dateGMT();
        Date expected4 = Date.newInstance(2006, 3, 17);
        System.assertEquals(expected4, myDate16);
        
        //format()
        DateTime myDateTime5 = DateTime.newInstance(1993, 6, 6, 3, 3, 3);
        system.assertEquals('6/6/1993, 3:03 AM', myDatetime5.format());
        
        //format(dateFormatString)
        DateTime myDateTime6 = DateTime.newInstance(1993, 6, 6, 3, 3, 3);
        system.assertEquals('6/6/1993, 3:03 AM', myDatetime6.format());
        
        //format(dateFormatString, timezone)
        Datetime GMTDate =  Datetime.newInstanceGmt(2011,6,1,12,1,5);
        String strConvertedDate = GMTDate.format('MM/dd/yyyy HH:mm:ss','America/New_York');
        // Date is converted to 
        // the new time zone and is adjusted
        // for daylight saving time.
        System.assertEquals('06/01/2011 08:01:05', strConvertedDate);
        
        //String
        String s = 'The quick brown fox jumped over the lazy dog.';
        System.debug(s);
        
        String s1 = 'Hello Maximillian';
        // Start at M
        String s2 = s1.abbreviate(9,6);
        System.assertEquals('...Max...', s2);
        System.assertEquals(9, s2.length());
        System.debug(s2);
        
        //capitalize()
        String s3 = 'hello world';
        String s4 =  s3.capitalize();
        System.debug(s4);
        
        //center()
        String s5 = 'hello';
        String s6 = s5.center(9);
        System.assertEquals('  hello  ',s6);
        
        //str.charAt()
        String str = 'Ω is Omega.';
        System.assertEquals(937, str.charAt(0));
        
        // Create an empty list of String
        List<String> my_list = new List<String>();
        // Create a nested list
        List<List<Set<Integer>>> my_list_2 = new List<List<Set<Integer>>>();

        List<Integer> myList = new List<Integer>(); // Define a new list
        myList.add(47);                    // Adds a second element of value 47 to the end 
                                               // of the list
        Integer i1 = myList.get(0);                   // Retrieves the element at index 0
        myList.set(0, 1);                           // Adds the integer 1 to the list at index 0
        myList.clear();                    // Removes all elements from the list
        System.debug(i1);
        
        //Set
        Set<String> myStringSet = new Set<String>();
        
        // Defines a new set with two elements
		Set<String> set1 = new Set<String>{'New York', 'Paris'};
            
        // Define a new set
        Set<Integer> mySet = new Set<Integer>();
        // Add two elements to the set
        mySet.add(1);
        mySet.add(3);
        // Assert that the set contains the integer value we added
        System.assert(mySet.contains(1)); 
        // Remove the integer value from the set
        mySet.remove(1);
        
        // Define a new set that contains the
        // elements of the set created in the previous example
        Set<Integer> mySet2 = new Set<Integer>(mySet);
        // Assert that the set size equals 1
        // Note: The set from the previous example contains only one value
        System.assert(mySet2.size() == 1);
        
        //Map
        Map<String, String> country_currencies = new Map<String, String>();
		Map<ID, Set<String>> m1 = new Map<ID, Set<String>>();
        
        Map<String, String> MyStrings = new Map<String, String>{'a' => 'b', 'c' => 'd'.toUpperCase()};
        
        Map<Integer, String> m = new Map<Integer, String>(); // Define a new map
        m.put(1, 'First entry');                  // Insert a new key-value pair in the map
        m.put(2, 'Second entry');                  // Insert a new key-value pair in the map
        System.assert(m.containsKey(1));  // Assert that the map contains a key
        String value = m.get(2);               // Retrieve a value, given a particular key
        System.assertEquals('Second entry', value);
        Set<Integer> str1 = m.keySet();       // Return a set that contains all of the keys in the map
        
        //List of Students In Yoga Classes
        map<String, Map<String, List<Student__c>>> yogaClassMap = new Map<String, Map<String, List<Student__c>>>();
        //Ist Year List of Student
        List<Student__c> lstYearListComputer = new List<Student__c>();
        lstYearListComputer = [select id,Name,Roll_Number__c, Class__c, Stream__c from Student__c where Class__c = '1stYear' and Stream__c = 'Computer Science'];
        Map<String, List<Student__c>> mapOfStudentwithStreamIstYear = new Map<String, List<Student__c>>();
   	    mapOfStudentwithStreamIstYear.put('Computer Science',lstYearListComputer); 
        
        //Ist Year List of Student
        List<Student__c> lstYearListElectronic = new List<Student__c>();
        lstYearListElectronic = [select id,Name,Roll_Number__c, Class__c, Stream__c from Student__c where Class__c = '1stYear' and Stream__c = 'Electronic'];
        mapOfStudentwithStreamIstYear.put('Electronic',lstYearListElectronic);
             
        //2nd Year List of Student
        List<Student__c> llndYearListElectronic = new List<Student__c>();
        llndYearListElectronic = [select id,Name,Roll_Number__c, Class__c, Stream__c from Student__c where Class__c = '2ndYear' and Stream__c = 'Electronic'];
        Map<String, List<Student__c>> mapOfStudentwithStream2ndYear = new Map<String, List<Student__c>>();
        mapOfStudentwithStream2ndYear.put('Electronic',llndYearListElectronic);
          
        yogaClassMap.put('IstYear', mapOfStudentwithStreamIstYear);
        yogaClassMap.put('2ndYear', mapOfStudentwithStream2ndYear);
        
        //List of Students In EnglishClasses
        map<String, Map<String, List<Student__c>>> EnglishClassMap = new Map<String, Map<String, List<Student__c>>>();
        //Ist Year List of Student
        List<Student__c> lstYearListComputer1 = new List<Student__c>();
        lstYearListComputer = [select id,Name,Roll_Number__c, Class__c, Stream__c from Student__c where Class__c = '1stYear' and Stream__c = 'Civil'];
        Map<String, List<Student__c>> mapOfStudentwithStreamIstYear1 = new Map<String, List<Student__c>>();
   	    mapOfStudentwithStreamIstYear1.put('Computer Science',lstYearListComputer1); 
        
        //Ist Year List of Student
        List<Student__c> lstYearListElectronic1 = new List<Student__c>();
        lstYearListElectronic1 = [select id,Name,Roll_Number__c, Class__c, Stream__c from Student__c where Class__c = '1stYear' and Stream__c = 'Mechanical'];
        mapOfStudentwithStreamIstYear1.put('Electronic',lstYearListElectronic1);
             
        //2nd Year List of Student
        List<Student__c> llndYearListElectronic1 = new List<Student__c>();
        llndYearListElectronic1 = [select id,Name,Roll_Number__c, Class__c, Stream__c from Student__c where Class__c = '2ndYear' and Stream__c = 'Electronic'];
        Map<String, List<Student__c>> mapOfStudentwithStream2ndYear1 = new Map<String, List<Student__c>>();
        mapOfStudentwithStream2ndYear1.put('Electronic',llndYearListElectronic1);
          
        EnglishClassMap.put('IstYear', mapOfStudentwithStreamIstYear1);
        EnglishClassMap.put('2ndYear', mapOfStudentwithStream2ndYear1);
        
        //Variable declaration and Initialization
        Account acc = new Account();
        Integer a2 = Null;
        
        List<Integer> numList = new List<Integer>();
        List<Account> numlist2 = new List<Account>();
        Student__c st1 = new Student__c();
        String str2 = 'Nitin';
        Boolean b1;
        
               
    }
}