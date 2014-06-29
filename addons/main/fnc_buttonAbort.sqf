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

["--------------------------------------------------------------"] call ALIVE_fnc_dump;
["ALIVE Abort - mode: %1",_mode] call ALIVE_fnc_dump;

// FUNCTION THAT SAVES PLAYER DATA
_savePlayer = {
	private ["_name","_uid","_id"];
	_id = _this select 0;
	_name = name (_this select 0);
	_uid = getPlayerUID (_this select 0);

	["ALIVE Abort - Save Player Data id: %1 name: %2 uid: %3",_id,_name,_uid] call ALIVE_fnc_dump;

	if !(isNil QMOD(sys_player)) then {
	    ["ALIVE Abort - Player Data OPD"] call ALIVE_fnc_dump;
	    // Update Gear
	     if (MOD(sys_player) getvariable "saveLoadout") then {
                private ["_gearHash","_unit"];
                // Get player gear
                _gearHash = [MOD(sys_player), "setGear", [player]] call ALIVE_fnc_player;
				["ALIVE Abort - Storing Player Gear"] call ALIVE_fnc_dump;
                [[MOD(sys_player), "updateGear", [player, _gearHash]], "ALiVE_fnc_player", false, false] call BIS_fnc_MP;
        };
		// sys_player module onPlayerDisconnected call
		[[_id, _name, _uid],"ALIVE_fnc_player_onPlayerDisconnected", false, false] call BIS_fnc_MP;
	};

};

// FUNCTION THAT HANDLES PLAYERS EXITING
_exitPlayer = {
		private ["_name","_uid","_id"];
	_id = _this select 0;
	_name = name (_this select 0);
	_uid = getPlayerUID (_this select 0);

	["ALIVE Abort - Exit Player id: %1 name: %2 uid: %3",_id,_name,_uid] call ALIVE_fnc_dump;

	if !(isNil QMOD(sys_statistics)) then {
	    ["ALIVE Abort - Player Stats OPD"] call ALIVE_fnc_dump;
		// Stats module onPlayerDisconnected call
		[[_id, _name, _uid],"ALIVE_fnc_stats_onPlayerDisconnected", false, false] call BIS_fnc_MP;
		//["server",QMOD(sys_statistics),[[_id, _name, _uid],{call ALIVE_fnc_stats_onPlayerDisconnected}]] call ALIVE_fnc_BUS;
	};

	if (["ALiVE_sys_profile"] call ALiVE_fnc_isModuleAvailable) then {
	    ["ALIVE Abort - Player Profile Handler OPD"] call ALIVE_fnc_dump;
        // Profiles module onPlayerDisconnected call
        [[_id, _name, _uid],"ALIVE_fnc_profile_onPlayerDisconnected", false, false] call BIS_fnc_MP;
        //["server","ALIVE_profileHandler",[[_id, _name, _uid],{call ALIVE_fnc_profile_onPlayerDisconnected}]] call ALIVE_fnc_BUS;
    };
};

// FUNCTION THAT HANDLES SERVER EXIT
_exitServer = {
	private ["_uid","_id"];
	_id = "";
	_uid = "";

	["ALIVE Abort - Exit Server Data"] call ALIVE_fnc_dump;

	 if !(isNil QMOD(sys_statistics)) then {
	    ["ALIVE Abort - Server Stats OPD"] call ALIVE_fnc_dump;
		// Stats module onPlayerDisconnected call
		[_id,"__SERVER__", _uid] call ALIVE_fnc_stats_onPlayerDisconnected;
	};
	if !(isNil QMOD(sys_perf)) then {
	    ["ALIVE Abort - Server Perf OPD"] call ALIVE_fnc_dump;
	    //["ABORT: S SYS_PERF OPD"] call ALIVE_fnc_dump;
		[_id, "__SERVER__", _uid] call ALIVE_fnc_perf_onPlayerDisconnected;
	};
	if !(isNil QMOD(sys_data)) then {
	    ["ALIVE Abort - Server Data OPD"] call ALIVE_fnc_dump;
		// Data module onPlayerDisconnected call
		[_id, "__SERVER__", _uid] call ALIVE_fnc_data_onPlayerDisconnected;
	};
};

// FUNCTION THAT HANDLES SERVER SAVE
_saveServer = {
	private ["_uid","_id"];
	_id = "";
	_uid = "";

	["ALIVE Abort - Save Server Data"] call ALIVE_fnc_dump;

	if !(isNil QMOD(sys_player)) then {
	    ["ALIVE Abort - Server Player OPD"] call ALIVE_fnc_dump;
		[_id, "__SERVER__", _uid] call ALIVE_fnc_player_onPlayerDisconnected;
	};

	if (["ALiVE_sys_profile"] call ALiVE_fnc_isModuleAvailable) then {
	    ["ALIVE Abort - Server Save Profiles"] call ALIVE_fnc_dump;
		call ALiVE_fnc_profilesSaveData;
	};

	if (["ALiVE_mil_OPCOM"] call ALiVE_fnc_isModuleAvailable) then {
	    ["ALIVE Abort - Server Save OPCOM State"] call ALIVE_fnc_dump;
		call ALiVE_fnc_OPCOMSaveData;
	};

	if (["ALiVE_mil_cqb"] call ALiVE_fnc_isModuleAvailable) then {
	    ["ALIVE Abort - Server Save OPCOM State"] call ALIVE_fnc_dump;
		call ALiVE_fnc_CQBSaveData;
	};
    
    if (["ALiVE_sys_logistics"] call ALiVE_fnc_isModuleAvailable) then {
	    ["ALIVE Abort - Server Save Logistics State"] call ALIVE_fnc_dump;
		call ALiVE_fnc_logisticsSaveData;
	};
};

