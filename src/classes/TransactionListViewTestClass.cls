@isTest
public class TransactionListViewTestClass {
    @isTest
    public static void getTransactionEntriesTest1(){
        
        Contact con = new Contact(FirstName = 'Test', LastName = '1245');
        insert con;
        
        Transaction_Enteries__c tra = new Transaction_Enteries__c();
        tra.contact__c = con.Id;
        tra.Name = 'Test Transaction';
        tra.Type__c = 'Debit';
        tra.Amount__c = 2000;
        tra.status__c = 'Completed';
        tra.Transaction_Date__c = date.parse('10/17/2022');
        
        List<Transaction_Enteries__c> res1 = TransactionListViewLwcController.getTransactionEntries(tra.contact__c , 5);
        List<Transaction_Enteries__c> res2 = TransactionListViewLwcController.getTransactionDataToExport(tra.contact__c , date.parse('10/01/2022') , date.parse('10/30/2022'));
        
    }
}