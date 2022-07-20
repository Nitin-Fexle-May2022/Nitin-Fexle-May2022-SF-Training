public class CountryStateDistrictDataManipulation{
    
    String combinationKey;
    Integer districtSize;
    
    static List<District__c> listOfDistrict = [SELECT Id, Name, State_Name__r.Country_Name__r.Id, State_Name__r.Country_Name__r.Name,
                                               State_Name__r.Id, State_Name__r.Name FROM District__c ];
    
    //Nested Map using Country to get the states and city name
    static Map<String, Map<String, List<String>>> countryMapWithStates = new Map<String, Map<String, List<String>>>();
    
    public CountryStateDistrictDataManipulation(String combinationKey , Integer districtSize){
        
        this.combinationKey = combinationKey;
        this.districtSize = districtSize;
        
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
        countryJSONGenerator();
    }
    
    public static void findCombinationCountryStateDistrict(String combinationLetter , Integer districtSize){
        
        List<String> listOfDistricts = new List<String>();
        for(District__c dis : listOfDistrict)
        {
            if(dis.Name.startsWith(combinationLetter) && dis.State_Name__r.Name.startsWith(combinationLetter) 
               && dis.State_Name__r.Country_Name__r.Name.startsWith(combinationLetter))
                System.debug('Combination - Country : '+dis.State_Name__r.Country_Name__r.Name+', State : '+dis.State_Name__r.Name+
                             ', District : '+dis.Name);
        }
        
        System.debug('District with Greater Interger : ');
        for(District__c dis : listOfDistrict){
            if(dis.Name.length() >= districtSize)
                listOfDistricts.add(dis.Name);               
        }
        System.debug(listOfDistricts);
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
    public static void countryJSONGenerator(){
        
        List<Country__c> countryList = [SELECT Id, Name, Total_Number_of_Districts__c, Total_Number_of_States__c, Country_Code__c, 
                                        (SELECT Id, Name, Total_Number_of_Districts__c FROM States__r )
                                        FROM Country__c ];
        if(!countryList.isEmpty())
            for(Country__c co : countryList)
        {
            {
                Country wCountry = new Country();
                wCountry.countryName = co.Name;
                wCountry.countryCode = co.Country_Code__c;
                wCountry.states = new List<states>();
                wCountry.Total_Number_Of_Districts = (Integer)co.Total_Number_of_Districts__c;
                wCountry.Total_Number_Of_States = (Integer)co.Total_Number_of_States__c;
                
                if(!co.States__r.isEmpty())
                {
                    for(State__c st : co.States__r)
                    {
                        States wrapState = new States();
                        wrapState.stateName = st.Name;
                        wrapState.districts = new List<Districts>();
                        wrapState.Total_Number_Of_Districts = (Integer)st.Total_Number_of_Districts__c;
                        
                        for(String dt : countryMapWithStates.get(co.Name).get(st.Name))
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
                co.Country_JSON_Data__c = jString;
                update countryList;
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