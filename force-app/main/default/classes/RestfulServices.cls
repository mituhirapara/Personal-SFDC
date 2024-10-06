@RestResource(urlMapping='/v1/Acc/*')
global class RestfulServices {
	
     @httpPost
    global static Account doPostMethod(AccountClass accountwrapper){
        System.debug('Before Insert');
        Account newAcc = accountwrapper.Acct;
        insert newAcc;
        System.debug('After insert '+ accountwrapper.Acct);
        return newAcc;
    }
    
    @httpPut
    global static Account doPutMethod(AccountClass accountwrapper) {
        Map<String,String> paramsMap = RestContext.request.params;
    	String accid=paramsMap.get('id');
        
        Account newAcc = new Account(id=accid,Name= accountwrapper.Acct.Name, Phone=accountwrapper.Acct.Phone);
        update newAcc;
        
        return newAcc;
    }
    
    @httpDelete
    global static String doDeleteMethod(){  
        Map<String,String> paramsMap = RestContext.request.params;
    	String accid=paramsMap.get('id');
        String res = '';
        try{
            Account a = [SELECT id, name FROM Account WHERE id=: accid];
            res = a.name + ' is Deleted successfully !!';
            delete a;
            return res;
        }catch(Exception e){
            return 'Oops! we hit a snag. Either no such Account exist or you do not have sufficient access to perform this Action.';
        }
        
    }
    
    global class AccountClass{
        Account Acct { get; set; }
    }
    
    
}