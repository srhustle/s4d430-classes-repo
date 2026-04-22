@AbapCatalog:{
    dataMaintenance: #RESTRICTED,// Restrict view data preview
    viewEnhancementCategory: [#NONE]
}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel:{
    usageType:{
        serviceQuality: #D, // Because the view does not support transacctional proccesing.
        sizeCategory: #M, // Because we are expecting less than 100k data sets
        dataClass: #MASTER // Because employee data are master data
    }
}
@EndUserText.label: 'Z01_R_Employee view consume data from my employee data'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z01_R_Employee
  as select from z01employ
  association[1..1] to Z01_R_Department as _Department
  on $projection.DepartmentId = _Department.Id
{
  key employee_id           as EmployeeId,
      first_name            as FirstName,
      last_name             as LastName,
      birth_date            as BirthDate,
      entry_date            as EntryDate,
      department_id         as DepartmentId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      annual_salay as AnnualSalay,
      @EndUserText.label: 'Currency Key' // Change how user see the label of this property
      currency_code as CurrencyCode,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      local_last_changed_by as LocalLastChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      last_changed_at       as LastChangedAt,
      
      _Department
}
