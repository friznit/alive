#include <\x\alive\addons\sys_player\script_component.hpp>
SCRIPT(player);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_player
Description:
Creates the server side object to store settings

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes that can change:
Boolean - debug - Debug enabled
Boolean - allowReset - Enabled or disable reset function
Boolean - diffClass - Enabled or disable rejoin as different class function
Boolean - storeToDB - Enabled or disable auto save to external database
Boolean - allowManualSave - Enable or disable manual save
integer - autoSaveTime - Interval between database saves
string - key - a unique id to represent the mission on this specific server

The popup menu will change to show status as functions are enabled and disabled.

Examples:
(begin example)
// Create instance by placing editor module and specifiying name myModule
(end)

See Also:
- <ALIVE_fnc_playerInit>
- <ALIVE_fnc_playerMenuDef>

Author:
Tupolov

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_Player

#define DEFAULT_INTERVAL 300

#define DEFAULT_RESET true
#define DEFAULT_DIFFCLASS true
#define DEFAULT_MANUALSAVE false
#define DEFAULT_STORETODB true
#define DEFAULT_AUTOSAVETIME 600

private ["_result", "_operation", "_args", "_logic", "_ops"];

_logic = [_this, 0, objNull, [objNull,[]]] call BIS_fnc_param;
_operation = [_this, 1, "", [""]] call BIS_fnc_param;
_args = [_this, 2, objNull, [objNull,[],"",0,true,false]] call BIS_fnc_param;

TRACE_3("SYS_PLAYER",_logic, _operation, _args);

_result = true;

