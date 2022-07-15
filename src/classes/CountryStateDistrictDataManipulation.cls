public class CountryStateDistrictDataManipulation {
    
    String combinationKey;
    String countryKey;
    Integer districtSize;
    
    //Nested Map using Country to get the states and city name
    static Map<String, Map<String, List<String>>> countryMapWithStates = new Map<String, Map<String, List<String>>>();
    
    public CountryStateDistrictDataManipulation(String combinationKey, String countryKey, Integer districtSize){
        
        this.combinationKey = combinationKey;
        this.countryKey = countryKey;
        this.districtSize = districtSize;
        
        List<District__c> listOfDistrict = [SELECT Id, Name, State_Name__r.Country_Name__r.Id, State_Name__r.Country_Name__r.Name,
                                            State_Name__r.Id, State_Name__r.Name FROM District__c ];
        for(District__c dis : listOfDistrict)
        {  
            if(!countryMapWithStates.containsKey(dis.State_Name__r.Country_Name__r.Name))
                countryMapWithStates.put(dis.State_Name__r.Country_Name__r.Name , new Map<String, List<String>>());
            if(!countryMapWithStates.get(dis.State_Name__r.Country_Name__r.Name).containsKey(dis.State_Name__r.Name))
                countryMapWithStates.get(dis.State_Name__r.Country_Name__r.Name).put(dis.State_Name__r.Name, new List<String>());
            if(!countryMapWithStates.get(dis.State_Name__r.Country_Name__r.Name).get(dis.State_Name__r.Name).contains(dis.Name))
                countryMapWithStates.get(dis.State_Name__r.Country_Name__r.Name).get(dis.State_Name__r.Name).add(dis.Name);
        }
        
        
        if(combinationKey != null)
            findCombinationCountryStateDistrict(combinationKey , districtSize);
        
        rollUpDistrictsAndStatesOnCountry();
        
        if(countryKey != null)
            countryJSONGenerator(countryKey);
    }
    
    public static void findCombinationCountryStateDistrict(String combinationLetter , Integer districtSize){
        for(String countryName : countryMapWithStates.keySet())
        {
            if(countryName.startsWith(combinationLetter))
            {
                for(String stateName : countryMapWithStates.get(countryName).keySet()){
                    if(stateName.startswith(combinationLetter))
                    {
                        for(String districtName : countryMapWithStates.get(countryName).get(stateName)){
                            if(districtName.startsWith(combinationLetter)){
                                System.debug('Combination - Country : '+countryName+', State : '+stateName+ ', District : '+districtName);
                            }
                        }
                    }
                }    
            }
        }
        
        List<String> listOfDistrict = new List<String>();
        System.debug('District with Greater Interger : ');
        for(String countryName : countryMapWithStates.keySet()){
            for(String stateName : countryMapWithStates.get(countryName).keySet()){
                for(String districtName : countryMapWithStates.get(countryName).get(stateName)){
                    if(districtName.length() >= districtSize)
                    	listOfDistrict.add(districtName);
                }
            }               
        }
        System.debug(listOfDistrict);
    }
    public static void rollUpDistrictsAndStatesOnCountry(){
        
        // Map to hold States records to update
        Map<Id, State__c> mapOfStateDistrictsToBeUpdate = new Map<Id, State__c>();
        Map<Id, Country__c> mapOfCountryDistrictsToBeUpdate = new Map<Id, Country__c>();
        
        //Get Aggregate result on Districts
        for(AggregateResult ag: [SELECT COUNT(Id) numberOfDistrict,  State_Name__c FROM District__c GROUP BY State_Name__c])
        {  
            State__c st = new State__c();
            st.Id = (Id)ag.get('State_Name__c');
            st.Total_Number_of_Districts__c = (Integer)ag.get('numberOfDistrict');
            mapOfStateDistrictsToBeUpdate.put(st.Id, st);
        }    
        if(!mapOfStateDistrictsToBeUpdate.isEmpty())
            //Update States records
            update mapOfStateDistrictsToBeUpdate.values();
        
        //Get Aggregate result on State
        for(AggregateResult ag: [SELECT COUNT(Id) numberOfStates,  Country_Name__c, SUM(Total_Number_of_Districts__c) numberOfDistricts
                                 FROM State__c GROUP BY Country_Name__c])
        {
            Country__c ct = new Country__c();
            ct.Id = (Id)ag.get('Country_Name__c');
            ct.Total_Number_of_Districts__c = (Decimal)ag.get('numberOfDistricts');
            ct.Total_Number_of_States__c = (Integer)ag.get('numberOfStates');
            mapOfCountryDistrictsToBeUpdate.put(ct.Id, ct);
        }
        
        if(!mapOfCountryDistrictsToBeUpdate.isEmpty())
            //Update Country records
            update mapOfCountryDistrictsToBeUpdate.values();
    }
    public static void countryJSONGenerator(String countryKey){
        
        List<Country__c> countryList = [SELECT Id, Name, Total_Number_of_Districts__c, Total_Number_of_States__c, Country_Code__c, 
                                        (SELECT Id, Name, Total_Number_of_Districts__c FROM States__r )
                                        FROM Country__c WHERE Name =:countryKey];
        if(!countryList.isEmpty())
        {
            Country wCountry = new Country();
            wCountry.countryName = countryList[0].Name;
            wCountry.countryCode = countryList[0].Country_Code__c;
            wCountry.states = new List<states>();
            wCountry.Total_Number_Of_Districts = (Integer)countryList[0].Total_Number_of_Districts__c;
            wCountry.Total_Number_Of_States = (Integer)countryList[0].Total_Number_of_States__c;
            
            if(!countryList[0].States__r.isEmpty())
            {
                for(State__c st : countryList[0].States__r)
                {
                    States wrapState = new States();
                    wrapState.stateName = st.Name;
                    wrapState.districts = new List<Districts>();
                    wrapState.Total_Number_Of_Districts = (Integer)st.Total_Number_of_Districts__c;
                    
                    for(String dt : countryMapWithStates.get(countryKey).get(st.Name))
                    {
                        Districts wrapDistrict = new Districts();
                        wrapDistrict.districtName = dt;
                        wrapState.districts.add(wrapDistrict);
                    }
                    wCountry.states.add(wrapState);         
                }
            }
            String jString = JSON.serialize(wCountry);
            System.debug(jString); 
            countryList[0].Country_JSON_Data__c = jString;
            update countryList;
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