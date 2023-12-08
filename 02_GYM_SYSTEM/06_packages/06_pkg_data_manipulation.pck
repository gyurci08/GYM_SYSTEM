CREATE OR REPLACE PACKAGE pkg_szemely IS
  PROCEDURE insert_szemely(
                           var_vezeteknev VARCHAR2,
                           var_keresztnev VARCHAR2,
                           var_szuletesi_hely VARCHAR2,
                           var_szuletesi_ido DATE,
                           new_id OUT NUMBER
                            );

 FUNCTION is_present(
                           var_vezeteknev VARCHAR2,
                           var_keresztnev VARCHAR2,
                           var_szuletesi_hely VARCHAR2,
                           var_szuletesi_ido DATE
                            )
                           RETURN
                           BOOLEAN;

END pkg_szemely;
/
create or replace package body  is

  -- Private type declarations
  type <TypeName> is <Datatype>;
  
  -- Private constant declarations
  <ConstantName> constant <Datatype> := <Value>;

  -- Private variable declarations
  <VariableName> <Datatype>;

  -- Function and procedure implementations
  function <FunctionName>(<Parameter> <Datatype>) return <Datatype> is
    <LocalVariable> <Datatype>;
  begin
    <Statement>;
    return(<Result>);
  end;

begin
  -- Initialization
  <Statement>;
end ;
/
