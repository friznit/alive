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
		_data = format["""Event"":""Heal"" , ""patientSide"":""%1"" , ""patientfaction"":""%2"" , ""patientType"":""%3"" ,""patientPos"":""%4"" , ""medicSide"":""%5"" , ""medicfaction"":""%6"" , ""medicType"":""%7"" , ""medicPos"":""%8"" , ""patient"":""%9"" , ""medic"":""%10""", _sidepatient, _factionpatient, _patientType, _patientPos, _sidemedic, _factionmedic, _medicType, _medicPos, _patient, _medic];
	
		if (isPlayer _patient) then { // Player was patient
			
				_data = _data + format[" , ""Player"":""%1"" , ""PlayerName"":""%2""", getplayeruid _patient, name _patient];
				
				// Send data to server to be written to DB
				ALIVE_SYS_STAT_UPDATE_EVENTS = _data;
				publicVariableServer "ALIVE_SYS_STAT_UPDATE_EVENTS";

		};
		
		if (isPlayer _medic) then {
			
				_data = _data + format[" , ""Medic"":""true"" , ""Player"":""%1"" , ""PlayerName"":""%2""", getplayeruid _medic, name _medic];
				
				// Send data to server to be written to DB
				ALIVE_SYS_STAT_UPDATE_EVENTS = _data;
				publicVariableServer "ALIVE_SYS_STAT_UPDATE_EVENTS";

		};
					
	};
};
// ====================================================================================