public class restCallout {
    
    public static void doPost() {
        
        wrapper w = new wrapper();
        w.ageV = 'true';
        w.iqosC = 'gold';
        w.iqosS = 'true';
        
        String body = JSON.serialize(w);
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:myCred');
        req.setMethod('POST');
        req.setHeader('Content-Type','application/json');
        req.setBody(body);
        
        HttpResponse res = http.send(req);
        if(res.getStatusCode()==200){
            system.debug('LTI success');
        }
        
        
    }
    
    public class wrapper {
        public String ageV;
        public String iqosS;
        public String iqosC;
    }

}