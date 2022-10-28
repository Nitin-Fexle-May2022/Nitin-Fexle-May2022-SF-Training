public class TransactionListViewLwcController {
      

    @AuraEnabled(cacheable=true)
    public static List<Transaction_Enteries__c> getTransactionEntries(Id conId, Integer selectedRecordLimits){
        return [SELECT Id, Name, Type__c, Status__c, Amount__c From Transaction_Enteries__c WHERE Contact__c =: conId AND Status__c != 'Cancelled' LIMIT : selectedRecordLimits];
    }

    @AuraEnabled(cacheable=true)
    public static List<Transaction_Enteries__c> getTransactionDataToExport(Id conId, Date startDate, Date endDate){
        List<Transaction_Enteries__c> transactionsRecord = [SELECT Id, Name, Type__c, Amount__c, Status__c, Transaction_Date__c FROM Transaction_Enteries__c where Contact__c =: conId AND
                                                            Transaction_Date__c >=: startDate AND Transaction_Date__c <=: endDate];
        return transactionsRecord;
    }
}