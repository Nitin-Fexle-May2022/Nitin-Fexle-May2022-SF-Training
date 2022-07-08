// Another implementation of the interface for employees
public class EmployeePurchaseOrder implements PurchaseOrder {
      public Double discount() {
          System.debug(.10);
          return .10;  // It’s worth it being an employee! 10% discount
      } 
}