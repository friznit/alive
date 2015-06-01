#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(exportMapWarRoom);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_exportMapWarRoom

Description:
Sends map to War Room for auto creation of tiles. Requires that you grab the map in EMF using LEFT SHIFT-Num Pad Minus key, then type topography and access the map in game.

Parameters:
String - username
String - password
Bool - debug

Returns:
String - Result

Examples:
(begin example)
_success = ["username","password",false] call ALiVE_fnc_exportMapWarRoom;
(end)

See Also:
- nil

Author:
Tupolov

Peer reviewed:
nil
---------------------------------------------------------------------------- */

private ["_ret"];

if (isDedicated) exitWith {};

_ret = [_this select 0, _this select 1, _this select 2] spawn {

	PARAMS_3(_user,_pwd,_debug);

	private ["_result"];

	_result = "INCOMPLETE";

	_result = "ALiVEClient" callExtension format["SendMap~C:\%1.emf,%2,%3", worldName, _user, _pwd];

	hint _result;

	if (_result == "FILE DOES NOT EXIST") exitWith {_result = "File does not exist";};

	waitUntil {
		sleep 1;
		_result = "ALiVEClient" callExtension "getUploadProgress~0";
		hint _result;
		if (_debug) then {
			diag_log _result;
		};

		_result == "FINISHED" ||  _result == "INCOMPLETE" || _result == "UNKNOWN";
	};

	_result
};

_ret