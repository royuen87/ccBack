@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #PRIVILEGED_ONLY
@Metadata.ignorePropagatedAnnotations: true
@EndUserText.label: 'VAT Summary List Custom Fields'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
} 
define view entity ZC_VAT_SLI_FIELDS 
    as select from I_JournalEntry as a
    inner join I_SupplierInvoiceAPI01 as b
    on a.OriginalReferenceDocument = concat(b.SupplierInvoice,b.FiscalYear)
{
    key a.CompanyCode,
    key a.FiscalYear,
    key a.AccountingDocument,
    a.OriginalReferenceDocument,
    b.YY1_AssessmentDate_MIH,
    b.YY1_CountryofOrigin_MIH,
    b.YY1_ImportationDate1_MIH,
    b.YY1_ORNumber_MIH
}
