#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(profilesSaveData);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_profilesSaveData

Description:
Save profile system persistence state via sys_data

Parameters:

Returns:
Boolean

Examples:
(begin example)
// save profile data
_result = call ALIVE_fnc_profilesSaveData;
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
[true, "ALiVE Profile System persistence save data started", "psper"] call ALIVE_fnc_timer;


["ALIVE_SYS_PROFILE","ALIVE_MIL_OPCOM","ALIVE_AMB_CIV_POPULATION","ALIVE_MIL_LOGISTICS","ALIVE_SYS_AISKILL"] call ALiVE_fnc_pauseModule;


[ALIVE_profileHandler,"saveProfileData"] call ALIVE_fnc_profileHandler;


["ALIVE_SYS_PROFILE","ALIVE_MIL_OPCOM","ALIVE_AMB_CIV_POPULATION","ALIVE_MIL_LOGISTICS","ALIVE_SYS_AISKILL"] call ALiVE_fnc_unPauseModule;


[false, "ALiVE Profile System persistence save data complete","psper"] call ALIVE_fnc_timer;
[["ALiVE_LOADINGSCREEN"],"BIS_fnc_endLoadingScreen",true,false] call BIS_fnc_MP;

_result