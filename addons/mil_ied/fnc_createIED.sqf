#include <\x\alive\addons\mil_IED\script_component.hpp>
#define DEFAULT_IED_THREAT 60
SCRIPT(createIED);

// IED - create IED(s) at location
private ["_position","_town","_debug","_numIEDs","_j","_size","_posloc","_IEDs","_threat","_IEDData"];

if !(isServer) exitWith {diag_log "IED Not running on server!";};

TRACE_1("IED",_this);

_debug = ADDON getVariable ["debug", false];
_threat = ADDON getVariable ["IED_Threat", DEFAULT_IED_THREAT];

_position = _this select 0;
_size = _this select 1;

if ((count _this) > 2) then {
	_town = _this select 2;
};

if ((count _this) > 3) then {
	_numIEDs = _this select 3;
} else {
	_numIEDs = round ((_size / 50) * ( _threat / 100));
};

// Get IEDs from store if available
_IEDs = [[GVAR(STORE), "IEDs"] call ALiVE_fnc_hashGet, _town, []] call ALiVE_fnc_hashGet;

// IF first time creating IEDs for location go work out how many IEDs
if (count _IEDs == 0) then {
	diag_log format ["ALIVE-%1 IED: creating %2 IEDs at %5 (%3) - size %4", time, _numIEDs, mapgridposition  _position, _size, _town];

	// Find positions in area
	_posloc = [];
	_posloc = [_position, true, true, true, _size] call ALIVE_fnc_placeIED;
	if (_debug) then {
		diag_log format ["ALIVE-%1 IED: Found %2 spots for IEDs",time, count _posloc];
	};

	if (_numIEDs > (count _posloc)) then {
		_numIEDs = (count _posloc) - 1;
	};

	_IEDData = [] call ALiVE_fnc_hashCreate;

} else {
	_numIEDs = count (_IEDs select 1);
};

