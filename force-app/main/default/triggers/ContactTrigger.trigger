trigger ContactTrigger on Contact (before insert, before update, after insert, after update) {


    if(Trigger.isBefore) {


        // if(trigger.isInsert) {
        //     ContactTriggerHandler.handleBeforeInsert(Trigger.new, Trigger.newMap);
        // }else if(trigger.isUpdate) {
        //     ContactTriggerHandler.handleBeforeUpdate(Trigger.new, Trigger.oldMap, Trigger.newMap);
        // }

    }else if(Trigger.isAfter) {

        if(trigger.isInsert) {
            ContactTriggerHandler.handleAfterInsert(Trigger.new);
        }else if(trigger.isUpdate) {
            ContactTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
        }

    }

}