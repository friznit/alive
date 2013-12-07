#include <\x\alive\addons\sys_weather\script_component.hpp>
SCRIPT(getWeather);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_getWeather
Description:
Gets real weather for a time and location, returns a CBA_HASH of weather observations for the day

Parameters:
_this select 0: STRING - Date in YYYYMMDD format
_this select 1: STRING - Location either as COUNTRY/CITY or LON,LAT

Returns:
CBA_HASH - Weather conditions

Examples:
(begin example)
// get london weather
_weather = ["England/London"] call ALIVE_fnc_getWeather;
(end)

See Also:
- <ALIVE_fnc_weather>

Author:
Tuplov
Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_date","_location","_cmd","_result"];

PARAMS_1(_location);

// Check param
// TO DO

_date = date;

_year = "2012";
_i = 0;
{
	if (_x < 10) then {
		_date set [_i, "0" + str(_x)];
	} else {
		_date set [_i, _x];
	};
	_i = _i + 1;
} foreach _date;


// Create function call
_cmd = format ["GetWeather [""%1"",""%2"",""%3"",""%4"",""%5""]", _year, _date select 1, _date select 2, _date select 3, _location];

diag_log format ["cmd: %1",_cmd];

// Send command to plugin
_response = [_cmd] call ALIVE_fnc_sendToPlugin;

diag_log format ["JSON: %1",_response];

// Check response for error
// TO DO

// Parse correct response
_result = [_response] call ALIVE_fnc_parseJSON;

_result;