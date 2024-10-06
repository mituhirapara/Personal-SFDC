trigger OpportunityLineItemTrigger on OpportunityLineItem (after insert, after update, after delete) {
    
    OpportunityLineItemTriggerHandler.byPassTrigger = false;
    
    if(Trigger.isUpdate) {
        OpportunityLineItemTriggerHandler.afterUpdate(Trigger.oldMap, Trigger.newMap);
    } else if(Trigger.isInsert) {
        OpportunityLineItemTriggerHandler.afterInsert(Trigger.newMap);
    }else if(Trigger.isDelete) {
        OpportunityLineItemTriggerHandler.afterDelete(Trigger.oldMap);
    }

}