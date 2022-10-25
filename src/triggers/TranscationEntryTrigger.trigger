trigger TranscationEntryTrigger on Transaction_Enteries__c (after insert, after update, before insert){
             
         if(Trigger.isBefore && Trigger.isInsert)
        {
           TransactionTriggerHelper.maintainDebitLimits(Trigger.new, Trigger.OldMap);
           system.debug('New List Values>>>>>>>> '+Trigger.new);
           system.debug('Old List Values>>>>>>>> '+Trigger.OldMap);
        }
        else if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate))
        {
           TransactionTriggerHelper.sumOFAvailableBalance(Trigger.new, Trigger.OldMap);
            system.debug('New List Values>>>>>>>> '+Trigger.new);
            system.debug('Old List Values>>>>>>>> '+Trigger.OldMap);
        }
}