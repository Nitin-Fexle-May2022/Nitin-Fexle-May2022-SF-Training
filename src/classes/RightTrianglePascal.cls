public class RightTrianglePascal {
    
    public static void printPattern(){
        
        integer k=0;
       for(integer i=1;i<=10;i++)
        {
            if(i<=5){k++;} else{k--;}
            string s='  ';
            for(integer j=1;j<=5;j++)
            {
                if(j<=k)
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