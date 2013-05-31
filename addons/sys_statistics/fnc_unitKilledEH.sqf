/* ----------------------------------------------------------------------------
Function: ALIVE_sys_stat_fnc_unitKilledEH
Description:
Handles a unit killed event for all vehicles, aircraft etc. Is defined using XEH in the config of the sys_stat module. Sends the information to the ALIVE website as a "kill" record

Parameters:
Object - the unit that was killed
Object- the unit that was the killer

Returns:
Nothing

Attributes:
None

Parameters:
_this select 0: OBJECT - unit killed
_this select 1: OBJECT - unit killer


Examples:
(begin example)
class Extended_Killed_Eventhandlers
{
	class LANDVEHICLE
	{
		class alive_sys_stat 
		{
			killed = "_this call alive_sys_stat_fnc_unitKilledEH";
		};
	};
};
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
	private ["_sideKilled","_sideKiller","_killedtype","_killerweapon","_killertype","_distance","_datetime","_factionKiller","_factionKilled","_data","_killedPos","_killerPos","_server","_realtime","_killer","_killed","_killedVehicleClass","_killerVehicleClass"];

	// Set Data 
	_killed = _this select 0;
	_killer = _this select 1;

	if (isNull _killer) then {
		_killer = _killed;
	};

	// if killed is a player or a vehicle then record, if killer is player or player in a vehicle
	if ( (_killed == player) || !(_killed iskindof "Man") || (isPlayer _killer) ) then {
		
		//diag_log format["Unit Killed: vehicle: %1, killed: %2, killer: %3, killerunit: %4 (%5)", typeof vehicle _killed, typeof _killed, typeof _killer, _killer, isPlayer _killer];

		_sideKilled = side (group _killed); // group side is more reliable
		_sideKiller = side _killer;
		
		_factionKiller = getText (configFile >> "cfgFactionClasses" >> (faction _killer) >> "displayName"); 
		_factionKilled = getText (configFile >> "cfgFactionClasses" >> (faction _killed) >> "displayName"); 
		
		_killedtype = getText (configFile >> "cfgVehicles" >> (typeof _killed) >> "displayName");
		_killertype = getText (configFile >> "cfgVehicles" >> (typeof _killer) >> "displayName");
		
		switch (true) do {
			case (_killed isKindof "LandVehicle"): {_killedVehicleClass = "Vehicle";};
			case (_killed isKindof "Air"): {_killedVehicleClass = "Aircraft";};
			case (_killed isKindof "Ship"): {_killedVehicleClass = "Ship";};
			case (_killed isKindof "Man"): {_killedVehicleClass = "Infantry";};
			default {_killedVehicleClass = "Other";};
		};

		switch (true) do {
			case (_killer isKindof "LandVehicle")  : {	_killerVehicleClass = "Vehicle";};
			case (_killer isKindof "Air") : {	_killerVehicleClass = "Aircraft";};
			case (_killer isKindof "Ship") : {	_killerVehicleClass = "Ship";};
			case (_killer isKindof "Man") : {	_killerVehicleClass = "Infantry";};
			default {_killerVehicleClass = "Other";};
		};
		
		_killerweapon = getText (configFile >> "cfgWeapons" >> (currentweapon _killer) >> "displayName");
		
		if (vehicle _killer != _killer) then {
				_killerweapon = _killerweapon + format[" (%1)", getText (configFile >> "cfgVehicles" >> (typeof (vehicle _killer)) >> "displayName")];
		};
		
		if (_killerweapon == "") then {
			_killerweapon = "UNKNOWN";
		};
		
		_distance = ceil(_killed distance _killer);
		
		_killedPos = mapgridposition _killed;
		_killerPos = mapgridposition _killer;
		
		// Log data
		_data = format["""Event"":""Kill"" , ""KilledSide"":""%1"" , ""Killedfaction"":""%2"" , ""KilledType"":""%3"" , ""KilledClass"":""%13"" ,""KilledPos"":""%4"" , ""KillerSide"":""%5"" , ""Killerfaction"":""%6"" , ""KillerType"":""%7"" , ""KillerClass"":""%14"" , ""KillerPos"":""%8"" , ""Weapon"":""%9"" , ""Distance"":%10 , ""Killed"":""%11"" , ""Killer"":""%12""", 
			_sideKilled, _factionKilled, _killedType, _killedPos, _sideKiller, _factionKiller, _killerType, _killerPos, _killerweapon, _distance, _killed, _killer, _killedVehicleClass, _killerVehicleClass];
		
		if (player == _killed) exitWith { // Player was killed
		
			if (_killer == _killed) then { // Suicide?
				_data = _data + " , ""suicide"":""true""";
			};
			
				_data = _data + format[" , ""Death"":""true"" , ""Player"":""%1"", ""PlayerName"":""%2""", getplayeruid _killed, name _killed];
				// Send data to server to be written to DB
				GVAR(UPDATE_EVENTS) = _data;
				publicVariableServer QGVAR(UPDATE_EVENTS);
		};
		
		if (!(_killed iskindof "Man")) then { // vehicle was killed

				if (isPlayer _killer || isPlayer (gunner _killer)) then {
					_data = _data + format[" , ""Player"":""%1"" , ""PlayerName"":""%2""", getplayeruid _killer, name _killer];
				};
				// Send data to server to be written to DB
				GVAR(UPDATE_EVENTS) = _data;
				publicVariableServer QGVAR(UPDATE_EVENTS);
		};
		
		if (isPlayer _killer && (_killer != _killed) && (_killed iskindof "Man")) then { // Player was killer
			
				// Check to see if player is in a vehicle and firing the weapon
				//if (_killer iskindof "Man" || isPlayer (gunner _killer) || isPlayer (commander _killer) || isPlayer (driver _killer) ) then {
					_data = _data + format[" , ""Player"":""%1"" , ""PlayerName"":""%2""", getplayeruid _killer, name _killer];
					// Send data to server to be written to DB
					GVAR(UPDATE_EVENTS) = _data;
					publicVariableServer QGVAR(UPDATE_EVENTS);		
				//};	
				
		};
					
	};				
};
// ====================================================================================