trigger CountryTrigger on Country__c (before update) {
    if( Trigger.isBefore && (Trigger.isUpdate))
    {
        CountryTriggerHelper.updateCountryJason(Trigger.new, Trigger.OldMap);
    } 
}