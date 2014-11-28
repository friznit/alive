#include <\x\alive\addons\mil_IED\script_component.hpp>
SCRIPT(armIED);

// Create trigger for IED detonation
private ["_IED","_trg","_type","_shell","_proximity","_debug"];

if !(isServer) exitWith {diag_log "ArmIED Not running on server!";};
_debug = MOD(mil_ied) getVariable ["debug", 0];

_IED = _this select 0;
_type = _this select 1;

if (count _this > 2) then {
	_shell = _this select 2;
} else {
	_shell = [["M_Mo_120mm_AT","M_Mo_120mm_AT_LG","M_Mo_82mm_AT_LG","R_60mm_HE","Bomb_04_F","Bomb_03_F"],[4,8,2,1,1,1]] call BIS_fnc_selectRandomWeighted;
};

_proximity = 2 + floor(random 10);

if (_debug) then {
	private "_iedm";
	diag_log format ["ALIVE-%1 IED: arming IED at %2 of %3 as %4 with proximity of %5",time, getposATL _IED,_type,_shell,_proximity];
	//Mark IED position
	_t = format["ied_r%1", floor (random 1000)];
	_iedm = [_t, position _IED, "Icon", [1,1], "TEXT:", "IED", "TYPE:", "mil_dot", "COLOR:", "ColorRed", "GLOBAL"] call CBA_fnc_createMarker;
	_IED setvariable ["Marker", _iedm];
};

// Add Action to IED for disarmm
_IED addAction ["<t color='#ff0000'>Disarm IED</t>",ALiVE_fnc_disarmIED, "", 6, false, true,"", "_target distance _this < 3"];


// Create Detonation Trigger
_trg = createTrigger["EmptyDetector", getposATL _IED];
_trg setTriggerArea[_proximity,_proximity,0,false];
_trg setTriggerActivation["WEST","PRESENT",false];
_trg setTriggerStatements["this && ({(vehicle _x in thisList) && ((getposATL  vehicle _x) select 2 < 8) && !('MineDetector' in (items _x)) && (getText (configFile >> 'cfgVehicles' >> typeof _x >> 'displayName') != 'Explosive Specialist') && ([vehicleVarName _x,'EOD'] call CBA_fnc_find == -1)} count ([] call BIS_fnc_listPlayers) > 0)", format["_bomb = nearestObject [getposATL (thisTrigger), '%1']; deletevehicle (_bomb getvariable 'Detect_Trigger'); deletevehicle (_bomb getvariable 'Det_Trigger'); boom = '%2' createVehicle getposATL _bomb; deletevehicle _bomb;",_type,_shell], ""];

_IED setvariable ["Trigger", _trg];

if !(typeof _IED == _type) then {
	// Attach trigger to moving vehicle/person
	_trg attachTo [_IED,[0,0,-0.5]];
};

// Create Detection Trigger - if Engineer or person with Minedetector gets near IED
_trg = createTrigger["EmptyDetector", getposATL _IED];
_trg setTriggerArea[_proximity+5,_proximity+5,0,false];
_trg setTriggerActivation["WEST","PRESENT",true];
_trg setTriggerStatements["this && ({(vehicle _x in thisList) && ((getposATL  vehicle _x) select 2 < 8) && (('MineDetector' in (items _x)) || (getText (configFile >> 'cfgVehicles' >> typeof _x >> 'displayName') == 'Explosive Specialist') || ([vehicleVarName _x,'EOD'] call CBA_fnc_find != -1))} count ([] call BIS_fnc_listPlayers) > 0)", format["_bomb = nearestObject [getposATL (thisTrigger), '%1']; [_bomb, %2, thislist] call ALiVE_fnc_detectIED", _type, _proximity], ""];

_IED setvariable ["Detect_Trigger", _trg];

if !(typeof _IED == _type) then {
	// Attach trigger to moving vehicle/person
	_trg attachTo [_IED,[0,0,-0.5]];
};

// Create Disarm Detonation Trigger - if Engineer or person with Minedetector step on IED
_trg = createTrigger["EmptyDetector", getposATL _IED];
_trg setTriggerArea[1,1,0,false];
_trg setTriggerActivation["WEST","PRESENT",false];
_trg setTriggerStatements["this && ({(vehicle _x in thisList) && ((getposATL  vehicle _x) select 2 < 8)} count ([] call BIS_fnc_listPlayers) > 0)", format["_bomb = nearestObject [getposATL (thisTrigger), '%1']; deletevehicle (_bomb getvariable 'Detect_Trigger'); deletevehicle (_bomb getvariable 'Trigger'); boom = '%2' createVehicle getposATL _bomb; deletevehicle _bomb;",_type,_shell], ""];

_IED setvariable ["Det_Trigger", _trg];

if !(typeof _IED == _type) then {
	// Attach trigger to moving vehicle/person
	_trg attachTo [_IED,[0,0,-0.5]];
};