public class InstanceOfDemo {
    
    public InstanceOfDemo(){
        sObject s = new Account();
        //This one is correct typecasting
        //Account a = (Account)s;
        //It is wrong (RunTIme error)
        //Contact c = (Contacts)s;
        
        if(s instanceOf Account)
            Account a = (Account)s;
        else if(s instanceOf Contact)
            Contact c = (Contact)s;
    }

}