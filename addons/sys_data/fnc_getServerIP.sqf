#include "script_component.hpp"	
SCRIPT(getServerIP);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_getServerIP

Description:
Gets the current server IP address via arma2net plugins

Parameters:
None

Returns:
String - Returns the server IP address

Examples:
(begin example)
 _serverIP = [] call ALIVE_fnc_getServerIP
(end)

Author:
Tupolov
Peer Reviewed:

---------------------------------------------------------------------------- */
private ["_response"];

_response = ["ServerAddress"] call ALIVE_fnc_sendToPlugIn;

_response;
