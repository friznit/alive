#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(profileKilledEventHandler);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_profileKilledEventHandler

Description:
Killed event handler for profile units

Parameters:

Returns:

Examples:
(begin example)
_eventID = _agent addEventHandler["Killed", ALIVE_fnc_profileKilledEventHandler];
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */
private ["_unit","_unitProfileID","_profile","_profileType","_profileIndex"];
	
_unit = _this select 0;

_unitProfileID = _unit getVariable "profileID";
_profile = [ALIVE_profileHandler, "getProfile", _unitProfileID] call ALIVE_fnc_profileHandler;
_profileType = [_profile, "type"] call ALIVE_fnc_hashGet;

switch(_profileType) do {
		case "entity": {
			[_profile, "handleDeath"] call ALIVE_fnc_profileEntity;
		};
		case "mil": {
			[_profile, "handleDeath"] call ALIVE_fnc_profileMil;
		};
		case "civ": {
			[_profile, "handleDeath"] call ALIVE_fnc_profileCiv;
		};
		case "vehicle": {
			[_profile, "handleDeath"] call ALIVE_fnc_profileVehicle;
		};
};