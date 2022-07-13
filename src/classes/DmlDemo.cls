public class DmlDemo {
    
    //Worst way to use Dml Operations
   public static void dmlOperations(){
           Contact[] conList = [SELECT Department, Description FROM Contact ];
			if(!conList.isEmpty())
               for(Contact con : conList)
               {
                   if(con.Department == 'Finance')
                   {
                       con.Description = 'New Description';
                   }
                   update conList;
               }
    }
   
   // Better Approach for using DML
   public static void dmlOperations1(){
           Contact[] conList = [SELECT Department, Description FROM Contact ];
			if(!conList.isEmpty())
               for(Contact con : conList)
               {
                   if(con.Department == 'Finance')
                   {
                       con.Description = 'New Description';
                   }
               }
       update conList;
    }

   // More Optimize Way to use DML
   public static void dmlOperations2(){
            //List to hold the new contacts to update
           List<Contact> updateList = new List<Contact>();
           Contact[] conList = [SELECT Department, Description FROM Contact ];
			if(!conList.isEmpty())
               for(Contact con : conList)
               {
                   if(con.Department == 'Finance')
                   {
                       con.Description = 'New Description';
                       updateList.add(con);
                   }
               }
       update updateList;
    }    
	// upsert 
   public static void dmlOperations3(){
            //List to hold the new contacts to update
           List<Contact> updateList = new List<Contact>();
           Contact[] conList = [SELECT Department, Description FROM Contact ];
			if(!conList.isEmpty())
               for(Contact con : conList)
               {
                   if(con.Department == 'Finance')
                   {
                       con.Description = 'New Description';
                       updateList.add(con);
                   }
                   else
                   {
                       Contact newContact = new Contact(Department = 'Other');
                       updateList.add(newContact);
                   }
               }
       upsert updateList;
    }

    // upsert 
   public static void dmlOperations4(){
            //List to hold the new contacts to update
           List<Contact> updateList = new List<Contact>();
           List<Contact> conList = [SELECT Department, Description FROM Contact Where Department = 'Finance'];
			if(!conList.isEmpty())
               for(Contact con : conList)
               {
                       con.Description = 'New Description';
                       updateList.add(con);                  
               }
       update updateList;
    }

	// upsert 
   public static void dmlOperations5(){
            //List to hold the new contacts to update
           List<Contact> updateList = new List<Contact>();
           //Map with Contacts
           Map<Id,Contact> mapWithContacts = new Map<Id,Contact>();
           Contact[] conList = [SELECT Department, Description FROM Contact ];
			if(!conList.isEmpty())
               for(Contact con : conList)
               {
                       con.Description = 'New Description';
                       updateList.add(con);
                       mapWithContacts.put(con.Id , con);
               }
       update mapWithContacts.values();
    }        
    
}