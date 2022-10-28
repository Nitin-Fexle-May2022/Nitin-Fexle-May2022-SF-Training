trigger ContactTrigger on Contact (after update, before delete) {
    
    if(Trigger.isBefore && Trigger.isDelete)
    {
        ContactTriggerHandler.contactCanNotBeDelete(Trigger.old);
    }
}