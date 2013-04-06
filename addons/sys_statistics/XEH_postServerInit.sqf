#include "script_component.hpp"	
			
// Register Operation with DB and setup OPD
if (isDedicated) then {

	_data = """Event"":""OperationStart""";
	
	GVAR(UPDATE_EVENTS) = _data;
	publicVariableServer QGVAR(UPDATE_EVENTS);
		
	GVAR(timeStarted) = date;
	
	//diag_log format["TimeStarted: %1", GVAR(timeStarted)];
	
	// Setup player disconnection eventhandler
	onPlayerDisconnected {
	
		private ["_name","_class","_puid","_PlayerSide","_PlayerFaction","_startTime","_endTime","_minutesPlayed","_data","_shotsFired","_shotsFiredData","_unit","_playerType"];
					
		_unit = objNull;
		
		diag_log [_id, _name, _uid];
		
		if (_name == "__SERVER__") exitWith {
		
			_minutesPlayed = floor(( (dateToNumber date) - ( dateToNumber GVAR(timeStarted)) ) * 525600);
			
			// Format Data
			_data = format["""Event"":""OperationFinish"" , ""timePlayed"":%1", _minutesPlayed];

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
			_shotsFiredData = "";
			
		} else {
		
			_class = getText (configFile >> "cfgVehicles" >> (typeof _unit) >> "displayName");	
			_PlayerSide = side (group _unit); // group side is more reliable
			_PlayerFaction = faction _unit;			
			_playerType = typeof _unit;
			// Calculate Minutes Played
			_minutesPlayed = floor(( (dateToNumber date) - ( dateToNumber (_unit getvariable QGVAR(timeStarted))) ) * 525600);
			//diag_log _minutesPlayed;
			
			// Grab shots fired data
			_shotsFired = _unit getvariable QGVAR(shotsFired);
						
			_shotsFiredData = "";
			{
				private ["_weaponCount","_weapon","_count","_muzzle"];
				_weaponCount = _x;
				_muzzle = _weaponCount select 0;
				_count = _weaponCount select 1;
				_weapon = _weaponCount select 2;
				_weaponName = _weaponCount select 3;
				_shotsFiredData = _shotsFiredData + format["{""weaponMuzzle"":""%1"" , ""count"":%2 , ""weaponType"":""%3"" , ""weaponName"":""%4""} , ", _muzzle, _count, _weapon, _weaponName];
			} foreach _shotsFired;	
		
		};
				
		// Format Data
		_data = format["""Event"":""PlayerFinish"" , ""PlayerSide"":""%1"" , ""PlayerFaction"":""%2"" , ""PlayerName"":""%3"" ,""PlayerType"":""%4"" , ""PlayerClass"":""%5"" , ""Player"":""%6"" , ""shotsFired"": [%7{}] , ""timePlayed"":%8", _PlayerSide, _PlayerFaction, _name, _playerType, _class, _uid, _shotsFiredData, _minutesPlayed];

		// Send Data
		GVAR(UPDATE_EVENTS) = _data;
		publicVariableServer QGVAR(UPDATE_EVENTS);;
		
	};

};



