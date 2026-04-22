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
      _Department.Description as DepartmentDescription,
      _Department._Assistant.FirstName as AssistantName,
      
      /* Associations */
      _Department
}
