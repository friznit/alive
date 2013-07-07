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



