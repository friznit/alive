#include "script_component.hpp"
SCRIPT(sendToPlugIn);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_sendToPlugInAsync

Description:
Sends valid commands and data to arma2net plugins using an Async function. Sends the command to the ASYNC_QUEUE to be handled.

Parameters:
String - Text to be sent to external source

Returns:
String

Examples:
(begin example)
 ["ARMA2NetMySQLCommand ['arma','SELECT * FROM missions'] "] call ALIVE_fnc_sendToPlugInAsync
(end)
(begin example)
 ["SendJSON ['http://msostore.iriscouch.com','POST','missions','{'key':'value'}'] "] call ALIVE_fnc_sendToPlugInAsync
(end)

Author:
Tupolov
Peer Reviewed:

---------------------------------------------------------------------------- */
private ["_cmd","_response","_resp"];
PARAMS_1(_cmd);

// Send command to the async call handler (PVEH)
if (([_cmd] call CBA_fnc_strLen) < 10000) then {
	// update the async queue, send back response immediately
	GVAR(ASYNC_QUEUE) = GVAR(ASYNC_QUEUE) + [_cmd];
	publicVariableServer QGVAR(ASYNC_QUEUE);
	_response = "SENT";
} else{
	format["SendToPlugInAsync - Output is greater than 10kb - NOT sending: %1", _cmd] call ALIVE_fnc_logger;
	_response = "ERROR";
};

_response;
