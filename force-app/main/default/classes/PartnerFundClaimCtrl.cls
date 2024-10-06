public with sharing class PartnerFundClaimCtrl {

    @AuraEnabled
    public static List<PartnerFundClaim> getClaims(String partnerId) {

        List<PartnerFundClaim> claimList = new List<PartnerFundClaim>();

        try {
            
            claimList = [SELECT id,Request.Title, Request.RequestedAmount,Amount
                        FROM PartnerFundClaim
                        WHERE ChannelPartnerId =: partnerId];
        } catch (Exception ex) {
            System.debug('Exception when fetching Claims records: '+ ex);
        }

        return claimList;

    }

}