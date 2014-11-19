#include <\x\alive\addons\mil_IED\script_component.hpp>
SCRIPT(createVBIED);


private ["_IEDskins","_IED","_trg","_vehicle","_debug"];
_debug = MOD(mil_ied) getVariable ["debug", false];
_vehicle = _this select 0;
_radio = _this select 1;

// create IED object and attach to vehicle
//_IEDskins = ["Land_IED_v1_PMC","Land_IED_v2_PMC","Land_IED_v3_PMC","Land_IED_v4_PMC"];

_IEDskins = ["IEDUrbanSmall_Remote_Ammo","IEDLandSmall_Remote_Ammo"];

_IED = createVehicle [_IEDskins select (floor (random (count _IEDskins))),getposATL _vehicle, [], 0, "CAN_COLLIDE"];
_IED attachTo [_vehicle,[0,0,-0.5]];

if (_debug) then {
	private ["_vbiedm","_t"];
	_t = format["vbied_r%1", floor (random 1000)];
	_vbiedm = [_t, getposATL _vehicle, "Icon", [0.5,0.5], "TYPE:", "Warning", "COLOR:", "ColorRed", "GLOBAL"] call CBA_fnc_createMarker;
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
_booby = [_IED, typeOf _vehicle, "Sh_125_HE"] call ALIVE_fnc_armIED;
waitUntil {sleep 1; scriptDone _booby};
if (_debug) then {
	diag_log format ["ALIVE-%1 IED: Creating VB-IED for %2 at %3", time, typeof _vehicle, getposATL _vehicle];
};