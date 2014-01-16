#include "script_component.hpp"
SCRIPT(sendToPlugIn);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_sendToPlugIn

Description:
Sends valid commands and data to arma2net plugins

Parameters:
String - Text to be sent to external source

Returns:
String - Returns a response error

Examples:
(begin example)
 ["ARMA2NetMySQLCommand ['arma','SELECT * FROM missions'] "] call ALIVE_fnc_sendToPlugIn
(end)
(begin example)
 ["SendJSON ['http://msostore.iriscouch.com','POST','missions','{'key':'value'}'] "] call ALIVE_fnc_sendToPlugIn
(end)

Author:
Tupolov
Peer Reviewed:
Wolffy.au 24 Oct 2012
---------------------------------------------------------------------------- */
private ["_cmd","_response","_resp"];
PARAMS_1(_cmd);

if (([_cmd] call CBA_fnc_strLen) < 16000) then {
	_response = "Arma2Net" callExtension _cmd;
	TRACE_1("SEND TO PLUGIN: ", _response);
} else{
	format["SendToPlugIn - Output is greater than 16kb - NOT sending: %1", _cmd] call ALIVE_fnc_logger;
	_response = "String was greater than 16kb";
};

if (typeName _response == "ARRAY") then {
	_response = _response select 0;
};

// Need to check for errors here
if ([_response, "throw"] call CBA_fnc_find != -1) then {
	_response = "ERROR";
};

_response;
