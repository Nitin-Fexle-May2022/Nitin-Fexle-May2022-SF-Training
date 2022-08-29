/**
* Description   - Opportunity Trigger Helper Class.   
* Created by    - Nitin Rajput
* Created Date  - 30/07/2022
* Revision log  -  V_1.0 - Created  - Nitin Rajput - 30/07/2022
**/
public class OpportunityTriggerHelper {
    
    /**   
* 	  Description :   Method is used to after insert automation.
*     Created By  :   Nitin Rajput
*     Arguments   :   List<Opportunity>, Map<Id, Opportunity>
*     Return      :   void
*     Revision log:   V_1.0 - Created  - Nitin Rajput - 30/07/2022                    
**/
    public static void maintainAutomobileRecordsAfterUpdateAndInsert(List<Opportunity> newListOfOpportunity, Map<Id, Opportunity> mapOfOldOpportunity){
        
        //Map to hold AutoMobileTagDetailsWithOppId
        Map<Id, List<String>> mapOfAutoMobileTagDetailByOppId = new Map<Id, List<String>>();
        
        //Map to hold Opportunity record with Opp Id
        Map<Id, Opportunity> mapOfOppWithId = new Map<Id, Opportunity>();
        
        //Map to hold child Object id with Opp Id
        Map<Id, Map<String, Id>> mapOfOppWithChildObjectId = new Map<Id, Map<String, Id>>();
        
        //Map to hold opportunity id with child object
        Map<Id, List<sObject>> mapOfOppWithChildObject = new Map<Id, List<sObject>>();
        
        //Map to hold record to be inserted
        Map<Id, List<SObject >> mapOfAutomobileSensorsTobeInsert = new Map<Id, List<SObject >>();
        
        //Map to hold record to be update
        Map<Id, List<SObject >> mapOfAutomobileSensorsTobeUpdate = new Map<Id, List<SObject >>();
        
        //List to hold record of different object instance to insert.
        List<SObject> listOfSobjectToInsert = new List<SObject>();
        
        //List to hold record of different object instance to update.
        List<SObject> listOfSobjectToUpdate = new List<SObject>();
        
        //Map to hold invalid data in automobile tag details.
        // Map<Id, List<String>> mapOfInvlidData = new Map<Id, List<String>>();
        
        //List to hold invalid sensors
        List<String> invalidSensorList = new List<String>();
        
        //List to hold already exist sensors
        List<String> existedSensorList = new List<String>();
        
        //loop for fill values in mapOfAutoMobileTagDetailByOppId
        for(Opportunity opp : newListOfOpportunity)
        {   
            if((opp.StageName == 'Shipped to Customer' || opp.StageName == 'Return To HQ' || opp.StageName == 'Return To Customer') && opp.AccountId != null && 
               (mapOfOldOpportunity == null || (mapOfOldOpportunity != null && (opp.Automobile_Tag_Details_1__c != mapOfOldOpportunity.get(opp.Id).Automobile_Tag_Details_1__c
                                                                                || opp.Automobile_Tag_Details_2__c != mapOfOldOpportunity.get(opp.Id).Automobile_Tag_Details_2__c || opp.Automobile_Tag_Details_3__c != mapOfOldOpportunity.get(opp.Id).Automobile_Tag_Details_3__c
                                                                                || opp.Return_To_HQ__c != mapOfOldOpportunity.get(opp.Id).Return_To_HQ__c || opp.StageName !=  mapOfOldOpportunity.get(opp.Id).stageName)))) 
            {                  
                mapOfAutoMobileTagDetailByOppId.put(opp.Id, getListOfSeprateSensors(opp.Automobile_Tag_Details_1__c+'\n'+opp.Automobile_Tag_Details_2__c+'\n'+opp.Automobile_Tag_Details_3__c));
                System.debug(mapOfAutoMobileTagDetailByOppId);  
            }              
        }
        if(mapOfAutoMobileTagDetailByOppId.size() > 0)
        {
            //Query to fill Map Of Opportunity with Id
            for(Opportunity opp : [Select Id, Name, stageName, Owner.Email, AccountId, Account.Name, Shipment_Account__c, Shipment_Account__r.Name, (Select Id, Name, Account__c, Opportunity__c From Automobile_Sensors__r), (Select Id, Name, Account__c, Opportunity__c From Automobile_Presence_Sensors__r),
                                   (Select Id, Name, Account__c, Opportunity__c From Automobile_Tags__r), (Select Id, Name, Account__c, Opportunity__c From Automobile_TDU_s__r)
                                   From Opportunity Where Id IN : mapOfAutoMobileTagDetailByOppId.KeySet()])
            {   
                //fill mapOfOppWithId
                mapOfOppWithId.put(opp.Id, opp);
                System.debug(mapOfOppWithId);
                
                //fill mapOfOppWithChildObject
                if(!mapOfOppWithChildObject.containsKey(opp.Id))
                    mapOfOppWithChildObject.put(opp.Id, new List<sObject>());
                
                //fill mapOfOppWithChildObject
                if(!mapOfOppWithChildObjectId.containsKey(opp.Id))
                    mapOfOppWithChildObjectId.put(opp.Id, new Map<String, Id>());
                
                //Loop for Automobile_Sensors__r
                if(!opp.Automobile_Sensors__r.isEmpty())
                {
                    for(Automobile_Sensor__c ams : opp.Automobile_Sensors__r)
                    {    
                        mapOfOppWithChildObject.get(opp.Id).add(ams);
                        mapOfOppWithChildObjectId.get(opp.Id).put(ams.Name, ams.Id);
                    }
                    System.debug(mapOfOppWithChildObject);
                }
                
                //Loop for Automobile_Presence_Sensors__r
                if(!opp.Automobile_Presence_Sensors__r.isEmpty())
                {
                    for(Automobile_Presence_Sensor__c amps : opp.Automobile_Presence_Sensors__r)
                    {    
                        mapOfOppWithChildObject.get(opp.Id).add(amps);
                        mapOfOppWithChildObjectId.get(opp.Id).put(amps.Name, amps.Id);
                    }
                    System.debug(mapOfOppWithChildObject);
                }
                
                //Loop for Automobile_Tags__r
                if(!opp.Automobile_Tags__r.isEmpty())
                {
                    for(Automobile_Tag__c amt : opp.Automobile_Tags__r)
                    {              
                        mapOfOppWithChildObject.get(opp.Id).add(amt);
                        mapOfOppWithChildObjectId.get(opp.Id).put(amt.Name, amt.Id);
                    }
                    System.debug(mapOfOppWithChildObject);
                }
                
                if(!opp.Automobile_TDU_s__r.isEmpty())
                {
                    //Loop for Automobile_TDU_s__r
                    for(Automobile_TDU__c amtdu : opp.Automobile_TDU_s__r)
                    {   
                        mapOfOppWithChildObject.get(opp.Id).add(amtdu);
                        mapOfOppWithChildObjectId.get(opp.Id).put(amtdu.Name, amtdu.Id);
                    }
                    System.debug(mapOfOppWithChildObject);
                }          
            }
        }
        
        //Loop for newlistOfOpportunity.
        for(Opportunity opp : newListOfOpportunity)
        {
            //Handle Insert And Update Case 
            if((opp.StageName == 'Shipped to Customer' || opp.StageName == 'Return To HQ' || opp.StageName == 'Return To Customer') && opp.AccountId != null && 
               (mapOfOldOpportunity == null || (mapOfOldOpportunity != null && (opp.Automobile_Tag_Details_1__c != mapOfOldOpportunity.get(opp.Id).Automobile_Tag_Details_1__c
                                                                                || opp.Automobile_Tag_Details_2__c != mapOfOldOpportunity.get(opp.Id).Automobile_Tag_Details_2__c || opp.Automobile_Tag_Details_3__c != mapOfOldOpportunity.get(opp.Id).Automobile_Tag_Details_3__c
                                                                                || opp.Return_To_HQ__c != mapOfOldOpportunity.get(opp.Id).Return_To_HQ__c || opp.StageName !=  mapOfOldOpportunity.get(opp.Id).stageName)))) 
            {
                //Set used to prevent duplicate records
                Set<String> sensorRecordName = new Set<String>();
                
                if(mapOfOppWithChildObject.size() > 0)
                {
                    if(mapOfOppWithChildObject.containsKey(opp.Id))
                    {                           
                        for(SObject sObj : mapOfOppWithChildObject.get(opp.Id))
                        {
                            sensorRecordName.add(String.valueOf(sObj.get('Name')));
                        }
                        System.debug(sensorRecordName);
                    }
                }
                
                //handle opportunity stage is shippment.
                if(opp.StageName == 'Shipped to Customer')
                {                    
                    //insert case in shipment stage.
                    if(mapOfOldOpportunity == null && mapOfAutoMobileTagDetailByOppId.containskey(opp.Id))
                    {  
                        for(String autoMobileName : mapOfAutoMobileTagDetailByOppId.get(opp.Id))
                        { 
                            if(sensorRecordName.contains(autoMobileName))
                            {
                                existedSensorList.add(autoMobileName);
                            }
                            else
                            {
                                if(!mapOfAutomobileSensorsTobeInsert.containskey(opp.Id))
                                    mapOfAutomobileSensorsTobeInsert.put(opp.Id, new List<SObject>());
                                
                                
                                if(isAutoMobileSensor(autoMobileName))
                                {
                                    mapOfAutomobileSensorsTobeInsert.get(opp.Id).add(new Automobile_Sensor__c(Name = autoMobileName, Account__c = opp.AccountId, Opportunity__c = opp.id));
                                    sensorRecordName.add(autoMobileName);
                                    System.debug(sensorRecordName);
                                    
                                }
                                
                                else if(isAutoMobilePresenceSensor(autoMobileName))
                                {
                                    mapOfAutomobileSensorsTobeInsert.get(opp.Id).add(new Automobile_Presence_Sensor__c(Name = autoMobileName, Account__c = opp.AccountId, Opportunity__c = opp.id));
                                    sensorRecordName.add(autoMobileName);
                                    System.debug(sensorRecordName);
                                }
                                else if(isAutoMobileTDU(autoMobileName))
                                {
                                    mapOfAutomobileSensorsTobeInsert.get(opp.Id).add(new Automobile_TDU__c(Name = autoMobileName, Account__c = opp.AccountId, Opportunity__c = opp.id));
                                    sensorRecordName.add(autoMobileName);
                                    System.debug(sensorRecordName);
                                }
                                else if(isAutoMobileTAG(autoMobileName))
                                {
                                    mapOfAutomobileSensorsTobeInsert.get(opp.Id).add(new Automobile_TAG__c(Name = autoMobileName, Account__c = opp.AccountId, Opportunity__c = opp.id));
                                    sensorRecordName.add(autoMobileName);
                                    System.debug(sensorRecordName);
                                }
                                else
                                {
                                    if(autoMobileName != null)
                                		invalidSensorList.add(autoMobileName);
                                }
                            } 
                        }
                    }
                    
                    //insert case in shipment stage.
                    if(opp.AccountId != null && mapOfOldOpportunity != null && ( mapOfOldOpportunity != null &&opp.Automobile_Tag_Details_1__c != mapOfOldOpportunity.get(opp.Id).Automobile_Tag_Details_1__c
                                                                                || opp.Automobile_Tag_Details_2__c != mapOfOldOpportunity.get(opp.Id).Automobile_Tag_Details_2__c || opp.Automobile_Tag_Details_3__c != mapOfOldOpportunity.get(opp.Id).Automobile_Tag_Details_3__c
                                                                                || opp.StageName !=  mapOfOldOpportunity.get(opp.Id).stageName))
                    {
                        List<String> newDetails = getListOfSeprateSensors(opp.Automobile_Tag_Details_1__c+'\n'+opp.Automobile_Tag_Details_2__c+'\n'+opp.Automobile_Tag_Details_3__c);
                        List<String> oldDetails = getListOfSeprateSensors(mapOfOldOpportunity.get(opp.Id).Automobile_Tag_Details_1__c+'\n'+mapOfOldOpportunity.get(opp.Id).Automobile_Tag_Details_2__c+'\n'+mapOfOldOpportunity.get(opp.Id).Automobile_Tag_Details_3__c);
                        
                        System.debug(newDetails);
                        System.debug(oldDetails);
                        
                        //loop to insert new records after update in tag details
                        for(String sensor : newDetails)
                        {   
                            if(sensorRecordName.contains(sensor) || oldDetails.contains(sensor))
                            {
                                existedSensorList.add(sensor);
                            }
                            else
                            {
                                if(!mapOfAutomobileSensorsTobeInsert.containsKey(opp.Id))
                                    mapOfAutomobileSensorsTobeInsert.put(opp.Id, new List<SObject>());
                                
                                if(isAutoMobileSensor(sensor))
                                {
                                    mapOfAutomobileSensorsTobeInsert.get(opp.Id).add(new Automobile_Sensor__c(Name = sensor, Account__c = opp.AccountId, Opportunity__c = opp.id));
                                    sensorRecordName.add(sensor);
                                    System.debug(sensorRecordName);
                                }
                                
                                else if(isAutoMobilePresenceSensor(sensor))
                                {
                                    mapOfAutomobileSensorsTobeInsert.get(opp.Id).add(new Automobile_Presence_Sensor__c(Name = sensor, Account__c = opp.AccountId, Opportunity__c = opp.id));
                                    sensorRecordName.add(sensor);
                                    System.debug(sensorRecordName);
                                }
                                else if(isAutoMobileTDU(sensor))
                                {
                                    mapOfAutomobileSensorsTobeInsert.get(opp.Id).add(new Automobile_TDU__c(Name = sensor, Account__c = opp.AccountId, Opportunity__c = opp.id));
                                    sensorRecordName.add(sensor);
                                    System.debug(sensorRecordName);
                                }
                                else if(isAutoMobileTAG(sensor))
                                {
                                    mapOfAutomobileSensorsTobeInsert.get(opp.Id).add(new Automobile_TAG__c(Name = sensor, Account__c = opp.AccountId, Opportunity__c = opp.id));
                                    sensorRecordName.add(sensor);
                                    System.debug(sensorRecordName);
                                }
                                else
                                {
                                    if(sensor != null)
                                		invalidSensorList.add(sensor);
                                }
                            }
                        }
                    }
                }
                //handle stage in Return To HQ
                if(opp.StageName == 'Return To HQ' && opp.AccountId != null && opp.Return_To_HQ__c != null )
                {
                    List<String> sensorDetailsOfReturnToHQ = getListOfSeprateSensors(opp.Return_To_HQ__c);
                    System.debug(sensorDetailsOfReturnToHQ);
                    List<String> allsensorDetailsOfTags = getListOfSeprateSensors(opp.Automobile_Tag_Details_1__c+'\n'+opp.Automobile_Tag_Details_2__c+'\n'+opp.Automobile_Tag_Details_3__c);
                    System.debug(sensorDetailsOfReturnToHQ);
                    for(String sensorReturnToHQ : sensorDetailsOfReturnToHQ)
                    {
                        if(allsensorDetailsOfTags.contains(sensorReturnToHQ) && mapOfOppWithChildObjectId.containsKey(opp.Id) && mapOfOppWithChildObjectId.get(opp.Id).keySet().contains(sensorReturnToHQ))
                        {
                            if(!mapOfAutomobileSensorsTobeUpdate.containsKey(opp.Id))
                                mapOfAutomobileSensorsTobeUpdate.put(opp.Id, new List<SObject>());
                            
                            if(isAutoMobileSensor(sensorReturnToHQ))
                            {
                                mapOfAutomobileSensorsTobeUpdate.get(opp.Id).add(new Automobile_Sensor__c( Id = mapOfOppWithChildObjectId.get(opp.Id).get(sensorReturnToHQ), Name = sensorReturnToHQ, Account__c = opp.Shipment_Account__c));
                            }
                            
                            else if(isAutoMobilePresenceSensor(sensorReturnToHQ))
                            {
                                mapOfAutomobileSensorsTobeUpdate.get(opp.Id).add(new Automobile_Presence_Sensor__c(Id = mapOfOppWithChildObjectId.get(opp.Id).get(sensorReturnToHQ), Name = sensorReturnToHQ, Account__c = opp.Shipment_Account__c));
                            }
                            else if(isAutoMobileTDU(sensorReturnToHQ))
                            {
                                mapOfAutomobileSensorsTobeUpdate.get(opp.Id).add(new Automobile_TDU__c(Id = mapOfOppWithChildObjectId.get(opp.Id).get(sensorReturnToHQ), Name = sensorReturnToHQ, Account__c = opp.Shipment_Account__c));
                            }
                            else if(isAutoMobileTAG(sensorReturnToHQ))
                            {
                                mapOfAutomobileSensorsTobeUpdate.get(opp.Id).add(new Automobile_TAG__c(Id = mapOfOppWithChildObjectId.get(opp.Id).get(sensorReturnToHQ), Name = sensorReturnToHQ, Account__c = opp.Shipment_Account__c));
                            }
                            else
                            {
                                if(sensorReturnToHQ != null)
                                	invalidSensorList.add(sensorReturnToHQ);
                            }                            
                        }
                    }
                    System.debug(mapOfAutomobileSensorsTobeUpdate);
                }
                
                // if stage changed to Return To Customer
                if(opp.StageName == 'Return To Customer' && opp.AccountId != null && (opp.Automobile_Tag_Details_1__c != null || opp.Automobile_Tag_Details_2__c != null || opp.Automobile_Tag_Details_3__c !=null)) 
                {
                    List<String> SetOfSensorToRTC = getListOfSeprateSensors(opp.Automobile_Tag_Details_1__c+'\n'+opp.Automobile_Tag_Details_2__c+'\n'+opp.Automobile_Tag_Details_3__c);
                    for(String singleSensorToReturn : setOfSensorToRTC)
                    {
                        if(mapOfOppWithChildObjectId.containsKey(opp.Id) && mapOfOppWithChildObjectId.get(opp.Id).keySet().contains(singleSensorToReturn))
                        {
                            if(!mapOfAutomobileSensorsTobeUpdate.containsKey(opp.Id))
                                mapOfAutomobileSensorsTobeUpdate.put(opp.Id, new List<SObject>());
                            
                            if(isAutoMobileSensor(singleSensorToReturn))
                            {
                                mapOfAutomobileSensorsTobeUpdate.get(opp.Id).add(new Automobile_Sensor__c(Id = mapOfOppWithChildObjectId.get(opp.Id).get(singleSensorToReturn), Name = singleSensorToReturn, Account__c = opp.AccountId, Opportunity__c = opp.id));
                            }
                            
                            else if(isAutoMobilePresenceSensor(singleSensorToReturn))
                            {
                                mapOfAutomobileSensorsTobeUpdate.get(opp.Id).add(new Automobile_Presence_Sensor__c(Id = mapOfOppWithChildObjectId.get(opp.Id).get(singleSensorToReturn), Name = singleSensorToReturn, Account__c = opp.AccountId, Opportunity__c = opp.id));
                            }
                            else if(isAutoMobileTDU(singleSensorToReturn))
                            {
                                mapOfAutomobileSensorsTobeUpdate.get(opp.Id).add(new Automobile_TDU__c(Id = mapOfOppWithChildObjectId.get(opp.Id).get(singleSensorToReturn), Name = singleSensorToReturn, Account__c = opp.AccountId, Opportunity__c = opp.id));
                            }
                            else if(isAutoMobileTAG(singleSensorToReturn))
                            {
                                mapOfAutomobileSensorsTobeUpdate.get(opp.Id).add(new Automobile_TAG__c(Id = mapOfOppWithChildObjectId.get(opp.Id).get(singleSensorToReturn), Name = singleSensorToReturn, Account__c = opp.AccountId, Opportunity__c = opp.id));
                            }
                            else
                            {   
                                if(singleSensorToReturn != null)
                                	invalidSensorList.add(singleSensorToReturn);
                            }
                        }
                    }   
                }
            }
        }
        //Map to hold Successfully inserted data
        Map<Id, List<Sobject>> mapOfSuccessfullyInsertRecord = new Map<Id, List<Sobject>>();
        
        //Map to hold Successfully inserted data
        Map<Id, List<Sobject>> mapOfUnsuccessfullyInsertRecord = new Map<Id, List<Sobject>>();
        
        //Insertion of Data 
        if(mapOfAutomobileSensorsTobeInsert.size() > 0)
        {   
            Set<String> setOfSuccessfulRecord = new Set<String>();
            for(Id autoMobileId : mapOfAutomobileSensorsTobeInsert.keySet())
            {   
                listOfSobjectToInsert.addAll(mapOfAutomobileSensorsTobeInsert.get(autoMobileId)); 
            }
            
            Database.SaveResult[] insertedRecordDetail = Database.insert(listOfSobjectToInsert, false);
            System.debug(insertedRecordDetail);
            for(Integer i=0; i < insertedRecordDetail.size(); i++)
            {
                if(insertedRecordDetail[i].isSuccess())
                {
                    setOfSuccessfulRecord.add(insertedRecordDetail[i].getId());
                }
            }
            
            //Loop over mapToInsertSobjectRecord to fill mapOfSuccessfullyInsertRecord
            for(Id key : mapOfAutomobileSensorsTobeInsert.KeySet()){
                for(Sobject obj : mapOfAutomobileSensorsTobeInsert.get(Key))
                {
                    if(obj.get('Id') != null && setOfSuccessfulRecord.contains(String.valueOf(obj.get('Id'))))
                    {
                        if(!mapOfSuccessfullyInsertRecord.containsKey(key))
                            mapOfSuccessfullyInsertRecord.put(Key, new List<Sobject>());
                        mapOfSuccessfullyInsertRecord.get(key).add(obj);
                    }
                }
            }
        }
        
        //Updation of Data
        if(mapOfAutomobileSensorsTobeUpdate.size() > 0)
        {
            for(Id autoMobileId : mapOfAutomobileSensorsTobeUpdate.keySet())
            {
                listOfSobjectToUpdate.addAll(mapOfAutomobileSensorsTobeUpdate.get(autoMobileId)); 
            }
            
            update(listOfSobjectToUpdate);
        }
        System.debug('Invalid Data======>'+invalidSensorList);
        System.debug('Already Existed DATA======>'+existedSensorList);
        
        //Calling Email Method
        sendEmail(mapOfSuccessfullyInsertRecord, mapOfAutomobileSensorsTobeUpdate, mapOfOppWithId, mapOfUnSuccessfullyInsertRecord, invalidSensorList, existedSensorList);
    }
    
