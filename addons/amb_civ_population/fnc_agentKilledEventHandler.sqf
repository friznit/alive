#include <\x\alive\addons\amb_civ_population\script_component.hpp>
SCRIPT(agentKilledEventHandler);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_agentKilledEventHandler

Description:
Killed event handler for agent units

Parameters:

Returns:

Examples:
(begin example)
_eventID = _agent addEventHandler["Killed", ALIVE_fnc_agentKilledEventHandler];
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */
private ["_unit","_agentID","_agent","_position","_faction","_event","_eventID"];
	
_unit = _this select 0;

_agentID = _unit getVariable "agentID";
_agent = [ALIVE_agentHandler, "getAgent", _agentID] call ALIVE_fnc_agentHandler;

if (isnil "_agent") exitwith {};

[_agent, "handleDeath"] call ALIVE_fnc_civilianAgent;

[ALIVE_agentHandler, "unregisterAgent", _agent] call ALIVE_fnc_agentHandler;

// log event

_position = getPosASL _unit;
_faction = _agent select 2 select 7;

_event = ['AGENT_KILLED', [_position,_faction],"Agent"] call ALIVE_fnc_event;
_eventID = [ALIVE_eventLog, "addEvent",_event] call ALIVE_fnc_eventLog;