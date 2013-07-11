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

private ["_result","_profile","_data","_msg"];

TRACE_1("CREATING PLAYER PROFILE", _this);

_data = _this select 0;
_profile = "";

if ((count _data) > 0) then {
		
	// Create a Player diary record
	player createDiarySubject ["statsPage","ALiVE"];
	
	{
		_profile = _profile + (_x select 0) + " : " + (_x select 1) + "<br />";
	} foreach _data;
	
	player createDiaryRecord ["statsPage", ["Profile", _profile]]; 
	
	_msg = format["Welcome %1!", name player];
	
	[_msg, "Profile download from ALiVE website completed. Your profile now available in player diary under the entry ALiVE > Profile."] call ALIVE_fnc_sendHint;

	_result = true;

} else {
	TRACE_1("NOT CREATING PLAYER PROFILE - NO DATA", _data);
	_result = false;
};


_result;
		