    //For Handling email 
    
    /* 
*	Description     : This method is used for handeling email
*	Return Type		: void
*	@argument		: String
*	Revision Logs   : V_1.0 - Created
*/
    public static void sendEmail( Map<Id, List<Sobject>> mapOfSuccessfullyInsertRecord, Map<Id, List<Sobject>> mapOfAutomobileSensorsTobeUpdate, Map<Id, Opportunity>mapOfOppWithId, Map<Id, List<Sobject>>mapOfUnSuccessfullyInsertRecord, List<String> invalidSensorList,List<String> existedSensorList){
        //List of single mail.
        List<Messaging.SingleEmailMessage> listOfSingleMail = new List<Messaging.SingleEmailMessage>();
        
        Set<Id> setOfUpatedRecordOppId = new Set<Id>();
        System.debug(mapOfSuccessfullyInsertRecord);
        for(Id key : mapOfSuccessfullyInsertRecord.KeySet()){
            
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            List<String> toAddress = new List<String>{mapOfOppWithId.get(Key).Owner.Email};
                email.setSubject(mapOfOppWithId.get(Key).Name + ' Shipment Details');
            email.setToAddresses(toAddress);
            
            String mailBody = 'Sensor shipment process is completed. Please refer below mentioned details to get all ';
            mailBody += 'the success and failure details. </br>';
            mailBody += 'Successful: </br>';             
            mailBody += '<table border = "1">'+
                '<tr>'+
                '<th> AutoMobile Type </th>'+
                '<th> AutoMobile Name </th>'+
                '<th> Message </th>'+
                '</tr>';
            for(Sobject obj : mapOfSuccessfullyInsertRecord.get(Key)){
                Id autoId = String.valueOf(obj.get('Id'));
                String autoMobileType = autoId.getSObjectType().getDescribe().getlabel();
                System.debug(obj);
                
                mailBody += '<tr>'+
                    '<td>'+ autoMobileType +'</td>'+
                    '<td>'+ String.valueOf(obj.get('Name')) +'</td>'+
                    '<td> Sensor inserted under installation account "'+mapOfOppWithId.get(key).Account.Name +'</td>'+
                    '</tr>';
            }
            
            //loop over updated record.
            if(mapOfAutomobileSensorsTobeUpdate.containsKey(key)){
                setOfUpatedRecordOppId.add(key);
                for(Sobject obj : mapOfAutomobileSensorsTobeUpdate.get(key)){
                    Id automobileId = String.valueOf(obj.get('Id'));
                    String autoMobileType = automobileId.getSObjectType().getDescribe().getlabel();
                    
                    mailBody += '<tr>'+
                        '<td>'+ autoMobileType +'</td>'+
                        '<td>'+ String.valueOf(obj.get('Name')) +'</td>';
                    
                    if(mapOfOppWithId.get(Key).StageName.EqualsIgnoreCase('Return To HQ'))
                        mailBody += '<td> '+ mapOfOppWithId.get(key).Account.Name +' is moved from shipment account '+mapOfOppWithId.get(key).Shipment_Account__r.Name+' to installation account '+mapOfOppWithId.get(key).Account.Name+' </td>';
                    if(mapOfOppWithId.get(Key).StageName.EqualsIgnoreCase('Return To Customer'))
                        mailBody += '<td> '+ mapOfOppWithId.get(key).Account.Name +' is moved from shipment account '+mapOfOppWithId.get(key).Account.Name+' to installation account '+mapOfOppWithId.get(key).Shipment_Account__r.Name+' </td>';
                    mailBody += '</tr>';
                }
            }
            
            mailBody += '</table><br><br>';
            mailBody += 'Unsuccessful: </br>';
            mailBody += '<table border = "1">'+
                '<tr>'+
                '<th> AutoMobile Type </th>'+
                '<th> AutoMobile Name </th>'+
                '<th> Message </th>'+
                '</tr>';
            for(String str : invalidSensorList)
            {
                mailBody += '<tr>'+
                    '<td>None</td>'+
                    '<td>'+str+'</td>'+
                    '<td>Invalid sensor</td>'+
                    '</tr>';
            }
            for(String str : existedSensorList)
            {
                if(isAutoMobileSensor(str))
                {
                    mailBody += '<tr>'+
                        '<td>AutoMobie Sensor</td>'+
                        '<td>'+str+'</td>';
                }
                
                else if(isAutoMobilePresenceSensor(str))
                {
                    mailBody += '<tr>'+
                        '<td>AutoMobie Presence Sensor</td>'+
                        '<td>'+str+'</td>';
                }
                else if(isAutoMobileTDU(str))
                {
                    mailBody += '<tr>'+
                        '<td>AutoMobie TDU</td>'+
                        '<td>'+str+'</td>';
                }
                else if(isAutoMobileTAG(str))
                {
                    mailBody += '<tr>'+
                        '<td>AutoMobie TAG</td>'+
                        '<td>'+str+'</td>';
                }
                mailBody += '<td>Already Existing</td>'+'</tr>';
            }
            mailBody += '</table>';
            
            email.setHtmlBody(mailBody);
            listOfSingleMail.add(email);
        }
        
        //loop over updated record.
        for(Id key : mapOfAutomobileSensorsTobeUpdate.keySet()){
            if(!setOfUpatedRecordOppId.contains(key)){
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                String[] toAddress = new String[] {mapOfOppWithId.get(Key).Owner.Email};
                    email.setSubject(mapOfOppWithId.get(Key).Name + ' Shipment Details');
                email.setToAddresses(toAddress);
                String mailBody = 'Here is the detail of automobile parts </br>';
                mailBody += 'Successfully Updated Record </br>';
                mailBody += '<table border="1">'+
                    '<tr>'+
                    '<th> AutoMobile Type </th>'+
                    '<th> AutoMobile Name </th>'+
                    '<th> Comments </th>'+
                    +                '</tr>';
                
                for(Sobject obj : mapOfAutomobileSensorsTobeUpdate.get(key)){
                    Id automobileId = String.valueOf(obj.get('Id'));
                    String autoMobileType = automobileId.getSObjectType().getDescribe().getlabel();
                    System.debug('This is obj==>'+obj);
                    mailBody += '<tr>'+
                        '<td>'+ autoMobileType +'</td>'+
                        '<td>'+ String.valueOf(obj.get('Name')) +'</td>';
                    
                    if(mapOfOppWithId.get(Key).StageName.EqualsIgnoreCase('Return To HQ'))
                        mailBody += '<td> Sensor update successfully from '+ mapOfOppWithId.get(key).Account.Name +' to '+mapOfOppWithId.get(key).Shipment_Account__r.Name+'</td>';
                    if(mapOfOppWithId.get(Key).StageName.EqualsIgnoreCase('Return To Customer'))
                        mailBody += '<td> Sensor update successfully from '+ mapOfOppWithId.get(key).Shipment_Account__r.Name +' to '+mapOfOppWithId.get(key).Account.Name+'</td>';
                    
                    mailBody += '</tr>';
                } 
                mailBody += '</table>';
                email.setHtmlBody(mailBody);
                listOfSingleMail.add(email);
            }
        }
        
        //Send Email
        if(listOfSingleMail.size() > 0)
            Messaging.sendEmail(listOfSingleMail);
    }
    
