trigger DistrictTrigger on District__c (after insert, after update, after delete){
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete))
    {
        DistrictTriggerHelper.rollUpCountryStateCountUsingDistrict(Trigger.new, Trigger.OldMap);
    }
}