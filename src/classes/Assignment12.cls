public class Assignment12 {
    public Assignment12(){
        
        //An expression is a construct made up of variables, operators, and method invocations that evaluates to a single value
        //A literal expression
        //For example: 1 + 1
        
        //A new sObject, Apex object, list, set, or map
        //new Account(<field_initializers>)
        //new Integer[<n>]
        //new Account[]{<elements>}
        //new List<Account>()
        //new Set<String>{}
        //new Map<String, Integer>()
        //new myRenamingClass(string oldName, string newName)
        
        //Any value that can act as the left-hand of an assignment operator (L-values), including variables, one-dimensional list positions, and most sObject or Apex object field references.
 		//Integer i
        //myList[3]
        //myContact.name
        //myRenamingClass.oldName
        
        //Any sObject field reference that is not an L-value
        
        //A SOQL or SOSL query surrounded by square brackets, allowing for on-the-fly evaluation in Apex
        ////Account[] aa = [SELECT Id, Name FROM Account WHERE Name ='Acme'];
        //Integer i = [SELECT COUNT() FROM Contact WHERE LastName ='Weissman'];
        //List<List<SObject>> searchList = [FIND 'map*' IN ALL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead];
        
        
        //A static or instance method invocation
        //System.assert(true)
		//myRenamingClass.replaceNames()
		//changePoint(new Point(x, y));
		
        
        //Expression Operators
        //Expressions can be joined to one another with operators to create compound expressions
		
        
        // '=' Operator
        Integer x = 10;
        Integer y;
        y=x;
        System.debug(y);
        
        // '+=' Operator
        y+=x;
        System.debug(y);
        
        // '*=' Operator
        y*=x;
        System.debug(y);
        
        // '-=' Operator
        y-=x;
        System.debug(y);
        
        // '/=' Operator
        y/=x;
        System.debug(y);
        
        // '/=' Operator
        y/=x;
        System.debug(y);
        
        // '|=' Operator
        Boolean u = false;
        Boolean v = false;
        System.debug(u|=v);
                
        // '&=' Operator
        System.debug(u&=v);
        
        //Operator Precedence
        
        Integer myInt = 12 - 4 * 2;
        System.debug(myInt);
        
        Integer a = 10, b = 5, c = 1, result;
    	result = a-++c-++b;
    	
    	System.debug(result);
        
        //Comments
        Integer i = 1; // This comment is ignored by the parser
        
        Integer j = 1; /* This comment can wrap over multiple
                  lines without getting interpreted by the 
                  parser. */
        
        //Rules of Conversion
        Long MillsPerYear = 365L * 24L * 60L * 60L * 1000L;
        Long ExpectedValue = 31536000000L;
        System.assertEquals(MillsPerYear, ExpectedValue);
        
    }
                
        //Safe Navigator
          public static void SafeNavigator(){
            List<Student__c> results = [select Name from Student__c where Roll_Number__c = 19380];
            if(results.size() == 0){ //Account was deleted
                results = null;
            }
            System.debug('check student result :'+results);
        }
}