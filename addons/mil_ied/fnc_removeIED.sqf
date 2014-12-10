#include <\x\alive\addons\mil_ied\script_component.hpp>
SCRIPT(removeIED);

// Remove IED
private ["_IEDs","_town","_position","_size","_j","_nodel","_debug"];

_debug = ADDON getVariable ["debug", 0];

if !(isServer) exitWith {diag_log "RemoveIED Not running on server!";};

_position = _this select 0;
_town = _this select 1;

_IEDs = [[GVAR(STORE), "IEDs"] call ALiVE_fnc_hashGet, _town] call ALiVE_fnc_hashGet;

_removeIED = {
	private ["_IED","_IEDObj","_IEDCharge","_IEDskin","_IEDpos","_trgr"];
	_IEDpos = [_value, "IEDpos", [0,0,0]] call ALiVE_fnc_hashGet;
	_IEDskin = [_value, "IEDskin", "ALIVE_IEDUrbanSmall_Remote_Ammo"] call ALiVE_fnc_hashGet;

	// Delete Objects
	_IEDObj = (_IEDpos nearObjects [_IEDskin, 5]) select 0;

	if (isNil "_IEDObj") then {
		diag_log "IED NOT FOUND";
	};
	_IEDCharge = _IEDobj getVariable ["charge", nil];

	// Delete Triggers
	_trgr = (position _IEDObj) nearObjects ["EmptyDetector", 3];
	{
		deleteVehicle _x;
	} foreach _trgr;

	deleteVehicle _IEDCharge;
	deleteVehicle _IEDObj;

	if (_debug) then {
		[_IEDObj getvariable "Marker"] call cba_fnc_deleteEntity;
	};
};

[_IEDs, _removeIED] call CBA_fnc_hashEachPair;