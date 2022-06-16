public class QueriesManager {
     
    //IN Operator
    public QueriesManager(){
        List<Student__c> studentList1 = [select id, Roll_Number__c,Name from Student__c where Name IN ('Nitin Rajput','Shivam Sahu') ];
        for(Student__c stu : studentList1){
			system.debug('Check Student Data ::: ' + stu);
		}
    //NOT IN Operator    
        List<Student__c> studentList2 = [select id, Roll_Number__c,Name from Student__c where Name NOT IN ('Nitin Rajput','Shivam Sahu') ];
        for(Student__c stu : studentList2){
			system.debug('Check Student Data ::: ' + stu);
		}
    //OR Operator      
        List<Student__c> studentList3 = [select id, Stream__C from Student__c where Stream__c = 'PCM' OR Stream__c = 'PCB' ];
        for(Student__c stu : studentList3){
            system.debug('Check Student Data ::: ' + stu);
        }
        
    //AND Operator      
        List<Student__c> studentList4 = [select id, Stream__C , Bank_Name__c from Student__c where Stream__c = 'PCM' AND Bank_Name__c = 'BOB'];
        for(Student__c stu : studentList4){
			system.debug('Check Student Data ::: ' + stu);        
		}
        
    //AND OR Operator      
        List<Student__c> studentList5 = [select id, Stream__C , Bank_Name__c , Name from Student__c where Bank_Name__c = 'BOB' AND (Stream__c = 'PCB' OR Stream__c = 'PCM')];
        for(Student__c stu : studentList5){
			system.debug('Check Student Data ::: ' + stu);        
	    }        
    }
}