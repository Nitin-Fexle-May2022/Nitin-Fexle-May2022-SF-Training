public class ExampleB extends ExampleA{
    
    public ExampleB(){
        Integer a  = new ExampleA().classNum;
       System.debug(ExampleA.globalNum);
        
    }
     
    override public void display(){
        super.display();
    }
}