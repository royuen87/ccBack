@VDM.viewType: #CONSUMPTION
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Withholding Tax Item'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.supportedCapabilities:
   [ #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE ]
@Analytics: { dataCategory: #CUBE }
@ObjectModel.usageType:{
    serviceQuality: #C,
    sizeCategory: #XL,
    dataClass: #TRANSACTIONAL
}

define view entity zc_withholdingtaxitem
  as select from I_Withholdingtaxitem
{
  key CompanyCode,
  key AccountingDocument,
  key FiscalYear,
  key AccountingDocumentItem,
  key WithholdingTaxType,
      /* Associations */
      _WithholdingTaxCode.OfficialWhldgTaxCode
}
