/* ----------------------------------------------------------------------------
Function: ALIVE_sys_stat_fnc_getOutEH
Description:
Handles a unit getOut event for all players. Is defined using XEH_postClientInit.sqf in the sys_stat module. Sends the information to the ALIVE website as a "GetOut" record

Parameters:
Object - the vehicle unit gets out of
String - position in the vehicle that the unit was in
Object - unit that got out

Returns:
Nothing

Attributes:
None

Parameters:
_this select 0: OBJECT - vehicle
_this select 1: STRING - position
_this select 2: OBJECT - unit


Examples:
(begin example)
	player addEventHandler ["getOut", {_this call GVAR(fnc_getOutEH);}];
(end)

See Also:
- <ALIVE_sys_stat_fnc_firedEH>
- <ALIVE_sys_stat_fnc_incomingMissileEH>
- <ALIVE_sys_stat_fnc_handleDamageEH>

Author:
Tupolov
---------------------------------------------------------------------------- */
// MAIN
#define DEBUG_MODE_FULL

#include "script_component.hpp"
if (GVAR(ENABLED)) then {
	private ["_sideunit","_sidevehicle","_unittype","_vehicleweapon","_vehicletype","_distance","_datetime","_factionvehicle","_factionunit","_data","_unitPos","_vehiclePos","_server","_realtime","_vehicle","_unit","_unitVehicleClass","_vehicleVehicleClass","_position"];

	// Set Data 
	_vehicle = _this select 0;
	_position = _this select 1;
	_unit = _this select 2;

	//diag_log format["GetOut: %1", _this];

	if (local _unit && isPlayer _unit) then {
		
		_sideunit = side (group _unit); // group side is more reliable
		_sidevehicle = side _vehicle;
		
		_factionvehicle = getText (configFile >> "cfgFactionClasses" >> (faction _vehicle) >> "displayName"); 
		_factionunit = getText (configFile >> "cfgFactionClasses" >> (faction _unit) >> "displayName"); 
		
		_unittype = getText (configFile >> "cfgVehicles" >> (typeof _unit) >> "displayName");
		_vehicletype = getText (configFile >> "cfgVehicles" >> (typeof _vehicle) >> "displayName");
		
		_unitVehicleClass = "Infantry";
		_vehicleVehicleClass = "None";

		switch true do {
			case (_vehicle isKindof "LandVehicle"): {_vehicleVehicleClass = "Vehicle";};
			case (_vehicle isKindof "Air"): {_vehicleVehicleClass = "Aircraft";};
			case (_vehicle isKindof "Ship"): {_vehicleVehicleClass = "Ship";};
			case (_vehicle isKindof "Man"): {_vehicleVehicleClass = "Infantry";};
			
			case default {_vehicleVehicleClass = "Other";};
		};
			
		_unitPos = mapgridposition _unit;
		_vehiclePos = mapgridposition _vehicle;
		
		// Set Player time spent in vehicle
		_vehMinutes = floor(( (dateToNumber date) - ( dateToNumber (_unit getVariable [QGVAR(GetInTime),time])) ) * 525600);
		
		// Log data
		_data = format["""Event"":""GetOut"" , ""unitSide"":""%1"" , ""unitfaction"":""%2"" , ""unitType"":""%3"" , ""unitClass"":""%11"" ,""unitPos"":""%4"" , ""vehicleSide"":""%5"" , ""vehiclefaction"":""%6"" , ""vehicleType"":""%7"" , ""vehicleClass"":""%12"" , ""vehiclePos"":""%8"" , ""unit"":""%9"" , ""vehicle"":""%10"" , ""vehiclePosition"":""%13"" , ""vehicleMinutes"":%14", _sideunit, _factionunit, _unitType, _unitPos, _sidevehicle, _factionvehicle, _vehicleType, _vehiclePos, _unit, _vehicle, _unitVehicleClass, _vehicleVehicleClass, _position, _vehMinutes];
		

			_data = _data + format[" , ""Player"":""%1"" , ""PlayerName"":""%2""", getplayeruid _unit, name _unit];
			
			// Send data to server to be written to DB
			GVAR(UPDATE_EVENTS) = _data;
			publicVariableServer QGVAR(UPDATE_EVENTS);

	};		
};
	
// ====================================================================================