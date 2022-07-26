trigger Trigger_Account on Account (Before Insert, Before Update, After Insert, After Update) {
    
    if(Trigger.isBefore){
        
        system.debug('Checking in Before Trigger Operations');
        if(Trigger.isInsert){
            
            system.debug('Check Insert List ::: Trigger.New ' + Trigger.New);
            system.debug('Check Insert List ::: Trigger.old ' + Trigger.old);
            //Calling Helper Class Method
            AccountTriggerHelper.accountEmailHandlerBeforeInsert(Trigger.new);
        }
        if(Trigger.isUpdate){  
            system.debug('Check Update List ::: Trigger.New ' + Trigger.New);
            system.debug('Check Update List ::: Trigger.old ' + Trigger.Old);
            AccountTriggerHelper.accountEmailHandlerBeforeUpdate(Trigger.New,Trigger.OldMap);
            
            if(Trigger.New[0].Type != Trigger.old[0].Type){
  
                system.debug('Type Value Changed');
                system.debug('Trigger.New Data' + Trigger.New[0].Type);
                system.debug('Trigger.old Data' + Trigger.Old[0].Type);
            }
        }
    }
    
    if(Trigger.isAfter){
        if(Trigger.isInsert)
        {
            //Calling Helper Class Method
            AccountTriggerHelper.accountEmailHandlerAfterInsert(Trigger.new);
        }
        system.debug('Checking in After Trigger Operations');
    }
}