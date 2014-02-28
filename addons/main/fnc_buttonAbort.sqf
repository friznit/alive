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

["PLAYER CLICKED ABORT - MODE: %1",_mode] call ALIVE_fnc_dump;

_savePlayer = {
	private ["_name","_uid","_id"];
	_id = _this select 0;
	_name = name (_this select 0);
	_uid = getPlayerUID (_this select 0);

	["ABORT: SAVING PLAYER - ID: %1 NAME: %2 UID: %3",_id,_name,_uid] call ALIVE_fnc_dump;

	if !(isNil QMOD(sys_statistics)) then {
	    ["ABORT: P SYS_STATS OPD"] call ALIVE_fnc_dump;
		// Stats module onPlayerDisconnected call
		//[[_id, _name, _uid],"ALIVE_fnc_stats_onPlayerDisconnected", false, false] call BIS_fnc_MP;
		["server",QMOD(sys_statistics),[[_id, _name, _uid],{call ALIVE_fnc_stats_onPlayerDisconnected}]] call ALIVE_fnc_BUS;
	};

	if !(isNil QMOD(sys_player)) then {
	    ["ABORT: P SYS_PLAYER OPD"] call ALIVE_fnc_dump;
		// sys_player module onPlayerDisconnected call
		//[[_id, _name, _uid],"ALIVE_fnc_player_onPlayerDisconnected", false, false] call BIS_fnc_MP;
		["server",QMOD(sys_player),[[_id, _name, _uid],{call ALIVE_fnc_player_onPlayerDisconnected}]] call ALIVE_fnc_BUS;
	};

	if !(isNil 'ALIVE_profileHandler') then {
	    ["ABORT: P SYS_PROFILE OPD"] call ALIVE_fnc_dump;
        // Profiles module onPlayerDisconnected call
        //[[_id, _name, _uid],"ALIVE_fnc_profile_onPlayerDisconnected", false, false] call BIS_fnc_MP;
        ["server","ALIVE_profileHandler",[[_id, _name, _uid],{call ALIVE_fnc_profile_onPlayerDisconnected}]] call ALIVE_fnc_BUS;
    };
};

_saveServer = {
	private ["_uid","_id"];
	_id = "";
	_uid = "";

	["ABORT: SAVING SERVER"] call ALIVE_fnc_dump;

    if !(isNil QMOD(sys_statistics)) then {
	    ["ABORT: S SYS_STATS OPD"] call ALIVE_fnc_dump;
		// Stats module onPlayerDisconnected call
		//[[_id, "__SERVER__", _uid],"ALIVE_fnc_stats_onPlayerDisconnected", false, false] call BIS_fnc_MP;
		//["server",QMOD(sys_statistics),[[_id,"__SERVER__", _uid],{call ALIVE_fnc_stats_onPlayerDisconnected}]] call ALIVE_fnc_BUS;
		[_id,"__SERVER__", _uid] call ALIVE_fnc_stats_onPlayerDisconnected;
	};
	if !(isNil QMOD(sys_perf)) then {
	    ["ABORT: S SYS_PERF OPD"] call ALIVE_fnc_dump;
		//[[_id, "__SERVER__", _uid],"ALIVE_fnc_perf_onPlayerDisconnected", false, false] call BIS_fnc_MP;
		//["server",QMOD(sys_perf),[[_id, "__SERVER__", _uid],{call ALIVE_fnc_perf_onPlayerDisconnected}]] call ALIVE_fnc_BUS;
		[_id, "__SERVER__", _uid] call ALIVE_fnc_perf_onPlayerDisconnected;
	};

	["!!!ABOUT TO OPD DATA BITCHES!!! IS THERE DATA: %1",!(isNil QMOD(sys_data))] call ALIVE_fnc_dump;

	if !(isNil QMOD(sys_data)) then {
	    ["ABORT: S SYS_DATA OPD"] call ALIVE_fnc_dump;
		// Data module onPlayerDisconnected call
		//[[_id, "__SERVER__", _uid],"ALIVE_fnc_data_onPlayerDisconnected", false, false] call BIS_fnc_MP;
		//["server",QMOD(sys_data),[[_id, "__SERVER__", _uid],{call ALIVE_fnc_data_onPlayerDisconnected}]] call ALIVE_fnc_BUS;
		[_id, "__SERVER__", _uid] call ALIVE_fnc_data_onPlayerDisconnected;
	};
};

if (_mode == "SAVESERVERYO") then {
    ["ABORT: SAVE SERVER DATA"] call ALIVE_fnc_dump;
    // Save player data
	[] call _saveServer;
};

if (_mode == "SAVE" || _mode == "REMSAVE") then {
    ["ABORT: SAVE PLAYER DATA"] call ALIVE_fnc_dump;
    // Save player data
	[player] call _savePlayer;
};

if (call ALiVE_fnc_isServerAdmin) then {

    ["ABORT: SERVER ADMIN DETECTED"] call ALIVE_fnc_dump;

	if (_mode == "SERVERSAVE") then {

	    ["ABORT: BROADCAST SAVE TO ALL PLAYERS"] call ALIVE_fnc_dump;

		// Save all players
		[["REMSAVE"],"ALiVE_fnc_buttonAbort",true,false] call BIS_fnc_MP;

        ["ABORT: SAVE SERVER DATA"] call ALIVE_fnc_dump;

		// Save server data
		//[] call _saveServer;
		["server",QMOD(main),[["SAVESERVERYO"],{call ALiVE_fnc_buttonAbort}]] call ALIVE_fnc_BUS;
		["server",QMOD(main),[[],{endMission "serversaved"}]] call ALIVE_fnc_BUS;

	};
	if (_mode == "SERVERABORT") then {

	    ["ABORT: SERVER ABORT"] call ALIVE_fnc_dump;

		["server",QMOD(main),[[],{endMission "serverabort"}]] call ALIVE_fnc_BUS;

		// abort all players
		[["ABORT"],"ALiVE_fnc_buttonAbort",true,false] call BIS_fnc_MP;
	};
};

["ABORT: SHUTTING DOWN - MODE: %1",_mode] call ALIVE_fnc_dump;

switch (_mode) do {
	case "SAVE": {
	    ["ABORT: SWITCH SAVE MODE END MISH"] call ALIVE_fnc_dump;
	    "saved" call BIS_fnc_endMission;
    };
	case "ABORT": {
	    ["ABORT: SWITCH ABORT MODE END MISH"] call ALIVE_fnc_dump;
	    "abort" call BIS_fnc_endMission;
    };
	case "REMSAVE" : {
	    if !(call ALiVE_fnc_isServerAdmin) then {
	        ["ABORT: SWITCH REMSAVE MODE IS NOT ADMIN END MISH"] call ALIVE_fnc_dump;
			"saved" call BIS_fnc_endMission;
		};
	};
	case "SERVERSAVE": {
		if (call ALiVE_fnc_isServerAdmin) then {
		    ["ABORT: SWITCH SERVERSAVE MODE IS ADMIN END MISH"] call ALIVE_fnc_dump;
			"serversaved" call BIS_fnc_endMission;
		};
	};
	case "SERVERABORT": {
		if (call ALiVE_fnc_isServerAdmin) then {
		    ["ABORT: SWITCH SERVERABORT MODE IS ADMIN END MISH"] call ALIVE_fnc_dump;
			"serverabort" call BIS_fnc_endMission;
		};
	};
	default {
	    ["ABORT: SWITCH SERVERABORT DEFAULT ADMIN END MISH"] call ALIVE_fnc_dump;
	    "abort" call BIS_fnc_endMission;
    };
};
