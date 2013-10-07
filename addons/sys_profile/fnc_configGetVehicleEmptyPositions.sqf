#include <\x\alive\addons\sys_profile\script_component.hpp>
SCRIPT(configGetVehicleEmptyPositions);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_configGetVehicleEmptyPositions

Description:
Get an array of empty positions for the vehicle from config

Parameters:
String - The vehicle class name

Returns:
Array of empty positions [driver, gunner, commander, turretsEmpty, cargo]

Examples:
(begin example)
// get empty positions array
_result = ["B_Truck_01_transport_F"] call ALIVE_fnc_vehicleGetEmptyPositions;
// returns [1,0,0,0,17]
(end)

See Also:

Author:
Wolffy.au
---------------------------------------------------------------------------- */

private ["_vehicle","_positions","_class","_turretEmptyCount","_root"];
	
_vehicle = [_this, 0, "", [""]] call BIS_fnc_param;

_positions = [0,0,0,0,0];
_class = (configFile >> "CfgVehicles" >> _vehicle);

_positions set [0, getNumber(_class >> "hasDriver")];

// get turrets for this class ignoring gunner and commander turrets
_turretEmptyCount = 0;

_root = (configFile >> "CfgVehicles" >> _vehicle >> "turrets");
for "_i" from 0 to count _root -1 do {
	private["_class"];
	_class = _root select _i;

	if (isClass _class) then {
		if (getNumber(_class >> "hasGunner") == 1) then {
			if(getNumber(_class >> "primaryGunner") == 1) then {
				_positions set [1, 1];
			} else {
				if(getNumber(_class >> "primaryObserver") == 1) then {
					_positions set [2, 1];
				} else {
					_turretEmptyCount = _turretEmptyCount +1;
				};
			};
		};
	};
};

if(getNumber(configFile >> "CfgVehicles" >> _vehicle >> "CommanderOptics" >> "primaryObserver") == 1) then {
	_positions set [2, 1];
};

_positions set [3, _turretEmptyCount];
_positions set [4, getNumber(_class >> "transportSoldier")];

_positions;