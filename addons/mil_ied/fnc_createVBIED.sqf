#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_ied
#define DEFAULT_VB_IED_THREAT 5
#define DEFAULT_VBIED_SIDE "CIV"
#include <\x\alive\addons\mil_IED\script_component.hpp>
SCRIPT(createVBIED);

private ["_IEDskins","_IED","_trg","_vehicle","_debug","_threat","_side"];

if (isNil QUOTE(ADDON)) exitWith {};

_debug = ADDON getVariable ["debug", false];
_threat = ADDON getvariable ["VB_IED_Threat", DEFAULT_VB_IED_THREAT];
_side = ADDON getvariable ["VB_IED_Side", DEFAULT_VBIED_SIDE];
_vehicle = (_this select 0) select 0;

_fate = random 100;

if (_debug) then {
	diag_log format ["Threat: %1, Fate: %4, Side: %2, VBIED: %3", _threat, _side, (_vehicle getvariable [QUOTE(ADDON(VBIED)), true]), _fate];
};

if (_fate > _threat || str(side _vehicle) != _side || (_vehicle isKindOf "Quadbike_01_base_F") ) exitWith {};

// Make sure vehicle is not in blacklist

_taor = [MOD(mil_ied), "taor"] call MAINCLASS;
_blacklist = [MOD(mil_ied), "blacklist"] call MAINCLASS;

// check markers for existance
private ["_marker","_counter","_black","_t"];

_black = false;
_t = true;

if(count _blacklist > 0) then {
	{
		_black = [_vehicle, _x] call ALiVE_fnc_inArea;
	} foreach _blacklist;
};

if (_black) exitWith {};

if(count _taor > 0) then {
	{
		_t = [_vehicle, _x] call ALiVE_fnc_inArea;
	} foreach _taor;
};

if !(_t) exitWith {};

// create IED object and attach to vehicle
//_IEDskins = ["Land_IED_v1_PMC","Land_IED_v2_PMC","Land_IED_v3_PMC","Land_IED_v4_PMC"];

_IED = createVehicle ["ALIVE_DemoCharge_Remote_Ammo",getposATL _vehicle, [], 0, "CAN_COLLIDE"];
_IED attachTo [_vehicle, [0,-2,-1.08]];
_IED setDir 270;
_IED setVectorUp [0,0,-1];

if (_debug) then {
	private ["_vbiedm","_t"];
	_t = format["vbied_r%1", floor (random 1000)];
	_vbiedm = [_t, getposATL _vehicle, "Icon", [0.5,0.5], "TYPE:", "mil_dot", "COLOR:", "ColorRed", "GLOBAL"] call CBA_fnc_createMarker;
	[_vbiedm,_vehicle] spawn {
		_vbiedm = _this select 0;
		_vehicle = _this select 1;
		while {alive _vehicle} do {
			_vbiedm  setmarkerpos position _vehicle;
			sleep 0.1;
		};
		[_vbiedm] call CBA_fnc_deleteEntity;
	};
};

// Set up trigger to detonate IED
_booby = [_IED, typeOf _vehicle] call ALIVE_fnc_armIED;

// Add damage handler
_ehID = _IED addeventhandler ["HandleDamage",{
	private "_trgr";
//	diag_log str(_this);

	if (MOD(mil_IED) getVariable "debug") then {
		diag_log format ["ALIVE-%1 IED: %2 explodes due to damage by %3", time, (_this select 0), (_this select 3)];
		[(_this select 0) getvariable "Marker"] call cba_fnc_deleteEntity;
	};

	"M_Mo_120mm_AT" createVehicle getposATL (_this select 0);

	_trgr = (position (_this select 0)) nearObjects ["EmptyDetector", 3];
	{
		deleteVehicle _x;
	} foreach _trgr;

	deletevehicle (_this select 0);
}];

if (_debug) then {
	diag_log format ["ALIVE-%1 IED: Creating VB-IED for %2 at %3", time, typeof _vehicle, getposATL _vehicle];
};