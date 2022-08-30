trigger myOpportunityTrigger on Opportunity (after insert, after update) {
    if(Trigger.isAfter && Trigger.isInsert || Trigger.isAfter && Trigger.isUpdate)
    {   
        OpportunityTriggerHelper.maintainAutomobileRecordsAfterUpdateAndInsert(Trigger.New , Trigger.OldMap);
    }
    
}