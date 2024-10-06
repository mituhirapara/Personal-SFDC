public class dummyClass{
	
    public static void submit_for_approval(String leadId){
     
         Approval.ProcessSubmitRequest req1 = 
            new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(leadId);
        
        // Submit on behalf of a specific submitter
        req1.setSubmitterId(UserInfo.getUserId()); 
        
        // Submit the record to specific process and skip the criteria evaluation
        //req1.setProcessDefinitionNameOrId('PTO_Request_Process');
        req1.setSkipEntryCriteria(false);
        
        // submit the recordto specific user
        req1.setNextApproverIds(new Id[]{UserInfo.getUserId()});
        
        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req1);
    }
    
    
}