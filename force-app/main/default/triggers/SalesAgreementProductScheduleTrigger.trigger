trigger SalesAgreementProductScheduleTrigger on SalesAgreementProductSchedule (before insert, after insert, before update, after update) {


    SCDR_SalesAgreementHelper helper = new SCDR_SalesAgreementHelper();

    if(Trigger.isInsert && Trigger.isBefore) {
        helper.beforeInsert(Trigger.new, Trigger.newMap);
    }else if(Trigger.isInsert && Trigger.isAfter) {
        helper.afterInsert(Trigger.new, Trigger.newMap);
    }else if(Trigger.isUpdate && Trigger.isBefore) {
        helper.beforeUpdate(trigger.new, trigger.newMap, trigger.old, trigger.oldMap);
    }else if(Trigger.isUpdate && Trigger.isAfter) {
        helper.afterUpdate(Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap);
    }

}
