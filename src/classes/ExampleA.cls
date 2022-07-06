public virtual class ExampleA {
	public static Integer globalNum = 10;
    public Integer classNum = 20;
    private Integer classNum_1 = 30;
    protected Integer abc = 40;
    
    public virtual void display(){
        System.debug('This is ExampleA method');
    }
    public static void display1(){
        System.debug('This is ExampleA method');
    } 
}