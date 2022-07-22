/**
* Description   - Accessing Data(Convert the data) 
* Created by    - Nitin Rajput
* Created Date  - 13/07/2022
* Revision log  -  V_1.0 - Created  - Youe name - Date
*                  V_1.1 - Modified - Youe Name - Date - Details what you modified
**/
public class Assignment17 {
    public Assignment17(){
        //Parent To Child Query
        List<Country__c> countryList = [SELECT Id, Name, (SELECT Name FROM States__r) FROM Country__c];
         System.debug(countryList);
        for(Country__c ct : countryList)
        {
            System.debug(ct.States__r);
        }
        // Child To Parent Query
        List<District__c> districtList = [SELECT Id, Name, State_Name__r.Id, State_Name__r.Name, 
                                          State_Name__r.Country_Name__r.Id, State_Name__r.Country_Name__r.Name
                                         FROM District__c];
    }
    
    //example of SOSL using Generic SObject
    List<Contact> contacts = new List<Contact>();
    List<Lead> leads = new List<Lead>();
    List<Account> accounts = new List<Account>();
 
    public void convertType(String phoneNumber) {
        List<List<SObject>> results = [FIND :phoneNumber 
            IN Phone FIELDS 
            RETURNING Contact(Id, Phone, FirstName, LastName), 
            Lead(Id, Phone, FirstName, LastName), 
            Account(Id, Phone, Name)];
        List<SObject> records = new List<SObject>();
        records.addAll(results[0]); //add Contact results to our results super-set
        records.addAll(results[1]); //add Lead results
        records.addAll(results[2]); //add Account results
 
        if (!records.isEmpty()) { 
            for (Integer i = 0; i < records.size(); i++) { 
                SObject record = records[i];
                if (record.getSObjectType() == Contact.sObjectType) { 
                    contacts.add((Contact) record);
                } else if (record.getSObjectType() == Lead.sObjectType){ 
                    leads.add((Lead) record);
                } else if (record.getSObjectType() == Account.sObjectType) { 
                    accounts.add((Account) record); 
                }
            }
        }
    }
}