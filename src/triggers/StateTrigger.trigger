trigger StateTrigger on State__c (after insert, before update, after delete, after update) {
    if( Trigger.isBefore && (Trigger.isUpdate))
    {
        StateTriggerHelper.updateStateJason(Trigger.new, Trigger.OldMap);
    }
    if( Trigger.isAfter && ( Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete ))
    {
       StateTriggerHelper.rollupStateCountOnUsingState(Trigger.new, Trigger.OldMap);
    }
}