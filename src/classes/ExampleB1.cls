public class ExampleB1 extends ExampleA{
    
    public ExampleB1(){
        Integer a  = new ExampleA().classNum;
       System.debug(ExampleA.globalNum);
        
    }
     
    override public void display(){
        super.display();
    }
}