public with sharing class AccountUtitlity {
   

    @AuraEnabled
    public static List<Account> getPartnerAccount(){
        try {
            
            return [SELECT Id, name FROM Account];

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


}