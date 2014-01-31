#include <\x\alive\addons\sys_statistics\script_component.hpp>
SCRIPT(statisticsInit);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_statisticsInit
Description:
Creates the server side object to store settings

Parameters:
_this select 0: OBJECT - Reference to module

Returns:
Nil

See Also:
- <ALIVE_fnc_statistics>

Author:
Tupolov

Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_logic"];

PARAMS_1(_logic);

// Confirm init function available
ASSERT_DEFINED("ALIVE_fnc_data","Main function missing");

LOG(MSG_INIT);

ADDON = false;

TRACE_2("SYS_STATS",isDedicated,GVAR(ENABLED));

if (isDedicated && GVAR(ENABLED)) then {

	// Setup data handler
	GVAR(datahandler) = [nil, "create"] call ALIVE_fnc_Data;
	[GVAR(datahandler),"storeType",false] call ALIVE_fnc_Data;

	// Grab Server IP and data group info
	GVAR(serverIP) = [] call ALIVE_fnc_getServerIP;
	GVAR(serverName) = [] call ALIVE_fnc_getServerName;
	GVAR(groupTag) = [] call ALIVE_fnc_getGroupID;
	publicVariable QGVAR(groupTag);

	// If the host IP web service is down, just use the serverName
	if (GVAR(serverIP) == "ERROR") then {
		GVAR(serverIP) = GVAR(serverName);
	};

	// Try getting the actual MP hostname of server
	//GVAR(serverhostname) = ["ServerHostName"] call ALIVE_fnc_sendToPlugIn;
	//diag_log GVAR(serverhostname);

	// Setup OPC and OPD events
	//[QGVAR(OPC), "OnPlayerConnected","ALIVE_fnc_stats_OnPlayerConnected"] call BIS_fnc_addStackedEventHandler;
	//[QGVAR(OPD), "OnPlayerDisconnected","ALIVE_fnc_stats_OnPlayerDisconnected"] call BIS_fnc_addStackedEventHandler;

	// Setup Module Data Listener
	// Server side handler to write data to DB
	QGVAR(UPDATE_EVENTS) addPublicVariableEventHandler {

		private ["_data", "_post", "_gameTime", "_realTime","_hours","_minutes","_currenttime","_async"];
		if (GVAR(ENABLED)) then {
			_data = _this select 1;
			_module = "events";

			// Check data passed is an array
			ASSERT_TRUE(typeName _data == "ARRAY", _data);

			// Get server/date/time/operation/map specific information to prefix to event data

			// Get local time and format please.
			_currenttime = date;

			// Work out time in 4 digits
			if ((_currenttime select 4) < 10) then {
				_minutes = "0" + str(_currenttime select 4);
			} else {
				_minutes = str(_currenttime select 4);
				};
			if ((_currenttime select 3) < 10) then {
				_hours = "0" + str(_currenttime select 3);
			} else {
				_hours = str(_currenttime select 3);
			};

			_gametime = format["%1%2", _hours, _minutes];
			_realtime = [] call ALIVE_fnc_getServerTime;

			// _data should be an array of key/value
			_data = [ ["realTime",_realtime],["Server",GVAR(serverIP)],["Group",GVAR(groupTag)],["Operation",GVAR(operation)],["Map",worldName],["gameTime",_gametime] ] + _data;

			// Write event data to DB
			if ((_data select 5) select 1 == "OperationFinish") then {
				_async = false;
			} else {
				_async = true;
			};
			_result = [GVAR(datahandler), "write", [_module, _data, _async] ] call ALIVE_fnc_Data;
			if (_result == "ERROR") then {
				ERROR("SYS STATISTICS FAILED TO WRITE TO DATABASE");
			};
			TRACE_2("UPDATE EVENTS",_data,_result);
			_result;


		};
	};

	// Set Operation name
	GVAR(operation) = getText (missionConfigFile >> "OnLoadName");

	if (GVAR(operation) == "") then {
		//GVAR(operation) = GVAR(MISSIONNAME_UI);
		//if (GVAR(operation) == "") then {
			GVAR(operation) = missionName;
		//};
	};

	diag_log format["Operation: %1",GVAR(operation)];

	// Register Operation with DB and setup OPD
	private ["_data"];
	_data = [["Event","OperationStart"]];

	GVAR(UPDATE_EVENTS) = _data;
	publicVariableServer QGVAR(UPDATE_EVENTS);

	GVAR(timeStarted) = date;

	//diag_log format["TimeStarted: %1", GVAR(timeStarted)];

	/* Test Live Feed
	[] spawn {
		// Thread running on server to report state of every unit every 3 seconds
		while {true} do {
			diag_log format["Units: %1",count allUnits];
			{
				private ["_unit"];
				_unit = vehicle _x;
				if (alive _unit) then {
					private ["_name","_id","_pos","_dir","_class","_damage","_data","_streamName","_post","_result","_icon"];
					_name = name _unit;
					_id = [netid _unit, ,, "A"] call CBA_fnc_replace;
					_pos = getpos _unit;
					_position = format ["{""x"":%1,""y"":%2,""z"":%3}", _pos select 0, _pos select 1, _pos select 2];
					_dir = ceil(getdir _unit);
					_class = getText (configFile >> "cfgVehicles" >> (typeof _unit) >> "displayName");
					_damage = damage _unit;
					_side = side (group _unit);
					_fac = getText (configFile >> "cfgFactionClasses" >> (faction _unit) >> "displayName");

					_icon = switch (_side) do
					{
						case EAST :{"red.fw"};
						case WEST :{"green.fw"}:
						default {"yellow.fw"};
					};

					_data = format[" ""data"":{""name","%1"", ""id","%2"", ""pos"":%3, ""dir","%4"", ""type","%5"", ""damage"":%6, ""side","%7"", ""faction","%8"", ""icon","%9""}", _name, _id, _position, _dir, _class, _damage, _side, _fac, _icon];

					_streamName = "ALIVE_STREAM"; // GVAR(serverIP) + "_" + missionName;
					_post = format ["SendxRTML [""%2"", ""{%1}""]", _data, _streamName];
					"Arma2Net.Unmanaged" callExtension _post;
					sleep 0.33;
					_result = "Arma2Net.Unmanaged" callExtension "SendxRTML []";
				};
			} foreach allUnits;
			sleep 1;
		};
	}; */


};

