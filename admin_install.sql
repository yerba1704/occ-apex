clear screen

define apex_user_name = apexdata
define apex_workspace_name = apexdata
define apex_application_id = 777
define apex_application_alias = occ_gui

  /************************************/
 /** INSTALL ora*CODECOP (OCC-APEX) **/
/************************************/

whenever sqlerror exit failure rollback
whenever oserror exit failure rollback

set serveroutput on
set feedback on
set echo off
set heading off
set verify off

grant create synonym to &apex_user_name;

--------------------------------------------------------------------------------
prompt >>> grant permission

grant all on occ.analyzer_rules to &apex_user_name;
grant all on occ.database_objects to &apex_user_name;
grant all on occ.severity_levels to &apex_user_name;
grant all on occ.sqale_characteristics to &apex_user_name;

grant execute on occ.worker to &apex_user_name;
grant execute on occ.string_c to &apex_user_name;
grant execute on occ.rule_result_c to &apex_user_name;

--------------------------------------------------------------------------------
prompt >>> create synonyms

create or replace synonym &apex_user_name..analyzer_rules for occ.analyzer_rules;
create or replace synonym &apex_user_name..database_objects for occ.database_objects;
create or replace synonym &apex_user_name..severity_levels for occ.severity_levels;
create or replace synonym &apex_user_name..sqale_characteristics for occ.sqale_characteristics;

--------------------------------------------------------------------------------
prompt >>> install application

declare
  l_workspace_id apex_workspaces.workspace_id%type;
begin
  apex_application_install.clear_all;

  select workspace_id
    into l_workspace_id
    from apex_workspaces
   where workspace = upper('&apex_workspace_name');

  apex_application_install.set_workspace_id(l_workspace_id);
  apex_application_install.set_application_id(&apex_application_id);
  apex_application_install.set_application_alias('&apex_application_alias');
  apex_application_install.generate_offset;
end;
/
@app/occ_gui.sql

--------------------------------------------------------------------------------
prompt >>> done <<<