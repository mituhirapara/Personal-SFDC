public with sharing class EmailHandler {

    
    @InvocableMethod
    public static void sendEmailWithAttachment(List<EmailContent> emailContents){

        String claimId = emailContents.get(0).claimId;
        List<String> toAddresses = emailContents.get(0).toAddresses;

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();


        // Strings to hold the email addresses to which you are sending the email.
        //String[] toAddresses = new String[] {'mitu.hirapara@lntinfotech.com'}; 
    
        // Assign the addresses for the To and CC lists to the mail object.
        mail.setToAddresses(toAddresses);
        //mail.setCcAddresses(ccAddresses);        
        // Specify the subject line for your email address.
        mail.setSubject(emailContents.get(0).subject);


        // Specify the text content of the email.
        //mail.setPlainTextBody('Your Case has been created.');

        mail.setHtmlBody(emailContents.get(0).body);

        // attachDocumentIfAny will append any files linked to the claim with this Email
        mail = attachDocumentIfAny(mail, claimId);
        //mail = getAttachment(mail, claimId);
        // Send the email you have created.
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    }



    private static Messaging.SingleEmailMessage attachDocumentIfAny(Messaging.SingleEmailMessage mail, string claimId){


                //id claimId= '0015g00000pqcuUAAQ';
                List<ContentDocumentLink> fileLinks = new List<ContentDocumentLink>();
                List<id> contentDocumentIds = new List<id>();
                List<ContentVersion> files = new List<ContentVersion>();
                try {
                    
                    // Queries all the related files
                    fileLinks = [SELECT Id, LinkedEntityId, ContentDocumentId,Visibility, IsDeleted, ShareType,ContentDocument.Title,ContentDocument.createdDate, ContentDocument.FileType
                    FROM ContentDocumentLink
                    WHERE LinkedEntityId=:claimId];
                    
                    // storing file Ids
                    for(ContentDocumentLink link : fileLinks) {
                        contentDocumentIds.add(link.ContentDocumentId);
                    }
        
                    // Files linked to object
                    files = [SELECT id, VersionData, ContentDocument.Title, ContentDocument.FileType
                            FROM ContentVersion
                            WHERE contentDocumentId in: contentDocumentIds];
                     
                } catch (Exception e) {
                    System.debug('Exception when fetching related files'+ e);
                }
        
                // using custom setting to store file type to mime type
                Map<String, String> fileToContentTypeMap = FileExtension.contentTypeMap;
        
        
                List<Messaging.EmailFileAttachment> attachments = new List<Messaging.EmailFileAttachment>();
                if(files.size() >0) {
                    for(ContentVersion file : files){
                        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                        efa.setFileName(file.ContentDocument.Title+'.'+file.ContentDocument.FileType);
                        efa.setBody(file.VersionData);
                        String contentType = fileToContentTypeMap.get(file.ContentDocument.FileType);
                        efa.setContentType(contentType != null ? contentType : 'application/pdf');
                        attachments.add(efa);
                    }
                }
        
                
                if(attachments.size() >0) {
                    mail.setFileAttachments( attachments);
                }
        
        return mail;

    }


    public class EmailContent{
        @InvocableVariable
        public id claimId;
        
        @InvocableVariable
        public String subject;

        @InvocableVariable
        public String body;

        @InvocableVariable
        public List<String> toAddresses;
 
    } 





}