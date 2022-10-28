global with sharing class SendMonthlyEmailSchdule implements Schedulable {
    global void execute(SchedulableContext sc) {
        List<Contact> conList = [Select Id, Name, Available_Balance__c, Account_Number__c, Status__c, Email FROM Contact];
        List<Transaction_Enteries__c> txnList = [Select Id, Amount__c, Type__c, Transaction_Date__c, Contact__c From Transaction_Enteries__c Where Contact__c In : conList];
        List<Messaging.Email> emailList = new List<Messaging.Email>();

        for(Contact con: conList){
            if(con.Status__c=='Active'){
                Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
                emailMsg.setToAddresses(new String[]{con.Email});
                emailMsg.setSubject(con.Name);
                String htmlBody = '';
                for(Transaction_Enteries__c txn :txnList){
                    if(con.Id==txn.Contact__c){
                        htmlBody='Greeting From Axis Bank<br> <table border="1" style="border-collapse: collapse"><tr><th>Account Number</th><th>Type</th><th>Amount</th><th>Transaction Date</th></tr>';
                        htmlBody += '<tr><td>' + con.Account_Number__c + '</td><td>' + txn.Type__c + '</td><td>' + txn.Amount__c + '</td><td>' + txn.Transaction_Date__c + '</td></tr>'; 
                        }
            emailMsg.setHtmlBody(htmlBody);
            }
            emailList.add(emailMsg);
            }
        }
        Messaging.sendEmail(emailList);
    }
}