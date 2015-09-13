params ["_locality","_arguments"];

switch (toLower (_locality)) do {
	//-- Client
	case "client": {
		//-- position
		_position = getMarkerPos (uiNamespace getVariable "SpyderCommandTablet_MissionPosition");
		deleteMarkerLocal (uiNamespace getVariable "SpyderCommandTablet_MissionPosition");

		//-- Get player-set parameters
			//--Radius
			_radius = parseNumber (ctrlText 72311);
			if (_radius < 1) then {_radius = 3000};


		//-- Execute on server
		[[[player,_position,_radius],{
			["server",[(_this select 0),(_this select 1),(_this select 2)]] call ALiVE_fnc_requestRecon;
		}],"BIS_fnc_spawn",false,true,false] call BIS_fnc_MP;
	};

	//-- Server
	case "server": {
		_arguments params ["_player","_position","_radius"];

		//-- Exit if ALiVE is not running
		if (isNil "ALIVE_profileHandler") exitWith {hint "ALiVE is not currently running"};

		//-- Get nearby profiles and sort for closest
		_profileArray = [str side _player] call ALiVE_fnc_getSideInfantry;
		_profileArray = [_profileArray,[_position],{_Input0 distance ([_x, "position", []] call CBA_fnc_HashGet)},"ASCEND"] call BIS_fnc_sortBy;


		//-- Assign waypoints to nearby profiles
		_loops = 0;
		for "_x" from 1 to (count _profileArray - 1) step 1 do {

			//--Exit if max groups already reached
			if (_loops == 1) exitWith {};

			_profile = _profileArray select _x;

			//-- Player check
			if !([_profile,"isPlayer",false] call ALIVE_fnc_hashGet) then {

				//-- Clear waypoints
				[_profile, "clearWaypoints"] call ALIVE_fnc_profileEntity;

				//-- Staging waypoint
				_profilePos = [_profile, "position", []] call CBA_fnc_HashGet;
				_wp1 = [_position, 50, "MOVE","NORMAL", 75] call ALIVE_fnc_createProfileWaypoint;
				[_profile,"addWaypoint",_wp1] call ALIVE_fnc_profileEntity;

				[_profile,"busy",true] call ALIVE_fnc_hashSet;
				["task",[_profile,_position,_player]] spawn ALiVE_fnc_requestRecon;
				_loops = _loops + 1;
				sleep .3;
			};
		};

		//-- Notify requester of inbound units
		if (_loops == 1) then {
			[str side _player,[_player,"A recon team is inbound to the location","side",side _player,false,false,false,true,"HQ"]] call ALIVE_fnc_radioBroadcastToSide;
		} else {
			[str side _player,[_player,"No recon team could be found to complete the mission","side",side _player,false,false,false,true,"HQ"]] call ALIVE_fnc_radioBroadcastToSide;
		};
	};
	case "task": {
		_arguments params ["_profile","_position","_player"];
		_originalPos = [_profile, "position", []] call CBA_fnc_HashGet;

		//-- Wait until profile has reached location or has died
		waitUntil {sleep 120;count ([_profile,"waypoints",[]] call ALIVE_fnc_hashGet) == 0 or {([_profile, "unitCount"] call ALIVE_fnc_profileEntity) == 0}};


		//-- Check if profile died
		if (([_profile, "unitCount"] call ALIVE_fnc_profileEntity) == 0) exitWith {};


		//-- Find nearby enemy profiles and create markers after delay
		sleep (120 + random 80);

		_enemySides = [([_profile,"side"] call ALIVE_fnc_hashGet)] call ALiVE_fnc_getEnemySides;
		_enemies = [];
		{
			{_enemies pushBack _x} forEach ([nil,"entitiesnearsector",[([_profile, "position", []] call CBA_fnc_HashGet),_x,true]] call ALIVE_fnc_OPCOM);
		} forEach _enemySides;


		//-- Get enemy positions
		_enemyPositions = [];
		{
			_enemyPositions pushBack (_x select 1);
		} forEach _enemies;

		//-- Create markers
		{
			_marker = [str _x,_x,"ICON",[1.5,1.5],"ColorRed","","o_unknown","Solid",0,1] call ALIVE_fnc_createMarkerGlobal;
			[_marker] spawn ALiVE_fnc_markerFade;
		} forEach _enemyPositions;


		//--Send back to original location
		_wp = [_originalPos, 50, "MOVE","NORMAL", 75] call ALIVE_fnc_createProfileWaypoint;
		[_profile,"addWaypoint",_wp] call ALIVE_fnc_profileEntity;

		//-- Notify player
		[str side _player,[_player,"Recon team has marked any visible enemy units and is retreating","side",side _player,false,false,false,true,"HQ"]] call ALIVE_fnc_radioBroadcastToSide;
		[_profile,"busy",false] call ALIVE_fnc_hashSet;
	};
};