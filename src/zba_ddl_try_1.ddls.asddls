@AbapCatalog.sqlViewName: 'ZBA_CDS_TRY_1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DDL Trying 1'
define view ZBA_V_TRY_1 as select from mara
{
  key matnr,
      meins,
      mtart,
      matkl
}
where meins = 'ST'
