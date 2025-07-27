clear screen

define apex_user_name = apexdata
define apex_application_id = 777

  /**************************************/
 /** UNINSTALL ora*CODECOP (OCC-APEX) **/
/**************************************/

whenever sqlerror exit failure rollback
whenever oserror exit failure rollback

set serveroutput on
set feedback on
set echo off
set heading off
set verify off

--------------------------------------------------------------------------------
prompt >>> revoke permission

revoke all on occ.analyzer_rules from &apex_user_name;
revoke all on occ.database_objects from &apex_user_name;
revoke all on occ.severity_levels from &apex_user_name;
revoke all on occ.sqale_characteristics from &apex_user_name;

revoke execute on occ.worker from &apex_user_name;
revoke execute on occ.string_c from &apex_user_name;
revoke execute on occ.rule_result_c from &apex_user_name;

--------------------------------------------------------------------------------
prompt >>> drop synonyms

drop synonym &apex_user_name..analyzer_rules;
drop synonym &apex_user_name..database_objects;
drop synonym &apex_user_name..severity_levels;
drop synonym &apex_user_name..sqale_characteristics;

--------------------------------------------------------------------------------
prompt >>> uninstall application

exec apex_instance_admin.remove_application( p_application_id => &apex_application_id );
commit;

--------------------------------------------------------------------------------
prompt >>> done <<<