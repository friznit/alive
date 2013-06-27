/* 
 * Filename:
 * fnc_handleDamageEH.sqf 
 *
 * Description:
 * Extended handleDamage Eventhandler
 * 
 * Created by Tupolov
 * Creation date: 21/03/2013
 * 
 * */

// ====================================================================================
// MAIN
#define DEBUG_MODE_FULL

#include "script_component.hpp"
if (GVAR(ENABLED)) then {
	private ["_sidepatient","_sidemedic","_patienttype","_medicweapon","_medictype","_distance","_datetime","_factionmedic","_factionpatient","_data","_patientPos","_medicPos","_server","_realtime","_medic","_patient"];
	
	diag_log format["handledamage = %1",_this];
	// Set Data 
	_patient = _this select 0;
	_medic = _this select 1;
	
	if ((isPlayer _patient) || (isPlayer _medic)) then {
		
		_sidepatient = side (group _patient); // group side is more reliable
		_sidemedic = side _medic;
		
		_factionmedic = getText (configFile >> "cfgFactionClasses" >> (faction _medic) >> "displayName"); 
		_factionpatient = getText (configFile >> "cfgFactionClasses" >> (faction _patient) >> "displayName"); 
		
		_patienttype = getText (configFile >> "cfgVehicles" >> (typeof _patient) >> "displayName");
		_medictype = getText (configFile >> "cfgVehicles" >> (typeof _medic) >> "displayName");
				
		_patientPos = mapgridposition _patient;
		_medicPos = mapgridposition _medic;
		
		// Log data
		_data = [ ["Event","Heal"] , ["patientSide",_sidepatient] , ["patientfaction",_factionpatient] , ["patientType",_patientType] , ["patientPos",_patientPos] , ["medicSide",_sidemedic] , ["medicfaction",_factionmedic] , ["medicType",_medicType] , ["medicPos",_medicPos] , ["patient", _patient] , ["medic",_medic] ];
	
		if (isPlayer _patient) then { // Player was patient
			
				_data = _data + [ ["Player",getplayeruid _patient] , ["PlayerName",name _patient] ];
				
				// Send data to server to be written to DB
				GVAR(UPDATE_EVENTS) = _data;
				publicVariableServer QGVAR(UPDATE_EVENTS);

		};
		
		if (isPlayer _medic) then {
			
				_data = _data + [ ["Medic","true"] , ["Player",getplayeruid _medic] , ["PlayerName",name _medic] ];
				
				// Send data to server to be written to DB
				GVAR(UPDATE_EVENTS) = _data;
				publicVariableServer QGVAR(UPDATE_EVENTS);

		};
					
	};
};
// ====================================================================================