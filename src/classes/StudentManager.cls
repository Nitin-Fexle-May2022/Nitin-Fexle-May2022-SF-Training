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
    // Class Info
        s1.Stream__c = 'PCM';
        s1.Section__c = 'A';
        s1.Class__c = '9th';
   // Fees Details
        s1.Current_Year__c = 2022;
        s1.Fees_Submitted__c = True;
        s1.Exam_Fees_Submitted__c = True;
        s1.Pending_Exam_Fees__c = 2000;
        s1.Is_Donation__c = True;
        s1.Donation_Amount__c = 5000;
        s1.Subjects_in_which_Back3__c = 'TF';
        s1.Pending_Overall_Amount__c = 2000;    
   //Bank Detail
        
        s1.Bank_Name__c = 'BOB';
        s1.IFSC_Code__c = 'BARB0DEEGXX';
        s1.Account_Number__c = 112489419;
        s1.Bank_Phone_Number__c = '91-941-754-8624';
        s1.City__c = 'Bharatpur';
        s1.State__c = 'Rajasthan'
            ;     
        insert s1;     
      // get inserted record id
        system.debug(s1.Id);
      
    }
}