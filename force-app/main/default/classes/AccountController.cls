public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static Map<Id, Contact> getRelatedContactsMap(Id accountId) {
        Map<Id, Contact> contactMap = new Map<Id, Contact>();
        try {
            contactMap = new Map<Id, Contact>([SELECT id, Name FROM Contact WHERE AccountId = :accountId]);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return contactMap;
    }

    //Apex methods that are to be cached must be marked as @AuraEnabled(cacheable=true)
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountByName(String searchKey) {
        try {
            return SOQL.of(Account.sObjectType).with(Account.Id, Account.Name).whereAre(SOQL.Filter.with(Account.Name).contains('%', searchKey, '%')).setLimit(10).toList();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}