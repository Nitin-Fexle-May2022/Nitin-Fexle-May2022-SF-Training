public class ConstuctorDemo {

private static final Integer DEFAULT_SIZE = 10;

Integer size;

   //Constructor with no arguments
   public ConstuctorDemo() {
       this(DEFAULT_SIZE);
       System.debug(DEFAULT_SIZE);// Using this(...) calls the one argument constructor    
   }

   // Constructor with one argument 
   public ConstuctorDemo(Integer ObjectSize) {
     size = ObjectSize;
     System.debug(size);
   }
}