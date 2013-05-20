/* ----------------------------------------------------------------------------
Function: ALIVE_sys_stat_fnc_divingEH
Description:
Handles a unit diving event for all players. Is defined using XEH_postClientInit.sqf in the sys_stat module. Sends the information to the ALIVE website as a "Diving" record

Parameters:
Object - player that dived
Integer - time in seconds for dive


Returns:
Nothing

Attributes:
None

Parameters:
_this select 0: OBJECT - player
_this select 1: INTEGER - dive time

Examples:
(begin example)

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
	private ["_sideunit","_diveTime","_unitType","_factionunit","_data","_unitPos","_unit"];

	// Set Data 
	_unit = _this select 0;
	_diveTime = _this select 1;

	//diag_log format["Diving: %1", _this];

	if (local _unit && isPlayer _unit) then {
	
		_sideunit = side (group _unit); // group side is more reliable
		
		_factionunit = getText (configFile >> "cfgFactionClasses" >> (faction _unit) >> "displayName"); 
		
		_unitType = getText (configFile >> "cfgVehicles" >> (typeof _unit) >> "displayName");
				
		_unitPos = mapgridposition _unit;
		
		// Log data
		_data = format["""Event"":""CombatDive"" , ""unitSide"":""%1"" , ""unitfaction"":""%2"" , ""unitType"":""%3"" , ""unitPos"":""%4"" , ""unit"":""%5"" , ""diveTime"":""%6""", _sideunit, _factionunit, _unitType, _unitPos, _unit, _diveTime];
			
		_data = _data + format[" , ""Player"":""%1"" , ""PlayerName"":""%2""", getplayeruid _unit, name _unit];
		
		// Send data to server to be written to DB
		GVAR(UPDATE_EVENTS) = _data;
		publicVariableServer QGVAR(UPDATE_EVENTS);
				
	};
};
// ====================================================================================