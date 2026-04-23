@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Z01_C_DepartmentQuery'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z01_C_DepartmentQuery
  with parameters
    p_target_curr : /dmo/currency_code,
    @EndUserText.label: 'Date of Evaluation'
    @Environment.systemField: #SYSTEM_DATE
    p_date        : abap.dats
  as select from Z01_C_EmployeeQueryP( 
    p_target_curr: $parameters.p_target_curr, 
    p_date:  $parameters.p_date
  ) as t0
  right outer join Z01_R_Department as t1
  on t1.Id = t0.DepartmentId
  
{
  t1.Id,
  t1.Description,
  t0.DepartmentId,
  t0.DepartmentDescription,
  avg(t0.CompanyAffiliation as abap.fltp) as AverageAffiliation,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  sum(t0.AnnualSalaryConverted)           as TotalSalary,
  t0.CurrencyCode
}
group by
  t1.Id,
  t1.Description,
  t0.DepartmentId,
  t0.DepartmentDescription,
  t0.CurrencyCode
