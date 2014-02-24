#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(getEnvironment);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_getEnvironment
Description:
Gets current environment (day state, time, etc)

Parameters:
Nil

Returns:
Array - Environment settings

Examples:
(begin example)
// Create instance
_env = call ALIVE_fnc_getEnvironment;
(end)

Author:
ARJay

Peer reviewed:
nil
---------------------------------------------------------------------------- */

_date = date;
_dateString = format["%1-%2-%3", _date select 0, _date select 1, _date select 2];

// sunrise sunset is already set
if!(isNil "ALIVE_sunriseSunset") then
{
    // date has changed reset
    if(ALIVE_currentDate != _dateString) then
    {
        ALIVE_sunriseSunset = [_date select 0, _date select 1, _date select 2] call ALIVE_fnc_getSunriseSunset;
    };
}
else
{
    ALIVE_sunriseSunset = [_date select 0, _date select 1, _date select 2] call ALIVE_fnc_getSunriseSunset;
};

ALIVE_currentDate = _dateString;

_hour = _date select 3;
_minute = _date select 4;
_sunSet = ALIVE_sunriseSunset select 1;
_sunSet = _sunSet select 0;
_sunRise = ALIVE_sunriseSunset select 0;
_sunRise = _sunRise select 0;

_dayState = "DAY";

if(_hour <= _sunRise) then
{
    _dayState = "NIGHT";
};

if(_hour > _sunSet) then
{
    _dayState = "EVENING";
};

ALIVE_currentEnvironment = [_dayState, _hour, _minute];

ALIVE_currentEnvironment