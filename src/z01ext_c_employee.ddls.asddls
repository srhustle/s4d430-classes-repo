extend view entity Z01_C_EmployeeQueryP with 
association to I_Country as _ZZCountryZen
on $projection.ZZCountryZen = _ZZCountryZen.Country{
    Employee.ZZCountryZen,
    Employee.ZZTitleZern, 
    concat_with_space(Employee.FirstName, Employee.LastName, 1) as ZZFullNameZen,
    _ZZCountryZen.IsEuropeanUnionMember as ZZIsEuropean
}
