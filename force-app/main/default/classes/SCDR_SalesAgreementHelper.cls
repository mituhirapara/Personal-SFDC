public with sharing class SCDR_SalesAgreementHelper {
    public static Boolean stopTrigger = false;

    private List<Period> PeriodList = new List<Period>();

    public SCDR_SalesAgreementHelper() {
        this.PeriodList = SOQL.of(Period.SObjectType)
            .with(Period.StartDate, Period.EndDate, Period.Id, Period.Type)
            .whereAre(SOQL.Filter.with(Period.Type).equal('Month'))
            .orderBy('Period.StartDate')
            .toList();
    }

    public void beforeInsert(List<SalesAgreementProductSchedule> newSAPS, Map<Id, SalesAgreementProductSchedule> newSAPSMap) {
        /**
         * update periodid field by performing lookup on period object based on SAPS's start date and end date
         */

        for (SalesAgreementProductSchedule saps : newSAPS) {
            // saps.StartDate
        }
    }

    public void afterInsert(List<SalesAgreementProductSchedule> newSAPS, Map<Id, SalesAgreementProductSchedule> newSAPSMap) {
    }

    public void beforeUpdate(
        List<SalesAgreementProductSchedule> newSAPS,
        Map<Id, SalesAgreementProductSchedule> newSAPSMap,
        List<SalesAgreementProductSchedule> oldSAPS,
        Map<Id, SalesAgreementProductSchedule> oldSAPSMap
    ) {
    }

    public void afterUpdate(
        List<SalesAgreementProductSchedule> newSAPS,
        Map<Id, SalesAgreementProductSchedule> newSAPSMap,
        List<SalesAgreementProductSchedule> oldSAPS,
        Map<Id, SalesAgreementProductSchedule> oldSAPSMap
    ) {
    }

    /**
     * Schema.SObjectType periodSObjectType = Period.SObjectType;
System.debug('Sobject label '+ periodSObjectType);

List<Period> fiscalMonth = SOQL.of(Period.SObjectType)
                            .with(Period.StartDate, Period.EndDate, Period.Id, Period.Type)
                            .whereAre(SOQL.FilterGroup
                                        .add(SOQL.Filter.with(Period.Type).equal('Month'))
                                        .add(SOQL.Filter.with(Period.StartDate).greaterOrEqual())
                                    )
                            .orderBy('Period.StartDate')
                            .toList();

for(Period p : fiscalMonth) {
    System.debug('P : '+ p.StartDate+' - '+ p.EndDate);
}
     */
}
