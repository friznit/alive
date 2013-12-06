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
_weather = ["20131202", "England/London"] call ALIVE_fnc_getWeather;
(end)

See Also:
- <ALIVE_fnc_weather>

Author:
Tuplov
Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_date","_location","_cmd","_result"];

PARAMS_2(_date,_location);

// Check params
// TO DO

// Create function call
_cmd = format ["GetWeather [""%1"", ""%2""]", _date, _location];

// Send command to plugin
_response = [_cmd] call ALIVE_fnc_sendToPlugin;

// Check response for error
// TO DO

// Parse correct response
_result = [_response] call ALIVE_fnc_parseJSON;

_result;