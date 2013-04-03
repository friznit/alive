#include "script_component.hpp"

//https://dev-heaven.net/projects/cca/wiki/Extended_Eventhandlers#New-in-19-version-stringtable-and-pre-init-EH-code

// https://dev-heaven.net/projects/cca/wiki/Extended_Eventhandlers#New-in-200-Support-for-ArmA-II-serverInit-and-clientInit-entries

LOG(MSG_INIT);

ADDON = false;

if (isDedicated) then {
	// Add stuff here
	GVAR(serverIP) = "Arma2Net.Unmanaged" callExtension "ServerAddress";

	// Server side handler to write data to DB
	QGVAR(UPDATE_EVENTS) addPublicVariableEventHandler { 

					private ["_data", "_post", "_result", "_gameTime", "_realTime","_hours","_minutes","_currenttime"];
						
					_data = _this select 1;
					
					// Get local time and format please.
					_currenttime = date;

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
					
					_realtime = "Arma2Net.Unmanaged" callExtension "DateTime ['utcnow',]";
					
					_data = format["""realTime"":%1 ,  ""Server"":""%2"" , ""Operation"":""%3"" , ""Map"":""%4"" , ""gameTime"":""%5"" , ", _realtime, GVAR(serverIP), missionName, worldName, _gametime] + _data;
			
					// Write event data to DB
					_post = format ["SendJSON [""POST"", ""events"", ""{%1}""]", _data];
					_result = "Arma2Net.Unmanaged" callExtension _post;
					
					diag_log _data;
					diag_log _result;
	};
};
ADDON = true;