switch(_operation) do {
        case "init": {
                // Ensure only one module is used
                if (isServer && !(isNil QMOD(sys_player))) exitWith {
                        ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_player_ERROR1");
                };

                /*
                MODEL - no visual just reference data
                - module object stores parameters
                - Establish data handler on server
                - Establish data model on server and client
                */

                // DEFINE PLAYER DATA
                #include <playerData.hpp>

             if (isServer) then {

                        MOD(sys_player) = _logic;
                        publicVariable QMOD(sys_player);

                	// if server, initialise module game logic
            	   MOD(sys_player) setVariable ["super", QUOTE(SUPERCLASS)];
            	   MOD(sys_player) setVariable ["class", QUOTE(MAINCLASS)];

                      TRACE_1("SYS_PLAYER LOGIC", _logic);

            	// Grab Server ID and Mission ID
            	private ["_serverID"];

            	_serverID = [] call ALIVE_fnc_getServerName;
            	MOD(sys_player) setVariable ["serverID", _serverID];
            	MOD(sys_player) setVariable ["missionID", missionName];

            	// Set unique key for this mission - assuming that server name isn't going to change :(
            	if (MOD(sys_player) getVariable ["key",""] == "") then {
            	       MOD(sys_player) setVariable ["key", _serverID+missionName];
            	};

                	// Setup data handler
                	GVAR(datahandler) = [nil, "create"] call ALIVE_fnc_Data;
                	[GVAR(datahandler),"source","couchdb"] call ALIVE_fnc_Data; //maybe chosen by mission maker via module params
                	[GVAR(datahandler),"databaseName","arma3live"] call ALIVE_fnc_Data; // maybe chosen by mission maker via module params
                	[GVAR(datahandler),"storeType",true] call ALIVE_fnc_Data;

                      // Create Player Store
                      GVAR(player_data) = [] call CBA_fnc_hashCreate;

                      MOD(sys_player) setVariable ["init", true, true];

                        TRACE_3("SYS_PLAYER LOGIC", MOD(sys_player) getvariable "init", MOD(sys_player) getvariable "serverID", MOD(sys_player) getvariable "missionID");
                        TRACE_3("SYS_PLAYER DATA", MOD(sys_player), GVAR(player_data),GVAR(datahandler));



                } else {
                        // any client side logic

                };


                /*
                VIEW - purely visual
                - initialise menu
                - frequent check to modify menu and display status (ALIVE_fnc_playermenuDef)
                */

                TRACE_2("Adding menu",isDedicated,isHC);

                if(!isDedicated && !isHC) then {
                        // Initialise interaction key if undefined
                        if(isNil "SELF_INTERACTION_KEY") then {SELF_INTERACTION_KEY = [221,[false,false,false]];};

                        // if ACE spectator enabled, seto to allow exit
                        if(!isNil "ace_fnc_startSpectator") then {ace_sys_spectator_can_exit_spectator = true;};

                        TRACE_3("Menu pre-req",SELF_INTERACTION_KEY,ace_fnc_startSpectator,DEFAULT_MAPCLICK);

                        // initialise main menu
                        [
                                "player",
                                [SELF_INTERACTION_KEY],
                                -9500,
                                [
                                        "call ALIVE_fnc_playerMenuDef",
                                        "main"
                                ]
                        ] call CBA_fnc_flexiMenu_Add;
                };

                /*
                CONTROLLER  - coordination
                - frequent check if player is server admin (ALIVE_fnc_playermenuDef)
                - Tell the server that the player is connected
                - Spawn process to regularly save player data to an in memory store
                - Spawn process to regularly save to DB based on auto save time
                - setup event handler to load data on server start (OPC)
                - setup event handler to save data on server exit (OPD)
                - setup event handler to get player data on player connected (OPC)
                - setup event handler to set player data on player disconnected (OPD)
                - setup any event handlers needed on clientside
                */

                TRACE_2("Setting player guid on logic",isDedicated,isHC);
                // For players waituntil the player is valid then let server know.
                if(!isDedicated && !isHC) then {
                    [] spawn {
                        private ["_puid"];
                        TRACE_1("SYS_PLAYER GETTING READY",player);

                        waitUntil { !(isNull player) };
                        sleep 0.2;

                        waitUntil {!isNil QMOD(sys_player)};
                        sleep 0.2;

                        _puid = getplayerUID player;
                        TRACE_1("SYS_PLAYER GUID SET", _puid);

                        MOD(sys_player) setVariable [_puid, true, true];
                    };
                } else {
                    TRACE_2("NO SYS_PLAYER or ISDEDICATED/HC", isDedicated, isNil QMOD(sys_player));
                };

                // Set up any spawn processes for checks
                if (isServer) then {

            	   [] spawn {
            		private ["_lastSaveTime","_lastDBSaveTime"];
            		_lastSaveTime = time;
            		_lastDBSaveTime = time;

            		while {!isNil QMOD(sys_player)} do {

            			// Every X minutes store player data
            			if (time >= (_lastSaveTime + DEFAULT_INTERVAL)) then {
                                    			{
                                    				[MOD(sys_player), "setPlayer", [_x]] call MAINCLASS;
                                    			} foreach playableUnits;
                                    			_lastSaveTime = time;
            			};

            			// If auto save interval is defined and ext db is enabled, then save to external db
            			_check = [MOD(sys_player),"storeToDB",[],DEFAULT_STORETODB] call ALIVE_fnc_OOsimpleOperation;
            			_autoSaveTime = [MOD(sys_player),"autoSaveTime",[],DEFAULT_AUTOSAVETIME] call ALIVE_fnc_OOsimpleOperation;
            			if (_check && (time >= (_lastDBSaveTime + _autoSaveTime))) then {
            				// Save player data to external db
            				[MOD(sys_player), "savePlayers", []] call MAINCLASS;
            			};

            			sleep DEFAULT_INTERVAL;

            		};
            	   };

                           TRACE_1("After module init",_logic);
                        "Player Persistence - Initialisation Completed" call ALiVE_fnc_logger;
                };

                // Eventhandlers for OPC/OPD are called from main

                // Eventhandlers for other stuff here?



        };

        case "allowReset": {
                _result = [_logic,_operation,_args,DEFAULT_RESET] call ALIVE_fnc_OOsimpleOperation;
		};
        case "allowDiffClass": {
                _result = [_logic,_operation,_args,DEFAULT_DIFFCLASS] call ALIVE_fnc_OOsimpleOperation;
        };
        case "allowManualSave": {
                _result = [_logic,_operation,_args,DEFAULT_MANUALSAVE] call ALIVE_fnc_OOsimpleOperation;
        };
        case "storeToDB": {
                _result = [_logic,_operation,_args,DEFAULT_STORETODB] call ALIVE_fnc_OOsimpleOperation;
        };
        case "autoSaveTime": {
                _result = [_logic,_operation,_args,DEFAULT_AUTOSAVETIME] call ALIVE_fnc_OOsimpleOperation;
        };
        case "debug": {
                if (typeName _args == "BOOL") then {
                	_logic setVariable ["debug", _args];
                } else {
                	_args = _logic getVariable ["debug", false];
                };
                if (typeName _args == "STRING") then {
                		if(_args == "true") then {_args = true;} else {_args = false;};
                		_logic setVariable ["debug", _args];
                };
                ASSERT_TRUE(typeName _args == "BOOL",str _args);
                // _logic call ?

                if(_args) then {
                	// _logic call ?
                };
                _result = _args;
        };
        case "loadPlayers": {
                // Load all players from external DB into player store
                _result = false;
        };
        case "savePlayers": {
                // Save all players to external DB
                // Check to see if external database selected
                // Call save players function
                _result = false;
        };
        case "getPlayer": {
        	           // Get player data from player store and apply to player object
                    private ["_playerHash","_unit"];
                    _unit  = _args select 0;
                    // Check that the hash is found
                     if ([GVAR(player_data), (getPlayerUID _unit)] call CBA_fnc_hashHasKey) then {
                        _result = [_logic, _args] call ALIVE_fnc_getPlayer;
                    } else {
                        TRACE_3("SYS_PLAYER PLAYER DATA DOES NOT EXIST",_unit);
                        _result = false;
                    };
        };
        case "getPlayerSaveTime": {
                    private ["_playerHash","_unit"];
                	// Get the time of the last player save for a specific player
                    _unit = _args select 0;
                    _playerHash = [GVAR(player_data), getplayerUID _unit] call CBA_fnc_hashGet;
                    _result =  [_playerHash, "lastSaveTime"] call CBA_fnc_hashGet;
        };
        case "setPlayer": {
                        // Set player data to player store
                        private ["_playerHash","_unit"];
                        _unit  = _args select 0;
                        _playerHash = [_logic, _args] call ALIVE_fnc_setPlayer;
                        _result = [GVAR(player_data), getplayerUID _unit, _playerHash] call CBA_fnc_hashSet;
        };
        case "checkPlayer": {
        	// Check to see if the player joining has the same class as the one stored in memory
        };
        case "resetPlayer": {
        	// Return the player state to the previous saved states
        };
        case "destroy": {

                [_logic, "debug", false] call MAINCLASS;

                if (isServer) then {
                		// if server

                                _logic setVariable ["super", nil];
                                _logic setVariable ["class", nil];
                                _logic setVariable ["init", nil];
                                // and publicVariable to clients
                                MOD(sys_player) = _logic;
                                publicVariable QMOD(sys_player);
                                [_logic, "destroy"] call SUPERCLASS;
                };



                if(!isDedicated && !isHC) then {
                        // remove main menu
                        [
                                "player",
                                [SELF_INTERACTION_KEY],
                                -9500,
                                [
                                        "call MAINCLASSMenuDef",
                                        "main"
                                ]
                        ] call CBA_fnc_flexiMenu_Remove;
                };
        };
        default {
            _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};
TRACE_1("SYS PLAYER - output",_result);
_result;
