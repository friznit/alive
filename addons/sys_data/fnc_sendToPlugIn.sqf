#include <script_macros_core.hpp>
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
private ["_cmd","_response"];
PARAMS_1(_cmd);

if (([_cmd] call CBA_fnc_strLen) < 16000) then {
	_response = "Arma2Net.Unmanaged" callExtension _cmd;
	_response = call compile _response;	
} else{
	format["SendToPlugIn - Output is greater than 16kb - NOT sending: %1", _cmd] call ALIVE_fnc_logger;
	_response = [];
};

if (count _response > 0) then {
	_response = _response select 0;
};

_response;
