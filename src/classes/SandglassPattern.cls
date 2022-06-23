public class SandglassPattern {
    
    public static void printPattern(){
        
       integer k=0;
       for(integer i=1;i<=10;i++)
        {
            if(i<=5){k++;} else{k--;}
            if(i==6){k++;} 
            string s='  ';
            for(integer j=1;j<=9;j++)
            {
                if(j>=k && j<=10-k)
                {
                    s = s + 'x';
                }
                else
                {
                     s = s + '_';
                }
            }
            
            system.debug(s);
            
        }       
    }
}