public class LeftTrianglePattern {
    public static void printPattern(){
        
            for(integer i=1;i<=5;i++)
        {
            string s='  ';
            for(integer j=1;j<=5;j++)
            {
                if(j>=6-i )
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