#include "script_component.hpp"

//https://dev-heaven.net/projects/cca/wiki/Extended_Eventhandlers#New-in-19-version-stringtable-and-pre-init-EH-code

// https://dev-heaven.net/projects/cca/wiki/Extended_Eventhandlers#New-in-200-Support-for-ArmA-II-serverInit-and-clientInit-entries

LOG(MSG_INIT);

ADDON = false;

// Spawn a process to handle async writes

// loop and wait for queue to be updated
// When queue changes process request, wait for response
GVAR(ASYNC_QUEUE) = [];
publicVariable QGVAR(ASYNC_QUEUE);

[] spawn {
	while {true} do {
		TRACE_1("ASYNC QUEUE COUNT", count GVAR(ASYNC_QUEUE));
		{
			private ["_cmd","_response"];
			_cmd = _x;
			
			"Arma2Net.Unmanaged" callExtension _cmd;
			
			waitUntil {sleep 0.3; _response = ["SendJSONAsync []"] call ALIVE_fnc_sendToPlugIn; ([_response] call CBA_fnc_strLen) > 0};
			
			REM(GVAR(ASYNC_QUEUE),_cmd);
			
			TRACE_3("ASYNC WRITE LOOP", _cmd, _response, count GVAR(ASYNC_QUEUE));
			
			sleep 0.3;
			
		} foreach GVAR(ASYNC_QUEUE);
		sleep 5;
	};
};
					
ADDON = true;
