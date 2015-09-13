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

			//-- Groups to send
			_groups = parseNumber (ctrlText 72313);
			if ((_groups < 1) or (_groups > 15)) then {_groups = 3};


		//-- Execute on server
		[[[player,_position,_radius,_groups],{
			["server",[(_this select 0),(_this select 1),(_this select 2),(_this select 3)]] call ALiVE_fnc_requestReinforcements;
		}],"BIS_fnc_spawn",false,true,false] call BIS_fnc_MP;
	};

	//-- Server
	case "server": {
		_arguments params ["_player","_position","_radius","_groups"];

		//-- Exit if ALiVE is not running
		if (isNil "ALIVE_profileHandler") exitWith {hint "ALiVE is not currently running"};

		//-- Get nearby profiles and sort for closest
		_profileArray = [_position, _radius, [str side _player,"entity"]] call ALIVE_fnc_getNearProfiles;
		_profileArray = [_profileArray,[_position],{_Input0 distance ([_x, "position", []] call CBA_fnc_HashGet)},"ASCEND"] call BIS_fnc_sortBy;


		//-- Exit if none nearby
		if (count _profileArray <= 1) exitWith {
			[str side _player,[_player,"There are no friendly groups in the vicinity","side",side _player,false,false,false,true,"HQ"]] call ALIVE_fnc_radioBroadcastToSide;
		};


		//-- Assign waypoints to nearby profiles
		_loops = 0;
		for "_x" from 1 to (count _profileArray - 1) step 1 do {

			//--Exit if max groups already sent
			if (_loops >= _groups) exitWith {};

			_profile = _profileArray select _x;

			//-- Player check
			if !([_profile,"isPlayer",false] call ALIVE_fnc_hashGet) then {

				//-- Clear waypoints
				[_profile, "clearWaypoints"] call ALIVE_fnc_profileEntity;

				//-- Assign waypoints
				_wp = [_position, 50, "MOVE","FULL",100] call ALIVE_fnc_createProfileWaypoint;
				[_profile,"addWaypoint",_wp] call ALIVE_fnc_profileEntity;

				[_profile] spawn ALiVE_fnc_retaskWhenReady;
				_loops = _loops + 1;
				sleep .3;
			};
		};

		//-- Notify requester of inbound units
		_message = format ["%1 friendly groups are inbound to the location", _loops];
		[str side _player,[_player,_message,"side",side _player,false,false,false,true,"HQ"]] call ALIVE_fnc_radioBroadcastToSide;
	};
};