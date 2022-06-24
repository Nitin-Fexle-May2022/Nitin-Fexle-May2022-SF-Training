public class PatternManager{
    
    public static void printPattern(){
        
        //Left Triangle Pascal's Program
		integer k=6;
       for(integer i=1;i<=9;i++)           
        {
            if(i<=5){k--;} else{k++;}
            string s='  ';
            for(integer j=1;j<=5;j++)
            {
                if(j>=k)
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
        //Down Triangle Star pattern
        
        boolean b=true;
    for(integer i=1;i<=5;i++)
    {
        string s='  ';
        for(integer j=1;j<=9;j++)
        {
          if(i>=2 && i<=4){if(j>=1+i && j<=9-i){b=false;}else{b=true;}}else{b=true;}
            
            if(j>=i && j<=10-i && b)
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
        
        //Left Triangle Star Pattern 
        
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
        
        //Downward Triangle Pattern Program
        
        for(integer i=1;i<=5;i++)
        {
            string s='  ';
            for(integer j=1;j<=5;j++)
            {
                if(j<=6-i)
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
        
        //Reversed Pyramid Pattern Program
        
        for(integer i=1;i<=5;i++){
            string s='  '; 
            boolean a=true;
            
            for(integer j=1;j<=9;j++) {
                if(j>=i && j<=10-i && a){
                    s = s + 'x';
                    a=false;
                }
                else{
                    s = s + '_';
                    a=true;
                }
            }
            system.debug(s);
        }
        
        //Right Pascal’s Triangle Program
        
        integer f=0;
       for(integer i=1;i<=10;i++)
        {
            if(i<=5){f++;} else{f--;}
            string s='  ';
            for(integer j=1;j<=5;j++)
            {
                if(j<=f)
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
        
        //Pyramid Pattern Program
        
        for(integer i=0;i<=4;i++)
        {
            string s = '  ';
            for(integer j=0;j<=8;j++)
            {
                if(j>=4-i && j<=4+i )
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
        
        //SandglassPattern Program
        
        integer h=0;
       for(integer i=1;i<=10;i++)
        {
            if(i<=5){h++;} else{h--;}
            if(i==6){h++;} 
            string s='  ';
            for(integer j=1;j<=9;j++)
            {
                if(j>=h && j<=10-h)
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