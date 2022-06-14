public class StudentManager {
    
    public static void insertStudent(){
    Student__c s1 = new Student__c();
     
    //insert student persnol info
    //
        s1.Name = 'Shivam Sahu';
        s1.Roll_Number__c = 46823;
        s1.Father_Name__c = 'Hukum Singh';
        s1.Mobile_Number__c = 91-941-754-8624;
        s1.Father_Mobile_Number__c = '91-953-041-5758';
        s1.HomePhone__c = '91-056-412-4589';
        s1.Email__c = 'Shivam.sahu@gmail.com';
        s1.Address__c = 'Purani mandi, Alwar';
        s1.Overall_Grade__c = 75;
        insert s1;
        
        
      // get inserted record id
        system.debug(s1.Id);
      
    }
}