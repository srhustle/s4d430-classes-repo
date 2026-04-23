@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Z01_C_EmployeeQuery'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z01_C_EmployeeQuery
  as select from Z01_R_Employee
{
  key EmployeeId,
      FirstName,
      LastName,
      DepartmentId,
      @EndUserText.label: 'Employee Role'
      case EmployeeId
        when _Department.DepartmentHead then 'H'
        when _Department.DepartmentAssistant then 'A'
      else ''
        end as EmployeeRole,
      cast('USD' as abap.cuky) as CurrencyCodeUSD,
      @Semantics.amount.currencyCode: 'CurrencyCodeUSD'
      currency_conversion(
        amount => AnnualSalay,
        source_currency => CurrencyCode,
        target_currency => $projection.CurrencyCodeUSD,
        exchange_rate_date => $session.system_date
      ) as AnnualSalaryConverted, 
      @EndUserText.label: 'Monthly Salary'
      cast($projection.AnnualSalaryConverted as abap.fltp) / cast(12 as abap.fltp) as MonthlySalary,
      _Department.Description as DepartmentDescription,
      concat_with_space(_Department._Assistant.FirstName, _Department._Assistant.LastName, 1) as AssistantName,
      //_Department._Assistant.FirstName as AssistantName,
      division(dats_days_between(_Department._Assistant.EntryDate, $session.system_date), 365, 1) as CompanyAffiliation,
      /* Associations */
      _Department
}
