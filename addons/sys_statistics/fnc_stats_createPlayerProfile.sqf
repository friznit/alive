/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_stats_createPlayerProfile

Description:
Adds a player diary record with their current website profile

Parameters:
Array - Array of key/value pairs

Returns:
Bool - success or failure

Examples:
(begin example)
	[ _data ] call ALIVE_fnc_stats_createPlayerProfile;
(end)

Author:
Tupolov
Peer Reviewed:

---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(stats_createPlayerProfile);

private ["_result","_profile","_data","_msg","_profile","_playerGroup"];

TRACE_1("CREATING PLAYER PROFILE", _this);

_data = _this select 0;
_profile = "";

if ([_data] call CBA_fnc_isHash) then {

	// Grab Player's serverGroup
	_playerGroup = [_data, "ServerGroup", "Unknown"] call ALIVE_fnc_hashGet;

	player setVariable [QGVAR(playerGroup), _playerGroup, true];

	// Create a Player diary record
	player createDiarySubject ["statsPage","ALiVE"];

	_prof = {
		_profile = _profile + _key + " : " + _value + "<br />";
	};

	[_data, _prof] call CBA_fnc_hashEachPair;

	player createDiaryRecord ["statsPage", ["Profile", _profile]];

	_msg = format["Welcome %1!", name player];

	[_msg, "Profile download from ALiVE website completed. Your ALiVE web profile is now available in player diary under the entry ALiVE > Profile."] call ALIVE_fnc_sendHint;

	_result = true;

} else {
	TRACE_1("NOT CREATING PLAYER PROFILE - NO VALID DATA", _data);
	_result = false;
};


_result;


