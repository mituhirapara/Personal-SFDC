public class quoteLineItemController {
    
    
    @AuraEnabled
    public static List<QuoteLineItem> getLineItems(id quoteId){
        
        return [Select id,Quote.Status from QuoteLineItem where QuoteId=:quoteId];
    }
  
    
    

}