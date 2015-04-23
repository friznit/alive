#include <\x\alive\addons\mil_OPCOM\script_component.hpp>
SCRIPT(OPCOMToggleInstallations);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_OPCOMToggleInstallations
Description:
Toggles installations (not objectives) on / off

Parameters:
None

Returns:
Nothing

Examples:
(begin example)
call ALIVE_fnc_OPCOMToggleInstallations
(end)

See Also:

Author:
Highhead

Peer reviewed:
nil
---------------------------------------------------------------------------- */

if !(isServer) exitWith {[[],"ALIVE_fnc_OPCOMToggleInstallations", false, false] call BIS_fnc_MP};

private ["_enabled","_OPCOM_HANDLER","_objectives","_size","_id"];

_enabled = ADDON getvariable ["installationsShown",false];

{
	_OPCOM_HANDLER = _x;
    
    _objectives = [_OPCOM_HANDLER,"objectives",[]] call ALiVE_fnc_HashGet;
    
    {
        _objective = _x;
        
        _id = [_objective,"objectiveID"] call ALiVE_fnc_HashGet;
        _size = [_objective,"size"] call ALiVE_fnc_HashGet;
	
		_factory = [_OPCOM_HANDLER,"convertObject",[_objective,"factory",[]] call ALiVE_fnc_HashGet] call ALiVE_fnc_OPCOM;
		_HQ = [_OPCOM_HANDLER,"convertObject",[_objective,"HQ",[]] call ALiVE_fnc_HashGet] call ALiVE_fnc_OPCOM;
		_ambush = [_OPCOM_HANDLER,"convertObject",[_objective,"ambush",[]] call ALiVE_fnc_HashGet] call ALiVE_fnc_OPCOM;
		_depot = [_OPCOM_HANDLER,"convertObject",[_objective,"depot",[]] call ALiVE_fnc_HashGet] call ALiVE_fnc_OPCOM;
		_sabotage = [_OPCOM_HANDLER,"convertObject",[_objective,"sabotage",[]] call ALiVE_fnc_HashGet] call ALiVE_fnc_OPCOM;
		_ied = [_OPCOM_HANDLER,"convertObject",[_objective,"ied",[]] call ALiVE_fnc_HashGet] call ALiVE_fnc_OPCOM;
		_suicide = [_OPCOM_HANDLER,"convertObject",[_objective,"suicide",[]] call ALiVE_fnc_HashGet] call ALiVE_fnc_OPCOM;
		_roadblocks = [_OPCOM_HANDLER,"convertObject",[_objective,"roadblocks",[]] call ALiVE_fnc_HashGet] call ALiVE_fnc_OPCOM;
	
		if (alive _HQ && {!_enabled}) then {[format["hq_%1",_id],getposATL _HQ,"ICON", [1,1],"ColorRed","Recruitment HQ", "n_installation", "FDiagonal",0,0.5 ] call ALIVE_fnc_createMarkerGlobal} else {deleteMarker format["hq_%1",_id]};
		if (alive _depot && {!_enabled}) then {[format["depot_%1",_id],getposATL _depot,"ICON", [1,1],"ColorRed","Weapons depot", "n_installation", "FDiagonal",0,0.5 ] call ALIVE_fnc_createMarkerGlobal} else {deleteMarker format["depot_%1",_id]};
		if (alive _factory && {!_enabled}) then {[format["factory_%1",_id],getposATL _factory,"ICON", [1,1],"ColorRed","IED factory", "n_installation", "FDiagonal",0,0.5 ] call ALIVE_fnc_createMarkerGlobal} else {deleteMarker format["factory_%1",_id]};
		if (alive _ambush && {!_enabled}) then {[format["ambush_%1",_id],getposATL _ambush,"ICON", [1,1],"ColorRed","Ambush", "hd_ambush", "FDiagonal",0,0.5 ] call ALIVE_fnc_createMarkerGlobal} else {deleteMarker format["ambush_%1",_id]};
		if (alive _sabotage && {!_enabled}) then {[format["sabotage_%1",_id],getposATL _sabotage,"ICON", [1,1],"ColorRed","Sabotage", "n_installation", "FDiagonal",0,0.5 ] call ALIVE_fnc_createMarkerGlobal} else {deleteMarker format["sabotage_%1",_id]};
		if (alive _ied && {!_enabled}) then {[format["ied_%1",_id],getposATL _ied,"ICON", [_size,_size],"ColorRed","IED", "hd_ambush", "FDiagonal",0,0.5 ] call ALIVE_fnc_createMarkerGlobal} else {deleteMarker format["ied_%1",_id]};
		if (alive _suicide && {!_enabled}) then {[format["suicide_%1",_id],getposATL _suicide,"ELLIPSE", [_size,_size],"ColorRed","Suicidebomber", "n_installation", "FDiagonal",0,0.5 ] call ALIVE_fnc_createMarkerGlobal} else {deleteMarker format["suicide_%1",_id]};
		if (alive _roadblocks&& {!_enabled}) then {[format["roadblocks_%1",_id],getposATL _roadblocks,"ELLIPSE", [_size,_size],"ColorRed","Roadblocks", "n_installation", "FDiagonal",0,0.5 ] call ALIVE_fnc_createMarkerGlobal} else {deleteMarker format["roadblocks_%1",_id]};

	} foreach _objectives;
} foreach OPCOM_instances;

ADDON setvariable ["installationsShown",!_enabled];