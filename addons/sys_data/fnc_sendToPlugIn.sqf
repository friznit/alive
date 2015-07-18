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

//if ([_cmd, "SendJSONAsync"] call CBA_fnc_find != -1) then {
//	_response = "Arma2Net.Unmanaged" callExtension _cmd;
//} else {
	_response = "ALiVEPlugIn" callExtension _cmd;
	_response = call compile _response;
//};

TRACE_1("SEND TO PLUGIN: ", _response);


if (typeName _response == "ARRAY") then {
	_response = _response select 0;
};



// Need to check for errors here with new plugin grab 2nd and 3rd array values.
if ([_response, "throw"] call CBA_fnc_find != -1 || [_response, "error"] call CBA_fnc_find != -1) then {

	_response = "SYS_DATA_ERROR";
};

_response;