// Function run on server
if (_mode == "SAVESERVERYO" && isDedicated) exitWith {
    // Save server data
    [_saveServer,_exitServer] spawn {
    	private ["_saveServer","_exitServer"];
    	_saveServer = _this select 0;
    	_exitServer = _this select 1;
    	WaitUntil {MOD(player_count) == 0};
		[] call _saveServer;
		[] call _exitServer;
		"serversaved" call BIS_fnc_endMission;
	};
};

// Function run on server
if (_mode == "SERVERABORTYO" && isDedicated) exitwith {

	// Exit server without saving
    [_exitServer] spawn {
    	private ["_exitServer"];
    	_exitServer = _this select 0;
    	WaitUntil {MOD(player_count) == 0};
		[] call _exitServer;
		"serverabort" call BIS_fnc_endMission;
	};

};

// Function run on client
if ((_mode == "SAVE" || _mode == "REMSAVE") && !isDedicated) then {
    // Save player data
	[player] call _savePlayer;
	[player] call _exitPlayer;
};

// Function run on client
if (_mode == "ABORT" && !isDedicated) then {
	// Exit player without saving
	[player] call _exitPlayer;
};

// Check client for admin
if (call ALiVE_fnc_isServerAdmin) then {

	if (_mode == "SERVERSAVE") then {

	    ["ALIVE Abort - Abort / Save by Admin"] call ALIVE_fnc_dump;

	    ["ALIVE Abort - Broadcasting abort call to all players"] call ALIVE_fnc_dump;

		// Save all players
		[["REMSAVE"],"ALiVE_fnc_buttonAbort",true,false] call BIS_fnc_MP;

		["ALIVE Abort - Trigger Server abort call"] call ALIVE_fnc_dump;

		// Save server data
		//[] call _saveServer;
        [["SAVESERVERYO"],"ALiVE_fnc_buttonAbort",false,false] call BIS_fnc_MP;
		//["server",QMOD(main),[["SAVESERVERYO"],{call ALiVE_fnc_buttonAbort}]] call ALIVE_fnc_BUS;

	};
	if (_mode == "SERVERABORT") then {

	    ["ALIVE Abort - Abort by Admin"] call ALIVE_fnc_dump;

		["ALIVE Abort - Broadcasting abort call to all players"] call ALIVE_fnc_dump;

		// abort all players
		[["ABORT"],"ALiVE_fnc_buttonAbort",true,false] call BIS_fnc_MP;

		["ALIVE Abort - Trigger Server abort call"] call ALIVE_fnc_dump;

		// exit server
        [["SERVERABORTYO"],"ALiVE_fnc_buttonAbort",false,false] call BIS_fnc_MP;
		//["server",QMOD(main),[["SERVERABORTYO"],{call ALiVE_fnc_buttonAbort}]] call ALIVE_fnc_BUS;
	};
};

switch (_mode) do {
	case "SAVE": {
	    ["ALIVE Abort - [%1] Ending mission",_mode] call ALIVE_fnc_dump;
	    "saved" call BIS_fnc_endMission;
    };
	case "ABORT": {
	    ["ALIVE Abort - [%1] Ending mission",_mode] call ALIVE_fnc_dump;
	    "abort" call BIS_fnc_endMission;
    };
	case "REMSAVE" : {
	    if !(call ALiVE_fnc_isServerAdmin) then {
	        ["ALIVE Abort - [%1] !(Admin) Ending mission",_mode] call ALIVE_fnc_dump;
			"saved" call BIS_fnc_endMission;
		};
	};
	case "SERVERSAVE": {
		if (call ALiVE_fnc_isServerAdmin) then {
		    ["ALIVE Abort - [%1] (Admin) Ending mission",_mode] call ALIVE_fnc_dump;
			"serversaved" call BIS_fnc_endMission;
		};
	};
	case "SERVERABORT": {
		if (call ALiVE_fnc_isServerAdmin) then {
		    ["ALIVE Abort - [%1] (Admin) Ending mission",_mode] call ALIVE_fnc_dump;
			"serverabort" call BIS_fnc_endMission;
		};
	};
	default {
	    ["ALIVE Abort - [%1] Unknown mode in switch Ending mission",_mode] call ALIVE_fnc_dump;
	    "abort" call BIS_fnc_endMission;
    };
};
