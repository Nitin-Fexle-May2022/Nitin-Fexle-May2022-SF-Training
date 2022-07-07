public class Assignment13 {
    public Assignment13(){
       // Conditional(If-else statement)
       //It can be used in two ways (If-else) independently and evaluate a logical outcome using operators on variables.
       // It can be used in an if-else ladder structure until one condition is true.
       // It's up to your logic how you use it.

       Integer x1=-32, sign1;
        // Your code
        if (x1 <= 0) if (x1 == 0) sign1 = 0; else sign1 = -1;
        System.debug(sign1);
       
       //is equivalent to:
       Integer x=-32, sign;
        // Your code
        if (x <= 0) {
            if (x == 0) {
                sign = 0; 
            } else  {
                sign = -1;
            }
        }
        System.debug(sign);
        
        //Repeated else if statements are also allowed. For example:
        Integer place = 2;
        String medal_color;
        if (place == 1) {
            medal_color = 'gold';
        } else if (place == 2) {
            medal_color = 'silver';
        } else if (place == 3) {
            medal_color = 'bronze';
        } else {
            medal_color = null;
        }
        System.debug(medal_color);

        //Do-While Loops
        Integer count = 1;

        do {
            System.debug(count);
            count++;
        } while (count < 11);

        //While Loops
        Integer count1 = 1;

        while (count1 < 11) {
            System.debug(count1);
            count1++;
        }

        //for loop

        //Traditional For Loops
        for (Integer i = 0, j = 0; i < 10; i++) {
            System.debug(i+1);
        }

        //List or Set Iteration for Loops
        Integer[] myInts = new Integer[]{1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

        for (Integer i : myInts) {
            System.debug(i);
        }
    }

}