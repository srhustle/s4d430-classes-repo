@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Z01_C_Employee'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel:{
    usageType:{
        serviceQuality: #D, // Because the view does not support transacctional proccesing.
        sizeCategory: #M, // Because we are expecting less than 100k data sets
        dataClass: #MASTER // Because employee data are master data
    }
}
define view entity Z01_C_Employee
  as select from Z01_R_Employee
{
  key EmployeeId,
      FirstName,
      LastName,
      BirthDate,
      EntryDate,
      DepartmentId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      AnnualSalay,
      CurrencyCode,
      CreatedBy,
      CreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt
}
