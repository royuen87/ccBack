@VDM.viewType: #CONSUMPTION
@Analytics.query:true

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Operational document tax items'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType.sizeCategory: #XL
@ObjectModel.usageType.serviceQuality: #D
@ObjectModel.usageType.dataClass: #MIXED
define view entity zc_taxwtopdoc
  as select from I_OperationalAcctgDocItem
{
      @AnalyticsDetails.query.axis: #ROWS
      @Consumption.filter : { selectionType : #SINGLE, multipleSelections : false}
  key CompanyCode,
      @Consumption.filter : { selectionType : #SINGLE, multipleSelections : true}
      @AnalyticsDetails.query.axis: #ROWS
  key AccountingDocument,
      @AnalyticsDetails.query.axis: #ROWS
  key FiscalYear,
  key AccountingDocumentItem,
      @AnalyticsDetails.query.axis: #COLUMNS
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      TaxAmountInCoCodeCrcy,
      CompanyCodeCurrency,
      @AnalyticsDetails.query.axis: #ROWS
      WithholdingTaxCode,
      @AnalyticsDetails.query.axis: #ROWS
      TaxCountry

}
