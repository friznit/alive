/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_buttonAbort
Handles clicking on the alive menu for disconnecting players

ADD MODULE CODE HERE FOR MODULES THAT NEED TO ACT ON DISCONNECT

Parameters:
Array - control data
String - mode - SAVE - save and disconnect - ABORT - just disconnect, REMSAVE - save all players remotely but dont kick admin
Returns:
Nothing

Attributes:
None

Parameters:
_this select 0: ARRAY - control data
_this select 1: STRING - mode

Examples:
(begin example)

(end)

See Also:


Author:
Tupolov
---------------------------------------------------------------------------- */
// MAIN
#define DEBUG_MODE_FULL

#include "script_component.hpp"

private ["_mode","_savePlayer","_saveServer"];

_mode = _this select 0;

TRACE_1("PLAYER CLICKING ON ABORT BUTTON",_this);

_savePlayer = {
	private ["_name","_uid","_id"];
	_id = _this select 0;
	_name = name (_this select 0);
	_uid = getPlayerUID (_this select 0);

	diag_log format["ABORT: SAVING PLAYER - %1",_name];

	if !(isNil QMOD(sys_statistics)) then {
		// Stats module onPlayerDisconnected call
		//[[_id, _name, _uid],"ALIVE_fnc_stats_onPlayerDisconnected", false, false] call BIS_fnc_MP;
		["server",QMOD(sys_statistics),[[_id, _name, _uid],{call ALIVE_fnc_stats_onPlayerDisconnected}]] call ALIVE_fnc_BUS;
	};

	if !(isNil QMOD(sys_player)) then {
		// sys_player module onPlayerDisconnected call
		//[[_id, _name, _uid],"ALIVE_fnc_player_onPlayerDisconnected", false, false] call BIS_fnc_MP;
		["server",QMOD(sys_player),[[_id, _name, _uid],{call ALIVE_fnc_player_onPlayerDisconnected}]] call ALIVE_fnc_BUS;
	};

	if !(isNil 'ALIVE_profileHandler') then {
        // Profiles module onPlayerDisconnected call
        //[[_id, _name, _uid],"ALIVE_fnc_profile_onPlayerDisconnected", false, false] call BIS_fnc_MP;
        ["server","ALIVE_profileHandler",[[_id, _name, _uid],{call ALIVE_fnc_profile_onPlayerDisconnected}]] call ALIVE_fnc_BUS;
    };
};

_saveServer = {
	private ["_uid","_id"];
	_id = "";
	_uid = "";

	diag_log["ABORT: SAVING SERVER DATA"];

	if !(isNil QMOD(sys_statistics)) then {
		// Stats module onPlayerDisconnected call
		//[[_id, "__SERVER__", _uid],"ALIVE_fnc_stats_onPlayerDisconnected", false, false] call BIS_fnc_MP;
		["server",QMOD(sys_statistics),[[_id,"__SERVER__", _uid],{call ALIVE_fnc_stats_onPlayerDisconnected}]] call ALIVE_fnc_BUS;
	};
	if !(isNil QMOD(sys_perf)) then {
		//[[_id, "__SERVER__", _uid],"ALIVE_fnc_perf_onPlayerDisconnected", false, false] call BIS_fnc_MP;
		["server",QMOD(sys_perf),[[_id, "__SERVER__", _uid],{call ALIVE_fnc_perf_onPlayerDisconnected}]] call ALIVE_fnc_BUS;
	};

	if !(isNil QMOD(sys_data)) then {
		// Data module onPlayerDisconnected call
		//[[_id, "__SERVER__", _uid],"ALIVE_fnc_data_onPlayerDisconnected", false, false] call BIS_fnc_MP;
		["server",QMOD(sys_data),[[_id, "__SERVER__", _uid],{call ALIVE_fnc_data_onPlayerDisconnected}]] call ALIVE_fnc_BUS;
	};
};

if (_mode == "SAVE" || _mode == "REMSAVE") then {
// Save player data
	[player] call _savePlayer;
};

if (call ALiVE_fnc_isServerAdmin) then {
	if (_mode == "SERVERSAVE") then {
		// Save all players
		[["REMSAVE"],"ALiVE_fnc_buttonAbort",true,false] call BIS_fnc_MP;

		// Save server data
		[] call _saveServer;
		["server",QMOD(main),[[],{endMission "serversaved"}]] call ALIVE_fnc_BUS;

	};
	if (_mode == "SERVERABORT") then {
		["server",QMOD(main),[[],{endMission "serverabort"}]] call ALIVE_fnc_BUS;

		// abort all players
		[["ABORT"],"ALiVE_fnc_buttonAbort",true,false] call BIS_fnc_MP;
	};
};

	diag_log format["ABORT: SHUTTING DOWN %1",_mode];

switch (_mode) do {
	case "SAVE": {"saved" call BIS_fnc_endMission;};
	case "ABORT": {"abort" call BIS_fnc_endMission;};
	case "REMSAVE" : {
		if !(call ALiVE_fnc_isServerAdmin) then {
			"saved" call BIS_fnc_endMission;
		};
	};
	case "SERVERSAVE": {"serversaved" call BIS_fnc_endMission;};
	case "SERVERABORT": {"serverabort" call BIS_fnc_endMission;};
	default {"abort" call BIS_fnc_endMission;};
};
