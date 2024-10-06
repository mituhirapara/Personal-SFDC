public inherited sharing class SOQL_Account extends SOQL implements SOQL.Selector {
    public SOQL_Account() {
        super(Account.getSObjectType());
        with(Account.Id, Account.Name).systemMode().withoutSharing();
    }

    public static SOQL_Account query() {
        return new SOQL_Account();
    }

    public SOQL_Account byRecordType(String rt) {
        whereAre(Filter.recordType().equal(rt));
        return this;
    }
}