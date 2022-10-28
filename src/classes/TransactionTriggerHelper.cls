public with sharing class TransactionTriggerHelper{
    
    public static void maintainDebitLimits(List<Transaction_Enteries__c> newTnxEntryList, Map<Id, Transaction_Enteries__c> mapOfOldTnxEntry){
        if(!newTnxEntryList.isEmpty())
        { 
            Set<Id> setOfContactId = new Set<Id>();
            for(Transaction_Enteries__c tnxEntryOfConId : newTnxEntryList)
            {   
                if(mapOfOldTnxEntry == null && tnxEntryOfConId.Type__c.equals('Debit'))
                    setOfContactId.add(tnxEntryOfConId.Contact__c);
            }
            
            Map<Id,Contact> mapOfContact = new Map<Id, Contact>([SELECT Id, Name, Status__c, Available_Balance__c, Monthly_Transaction_Limit_Count__c,
                                                                 Daily_Transaction_Limit_Count__c,
                                                                 Daily_Debit_Limit__c,
                                                                 Monthly_Debit_Limit__c,
                                                                 Transaction_Limit__r.Maximum_Debit_Allowed_Per_Day__c,
                                                                 Transaction_Limit__r.Maximum_Debit_Allowed_Per_Month__c,
                                                                 Transaction_Limit__r.Maximum_Debit_Allowed_Per_Transaction__c,
                                                                 Transaction_Limit__r.Maximum_Transaction_Allowed_Per_Day__c,
                                                                 Transaction_Limit__r.Maximum_Transaction_Allowed_Per_Mon__c
                                                                 FROM Contact WHERE Id IN : setOfContactId]);
            for(Transaction_Enteries__c tnxEntryOfConId : newTnxEntryList)
            {   
                if(mapOfOldTnxEntry == null && tnxEntryOfConId.Type__c.equals('Debit') && setOfContactId.contains(tnxEntryOfConId.contact__c))
                {   
                   
                    if(mapOfContact.get(tnxEntryOfConId.contact__c).Monthly_Transaction_Limit_Count__c > mapOfContact.get(tnxEntryOfConId.Contact__c).Transaction_Limit__r.Maximum_Transaction_Allowed_Per_Mon__c)
                    {
                       tnxEntryOfConId.addError('Monthly Transiction Limit Reached');   								
                    }
                    else if(mapOfContact.get(tnxEntryOfConId.contact__c).Daily_Transaction_Limit_Count__c > mapOfContact.get(tnxEntryOfConId.Contact__c).Transaction_Limit__r.Maximum_Transaction_Allowed_Per_Day__c)
                    {
                        tnxEntryOfConId.addError('Daily Transiction Limit Reached');   								
                    }
                    else if(mapOfContact.get(tnxEntryOfConId.contact__c).Monthly_Debit_Limit__c + tnxEntryOfConId.Amount__c > mapOfContact.get(tnxEntryOfConId.Contact__c).Transaction_Limit__r.Maximum_Debit_Allowed_Per_Month__c)
                    {
                       tnxEntryOfConId.addError('Monthly Debit Limit Reached');   								
                    }
                    else if(mapOfContact.get(tnxEntryOfConId.contact__c).Daily_Debit_Limit__c + tnxEntryOfConId.Amount__c> mapOfContact.get(tnxEntryOfConId.Contact__c).Transaction_Limit__r.Maximum_Debit_Allowed_Per_Day__c)
                    {
                        tnxEntryOfConId.addError('Daily Debit Limit Reached');   								
                    }
                    else if(tnxEntryOfConId.Amount__c > mapOfContact.get(tnxEntryOfConId.Contact__c).Transaction_Limit__r.Maximum_Debit_Allowed_Per_Transaction__c)
                    {
                        tnxEntryOfConId.addError('Maximum Debit Transiction Limit Reached');   								
                    }
                    
                }
            }
        }
    }
    
    public static void sumOFAvailableBalance(List<Transaction_Enteries__c> newTnxEntryList, Map<Id, Transaction_Enteries__c> mapOfOldTnxEntry){
        if(!newTnxEntryList.isEmpty())
        { 
            Set<Id> setOfContactId = new Set<Id>();
            for(Transaction_Enteries__c tnxEntryOfConId : newTnxEntryList)
            {   
                if(mapOfOldTnxEntry == null || mapOfOldTnxEntry != null && mapOfOldTnxEntry.get(tnxEntryOfConId.Id).status__c != tnxEntryOfConId.Status__c)
                    setOfContactId.add(tnxEntryOfConId.Contact__c);
            }
            System.debug('++++====>>>>'+setOfContactId); 
            
            
            Map<Id,Contact> mapOfContact = new Map<Id, Contact>([SELECT Id, Name, Status__c, Available_Balance__c FROM Contact WHERE Id IN : setOfContactId]);
            //List of contact To be update
            Map<Id, Contact> MapOfContactToBeUpdate = new Map<Id, Contact>();
            
            for(Transaction_Enteries__c tnxEntry :newTnxEntryList)
            {
                if(mapOfContact.get(tnxEntry.Contact__c).Status__c == 'Active' && setOfContactId.contains(tnxEntry.Contact__c))
                {   
                    if(!MapOfContactToBeUpdate.containsKey(tnxEntry.Contact__c))
                    {
                        Contact objContact = new Contact();
                        if(tnxEntry.Type__c.equals('Debit') && tnxEntry.Status__c.equals('Completed'))
                        {
                            objContact.Id = tnxEntry.Contact__c;
                            objContact.Available_Balance__c = mapOfContact.get(tnxEntry.Contact__c).Available_Balance__c - tnxEntry.Amount__c;
                            MapOfContactToBeUpdate.put(objContact.Id, objContact);
                            
                            for(AggregateResult agMonth : [SELECT COUNT(Id) NumberOfTransactionInMonth, SUM(Amount__c) totalDebitInMonth, Contact__c FROM 
                                                           Transaction_Enteries__c Where Type__c = 'Debit' AND 
                                                           Transaction_Date__c = THIS_MONTH GROUP BY Contact__c])
                            {   
                                objContact.Id = (Id)agMonth.get('Contact__c');
                                objContact.Monthly_Debit_Limit__c = (Decimal)agMonth.get('totalDebitInMonth');
                                objContact.Monthly_Transaction_Limit_Count__c = (Decimal)agMonth.get('NumberOfTransactionInMonth');
                            }
                            
                            for(AggregateResult agDay : [SELECT COUNT(Id) NumberOfTransactionInDay, SUM(Amount__c) totalDebitInDay, Contact__c FROM Transaction_Enteries__c Where Type__c = 'Debit' AND Transaction_Date__c = TODAY GROUP BY Contact__c])
                            {
                                objContact.Id = (Id)agDay.get('Contact__c');
                                objContact.Daily_Debit_Limit__c = (Decimal)agDay.get('totalDebitInDay');
                                objContact.Daily_Transaction_Limit_Count__c = (Decimal)agDay.get('NumberOfTransactionInDay');
                            }
                            
                        }
                        else if(tnxEntry.Type__c.equals('Credit') && tnxEntry.Status__c.equals('Completed'))
                        {
                            objContact.Id = tnxEntry.Contact__c;
                            objContact.Available_Balance__c = mapOfContact.get(tnxEntry.Contact__c).Available_Balance__c + tnxEntry.Amount__c;
                            MapOfContactToBeUpdate.put(objContact.Id, objContact);
                        }
                        else if(tnxEntry.Type__c.equals('Debit') && tnxEntry.Status__c.equals('Cancelled'))
                        {
                            objContact.Id = tnxEntry.Contact__c;
                            objContact.Available_Balance__c = mapOfContact.get(tnxEntry.Contact__c).Available_Balance__c + tnxEntry.Amount__c;
                            MapOfContactToBeUpdate.put(objContact.Id, objContact);
                        }
                        else if(tnxEntry.Type__c.equals('Credit') && tnxEntry.Status__c.equals('Cancelled'))
                        {
                            objContact.Id = tnxEntry.Contact__c;
                            objContact.Available_Balance__c = mapOfContact.get(tnxEntry.Contact__c).Available_Balance__c - tnxEntry.Amount__c;
                            MapOfContactToBeUpdate.put(objContact.Id, objContact);
                        }
                    }
                }
            }
            System.debug('+++++++====>>>'+MapOfContactToBeUpdate);
            
            if(MapOfContactToBeUpdate.size() > 0)
            {
                update MapOfContactToBeUpdate.values();
            }
        }
    }
}