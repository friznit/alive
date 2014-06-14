#include <\x\alive\addons\sys_logistics\script_component.hpp>
SCRIPT(setObjectCargo);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_setObjectCargo
Description:

Sets the cargo on the given object.

Parameters:
ARRAY - select 0: Logistics Cargo (Array)
ARRAY - select 1: Towed vehicles (Array)
ARRAY - select 2: Lifted vehicles (Array)
ARRAY - select 3: Weapons/Magazines/Items (Array)

Returns:
Cargo Array

See Also:
- <ALIVE_fnc_setObjectCargo>

Author:
Highhead

Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_object","_cargo","_weapons","_magazines","_items"];

_object = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_cargo = [_this, 1, [], [[]]] call BIS_fnc_param;

_cargoR = [_cargo, 0, [], [[]]] call BIS_fnc_param;
_cargoT = [_cargo, 1, [], [[]]] call BIS_fnc_param;
_cargoL = [_cargo, 2, [], [[]]] call BIS_fnc_param;

_cargoWMI = [_cargo, 3, [], [[]]] call BIS_fnc_param;
_cargoW = [_cargoWMI, 0, [], [[]]] call BIS_fnc_param;
_cargoM = [_cargoWMI, 1, [], [[]]] call BIS_fnc_param;
_cargoI = [_cargoWMI, 2, [], [[]]] call BIS_fnc_param;

{[MOD(SYS_LOGISTICS),"stowObject",_x] call ALiVE_fnc_logistics} foreach _cargoR;
{[MOD(SYS_LOGISTICS),"towObject",_x] call ALiVE_fnc_logistics} foreach _cargoT;
{[MOD(SYS_LOGISTICS),"liftObject",_x] call ALiVE_fnc_logistics} foreach _cargoL;

clearWeaponCargo _object;
for "_i" from 0 to (count (_cargoW select 0))-1 do {
    _type = _cargoW select 0 select _i;
    _count = _cargoW select 1 select _i;
    
    _object addWeaponCargo [_type,_count];
};

clearMagazineCargo _object;
for "_i" from 0 to (count (_cargoM select 0))-1 do {
    _type = _cargoM select 0 select _i;
    _count = _cargoM select 1 select _i;
    
    _object addMagazineCargo [_type,_count];
};

clearitemCargo _object;
for "_i" from 0 to (count (_cargoI select 0))-1 do {
    _type = _cargoI select 0 select _i;
    _count = _cargoI select 1 select _i;
    
    _object additemCargo [_type,_count];
};

_cargo;