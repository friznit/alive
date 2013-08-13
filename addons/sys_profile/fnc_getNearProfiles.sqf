#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(getNearProfiles);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_getNearProfiles

Description:
Returns an array of profiles within the passed radius

Parameters:
Array - position center of search
Scalar - radius of search

Returns:
Boolean

Examples:
(begin example)
// get profiles within the radius
_result = [getPos player, 1000] call ALIVE_fnc_getNearProfiles;
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_position","_radius","_categorySelector","_result","_profiles","_profilePositions","_profilePosition","_profile"];
	
_position = _this select 0;
_radius = _this select 1;
_categorySelector = if(count _this > 2) then {_this select 2} else {[]};

_result = [];

if(count _categorySelector > 0) then {
	_profiles = [ALIVE_profileHandler, "getProfilesByCategory", _categorySelector] call ALIVE_fnc_profileHandler;
}else{
	_profiles = [ALIVE_profileHandler, "getProfilesByType", "entity"] call ALIVE_fnc_profileHandler;
};

_profilePositions = [ALIVE_profileHandler, "profilePositions"] call ALIVE_fnc_hashGet;

{
	_profilePosition = [_profilePositions, _x] call ALIVE_fnc_hashGet;
	if(_position distance _profilePosition < _radius) then {
		_profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
		_result set [count _result, _profile];
	};
} forEach _profiles;

_result