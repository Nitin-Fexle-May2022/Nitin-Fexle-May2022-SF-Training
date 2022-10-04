/**
* Description   - CountryStateDistrict Trigger Helper Class.   
* Created by    - Nitin Rajput
* Created Date  - 9/08/2022
* Revision log  -  V_1.0 - Created  - Nitin Rajput - 9/08/2022
**/
public class StateTriggerHelper {
    
    public static void rollupStateCountOnUsingState(List<State__c> newListOfState, Map<Id, State__c> mapOfOldState)
    {     
        // Map to hold States records to update
        Map<Id, Country__c> mapOfCountryStateToBeUpdate = new Map<Id, Country__c>();
        
        for(State__c st : newListOfState != null?newListOfState: mapOfOldState.values())
        {
            if(mapOfOldState == null || newListOfState == null || (mapOfOldState != null && (st.Country_Name__c != mapOfOldState.get(st.id).Country_Name__c || st.State_JSON_Data__c != mapOfOldState.get(st.id).State_JSON_Data__c)))
            {   
                
                if(st.Country_Name__c != null)
                    mapOfCountryStateToBeUpdate.put(st.Country_Name__c, new Country__c(Id = st.Country_Name__c, Total_Number_of_Districts__c = 0, Total_Number_of_States__c = 0, Country_JSON_Data__c = null));
                //mapOfCountryStateToBeUpdate.put(st.Country_Name__c, st.Country_Name__r);
                if(mapOfOldState != null && st.Country_Name__c != mapOfOldState.get(st.id).Country_Name__c && mapOfOldState.get(st.id).Country_Name__c != null)               
                    mapOfCountryStateToBeUpdate.put(mapOfOldState.get(st.id).Country_Name__c, new Country__c(Id = mapOfOldState.get(st.id).Country_Name__c, Total_Number_of_Districts__c = 0, 
                                                                                                             Total_Number_of_States__c = 0, Country_JSON_Data__c = null ));                
            }
        }
               
        if(!mapOfCountryStateToBeUpdate.isEmpty())
        {
            for(AggregateResult ag: [SELECT COUNT(Id) numberOfState, SUM(Total_Number_of_Districts__c) numberOfDistrict, Country_Name__c FROM State__c
                                     WHERE Country_Name__c IN : mapOfCountryStateToBeUpdate.keySet() GROUP BY Country_Name__c])
            {
                mapOfCountryStateToBeUpdate.get((Id)ag.get('Country_Name__c')).Total_Number_of_Districts__c = (Decimal)ag.get('numberOfDistrict');
                mapOfCountryStateToBeUpdate.get((Id)ag.get('Country_Name__c')).Total_Number_of_States__c = (Decimal)ag.get('numberOfState');
            }  
            update mapOfCountryStateToBeUpdate.values();
        }
    }
    public static void updateStateJason(List<State__c> newListOfState, Map<Id, State__c> mapOfOldState){
        
        if(!newListOfState.isEmpty())
        {   
            Set<Id> setOfStateId = new Set<Id>();
            for(State__c st : newListOfState)
            {
                if(mapOfOldState != null && (st.Total_Number_of_Districts__c != mapOfOldState.get(st.id).Total_Number_of_Districts__c ))
                {   
                    setOfStateId.add(st.Id);               
                }
            }
            if(!setOfStateId.isEmpty())
            {
                Map<Id, State__c> mapOfState = new Map<Id, State__c>([Select Id, Name, Total_Number_of_Districts__c, (Select Id, Name From Districts1__r) From State__c Where Id IN : setOfStateId]);
                
                if(!newListOfState.isEmpty())
                {
                    for(State__c st : newListOfState)
                    {
                        if(mapOfOldState != null && (st.Total_Number_of_Districts__c != mapOfOldState.get(st.id).Total_Number_of_Districts__c ))
                        {  
                            State wrapState = new State();
                            wrapState.stateName = mapOfState.get(st.Id).Name;
                            wrapState.districts = new List<Districts>();
                            wrapState.Total_Number_Of_Districts = (Integer)st.Total_Number_of_Districts__c;
                            
                            for(District__c dt : mapOfState.get(st.Id).Districts1__r)
                            {
                                Districts wrapDistrict = new Districts();
                                wrapDistrict.districtName = dt.Name;
                                wrapState.districts.add(wrapDistrict);
                            }
                            String jString = JSON.serialize(wrapState);
                            st.State_JSON_Data__c = jString;
                            System.debug(jString);
                        }
                    } 
                }
            }
        }     
    }
    public List<State> states{get; set;}
    public class State{
        Public string stateName{get; set;}
        Public List<Districts> districts{get; set;}
        public Integer Total_Number_Of_Districts{get; set;}
    }
    public class Districts{
        Public String districtName{get; set;}
    }
}