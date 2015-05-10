#include <\x\alive\addons\sys_player\script_component.hpp>
SCRIPT(autoStorePlayer);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_autoStorePlayer
Description:
Save all player data to a server side store, DB save optional

Parameters:
Array - The selected parameters

Returns:
Nothing

Examples:
(begin example)
	    [ALiVE_fnc_autoSavePlayer, DEFAULT_INTERVAL, [DEFAULT_INTERVAL]] call CBA_fnc_addPerFrameHandler;
(end)

See Also:
- <ALIVE_fnc_player>

Author:
Tupolov

Peer reviewed:
nil
---------------------------------------------------------------------------- */

private ["_check","_autoSaveTime","_lastDBSaveTime","_params","_delay"];

_params = _this select 0;
_delay = _params select 0;
_lastSaveTime = diag_tickTime;

MOD(sys_player) setVariable ["lastDBSaveTime",_lastSaveTime, true];

// Regularly store the player state to a server store and/or DB
// By default Every 5 minutes store player data in memory
if (diag_tickTime >= (_lastSaveTime + _delay)) then {
	{
		[MOD(sys_player), "setPlayer", [_x]] call ALiVE_fnc_player;
	} foreach playableUnits;
	_lastSaveTime = diag_tickTime;
};

// If auto save interval is defined and ext db is enabled, then save to external db
_check = MOD(sys_player) getvariable ["storeToDB", false];
_autoSaveTime = MOD(sys_player) getVariable ["autoSaveTime",0];
_lastDBSaveTime = MOD(sys_player) getVariable ["lastDBSaveTime",0];
TRACE_3("Checking auto save", _check, _autoSaveTime,  _lastDBSaveTime);

if ( _autoSaveTime > 0 && _check && (diag_tickTime >= (_lastDBSaveTime + _autoSaveTime)) && (!isNil "ALIVE_sys_data" && {!ALIVE_sys_data_DISABLED}) ) then {
	// Save player data to external db
    TRACE_3("Saving players to DB", diag_tickTime, (_lastDBSaveTime + _autoSaveTime), _check);
	[MOD(sys_player), "savePlayers", [false]] call ALiVE_fnc_player;
    MOD(sys_player) setVariable ["lastDBSaveTime",diag_tickTime, true];
};

 TRACE_4("SYS_PLAYER3", typename (MOD(sys_player) getvariable "allowReset"), MOD(sys_player) getvariable "allowDiffClass",MOD(sys_player) getvariable "allowManualSave",MOD(sys_player) getvariable "storeToDB" );