for "_j" from 1 to _numIEDs do {
	private ["_IEDpos","_pos","_cen","_near","_IED","_IEDskin","_data","_ID","_error"];
	// Select Position for IED and remove position used
	_error = false;

	If (count _IEDs == 0) then {
		_index = round (random ((count _posloc) -1));
		_pos = _posloc select _index;

		_posloc set [_index, -1];
		_posloc = _posloc - [-1];
		// Find safe location - if no safe pos find random position within 6m
		_IEDpos = [_pos, 4, 20, 2, 0, 0, 0,[],[[((_pos select 0) - 6) + random 12, ((_pos select 1) - 6) + random 12, 0]]] call BIS_fnc_findSafePos;

		private ["_IEDskins","_near","_choice"];
		// Check no other IEDs nearby
		// _near = nearestObjects [_IEDpos, ["Land_IED_v1_PMC","Land_IED_v2_PMC","Land_IED_v3_PMC","Land_IED_v4_PMC","Land_Misc_Rubble_EP1","Land_Misc_Garb_Heap_EP1","Garbage_container","Misc_TyreHeapEP1","Misc_TyreHeap","Garbage_can","Land_bags_EP1"], 10];

		_near = nearestObjects [_IEDpos, ["ALIVE_IEDUrbanSmall_Remote_Ammo","ALIVE_IEDLandSmall_Remote_Ammo","ALIVE_IEDUrbanBig_Remote_Ammo","ALIVE_IEDLandBig_Remote_Ammo","Land_JunkPile_F","Land_GarbageContainer_closed_F","Land_GarbageBags_F","Land_Tyres_F","Land_GarbagePallet_F","Land_Basket_F","Land_Sack_F","Land_Sacks_goods_F","Land_Sacks_heap_F","Land_BarrelTrash_F"], 3];

		if (count _near > 0) exitWith {diag_log format ["ALIVE-%1 IED: exiting as other IEDs found %2",time,_near]; _error = true;}; //Exit if other IEDs are found
		if (surfaceIsWater _IEDpos) exitWith {diag_log format ["ALIVE-%1 IED: exiting as pos was on water.",time]; _error = true;};

		// Check not placed near a player
		if ({(getpos _x distance _IEDpos) < 75} count ([] call BIS_fnc_listPlayers) > 0) exitWith {diag_log format ["ALIVE-%1 IED: exiting as placement too close to player.",time]; _error = true;}; //Exit if position is too close to a player

		// Select type of IED
		if (isOnRoad _IEDpos) then {

	//		_IEDskins = ["Land_IED_v1_PMC","Land_IED_v2_PMC","Land_IED_v3_PMC","Land_IED_v4_PMC"];
			_IEDskins = ["ALIVE_IEDUrbanSmall_Remote_Ammo","ALIVE_IEDLandSmall_Remote_Ammo","ALIVE_IEDUrbanBig_Remote_Ammo","ALIVE_IEDLandBig_Remote_Ammo"];
		} else {
	//		_IEDskins =["Land_IED_v1_PMC","Land_IED_v2_PMC","Land_IED_v3_PMC","Land_IED_v4_PMC","Land_IED_v1_PMC","Land_IED_v2_PMC","Land_IED_v3_PMC","Land_IED_v4_PMC","Land_Misc_Rubble_EP1","Land_Misc_Garb_Heap_EP1","Garbage_container","Misc_TyreHeapEP1","Misc_TyreHeap","Garbage_can","Land_bags_EP1"];

			if (count (_IEDpos nearObjects ["House_F", 40]) > 0) then {
				_IEDskins = ["ALIVE_IEDUrbanSmall_Remote_Ammo","ALIVE_IEDUrbanBig_Remote_Ammo","Land_JunkPile_F","Land_GarbageContainer_closed_F","Land_GarbageBags_F","Land_Tyres_F","Land_GarbagePallet_F","Land_Basket_F","Land_Sack_F","Land_Sacks_goods_F","Land_Sacks_heap_F","Land_BarrelTrash_F"];

				// Add clutter nearby so its not so obvious that there is an IED
				private ["_clutter","_c","_clut","_clutm","_t"];
				_clutter = ["Land_JunkPile_F","Land_GarbageContainer_closed_F","Land_GarbageBags_F","Land_Tyres_F","Land_GarbagePallet_F","Land_Basket_F","Land_Sack_F","Land_Sacks_goods_F","Land_Sacks_heap_F","Land_BarrelTrash_F"];
				for "_c" from 1 to (2 + (ceil(random 6))) do {
					_clut = createVehicle [_clutter call BIS_fnc_selectRandom,_IEDpos, [], 40, ""];
					while {isOnRoad _clut} do {
						_clut setPos [((position _clut) select 0) - 10 + random 20, ((position _clut) select 1) - 10 + random 20, ((position _clut) select 2)];
					};
					if (_debug) then {
						diag_log format ["ALIVE-%1 IED: Planting clutter (%2) at %3.", time, typeOf _clut, position _clut];
						//Mark clutter position
						_t = format["cl_r%1", floor (random 1000)];
						_clutm = [_t, position _clut, "Icon", [1,1], "TEXT:", "", "TYPE:", "mil_dot", "COLOR:", "ColorGreen", "GLOBAL"] call CBA_fnc_createMarker;
						_clut setvariable ["Marker", _clutm];
					};
				};
			} else {
				_IEDskins = ["ALIVE_IEDUrbanSmall_Remote_Ammo","ALIVE_IEDLandSmall_Remote_Ammo","ALIVE_IEDUrbanBig_Remote_Ammo","ALIVE_IEDLandBig_Remote_Ammo"];
			};

		};

		_IEDpos set [2, -0.1];
		_IEDskin = _IEDskins call BIS_fnc_selectRandom;
		_IED = createVehicle [_IEDskin, _IEDpos, [], 0, ""];

		_ID = format ["%1-%2", _town, _j];

		_data = [] call ALiVE_fnc_hashCreate;
		[_data, "IEDskin", _IEDskin] call ALiVE_fnc_hashSet;
		[_data, "IEDpos", getposATL _IED] call ALiVE_fnc_hashSet;

		[_IEDdata, _ID, _data] call ALiVE_fnc_hashSet;

	} else {
		private ["_data"];
		_ID = (_IEDs select 1) select (_j-1);
		_data = [_IEDs, _ID] call ALiVE_fnc_hashGet;
		_IED = createVehicle [[_data, "IEDskin", "ALIVE_IEDUrbanSmall_Remote_Ammo"] call ALiVE_fnc_hashGet, [_data, "IEDpos",[0,0,0]] call ALiVE_fnc_hashGet, [], 0, ""];
	};

	if (_error) exitWith {diag_log format ["ALIVE-%1 IED: exiting as could not find suitable place.",time];};

	_IED setvariable ["ID", _ID];
	_IED setvariable ["town", _town];

	// Choose IED or Dud IED
	if (random 1 < 0.95) then {
		[_IED, typeOf _IED] call ALIVE_fnc_armIED;

		// Attach something that can take a hit to the IED and add a damage handler
		_IEDCharge = createVehicle ["ALIVE_DemoCharge_Remote_Ammo",getposATL _IED, [], 0, "CAN_COLLIDE"];
		_IEDCharge attachTo [_IED, [0,0,0]];

		// Add damage handler
		_ehID = _IEDCharge addeventhandler ["HandleDamage",{
			private ["_trgr","_IED"];
//			diag_log str(_this);

			if (isPlayer (_this select 3)) then { // GO BOOOOOOOOOOM!

				_IED = attachedTo (_this select 0);

				// Remove from store
				[ADDON, "removeIED", _IED] call ALiVE_fnc_IED;

				if (ADDON getVariable "debug") then {
					diag_log format ["ALIVE-%1 IED: %2 explodes due to damage by %3", time, _IED, (_this select 3)];
					[_IED getvariable "Marker"] call cba_fnc_deleteEntity;
				};

				"M_Mo_120mm_AT" createVehicle [(getpos (_this select 0)) select 0, (getpos (_this select 0)) select 1,0];

				deletevehicle (_this select 0);
				deleteVehicle _IED;

				_trgr = (position (_this select 0)) nearObjects ["EmptyDetector", 3];
				{
					deleteVehicle _x;
				} foreach _trgr;

			};

		}];
		_IED setVariable ["ehID",_ehID, true];
		_IED setvariable ["charge", _IEDCharge, true];
	};
};

// Set data
if (count _IEDs == 0) then {
	[[GVAR(STORE), "IEDs"] call ALiVE_fnc_hashGet, _town, _IEDData] call ALiVE_fnc_hashSet;
};
