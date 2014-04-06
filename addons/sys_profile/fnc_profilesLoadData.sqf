#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(profilesLoadData);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_profilesLoadData

Description:
Load profile system persistence state via sys_data

Parameters:

Returns:

Examples:
(begin example)
// save profile data
_result = call ALIVE_fnc_profilesLoadData;
(end)

See Also:
ALIVE_fnc_profilesLoadData

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_result"];

if !(isServer) exitwith {};

_result = false;

[["ALiVE_LOADINGSCREEN"],"BIS_fnc_startLoadingScreen",true,false] call BIS_fnc_MP;
[true, "ALiVE Profile System persistence load data started", "psper"] call ALIVE_fnc_timer;


["ALIVE_SYS_PROFILE","ALIVE_MIL_OPCOM","ALIVE_AMB_CIV_POPULATION","ALIVE_MIL_LOGISTICS","ALIVE_SYS_AISKILL"] call ALiVE_fnc_pauseModule;


[ALIVE_profileHandler,"reset"] call ALIVE_fnc_profileHandler;

_profiles = [ALIVE_profileHandler,"loadProfileData"] call ALIVE_fnc_profileHandler;

//_profiles call ALIVE_fnc_inspectHash;

[ALIVE_profileHandler,"importProfileData",_profiles] call ALIVE_fnc_profileHandler;


["ALIVE_SYS_PROFILE","ALIVE_MIL_OPCOM","ALIVE_AMB_CIV_POPULATION","ALIVE_MIL_LOGISTICS","ALIVE_SYS_AISKILL"] call ALiVE_fnc_unPauseModule;


[false, "ALiVE Profile System persistence load data complete","psper"] call ALIVE_fnc_timer;
[["ALiVE_LOADINGSCREEN"],"BIS_fnc_endLoadingScreen",true,false] call BIS_fnc_MP;

_result