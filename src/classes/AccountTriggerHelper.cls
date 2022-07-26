/**
* Description   - Account Trigger Helper Class.   
* Created by    - Nitin Rajput
* Created Date  - 21/07/2022
* Revision log  -  V_1.0 - Created  - Nitin Rajput - 21/07/2022
**/
public class AccountTriggerHelper {
    /**   
    * 	  Description :  Method is used to before insert automation.
    *     Created By  :   Nitin Rajput
    *     Arguments   :   List<Account>
    *     Return      :   void
    *     Revision log:   V_1.0 - Created  - Nitin Rajput - 21/07/2022                    
	**/
    public static void accountEmailHandlerBeforeInsert(List<Account> newAccounts){
		for(Account acc : newAccounts)
        {   
            if(acc.Type == 'Saving')
            	acc.AccountNumber = 'SA-'+acc.AccountNumber;
            if(acc.Type == 'FD')
            	acc.AccountNumber = 'FD-'+acc.AccountNumber;           
        }
    }
	/**   
    * 	  Description :   Method is used to after insert automation.
    *     Created By  :   Nitin Rajput
    *     Arguments   :   List<Account>
    *     Return      :   void
    *     Revision log:   V_1.0 - Created  - Nitin Rajput - 21/07/2022                    
	**/
	public static void accountEmailHandlerAfterInsert(List<Account> newAccounts){
        String emailBodyPrefix = 'Hello Dear Customer, \n Cogratulations Your Account is Successfully Created.\n Your Account Detail is :: \n Account Name : '; 
        String emailBodyPostfix = '\n Thanks And Regards\n Nitin Rajput';
        String accDetails = '\n Account Number : ';
        String emailSubject = 'Your Bank Account Created';
        for(Account acc : newAccounts)
        {
			String emailBody = emailBodyPrefix + acc.Name + accDetails + acc.AccountNumber + emailBodyPostfix; 
            sendEmailWithoutTemplate(new List<String>{acc.Account_Email__c}, null, emailSubject, emailBody);
        }      
    }
    
        /**   
    * 	  Description :  Method is used to before Update automation.
    *     Created By  :   Nitin Rajput
    *     Arguments   :   List<Account>, Map<Id, Account>
    *     Return      :   void
    *     Revision log:   V_1.0 - Created  - Nitin Rajput - 22/07/2022                    
	**/
    public static void accountEmailHandlerBeforeUpdate(List<Account> newAccounts, Map<Id, Account> oldAccountMap){
		//Loop Over New Account Records 
        for(Account acc : newAccounts)
        {   
            if(oldAccountMap != Null && acc.Type != oldAccountMap.get(acc.Id).Type)
            {  
                // if Account Type Changed to Saving
                if(acc.Type == 'Saving')
                {
                    if(oldAccountMap.get(acc.Id).Type != 'FD')
                    	acc.AccountNumber = 'SA-' + acc.AccountNumber;
                    else
                        acc.AccountNumber = acc.AccountNumber.replace('FD', 'SA');
                }
                // if Account Type Changed to FD
                else if(acc.Type == 'FD' )
                {
                    if(oldAccountMap.get(acc.Id).Type != 'Saving')
                        acc.AccountNumber = 'FD-' + acc.AccountNumber;
                    else
                        acc.AccountNumber = acc.AccountNumber.replace('SA', 'FD');
                }
                 // if Account Type Changed to Other
                else if(oldAccountMap.get(acc.Id).Type == 'Saving' || oldAccountMap.get(acc.Id).Type == 'FD')
                {
                        acc.AccountNumber = acc.AccountNumber.subString(3);
                }
            }
        }
    }
    
    /**   
    * 	  Description :   Method is Used to Send Email
    *     Created By  :   Nitin Rajput
    *     Arguments   :   List<String>,List<String>,String,String
    *     Return      :   void
    *     Revision log:   V_1.0 - Created  - Nitin Rajput - 21/07/2022                    
	**/
    public static void sendEmailWithoutTemplate(List<String> ccAddresses, List<String> bccAddresses, String subject, String emailBody){      
        //Creating list instance of messaging class
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        
        //Initialize variable of messaging class
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        //Set the subject of the mail
        mail.setSubject(subject);
        
        //Check for size and set to address of the mail
        if(ccAddresses != null && ccAddresses.size() > 0 )
            mail.setToAddresses(ccAddresses);
        
        //Check for size and set the cc address of the mail
        if(bccAddresses != null && bccAddresses.size() > 0)
            mail.setCcAddresses(bccAddresses);
        
        //Add the body of the mail
        mail.setPlainTextBody(emailBody);
        
        //Add into list
        mails.add(mail);    
        
        //Send email
        Messaging.sendEmail(mails); 
    }    
}