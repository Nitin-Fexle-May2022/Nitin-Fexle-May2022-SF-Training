// One implementation of the interface for customers
public class CustomerPurchaseOrder implements PurchaseOrder {
    public Double discount() {
        System.debug(.05);
        return .05;  // Flat 5% discount
    }
}