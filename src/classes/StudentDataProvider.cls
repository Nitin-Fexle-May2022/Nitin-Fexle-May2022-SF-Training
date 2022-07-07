public class StudentDataProvider {
	//Way of Caching the Data
    public static Student__c stData{
        get{
            if(stData == null){
                //One time run 
                stData = [select id, Name from Student__c where Name = Null ];
            }
            return stData;
        }
        
        set{
            stData.Name = stData.Name + DateTime.now();
            System.debug('Check stData.Name' + stData.Name);
        }
    }
    
    @AuraEnabled
    public static Student__c getStData(){
        Student__c stLocal;
        if(stLocal ==  Null)
        {
            stLocal = [Select  id, Name from Student__c where Name != Null];
        }
        return stLocal;
    }
    
    @AuraEnabled
    public static Student__c setStData(){
        if(stData ==  Null)
        {
            stData = [Select  id, Name from Student__c where Name != Null];
        }
        return stData;
    }
    
}