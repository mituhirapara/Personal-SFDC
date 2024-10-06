public class OpportunityLineItemTriggerHandler {

    public static boolean byPassTrigger = false;

    public static void afterInsert(Map<Id, OpportunityLineItem> newMap) {
        updateOppContractStartAndEndDate(newMap);
    }

    public static void afterUpdate(Map<Id, OpportunityLineItem> oldMap, Map<Id, OpportunityLineItem> newMap) {
        updateOppContractStartAndEndDate(newMap);
    }

    public static void afterDelete(Map<Id, OpportunityLineItem> oldMap) {
        updateOppContractStartAndEndDate(oldMap);
    }

    private static void updateOppContractStartAndEndDate(Map<Id, OpportunityLineItem> newMap) {
        // get other oli
        Set<Id> opportunityIds = new Set<Id>();

        for(OpportunityLineItem oli : newMap.values()) {
            opportunityIds.add(oli.OpportunityId);
        }

        List<Opportunity> OpportunitiesToUpdate = [SELECT Id,ContractStartDate__c,ContractEndDate__c, (Select id,ContractStartDate__c, ContractEndDate__c from OpportunityLineItems) from Opportunity WHERE Id in:opportunityIds WITH SECURITY_ENFORCED];

        for(Opportunity opp : OpportunitiesToUpdate) {
            Date minStartDate = null;
            Date maxStartDate = null;
            for(OpportunityLineItem oli : opp.OpportunityLineItems) {
                if(minStartDate== null || oli.ContractStartDate__c < minStartDate) {
                    minStartDate = oli.ContractStartDate__c;
                }
                if(maxStartDate== null || oli.ContractEndDate__c > maxStartDate) {
                    maxStartDate = oli.ContractEndDate__c;
                }
            }

            opp.ContractStartDate__c = minStartDate;
            opp.ContractEndDate__c = maxStartDate;
        }

        update OpportunitiesToUpdate;



    }


}