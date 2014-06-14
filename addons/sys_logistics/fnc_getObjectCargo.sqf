#include <\x\alive\addons\sys_logistics\script_component.hpp>
SCRIPT(getObjectCargo);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_getObjectCargo
Description:

Gets an cargo-array of the given object.

Parameters:
_this: ARRAY of OBJECTs

Returns:
ARRAY - select 0: Logistics Cargo (Array)
ARRAY - select 1: Towed vehicles (Array)
ARRAY - select 2: Lifted vehicles (Array)
ARRAY - select 3: Weapons/Magazines/Items (Array)

See Also:
- <ALIVE_fnc_setObjectCargo>

Author:
Highhead

Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_object","_cargo","_weapons","_magazines","_items"];

_object = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

_cargo = [];

_weapons = getWeaponCargo _object;
_magazines = getMagazineCargo _object;
_items = getItemCargo _object;

_cargo set [0,(_object getvariable [QGVAR(CARGO),[]])];
_cargo set [1,(_object getvariable [QGVAR(CARGO_TOW),[]])];
_cargo set [2,(_object getvariable [QGVAR(CARGO_LIFT),[]])];
_cargo set [3,[_weapons,_magazines,_items]];

_cargo;