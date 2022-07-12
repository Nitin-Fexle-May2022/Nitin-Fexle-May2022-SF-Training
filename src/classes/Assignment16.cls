public class Assignment16 {
    public static void relatingRecordByExternalId(){
        Opportunity newOpportunity = new Opportunity(
            Name='OpportunityWithAccountInsert',
            StageName='Prospecting',
            CloseDate=Date.today().addDays(7));
        
        // Create the parent record reference.
        // An account with external ID = 'SAP111111' already exists.
        // This sObject is used only for foreign key reference
        // and doesn't contain any other fields.
        Account accountReference = new Account(Id = '0015i00000JGTFiAAP');                        
        // Add the account sObject to the opportunity.
        newOpportunity.Account = accountReference;
        
        // Create the opportunity.
        Database.SaveResult results = Database.insert(newOpportunity);
    }
    
    public static void relatingRecordByExternalId1(){
        Opportunity newOpportunity = new Opportunity(
            Name='OpportunityWithAccountInsert',
            StageName='Prospecting',
            CloseDate=Date.today().addDays(7));
        
        // Create the parent record reference.
        // An account with external ID = 'SAP111111' already exists.
        // This sObject is used only for foreign key reference
        // and doesn't contain any other fields.
        List<Account> accounts = [Select Id, Name from Account where MyExtID__c = 'SAP111111'];                        
        // Add the account sObject to the opportunity.
        newOpportunity.Account = Accounts[0];
        
        // Create the opportunity.
        Database.SaveResult results = Database.insert(newOpportunity);
    }
    
    public static void relatingRecordByExternalId2(){
        Opportunity newOpportunity = new Opportunity(
            Name='OpportunityWithAccountInsert',
            StageName='Prospecting',
            CloseDate=Date.today().addDays(7),
            AccountId = 'vnfdjnvin');
        
        // Create the opportunity.
        Database.SaveResult results = Database.insert(newOpportunity);
        
            
        //Exception Handling
        try {
            Account acct = new Account(Name='SFDC Account');
            insert acct;
            
            // Once the account is inserted, the sObject will be 
            // populated with an ID.
            // Get this ID.
            ID acctID = acct.ID;
            
            // Add a contact to this account.
            Contact con = new Contact(
                FirstName='Joe',
                LastName='Smith',
                Phone='415.555.1212',
                AccountId=acctID);
            insert con;
        } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
        
        //User Standard Exception
        Account a = new Account(Name='Acme');
        try {
            insert a;
        } catch(DmlException e) {
            System.debug('Error');
        }  
    }
}