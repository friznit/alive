#include "script_component.hpp"

LOG(MSG_INIT);

ADDON = false;

// Register Client with DB

if (isMultiplayer && GVAR(ENABLED) && !isHC) then {

	// Get player information
	_name = name player;
	_class = getText (configFile >> "cfgVehicles" >> (typeof player) >> "displayName");
	_puid = getplayeruid player;
	_PlayerSide = side (group player); // group side is more reliable
	_PlayerFaction = faction player;

	// Setup the event data for player starting
	_data = [["Event","PlayerStart"] , ["PlayerSide",_PlayerSide] , ["PlayerFaction",_PlayerFaction], ["PlayerName",_name] ,["PlayerType",typeof player] , ["PlayerClass",_class] , ["Player",_puid] ];

	GVAR(UPDATE_EVENTS) = _data;
	publicVariableServer QGVAR(UPDATE_EVENTS);
	
	// Set player startTime
	player setVariable [QGVAR(timeStarted), date, true];
	
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
		] call CBA_fnc_flexiMenu_Add;
};

ADDON = true;
