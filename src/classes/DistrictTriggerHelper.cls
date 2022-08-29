/**
* Description   - CountryStateDistrict Trigger Helper Class.   
* Created by    - Nitin Rajput
* Created Date  - 9/08/2022
* Revision log  -  V_1.0 - Created  - Nitin Rajput - 9/08/2022
**/
public class DistrictTriggerHelper {
    
    public static void rollUpCountryStateCountUsingDistrict(List<District__c> newListOfDistrict, Map<Id, District__c> mapOfOldDistrict)
    {   
        // Map to hold States records to update
        Map<Id, State__c> mapOfStateDistrictsToBeUpdate = new Map<Id, State__c>();
        
        for(District__c dis : newListOfDistrict != null?newListOfDistrict: mapOfOldDistrict.values())
        {
            if(mapOfOldDistrict == null || newListOfDistrict == null || (mapOfOldDistrict != null && dis.State_Name__c != mapOfOldDistrict.get(dis.id).State_Name__c))
            {
                if(dis.State_Name__c != null)
                    mapOfStateDistrictsToBeUpdate.put(dis.State_Name__c, new State__c(Id = dis.State_Name__c, Total_Number_of_Districts__c = 0));
                
                if(mapOfOldDistrict != null && dis.State_Name__c != mapOfOldDistrict.get(dis.id).State_Name__c && mapOfOldDistrict.get(dis.id).state_Name__c != null)               
                    mapOfStateDistrictsToBeUpdate.put(mapOfOldDistrict.get(dis.id).state_Name__c, new State__c(Id = mapOfOldDistrict.get(dis.id).state_Name__c, Total_Number_of_Districts__c = 0));                
            }
        }
        if(!mapOfStateDistrictsToBeUpdate.isEmpty())
        {   
            //Map of district state
            Map<String, List<String>> StateMapWithDistricts = new Map<String, List<String>>();
            
            for(AggregateResult ag: [SELECT COUNT(Id) numberOfDistrict,  State_Name__c FROM District__c
                                     WHERE State_Name__c IN : mapOfStateDistrictsToBeUpdate.keySet() GROUP BY State_Name__c])
            {
                mapOfStateDistrictsToBeUpdate.get((Id)ag.get('State_Name__c')).Total_Number_of_Districts__c = (Integer)ag.get('numberOfDistrict');
            }
            update mapOfStateDistrictsToBeUpdate.values();
        }
    }
}