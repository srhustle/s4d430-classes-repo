CLASS zcl_s4d430_rls_path_expr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_S4D430_RLS_PATH_EXPR IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT
*    FROM /LRN/C_Employee_Ann
      FROM Z01_C_EmployeeQueryP(
*        p_date = @sy-datum,
        p_target_curr = 'EUR'
      )
    FIELDS employeeid,
           firstname,
           lastname,
           departmentid,
           MonthlySalary,
           CurrencyCode,
           CompanyAffiliation,
           departmentdescription,
           assistantname,
           \_department\_head-lastname AS headname

    INTO TABLE @DATA(result).

    out->write( result ).

  ENDMETHOD.
ENDCLASS.
