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
onPlayerDisconnected {

	TRACE_1("OPD DATA",_this);

	// Stats module onPlayerDisconnected call
	[_id, _name, _uid] call ALIVE_fnc_stats_onPlayerDisconnected;

	// sys_player module onPlayerDisconnected call
	[_id, _name, _uid] call ALIVE_fnc_player_onPlayerDisconnected;

	// Data module onPlayerDisconnected call
	[_id, _name, _uid] call ALIVE_fnc_data_onPlayerDisconnected;

};

onPlayerConnected {

	TRACE_1("OPC DATA",_this);

	// Stats module onPlayerConnected call
	[_id, _name, _uid] call ALIVE_fnc_stats_onPlayerConnected;

	// sys_player module onPlayerConnected call
	[_id, _name, _uid] call ALIVE_fnc_player_onPlayerConnected;

};

