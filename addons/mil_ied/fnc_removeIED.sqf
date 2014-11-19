
#define DEFAULT_IED_THREAT 60


#include <\x\alive\addons\mil_ied\script_component.hpp>

SCRIPT(removeIED);

// Remove IED
private ["_ieds","_IEDskins","_location","_size","_IEDplaced","_nodel","_debug"];

_debug = MOD(mil_ied) getVariable ["debug", 0];

if !(isServer) exitWith {diag_log "RemoveIED Not running on server!";};

_location = _this select 0;
_size = _this select 1;
_IEDplaced = round ((_size / 50) * (MOD(mil_ied) getVariable ["IED_Threat", DEFAULT_IED_THREAT] / 100));
_ieds = [];

_IEDskins = ["ALIVE_IEDUrbanSmall_Remote_Ammo","ALIVE_IEDLandSmall_Remote_Ammo","ALIVE_IEDUrbanBig_Remote_Ammo","ALIVE_IEDLandBig_Remote_Ammo","Land_JunkPile_F","Land_GarbageContainer_closed_F","Land_GarbageBags_F","Land_Tyres_F","Land_GarbagePallet_F","Land_Basket_F","Land_Sack_F","Land_Sacks_goods_F","Land_Sacks_heap_F","Land_BarrelTrash_F"];

_ieds = (nearestobjects [_location, _IEDskins, _size]);

_nodel = 0;

for "_j" from 0 to ((count _ieds) -1) do {
	private ["_IED"];
	_IED = _ieds select _j;
	if (count (nearestobjects [ _IED, ["Car"], 4]) == 0) then {
		// delete trigger too
		deletevehicle _IED;
		if (_debug) then {
			[_IED getvariable "Marker"] call cba_fnc_deleteEntity;
		};
	} else {
		_nodel = _nodel + 1;
	};
};


diag_log format ["Deleted %1 IEDs of %2 placed", (count _ieds) - _nodel, _IEDplaced];
