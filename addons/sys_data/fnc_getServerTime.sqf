#include "script_component.hpp"	
SCRIPT(getServerTime);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_getServerTime

Description:
Gets the current server local time via arma2net plugins

Parameters:
None

Returns:
String - Returns the server local time

Examples:
(begin example)
 _serverTime = [] call ALIVE_fnc_getServerTime
(end)

Author:
Tupolov
Peer Reviewed:

---------------------------------------------------------------------------- */
private ["_response"];

_response = ["DateTime ['utcnow','dd/MM/yyyy HH:mm:ss']"] call ALIVE_fnc_sendToPlugIn;

_response = call compile _response;

_response;
