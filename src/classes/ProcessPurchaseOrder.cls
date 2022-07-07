public class ProcessPurchaseOrder {
    
    public ProcessPurchaseOrder(){
        
        PurchaseOrder order1 = new CustomerPurchaseOrder();
        PurchaseOrder order2 = new EmployeePurchaseOrder();
        
        //Customer Order
        processOrder(order1);
        //Employee Order
        processOrder(order2);      
    }
    
    public void processOrder(PurchaseOrder order){
        
        System.debug('Check Discount ::: ' + order.discount());
    }

}