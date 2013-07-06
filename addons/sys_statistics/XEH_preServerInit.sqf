#include "script_component.hpp"

//https://dev-heaven.net/projects/cca/wiki/Extended_Eventhandlers#New-in-19-version-stringtable-and-pre-init-EH-code

// https://dev-heaven.net/projects/cca/wiki/Extended_Eventhandlers#New-in-200-Support-for-ArmA-II-serverInit-and-clientInit-entries

LOG(MSG_INIT);

ADDON = false;

if (!isDedicated) then {
	GVAR(ENABLED) = false;
	publicVariable QGVAR(ENABLED);
};

if (GVAR(ENABLED)) then {
	
	// Setup data handler
	GVAR(datahandler) = [nil, "create"] call ALIVE_fnc_Data;
	[GVAR(datahandler),"source","couchdb"] call ALIVE_fnc_Data; //maybe chosen by mission maker via module params
	[GVAR(datahandler),"databaseName","arma3live"] call ALIVE_fnc_Data; // maybe chosen by mission maker via module params
	[GVAR(datahandler),"storeType",false] call ALIVE_fnc_Data;
	
	// Grab Server IP
	GVAR(serverIP) = [] call ALIVE_fnc_getServerIP;
	GVAR(serverName) = [] call ALIVE_fnc_getServerName;

	// If the host IP web service is down, just use the serverName
	if (GVAR(serverIP) == "ERROR") then {
		GVAR(serverIP) = GVAR(serverName);
	};
	
	// Try getting the actual MP hostname of server
	//GVAR(serverhostname) = ["ServerHostName"] call ALIVE_fnc_sendToPlugIn;
	//diag_log GVAR(serverhostname);

	// Setup Module Data Listener
	// Server side handler to write data to DB
	QGVAR(UPDATE_EVENTS) addPublicVariableEventHandler { 

					private ["_data", "_post", "_gameTime", "_realTime","_hours","_minutes","_currenttime","_returnUID"];
					if (GVAR(ENABLED)) then {
						_data = _this select 1;
						_module = "events";
						
						// Check data passed is an array
						ASSERT_TRUE(typeName _data == "ARRAY", _data);
						
						// Get server/date/time/operation/map specific information to prefix to event data
						
						// Get local time and format please.
						_currenttime = date;

						// Work out time in 4 digits
						if ((_currenttime select 4) < 10) then {
							_minutes = "0" + str(_currenttime select 4);
						} else {
							_minutes = str(_currenttime select 4);
							};
						if ((_currenttime select 3) < 10) then {
							_hours = "0" + str(_currenttime select 3);
						} else {
							_hours = str(_currenttime select 3);
						};

						_gametime = format["%1%2", _hours, _minutes];		
						_realtime = [] call ALIVE_fnc_getServerTime;
						
						// _data should be an array of key/value			
						_data = [ ["realTime",_realtime],["Server",GVAR(serverIP)],["Operation",GVAR(operation)],["Map",worldName],["gameTime",_gametime] ] + _data;
										
						// Write event data to DB
						if ((_data select 5) select 1 == "OperationFinish") then {
							_returnUID = true;
						} else {
							_returnUID = false;
						};
						_result = [GVAR(datahandler), "write", [_module, _data, _returnUID] ] call ALIVE_fnc_Data;
						if (_result == "ERROR") then {
							ERROR("SYS STATISTICS FAILED TO WRITE TO DATABASE");
						};
						TRACE_2("UPDATE EVENTS",_data,_result);
						_result;

						
					};
	};
};
ADDON = true;
