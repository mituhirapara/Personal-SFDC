public with sharing class SCDR_ShellReduction {
    public void reducePrimaryShell(List<Id> childTermOppIds, List<Id> primaryShellOpportunityIds) {
        List<SalesAgreementProductSchedule> childSalesAgreementProductSch = getSchedulesByOppId(childTermOppIds);
        List<SalesAgreementProductSchedule> primaryShellOppSch = getSchedulesByOppId(primaryShellOpportunityIds);

        if (childSalesAgreementProductSch.isEmpty() || primaryShellOppSch.isEmpty()) {
            return;
        }

        List<SalesAgreementProductSchedule> schedulesReducedByMatchingProduct = reduceByMatchingProduct(childSalesAgreementProductSch, primaryShellOppSch);
        List<SalesAgreementProductSchedule> schedulesReducedByMatchingTechSleeve = reduceByMatchingTechSleeve(childSalesAgreementProductSch, schedulesReducedByMatchingProduct);
        List<SalesAgreementProductSchedule> schedulesReducedByContractAdmin = reduceByMatchingTechSleeve(childSalesAgreementProductSch, schedulesReducedByMatchingTechSleeve);
        List<SalesAgreementProductSchedule> schedulesReducedEqually = reduceByMatchingTechSleeve(childSalesAgreementProductSch, schedulesReducedByContractAdmin);
    }

    private List<SalesAgreementProductSchedule> getSchedulesByOppId(List<Id> oppIds) {
        return [
            SELECT id, ForecastedAmount, SalesAgreementProduct.ProductId
            FROM SalesAgreementProductSchedule
            WHERE SalesAgreementProduct.SalesAgreement.SCDR_Opportunity__c IN :oppIds
            WITH security_enforced
        ];
    }

    private List<SalesAgreementProductSchedule> reduceByMatchingProduct(List<SalesAgreementProductSchedule> childTermSch, List<SalesAgreementProductSchedule> primaryShellSch) {
        List<SalesAgreementProductSchedule> reducedSchedules = new List<SalesAgreementProductSchedule>();
        Map<Id, List<SalesAgreementProductSchedule>> primaryShellProductToSchedule = new Map<Id, List<SalesAgreementProductSchedule>>();

        for (SalesAgreementProductSchedule primarySch : primaryShellSch) {
            if (!primaryShellProductToSchedule.containsKey(primarySch.SalesAgreementProduct.ProductId)) {
                primaryShellProductToSchedule.put(primarySch.SalesAgreementProduct.ProductId, new List<SalesAgreementProductSchedule>());
            }
            primaryShellProductToSchedule.get(primarySch.SalesAgreementProduct.ProductId).add(primarySch);
        }

        for (SalesAgreementProductSchedule childSch : childTermSch) {
            if (primaryShellProductToSchedule.containsKey(childSch.SalesAgreementProduct.ProductId)) {
            }
        }
    }
}
