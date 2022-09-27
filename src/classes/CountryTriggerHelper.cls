public class CountryTriggerHelper {
    
    public static void updateCountryJason(List<Country__c> newListOfCountry, Map<Id, Country__c> mapOfOldCountry){
        
        if(!newListOfCountry.isEmpty())
        {   
            Set<Id> setOfCountryId = new Set<Id>();
            for(Country__c cou : newListOfCountry)
            {
                if(mapOfOldCountry != null && (cou.Total_Number_of_Districts__c != mapOfOldCountry.get(cou.id).Total_Number_of_Districts__c || cou.Total_Number_of_States__c != mapOfOldCountry.get(cou.id).Total_Number_of_States__c ))
                {   
                    setOfCountryId.add(cou.Id);               
                }
            }
            if(!setOfCountryId.isEmpty())
            {
                List<State__c> listOfState = [Select Id, Name, Total_Number_of_Districts__c, Country_Name__c, Country_Name__r.Name, Country_Name__r.Country_Code__c, Country_Name__r.Total_Number_of_Districts__c, Country_Name__r.Total_Number_of_States__c, 
                                              (Select Id, Name From Districts1__r) From State__c Where Country_Name__c IN : setOfCountryId];
                Map<Id, State__c> mapOfStatewithCountryId = new Map<Id, State__c>();
                for(State__c st : listOfState)
                {
                    if(!mapOfStatewithCountryId.containsKey(st.Country_Name__c))
                        mapOfStatewithCountryId.put(st.Country_Name__c, st);
                }
                
                if(!newListOfCountry.isEmpty())
                {
                    for(Country__c cou : newListOfCountry)
                    {
                        if(mapOfOldCountry != null && (cou.Total_Number_of_Districts__c != mapOfOldCountry.get(cou.id).Total_Number_of_Districts__c || cou.Total_Number_of_States__c != mapOfOldCountry.get(cou.id).Total_Number_of_States__c )) 
                        {  
                            Country wCountry = new Country();
                            wCountry.countryName = mapOfStatewithCountryId.get(cou.Id).Country_Name__r.Name;
                            wCountry.countryCode = mapOfStatewithCountryId.get(cou.Id).Country_Name__r.Country_Code__c;
                            wCountry.states = new List<states>();
                            wCountry.Total_Number_Of_Districts = (Integer)cou.Total_Number_of_Districts__c;
                            wCountry.Total_Number_Of_States = (Integer)cou.Total_Number_of_States__c;
                            
                            for(State__c st : listOfState)
                            {   
                                if(st.Country_Name__c == cou.Id)
                                {
                                    States wrapState = new States();
                                    wrapState.stateName = st.Name;
                                    wrapState.districts = new List<Districts>();
                                    wrapState.Total_Number_Of_Districts = (Integer)st.Total_Number_of_Districts__c; 
                                    
                                    for(District__c dt : st.Districts1__r)
                                {
                                    Districts wrapDistrict = new Districts();
                                    wrapDistrict.districtName = dt.Name;
                                    wrapState.districts.add(wrapDistrict);
                                }
                                wCountry.states.add(wrapState);   
                                }
                            }
                             String jString = JSON.serialize(wCountry);
                            cou.Country_JSON_Data__c = jString;
                        }
                    } 
                }
            }
        }     
    }
    public List<Country> countryList{get; set;}
    public class Country{
        public String countryName{get; set;}
        public String countryCode{get; set;}
        public Integer Total_Number_Of_States{get; set;}
        public Integer Total_Number_Of_Districts{get; set;}
        public List<States> states{get; set;}       
    }
    public class States{
        Public string stateName{get; set;}
        Public List<Districts> districts{get; set;}
        public Integer Total_Number_Of_Districts{get; set;}
    }
    public class Districts{
        Public String districtName{get; set;}
    }
}