#include <\x\alive\addons\sys_logistics\script_component.hpp>
SCRIPT(canTow);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_canTow
Description:

Checks if the given object can be towed by the given object

Parameters:
_this select 0: object to be towed
_this select 1: object that should tow the object above

Returns:
BOOL - yes/no

See Also:
- <ALIVE_fnc_canCarry>

Author:
Highhead

Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_object","_container","_containerCanTow","_objectCanTow","_canTow","_blacklist"];

_object = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_container = [_this, 1, objNull, [objNull]] call BIS_fnc_param;
_allowedContainers = GVAR(TOWABLE) select 0;
_allowedObjects = GVAR(TOWABLE) select 1;
_blacklist = GVAR(TOWABLE) select 2;

_canTow = false;

if (isnil "_container" || {_object == _container} || {{_object isKindOf _x} count _blackList > 0} || {(getNumber (configFile >> "cfgVehicles" >> typeof _container >> "transportSoldier")) < 3} || {count attachedObjects _container > 0}) exitwith {_canTow};

// Consider removing! How to handle profiles?
if (!isnil {_container getVariable "profileID"}) exitwith {_canTow};
if (!isnil {_object getVariable "profileID"}) exitwith {_canTow};

{if (_container isKindOf _x) exitwith {_containerCanTow = true}} foreach _allowedContainers;
{if (_object isKindOf _x) exitwith {_objectCanTow = true}} foreach _allowedObjects;

if (!(isnil "_containerCanTow") && {!(isnil "_objectCanTow")}) then {_canTow = true};

if (_canTow) then {
    // Available weight must be free to tow the object
	if (([_object] call ALiVE_fnc_getObjectWeight) > (([_container] call ALiVE_fnc_availableWeight))) exitwith {_canTow = false};
};

_canTow;
