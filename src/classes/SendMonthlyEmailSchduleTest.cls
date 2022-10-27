@isTest
public class SendMonthlyEmailSchduleTest {
    
    @isTest
    private static void testData() {
        
        List<Transaction_Limit__c> listOfTnxLimit = new List<Transaction_Limit__c>();
        
        Transaction_Limit__c limitOfHDFCBank = new Transaction_Limit__c();
        limitOfHDFCBank.name = 'HDFC';
        limitOfHDFCBank.Maximum_Debit_Allowed_Per_Month__c = 90000;
        limitOfHDFCBank.Maximum_Transaction_Allowed_Per_Mon__c = 50;
        limitOfHDFCBank.Maximum_Debit_Allowed_Per_Day__c = 20000;
        limitOfHDFCBank.Maximum_Transaction_Allowed_Per_Day__c = 3;
        limitOfHDFCBank.Maximum_Debit_Allowed_per_Transaction__c = 10000;  
        listOfTnxLimit.add(limitOfHDFCBank);
        
        Transaction_Limit__c limitOfICICIBank = new Transaction_Limit__c();
        limitOfICICIBank.name = 'ICICI';
        limitOfICICIBank.Maximum_Debit_Allowed_per_Month__c = 9000;
        limitOfICICIBank.Maximum_Transaction_Allowed_Per_Mon__c = 50;
        limitOfICICIBank.Maximum_Debit_Allowed_per_Day__c = 10000;
        limitOfICICIBank.Maximum_Transaction_Allowed_Per_Day__c = 22;
        limitOfICICIBank.Maximum_Debit_Allowed_per_Transaction__c = 10000;      
        listOfTnxLimit.add(limitOfICICIBank);
        insert listOfTnxLimit;
        
        
        List<Contact> listOfContact = new List<Contact>();
        Contact conForHDFC = new Contact();
        conForHDFC.LastName = 'Smith';
        conForHDFC.status__c = 'Active';
        conForHDFC.Email = 'test@test.com';
        conForHDFC.Available_Balance__c = 0;
        conForHDFC.Daily_Debit_Limit__c = 0;
        conForHDFC.Daily_Transaction_Limit_Count__c = 0;
        conForHDFC.Monthly_Debit_Limit__c = 0;
        conForHDFC.Monthly_Transaction_Limit_Count__c = 0;
        conForHDFC.Transaction_Limit__c = listOfTnxLimit[0].Id;
        listOfContact.add(conForHDFC);            
        insert listOfContact;
        
        List<Contact> listOfConId = new List<Contact>([Select Id From Contact Where LastName = 'Smith']);
        
        List<Transaction_Enteries__c> listOfCreditEntry = new List<Transaction_Enteries__c>();
        Transaction_Enteries__c  creditEntry = new Transaction_Enteries__c();
        creditEntry.Amount__c = 30000;
        creditEntry.Type__c = 'Credit';
        creditEntry.status__c = 'Completed';
        creditEntry.contact__c = listOfConId[0].id;
        creditEntry.Transaction_Date__c = System.today();
        insert creditEntry;
        
        Transaction_Enteries__c creditEntry2 = new Transaction_Enteries__c();
        creditEntry2.Amount__c = 5000;
        creditEntry2.Type__c = 'Debit';
        creditEntry2.status__c = 'Completed';
        creditEntry2.contact__c = listOfConId[0].id;
        creditEntry2.Transaction_Date__c = System.today();
        try {
            insert creditEntry2;
        } catch(Exception ex) {}
        
        creditEntry = new Transaction_Enteries__c();
        creditEntry.Amount__c = 250;
        creditEntry.Type__c = 'Debit';
        creditEntry.status__c = 'Completed';
        creditEntry.contact__c = listOfConId[0].id;
        creditEntry.Transaction_Date__c = System.today();
        insert creditEntry;
        
        creditEntry = new Transaction_Enteries__c();
        creditEntry.Amount__c = 1000;
        creditEntry.Type__c = 'Debit';
        creditEntry.status__c = 'Completed';
        creditEntry.contact__c = listOfConId[0].id;
        creditEntry.Transaction_Date__c = System.today(); 
        try {
            insert creditEntry;
        }
        catch(Exception ex){
        }
        
        SendMonthlyEmailSchdule.execute(null);  
    }
}