public class Collection {
	
    public static void of() {
        Opportunity opp = [SELECT id,CloseDate,currencyIsoCode FROM Opportunity limit 1];
        
    	Set<Opportunity> oppSetToUpdate = new Set<Opportunity>();
        
        opp.CloseDate = System.now().date()+7;
        oppSetToUpdate.add(opp);
		
        opp.CurrencyIsoCode = 'INR';
        
        System.debug('@@ oppSetToUpdate @@ '+ oppSetToUpdate);
        
        update new List<Opportunity>(oppSetToUpdate);
    }
    
    
}