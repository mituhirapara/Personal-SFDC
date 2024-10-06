public class TriggerUtility {
    
    static {
        setTriggerContext();
    }
    
    public static void run() {
        
    }
    
    private void run1() {
        
    }
    
    private static void setTriggerContext() {
        if(Trigger.isExecuting) {
            if(Trigger.isBefore && Trigger.isInsert) {
                
            } else if(Trigger.isBefore && Trigger.isUpdate) {
                
            } else if(Trigger.isAfter && Trigger.isInsert) {
                
            } else if(Trigger.isAfter && Trigger.isUpdate) {
                
            }
        }        
    }

}