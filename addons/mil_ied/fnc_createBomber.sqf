#include <\x\alive\addons\mil_IED\script_component.hpp>
SCRIPT(createBomber);

// Suicide Bomber - create Suicide Bomber at location
private ["_location","_debug","_victim","_size","_faction","_bomber"];

if !(isServer) exitWith {diag_log "Suicide Bomber Not running on server!";};

_victim = objNull;

if (typeName (_this select 0) == "ARRAY") then {
	_location = (_this select 0) select 0;
	_size = (_this select 0) select 1;
	_faction = (_this select 0) select 2;
} else {
	_bomber = _this select 0;
};

_victim = (_this select 1) select 0;

_debug = MOD(mil_ied) getVariable ["debug", false];

if(isnil "_debug") then {_debug = false};

// Create suicide bomber
private ["_grp","_side","_pos","_time","_marker","_class","_btype"];
if (isNil "_bomber") then {
	_pos = [_location, 0, _size - 10, 3, 0, 0, 0] call BIS_fnc_findSafePos;
	_side = _faction call ALiVE_fnc_factionSide;
	_grp = createGroup _side;
	_btype = MOD(mil_ied) getVariable ["Bomber_Type", ""];
	if ( isNil "_btype" || _btype == "") then {
		_class = ([[_faction], 1, [], false] call ALiVE_fnc_chooseRandomUnits) select 0;
		if (isNil "_class") then {
			_class = ([[_faction], 1, [], true] call ALiVE_fnc_chooseRandomUnits) select 0;
		};
	} else {
		_class = (call compile (MOD(mil_ied) getVariable "Bomber_Type")) call BIS_fnc_selectRandom;
	};
	if (isNil "_class") exitWith {diag_log "No bomber class defined."};
	_bomber = _grp createUnit [_class, _pos, [], _size, "NONE"];
};

if (isNil "_bomber") exitWith {};

if (surfaceIsWater _pos) exitWith {	deletevehicle _bomber;};


// Add explosive
_bomber addweapon "ItemRadio";

// Select victim
_victim = units (group _victim) call BIS_fnc_selectRandom;
if (isNil "_victim") exitWith {	deletevehicle _bomber;};

// Add debug marker
if (_debug) then {
	diag_log format ["ALIVE-%1 Suicide Bomber: created at %2 going after %3", time, _pos, name _victim];
	_marker = [format ["suic_%1", random 1000], _pos, "Icon", [1,1], "TEXT:", "Suicide", "TYPE:", "mil_dot", "COLOR:", "ColorRed", "GLOBAL"] call CBA_fnc_createMarker;
	[_marker,_bomber] spawn {
		_marker = _this select 0;
		_bomber = _this select 1;
		while {alive _bomber} do {
			_marker setmarkerpos position _bomber;
			sleep 0.1;
		};
		[_marker] call CBA_fnc_deleteEntity;
	};
} else {
	_marker = "";
};





[_victim,_bomber,_debug, _marker] spawn {

	private["_victim","_bomber","_debug","_marker","_shell"];

	_victim = _this select 0;
	_bomber = _this select 1;
	_debug = _this select 2;
	_marker = _this select 3;

	sleep (random 60);

	// Have bomber go after victim for up to 10 minutes
	_time = time + 600;
	waitUntil {
		if (!isNil "_victim") then {
			_bomber doMove getposATL _victim;
		};
		sleep 2;
		!(alive _victim) || (isNil "_victim") || (_bomber distance _victim < 8) || (time > _time) || !(alive _bomber)
	};

	if (!(alive _victim) || isNil "_victim") exitWith {	deletevehicle _bomber;};

	// Blow up bomber
	if ((_bomber distance _victim < 8) && (alive _bomber)) then {
		_bomber addRating -2001;
		[_bomber, "Alive_Beep", 50] call CBA_fnc_globalSay3d;
		_bomber playMoveNow "AmovPercMstpSsurWnonDnon";
		sleep 5;
		_bomber disableAI "ANIM";
		_bomber disableAI "MOVE";
		diag_log format ["BANG! Suicide Bomber %1", _bomber];
		_shell = [["M_Mo_120mm_AT","M_Mo_120mm_AT_LG","M_Mo_82mm_AT_LG","R_60mm_HE","Bomb_04_F","Bomb_03_F"],[8,4,2,1,1,1]] call BIS_fnc_selectRandomWeighted;
		_shell createVehicle (getposATL _bomber);
		sleep 0.3;
		deletevehicle _bomber;
	} else {
		sleep 1;
		if (_debug) then {
			diag_log format ["Deleting Suicide Bomber %1 as out of time or dead.", _bomber];
			[_marker] call CBA_fnc_deleteEntity;
		};
		_shell = [["M_Mo_120mm_AT","M_Mo_120mm_AT_LG","M_Mo_82mm_AT_LG","R_60mm_HE","Bomb_04_F","Bomb_03_F"],[8,4,2,1,1,1]] call BIS_fnc_selectRandomWeighted;
		_shell createVehicle (getposATL _bomber);
		sleep 0.3;
		deletevehicle _bomber;
	};
};
