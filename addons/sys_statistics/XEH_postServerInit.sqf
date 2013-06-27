#include "script_component.hpp"	

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
if (isDedicated && GVAR(ENABLED)) then {

	_data = [["Event","OperationStart"]];
	
	GVAR(UPDATE_EVENTS) = _data;
	publicVariableServer QGVAR(UPDATE_EVENTS);
		
	GVAR(timeStarted) = date;
	
	//diag_log format["TimeStarted: %1", GVAR(timeStarted)];
	
	// Setup player disconnection eventhandler
	onPlayerDisconnected {
	
		
		if (GVAR(ENABLED)) then {
			private ["_class","_puid","_PlayerSide","_PlayerFaction","_startTime","_endTime","_minutesPlayed","_data","_shotsFired","_shotsFiredData","_unit","_playerType","_score","_rating"];
	
			_unit = objNull;
			
			diag_log [str(_id), _name, _uid];
			
			if (_name == "__SERVER__") exitWith {
			
				_minutesPlayed = floor(( (dateToNumber date) - ( dateToNumber GVAR(timeStarted)) ) * 525600);
				
				// Format Data
				_data = [ ["Event","OperationFinish"] , ["timePlayed", _minutesPlayed] ];

				// Send Data
				GVAR(UPDATE_EVENTS) = _data;
				publicVariableServer QGVAR(UPDATE_EVENTS);
			};
			
			{
				if (getPlayerUID _x == _uid) exitwith {
					diag_log[format["PLAYER UNIT FOUND IN PLAYABLEUNITS (%1)",_x]];
					_unit = _x;
				};
			} foreach playableUnits;

			if (isNull _unit) then {
				diag_log["PLAYER UNIT NOT FOUND IN PLAYABLEUNITS"];
				
				// Can we still send some data to the DB?
				_class = "Unknown";
				_PlayerSide = "Unknown";
				_PlayerFaction = "Unknown";
				_playerType = "Unknown";
				_minutesPlayed = ceil(time / 60);
				_shotsFiredData = [];
				_score = 0;
				_rating = 0;
				
			} else {
			
				_class = getText (configFile >> "cfgVehicles" >> (typeof _unit) >> "displayName");	
				_PlayerSide = side (group _unit); // group side is more reliable
				_PlayerFaction = faction _unit;			
				_playerType = typeof _unit;
				// Calculate Minutes Played
				_minutesPlayed = floor(( (dateToNumber date) - ( dateToNumber (_unit getvariable QGVAR(timeStarted))) ) * 525600);
				//diag_log _minutesPlayed;
				
				_score = score _unit;
				_rating = rating _unit;
				
				// Grab shots fired data
				_shotsFired = _unit getvariable QGVAR(shotsFired);
							
				_shotsFiredData = [];
				{
					private ["_weaponCount","_weapon","_count","_muzzle"];
					_weaponCount = _x;
					_muzzle = _weaponCount select 0;
					_count = _weaponCount select 1;
					_weapon = _weaponCount select 2;
					_weaponName = _weaponCount select 3;
					_shotsFiredData = _shotsFiredData + [ [["weaponMuzzle",_muzzle] , ["count",_count] , ["weaponType", _weapon], ["weaponName",_weaponName]] ] ;
				} foreach _shotsFired;	
			
			};
					
			// Format Data
			_data = [ ["Event","PlayerFinish"] , ["PlayerSide",_PlayerSide] , ["PlayerFaction",_PlayerFaction] , ["PlayerName",_name] , ["PlayerType",_PlayerType] , ["PlayerClass",_class] , ["Player", _uid] , ["shotsFired", _shotsFiredData] , ["timePlayed",_minutesPlayed], ["score",_score], ["rating",_rating] ];

			// Send Data
			GVAR(UPDATE_EVENTS) = _data;
			publicVariableServer QGVAR(UPDATE_EVENTS);
		
		};
		
	};
	
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



