Public class QueryStudent{

    public QueryStudent(){
        //Query Single Student Record 
        
        Student__c student = [select id, Name, Roll_Number__c from Student__c order by createdDate DESC LIMIT 1];
        system.debug(student);
		/* Query 5 Students
		  
		  
		List<Student__c> studentList = [select id, Name, Roll_Number__c from Student__c order by createdDate DESC LIMIT 5];
		for(Student__c stu : studentList){
			system.debug('Check Student Data ::: ' + stu);
		}


       */
	}
}