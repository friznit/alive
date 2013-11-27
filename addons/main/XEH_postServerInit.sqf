#include "script_component.hpp"

// Handles all OnXXX calls that can't be stacked
/*
onBriefingGroup
onBriefingNotes
onBriefingPlan
onBriefingTeamSwitch
onCommandModeChanged
onDoubleClick
onEachFrame
onGroupIconClick
onGroupIconOverEnter
onGroupIconOverLeave
onHCGroupSelectionChanged
onMapSingleClick
onPlayerConnected
onPlayerDisconnected
onPreloadFinished
onPreloadStarted
onShowNewObject
onTeamSwitch
*/

// Setup player disconnection eventhandler

// Deprecated due to new BIS_fnc_addStackedEventHandler

// FIXME - what are these here and not in their respective modules?
// Is think you may have misunderstood me when I said we should only have
// one OPD and OPC for all of ALIVE.
onPlayerDisconnected {

	TRACE_1("OPD DATA",_this);

	if !(isNil QMOD(sys_statistics)) then {
		// Stats module onPlayerDisconnected call
		[_id, _name, _uid] call ALIVE_fnc_stats_onPlayerDisconnected;
	};

	if !(isNil QMOD(sys_player)) then {
		// sys_player module onPlayerDisconnected call
		[_id, _name, _uid] call ALIVE_fnc_player_onPlayerDisconnected;
	};

	if !(isNil QMOD(sys_perf)) then {
		[_id, _name, _uid] call ALIVE_fnc_perf_onPlayerDisconnected;
	};

	if !(isNil QMOD(sys_data)) then {
		// Data module onPlayerDisconnected call
		[_id, _name, _uid] call ALIVE_fnc_data_onPlayerDisconnected;
	};
};

onPlayerConnected {

	TRACE_1("OPC DATA",_this);

	if !(isNil QMOD(sys_statistics)) then {
		// Stats module onPlayerConnected call
		[_id, _name, _uid] call ALIVE_fnc_stats_onPlayerConnected;
	};

	if !(isNil QMOD(sys_player)) then {
		// sys_player module onPlayerConnected call
		[_id, _name, _uid] call ALIVE_fnc_player_onPlayerConnected;
	};
};

