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

private ["_mode","_adminUID","_savePlayer","_saveServer","_exitPlayer","_exitServer"];

_mode = _this select 0;
_adminUID = if(count _this > 1) then {_this select 1} else {""};

TRACE_1("PLAYER CLICKING ON ABORT BUTTON",_this);

["--------------------------------------------------------------"] call ALIVE_fnc_dump;
["ALiVE Abort - mode: %1",_mode] call ALIVE_fnc_dump;

// FUNCTION THAT SAVES PLAYER DATA
_savePlayer = {
	private ["_name","_uid","_id"];
	_id = _this select 0;
	_name = name (_this select 0);
	_uid = getPlayerUID (_this select 0);

	["ALiVE Abort - Save Player Data id: %1 name: %2 uid: %3",_id,_name,_uid] call ALIVE_fnc_dump;

	if !(isNil QMOD(sys_player)) then {
	    ["ALiVE Abort - Player Data OPD"] call ALIVE_fnc_dump;
	    // Update Gear
	     if (MOD(sys_player) getvariable "saveLoadout") then {
                private ["_gearHash","_unit"];
                // Get player gear
                _gearHash = [MOD(sys_player), "setGear", [player]] call ALIVE_fnc_player;
				["ALiVE Abort - Storing Player Gear"] call ALIVE_fnc_dump;
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

	["ALiVE Abort - Exit Player id: %1 name: %2 uid: %3",_id,_name,_uid] call ALIVE_fnc_dump;

	if !(isNil QMOD(sys_statistics)) then {
	    ["ALiVE Abort - Player Stats OPD"] call ALIVE_fnc_dump;
		// Stats module onPlayerDisconnected call
		[[_id, _name, _uid],"ALIVE_fnc_stats_onPlayerDisconnected", false, false] call BIS_fnc_MP;
		//["server",QMOD(sys_statistics),[[_id, _name, _uid],{call ALIVE_fnc_stats_onPlayerDisconnected}]] call ALIVE_fnc_BUS;
	};

	if (["ALiVE_sys_profile"] call ALiVE_fnc_isModuleAvailable) then {
	    ["ALiVE Abort - Player Profile Handler OPD"] call ALIVE_fnc_dump;
        // Profiles module onPlayerDisconnected call
        [[_id, _name, _uid],"ALIVE_fnc_profile_onPlayerDisconnected", false, false] call BIS_fnc_MP;
        //["server","ALIVE_profileHandler",[[_id, _name, _uid],{call ALIVE_fnc_profile_onPlayerDisconnected}]] call ALIVE_fnc_BUS;
    };
};

// FUNCTION THAT HANDLES SERVER EXIT
_exitServer = {
	private ["_uid","_id","_result"];
	_id = "";
	_uid = "";

    ["--------------------------------------------------------------"] call ALIVE_fnc_dump;
	["ALiVE Abort - Exiting Server"] call ALIVE_fnc_dump;

	 if !(isNil QMOD(sys_statistics)) then {
	    ["ALiVE Abort - Server Stats OPD"] call ALIVE_fnc_dump;
		// Stats module onPlayerDisconnected call
		[_id,"__SERVER__", _uid] call ALIVE_fnc_stats_onPlayerDisconnected;
	};
	if !(isNil QMOD(sys_perf)) then {
	    ["ALiVE Abort - Server Perf OPD"] call ALIVE_fnc_dump;
	    //["ABORT: S SYS_PERF OPD"] call ALIVE_fnc_dump;
		[_id, "__SERVER__", _uid] call ALIVE_fnc_perf_onPlayerDisconnected;
	};
	if !(isNil QMOD(sys_data)) then {
	    ["ALiVE Abort - Server Data OPD"] call ALIVE_fnc_dump;
		// Data module onPlayerDisconnected call
		_result = [_id, "__SERVER__", _uid] call ALIVE_fnc_data_onPlayerDisconnected;
	};

	["ALiVE Abort - Server Exited"] call ALIVE_fnc_dump;
	["--------------------------------------------------------------"] call ALIVE_fnc_dump;

};

// FUNCTION THAT HANDLES SERVER SAVE
_saveServer = {
	private ["_uid","_id","_admin"];
	_id = "";
	_uid = "";

	["--------------------------------------------------------------"] call ALIVE_fnc_dump;
    ["ALiVE Abort - Saving Server"] call ALIVE_fnc_dump;

    ["ADMIN UID: %1",_adminUID] call ALIVE_fnc_dump;
    _admin = [_adminUID] call ALIVE_fnc_getPlayerByUID;
    ["ADMIN: %1",_admin] call ALIVE_fnc_dump;

    if!(isNil "_admin") then {
        [["open"],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
    };

    sleep 2;

    if!(isNil "_admin") then {
        [["setTitle","ALiVE Persistence - Saving Data"],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
        [["updateList","ALiVE Persistence - Saving Data - Please Wait"],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
    };

    //[["ALiVE_LOADINGSCREEN"],"BIS_fnc_startLoadingScreen",true,false] call BIS_fnc_MP;
    ["ALIVE_SYS_PROFILE","ALIVE_MIL_OPCOM","ALIVE_AMB_CIV_POPULATION","ALIVE_MIL_LOGISTICS","ALIVE_SYS_AISKILL"] call ALiVE_fnc_pauseModule;

	if !(isNil QMOD(sys_player)) then {
	    ["ALiVE Abort - Server Player OPD"] call ALIVE_fnc_dump;
		[_id, "__SERVER__", _uid] call ALIVE_fnc_player_onPlayerDisconnected;
	};

	if (["ALiVE_sys_profile"] call ALiVE_fnc_isModuleAvailable) then {

	    private ["_result","_messages"];

        if!(isNil "_admin") then {
	        [["updateList","ALiVE Profile System - Saving Data"],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
        };

	    ["ALiVE Abort - Server Save Profiles"] call ALIVE_fnc_dump;

		_result = [] call ALiVE_fnc_profilesSaveData;

        if(!(isNil "_admin") && !(isNil "_result")) then {
            _messages = _result select 1;
            if(count _messages > 0) then {
                reverse _messages;
                {
                    [["updateList",_x],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
                } forEach _messages;
            };
        };
	};

	if (["ALiVE_mil_OPCOM"] call ALiVE_fnc_isModuleAvailable) then {

	    private ["_results","_result","_messages"];

        if!(isNil "_admin") then {
	        [["updateList","ALiVE OPCOM - Saving Data"],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
        };

	    ["ALiVE Abort - Server Save OPCOM State"] call ALIVE_fnc_dump;

		_results = [] call ALiVE_fnc_OPCOMSaveData;

		if(!(isNil "_admin") && !(isNil "_results")) then {
            {
                _result = _x;

                _messages = _result select 1;
                if(count _messages > 0) then {
                    reverse _messages;
                    {
                        [["updateList",_x],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
                    } forEach _messages;
                };

            } forEach _results;
        };

	};

	if (["ALiVE_mil_cqb"] call ALiVE_fnc_isModuleAvailable) then {

	    private ["_results","_result","_messages"];

        if!(isNil "_admin") then {
            [["updateList","ALiVE CQB - Saving Data"],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
        };

	    ["ALiVE Abort - Server Save OPCOM State"] call ALIVE_fnc_dump;

		_result = [] call ALiVE_fnc_CQBSaveData;

        if(!(isNil "_admin") && !(isNil "_result")) then {
            _messages = _result select 1;
            if(count _messages > 0) then {
                reverse _messages;
                {
                    [["updateList",_x],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
                } forEach _messages;
            };
        };

	};

    if (["ALiVE_sys_logistics"] call ALiVE_fnc_isModuleAvailable) then {

        private ["_results","_result","_messages"];

        if!(isNil "_admin") then {
            [["updateList","ALiVE Player Logistics - Saving Data"],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
        };

	    ["ALiVE Abort - Server Save Logistics State"] call ALIVE_fnc_dump;

		_result = [] call ALiVE_fnc_logisticsSaveData;

        if(!(isNil "_admin") && !(isNil "_result")) then {
            _messages = _result select 1;
            if(count _messages > 0) then {
                reverse _messages;
                {
                    [["updateList",_x],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
                } forEach _messages;
            };
        };

	};

	if (["ALiVE_sys_marker"] call ALiVE_fnc_isModuleAvailable) then {

	    private ["_results","_result","_messages"];

        if!(isNil "_admin") then {
	        [["updateList","ALiVE Markers - Saving Data"],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
        };

	    ["ALiVE Abort - Server Save Markers State"] call ALIVE_fnc_dump;

		_result = [] call ALiVE_fnc_markerSaveData;

        if(!(isNil "_admin") && !(isNil "_result")) then {
            _messages = _result select 1;
            if(count _messages > 0) then {
                reverse _messages;
                {
                    [["updateList",_x],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
                } forEach _messages;
            };
        };
	};

	if (["ALiVE_sys_spotrep"] call ALiVE_fnc_isModuleAvailable) then {

	    private ["_results","_result","_messages"];

        if!(isNil "_admin") then {
	        [["updateList","ALiVE SPOTREP - Saving Data"],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
        };

	    ["ALiVE Abort - Server Save SPOTREP State"] call ALIVE_fnc_dump;

		_result = [] call ALiVE_fnc_spotrepSaveData;

        if(!(isNil "_admin") && !(isNil "_result")) then {
            _messages = _result select 1;
            if(count _messages > 0) then {
                reverse _messages;
                {
                    [["updateList",_x],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
                } forEach _messages;
            };
        };
	};

	if (["ALiVE_sys_sitrep"] call ALiVE_fnc_isModuleAvailable) then {

	    private ["_results","_result","_messages"];

        if!(isNil "_admin") then {
	        [["updateList","ALiVE SITREP - Saving Data"],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
        };

	    ["ALiVE Abort - Server Save SITREP State"] call ALIVE_fnc_dump;

		_result = [] call ALiVE_fnc_sitrepSaveData;

        if(!(isNil "_admin") && !(isNil "_result")) then {
            _messages = _result select 1;
            if(count _messages > 0) then {
                reverse _messages;
                {
                    [["updateList",_x],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
                } forEach _messages;
            };
        };
	};

	if (["ALiVE_sys_patrolrep"] call ALiVE_fnc_isModuleAvailable) then {

	    private ["_results","_result","_messages"];

        if!(isNil "_admin") then {
	        [["updateList","ALiVE PATROLREP - Saving Data"],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
        };

	    ["ALiVE Abort - Server Save PATROLREP State"] call ALIVE_fnc_dump;

		_result = [] call ALiVE_fnc_patrolrepSaveData;

        if(!(isNil "_admin") && !(isNil "_result")) then {
            _messages = _result select 1;
            if(count _messages > 0) then {
                reverse _messages;
                {
                    [["updateList",_x],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
                } forEach _messages;
            };
        };
	};

	if (["ALiVE_mil_logistics"] call ALiVE_fnc_isModuleAvailable) then {

	    private ["_results","_result","_messages"];

        if!(isNil "_admin") then {
	        [["updateList","ALiVE Military Logistics - Saving Data"],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
        };

        ["ALiVE Abort - Server Save ML State"] call ALIVE_fnc_dump;

        _result = [] call ALiVE_fnc_MLSaveData;

        if(!(isNil "_admin") && !(isNil "_result")) then {
            _messages = _result select 1;
            if(count _messages > 0) then {
                reverse _messages;
                {
                    [["updateList",_x],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
                } forEach _messages;
            };
        };
    };

    if (["ALiVE_mil_C2ISTAR"] call ALiVE_fnc_isModuleAvailable) then {

        private ["_results","_result","_messages"];

        if!(isNil "_admin") then {
            [["updateList","ALiVE C2ISTAR - Saving Data"],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
        };

        ["ALiVE Abort - Server Save Task State"] call ALIVE_fnc_dump;

        _result = [] call ALiVE_fnc_taskHandlerSaveData;

        if(!(isNil "_admin") && !(isNil "_result")) then {
            _messages = _result select 1;
            if(count _messages > 0) then {
                reverse _messages;
                {
                    [["updateList",_x],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
                } forEach _messages;
            };
        };
    };

    ["ALIVE_SYS_PROFILE","ALIVE_MIL_OPCOM","ALIVE_AMB_CIV_POPULATION","ALIVE_MIL_LOGISTICS","ALIVE_SYS_AISKILL"] call ALiVE_fnc_unPauseModule;
    //[["ALiVE_LOADINGSCREEN"],"BIS_fnc_endLoadingScreen",true,false] call BIS_fnc_MP;

    ["ALiVE Abort - Server Saved"] call ALIVE_fnc_dump;
    ["--------------------------------------------------------------"] call ALIVE_fnc_dump;

    if!(isNull _admin) then {
        [["close"],"ALIVE_fnc_mainTablet",_admin,false,false] spawn BIS_fnc_MP;
    };

    ["serversaved","BIS_fnc_endMission",_admin,false,false] spawn BIS_fnc_MP;
};

// Function run on server
if (_mode == "SAVESERVERYO" && isDedicated) exitWith {
    // Save server data
    [_saveServer,_exitServer,_adminUID] spawn {
    	private ["_saveServer","_exitServer"];
    	_saveServer = _this select 0;
    	_exitServer = _this select 1;
    	_adminUID = _this select 2;
    	WaitUntil {MOD(player_count) == 1};
		[_adminUID] call _saveServer;
		[_adminUID] call _exitServer;
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

	    ["ALiVE Abort - Abort / Save by Admin"] call ALIVE_fnc_dump;

	    ["ALiVE Abort - Broadcasting abort call to all players"] call ALIVE_fnc_dump;

		// Save all players
		[["REMSAVE"],"ALiVE_fnc_buttonAbort",true,false] call BIS_fnc_MP;

		["ALiVE Abort - Trigger Server abort call"] call ALIVE_fnc_dump;

		// Save server data
		//[] call _saveServer;
        [["SAVESERVERYO",getPlayerUID player],"ALiVE_fnc_buttonAbort",false,false] call BIS_fnc_MP;
		//["server",QMOD(main),[["SAVESERVERYO"],{call ALiVE_fnc_buttonAbort}]] call ALIVE_fnc_BUS;

	};
	if (_mode == "SERVERABORT") then {

	    ["ALiVE Abort - Abort by Admin"] call ALIVE_fnc_dump;

		["ALiVE Abort - Broadcasting abort call to all players"] call ALIVE_fnc_dump;

		// abort all players
		[["ABORT"],"ALiVE_fnc_buttonAbort",true,false] call BIS_fnc_MP;

		["ALiVE Abort - Trigger Server abort call"] call ALIVE_fnc_dump;

		// exit server
        [["SERVERABORTYO"],"ALiVE_fnc_buttonAbort",false,false] call BIS_fnc_MP;
		//["server",QMOD(main),[["SERVERABORTYO"],{call ALiVE_fnc_buttonAbort}]] call ALIVE_fnc_BUS;
	};
};

switch (_mode) do {
	case "SAVE": {
	    ["ALiVE Abort - [%1] Ending mission",_mode] call ALIVE_fnc_dump;
	    "saved" call BIS_fnc_endMission;
    };
	case "ABORT": {
	    ["ALiVE Abort - [%1] Ending mission",_mode] call ALIVE_fnc_dump;
	    "abort" call BIS_fnc_endMission;
    };
	case "REMSAVE" : {
	    if !(call ALiVE_fnc_isServerAdmin) then {
	        ["ALiVE Abort - [%1] !(Admin) Ending mission",_mode] call ALIVE_fnc_dump;
			"saved" call BIS_fnc_endMission;
		};
	};
	case "SERVERSAVE": {
		if (call ALiVE_fnc_isServerAdmin) then {
		    ["ALiVE Abort - [%1] (Admin) Ending mission",_mode] call ALIVE_fnc_dump;
			//"serversaved" call BIS_fnc_endMission;
		};
	};
	case "SERVERABORT": {
		if (call ALiVE_fnc_isServerAdmin) then {
		    ["ALiVE Abort - [%1] (Admin) Ending mission",_mode] call ALIVE_fnc_dump;
			"serverabort" call BIS_fnc_endMission;
		};
	};
	default {
	    ["ALiVE Abort - [%1] Unknown mode in switch Ending mission",_mode] call ALIVE_fnc_dump;
	    "abort" call BIS_fnc_endMission;
    };
};
