@EndUserText.label: 'GL Group'
@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
define view entity ZI_GlGroup
  as select from ZDT_GLGROUP
  association to parent ZI_GlGroup_S as _GlGroupAll on $projection.SingletonID = _GlGroupAll.SingletonID
{
  key ZGROUP as Zgroup,
  key ZSAKNR as Zsaknr,
  @Consumption.hidden: true
  1 as SingletonID,
  _GlGroupAll
}
