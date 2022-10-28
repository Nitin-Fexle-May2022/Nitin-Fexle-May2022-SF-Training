@isTest
public class ContactTriggerHandlerTest {
    
    @isTest
    public static void contactCantBeDeleteTest(){
        List<Contact> listCon = new List<Contact>();
        Contact con = new Contact(FirstName = 'Test', LastName = '1245');
        listCon.add(con);
        insert listCon;
        
        Transaction_Enteries__c tra = new Transaction_Enteries__c();
        tra.contact__c = con.Id;
        tra.Name = 'Test Transaction';
        tra.Type__c = 'Debit';
        tra.Amount__c = 2000;
        tra.status__c = 'Completed';
        tra.Transaction_Date__c = date.parse('10/17/2022');
        
        ContactTriggerHandler.contactCanNotBeDelete(listCon);
        
    }
}