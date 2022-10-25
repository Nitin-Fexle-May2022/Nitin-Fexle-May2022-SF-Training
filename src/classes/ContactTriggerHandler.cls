public with sharing class ContactTriggerHandler {
    
//For Handling email     
/* 
*	Description     : This method is used for handeling email
*	Return Type		: void
*	@argument		: String
*	Revision Logs   : V_1.0 - Created
*/
            
    public static void contactCanNotBeDelete(List<Contact> oldContactList){
        Set<Id> setOfContactId = new Set<Id>();
        for(Contact conId : oldContactList)
        {
            setOfContactId.add(conId.Id);
        }
        
        Map<Id,Contact> mapOfContact = new Map<Id,Contact>([SELECT Id,Name,(SELECT Id,Name FROM Transaction_Entries__r) 
                                                                FROM Contact WHERE Id IN: setOfContactId]);
        for(Contact con : oldContactList)
        {
            if(mapOfContact.get(con.Id).Transaction_Entries__r.size()>0)
            {
                con.addError('Contact can’t be deleted once transaction entries are added under it');
            }
        }  
    }
}