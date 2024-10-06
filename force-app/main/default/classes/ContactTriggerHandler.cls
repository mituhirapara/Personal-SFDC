public with sharing class ContactTriggerHandler {

    public static void handleBeforeInsert(List<Contact> newContacts, Map<id,Contact> newMap) {

        //validatePrimaryContact(newContacts, null, newMap);
    }

    public static void handleAfterInsert(List<Contact> newContacts) {
        updateActiveContactOnAccount(newContacts, null);

    }

    public static void handleBeforeUpdate(List<Contact> newContacts, Map<Id,Contact> oldMap, Map<Id,Contact> newMap) {

      //  validatePrimaryContact(newContacts, oldMap, newMap);

    }

    public static void handleAfterUpdate(List<Contact> newContacts, Map<Id,Contact> oldMap) {
        
        updateActiveContactOnAccount(newContacts, oldMap);

    }

    private static void validatePrimaryContact(List<Contact> newContacts, Map<Id,Contact> oldMap, Map<Id,Contact> newMap) {
        Map<Id,Id> accountIdToContactIdMap = new Map<Id,Id>();

        for(Contact con: newContacts) {
            if(con.Primary__c) accountIdToContactIdMap.put(con.AccountId, con.Id);
        }

        if(!accountIdToContactIdMap.isEmpty()) {

            for(Contact con: [SELECT id,AccountId from Contact where AccountId in: accountIdToContactIdMap.keySet() and id not in: newContacts and Primary__c=true with security_enforced]) {
                if(accountIdToContactIdMap.containsKey(con.AccountId)) {
                    System.debug('### DEBUG ### | '+ accountIdToContactIdMap.get(con.AccountId));
                    newMap.get(accountIdToContactIdMap.get(con.AccountId)).addError('Account already has Primary Contact');
                }
            }

        }   
    }

    private static void updateActiveContactOnAccount(List<Contact> newContacts, Map<Id,Contact> oldMap) {

        Set<Account> accounts = new Set<Account>();
        for(Contact con : newContacts) {
            if((oldMap.get(con.Id).Active__c != con.Active__c) ||
                oldMap == null) {
                Account curAccount = new Account(Id = con.AccountId, NumOfActiveContacts__c = 0);
                curAccount.NumOfActiveContacts__c = con.Active__c ? curAccount.NumOfActiveContacts__c+1:curAccount.NumOfActiveContacts__c-1; 
                accounts.add(curAccount);
            } 
        }

        if(!accounts.isEmpty()) update new List<Account>(accounts);

    }

  
}