    public static List<String> getListOfSeprateSensors(String Str){
        
        List<String> setToReturn = new List<String>();       
        for(String splitStr : Str.split('\n'))
        {
            splitStr = splitStr.trim();            
            if(splitStr.length() > 18)
            {
                setToReturn.add(splitStr.substring(0, 18).trim());
            }
            else
                setToReturn.add(splitStr);
        }
        return setToReturn;
    }
    
    /* 
*	Description     : This method is used fetch check that parameter is autoMobileSensor type or not.
*	Return Type		: Boolean
*	@argument		: String
*	Revision Logs   : V_1.0 - Created
*/
    public static Boolean isAutoMobileSensor(String str){
        
        String autoMobileSensor = '00:11:CE:00';
        if(str.startsWith(autoMobileSensor))
            return true;
        else
            return false;
    }
    
    /* 
*	Description     : This method is used to check that parameter is AutoMobilePresenceSensor type or not.
*	Return Type		: Boolean
*	@argument		: String
*	Revision Logs   : V_1.0 - Created
*/
    public static Boolean isAutoMobilePresenceSensor(String str){
        String autoMobilePresenceSensor = '00:11:CE:D';
        if(str.startsWith(autoMobilePresenceSensor))
            return true;
        else
            return false;
    }
    
    /* 
*	Description     : This method is used to check that parameter is isAutoMobileTBU type or not.
*	Return Type		: Boolean
*	@argument		: String
*	Revision Logs   : V_1.0 - Created
*/
    public static Boolean isAutoMobileTDU(String str){
        String autoMobileTDU = '00:11:CE:E';
        if(str.startsWith(autoMobileTDU))
            return true;
        else
            return false;
    }
    
    /* 
*	Description     : This method is used to check that parameter is isAutoMobileTAG type or not.
*	Return Type		: Boolean
*	@argument		: String
*	Revision Logs   : V_1.0 - Created
*/
    public static Boolean isAutoMobileTAG(String str){
        //numeric
        //  |
        //  |
        //  V
        // Format Should be 'XXX-XXX-XXX';
        Boolean returnValue = false;        
        if(str.contains('-'))
        {
            List<String> splitString = str.split('-');            
            if(splitString.size() == 3 && splitString[0].length() == 3 && splitString[0].isNumeric() && splitString[1].length() == 3 && splitString[2].length() == 3 )
                returnValue = true;
        }        
        return returnValue;
    }
}