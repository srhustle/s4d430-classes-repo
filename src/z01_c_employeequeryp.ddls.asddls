@AbapCatalog:{
    dataMaintenance: #RESTRICTED,// Restrict view data preview
    viewEnhancementCategory: [#PROJECTION_LIST],
    extensibility.dataSources: [ 'Employee' ],
    extensibility.elementSuffix: 'ZEN'
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Z01_C_EmployeeQuery'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity Z01_C_EmployeeQueryP
with parameters p_target_curr : /dmo/currency_code,
                
                @Environment.systemField: #SYSTEM_DATE
                p_date : abap.dats
  as select from Z01_R_Employee as Employee
{
  key EmployeeId,
      FirstName,
      LastName,
      DepartmentId,
      
      case EmployeeId
        when _Department.DepartmentHead then 'H'
        when _Department.DepartmentAssistant then 'A'
      else ''
        end as EmployeeRole,
      cast($parameters.p_target_curr as /dmo/currency_code) as CurrencyCode,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      currency_conversion(
        amount => AnnualSalay,
        source_currency => CurrencyCode,
        target_currency => $projection.CurrencyCode,
        exchange_rate_date => $parameters.p_date
      ) as AnnualSalaryConverted, 
      
      cast(AnnualSalay as abap.fltp) / cast(12 as abap.fltp) as MonthlySalary,
      _Department.Description as DepartmentDescription,
      concat_with_space(_Department._Assistant.FirstName, _Department._Assistant.LastName, 1) as AssistantName,
      //_Department._Assistant.FirstName as AssistantName,
      division(dats_days_between(_Department._Assistant.EntryDate, $parameters.p_date), 365, 1) as CompanyAffiliation,
      /* Associations */
      _Department
}
