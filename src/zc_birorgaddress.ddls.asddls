@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #PRIVILEGED_ONLY
@EndUserText.label: 'BIR Organization Address'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zc_birorgaddress
  as select from I_OrganizationAddress
  left outer join I_CountryText on I_CountryText.Country = I_OrganizationAddress.Country
{
  key I_OrganizationAddress.AddressID,
  key I_OrganizationAddress.AddressPersonID,
  key I_OrganizationAddress.AddressRepresentationCode,
      concat_with_space(I_OrganizationAddress.StreetName,
          concat_with_space(I_OrganizationAddress.StreetPrefixName1,
              concat_with_space( I_OrganizationAddress.PostalCode,
                  concat_with_space(
                      I_OrganizationAddress.CityName,
                      I_CountryText.CountryName,
                      1
                  ),
                  1
               ), 1), 1 ) as completeaddress,
               I_OrganizationAddress.AddressSearchTerm1,
               I_OrganizationAddress.PostalCode,
               I_OrganizationAddress.Country
               
}
