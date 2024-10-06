public inherited sharing class SOQL_Period extends SOQL implements SOQL.Selector {
    private SOQL_Period() {
        super(Period.SobjectType);
        with(Period.Id, Period.StartDate, Period.EndDate).systemMode().withoutSharing();
    }

    public static SOQL_Period query() {
        return new SOQL_Period();
    }
}