if (isMultiplayer && GVAR(ENABLED) && !isHC) then {

	// Set player shotsFired
	player setVariable [QGVAR(shotsFired), [[primaryweapon player, 0, primaryweapon player, getText (configFile >> "cfgWeapons" >> primaryweapon player >> "displayName")]]];

	// Player eventhandlers

	// Set up eventhandler to grab player profile from website
	"STATS_PLAYER_PROFILE" addPublicVariableEventHandler {
		if (STATS_PLAYER_PROFILE_DONE) exitWith {}; // If i've loaded my player profile already, then quit
		private ["_data","_result"];

		TRACE_1("STATS PLAYER PROFILE",_this);

		// Read data from server PVEH
		_data = _this select 1;

		// Create player profile in diary record
		_result = [_data] call ALIVE_fnc_stats_createPlayerProfile;

		TRACE_1("STATS PLAYER PROFILE SUCCESS",_result);

		STATS_PLAYER_PROFILE_DONE = true;
	};

	// Set up player fired
	player addEventHandler ["Fired", {_this call GVAR(fnc_playerfiredEH);}];

	// Set up handleDamage
//	player addEventHandler ["handleDamage", {_this call GVAR(fnc_handleDamageEH);}];

	// Set up hit handler
	player addEventHandler ["hit", {_this call GVAR(fnc_hitEH);}];

	// Set up handleHeal
	player addEventHandler ["handleHeal", {_this call GVAR(fnc_handleHealEH);}];

	// Set up non eventhandler checks
	[] spawn {
		// Combat Dive - checks every 30 seconds for diving
		private ["_diving", "_diveStartTime", "_diveTime"];
		while {true} do {
			if (underwater player && isAbleToBreathe player) then {
				_diving = player getVariable [QGVAR(isDiving),false];
				if !(_diving) then {
					// record dive start time
					player setVariable [QGVAR(isDiving),true,false];
					player setVariable [QGVAR(diveStartTime),time,false];
				};
			} else {
				_diving = player getVariable [QGVAR(isDiving),false];
				if (_diving) then {
					// Player has exited from dive - they may have surfaced also?
					_diveStartTime = player getVariable [QGVAR(diveStartTime),time];
					_diveTime = ceil((time - _diveStartTime) / 60); // in minutes

					// Record Combat Dive
					[player,_diveTime] call GVAR(fnc_divingEH);

					// Clear dive flag
					player setVariable [QGVAR(isDiving),false,false];
				};
			};
			sleep 30;
		};
	};

	// Get player information and send player start event
	_name = name player;
	_class = getText (configFile >> "cfgVehicles" >> (typeof player) >> "displayName");
	_puid = getplayeruid player;
	_PlayerSide = side (group player); // group side is more reliable
	_PlayerFaction = faction player;


	// Setup the event data for player starting
	_data = [ ["Event","PlayerStart"] , ["PlayerSide",_PlayerSide] , ["PlayerFaction",_PlayerFaction], ["PlayerName",_name] ,["PlayerType",typeof player] , ["PlayerClass",_class] , ["Player",_puid] ];
	GVAR(UPDATE_EVENTS) = _data;
	publicVariableServer QGVAR(UPDATE_EVENTS);
};


/*
VIEW - purely visual
- initialise menu
- frequent check to modify menu and display status
*/

TRACE_4("Adding menu",isDedicated,isHC,GVAR(ENABLED),GVAR(DISABLED));

if(!isDedicated && !isHC && GVAR(ENABLED)) then {
		// Initialise interaction key if undefined
		if(isNil "SELF_INTERACTION_KEY") then {SELF_INTERACTION_KEY = [221,[false,false,false]];};

		// if ACE spectator enabled, seto to allow exit
		if(!isNil "ace_fnc_startSpectator") then {ace_sys_spectator_can_exit_spectator = true;};

		// Initialise default map click command if undefined
		ISNILS(DEFAULT_MAPCLICK,"");

		TRACE_3("Menu pre-req",SELF_INTERACTION_KEY,ace_fnc_startSpectator,DEFAULT_MAPCLICK);

		// initialise main menu
		[
				"player",
				[SELF_INTERACTION_KEY],
				-9500,
				[
						"call ALIVE_fnc_statisticsMenuDef",
						"main"
				]
		] call ALiVE_fnc_flexiMenu_Add;
};

ADDON = true;


