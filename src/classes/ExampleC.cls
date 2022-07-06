//Call By Value //Call By Reference
public class ExampleC{
	Student__c sl = new Student__c();
	Integer i = 10;
	public ExampleC() {
		manipulateReferences (sl);
		system.debug ('Check Student Name ::: ' + sl.Name);
		checkCallByValue (i);
		system.debug ('Check I::: ' + i);
    }
		public void manipulateReferences (Student__c stData) {
            for (Integer i= 0; i<10; i++)
			stData.Name = stData.Name + i;
        }
			public void checkCallByValue (Integer i)
            {
				i= 50;
				system.debug('Check I::: ' + i);
            }        
}