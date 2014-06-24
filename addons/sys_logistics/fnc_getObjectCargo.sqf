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

private ["_object","_cargo","_weapons","_magazines","_items","_hash"];

_object = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_types = [QGVAR(CARGO),QGVAR(CARGO_TOW),QGVAR(CARGO_LIFT)];

_cargo = (_object getvariable [QGVAR(CARGO),[]]);
_cargoTmp = [];
{
    private ["_id"];
    
    _id = [MOD(SYS_LOGISTICS),"id",_x] call ALiVE_fnc_logistics;
    
    if !(_id in _cargoTmp) then {
    	_cargoTmp set [count _cargoTmp,_id];
    };
} foreach _cargo;
_cargoReg = _cargoTmp;

_cargo = (_object getvariable [QGVAR(CARGO_TOW),[]]);
_cargoTmp = [];
{
    private ["_id"];
    
    _id = [MOD(SYS_LOGISTICS),"id",_x] call ALiVE_fnc_logistics;
    
    if !(_id in _cargoTmp) then {
    	_cargoTmp set [count _cargoTmp,_id];
    };
} foreach _cargo;
_cargoTow = _cargoTmp;

_cargo = (_object getvariable [QGVAR(CARGO_LIFT),[]]);
_cargoTmp = [];
{
    private ["_id"];
    
    _id = [MOD(SYS_LOGISTICS),"id",_x] call ALiVE_fnc_logistics;
    
    if !(_id in _cargoTmp) then {
    	_cargoTmp set [count _cargoTmp,_id];
    };
} foreach _cargo;
_cargoLift = _cargoTmp;

_weapons = getWeaponCargo _object;
_magazines = getMagazineCargo _object;
_items = getItemCargo _object;
_ammo = magazinesAmmo _object;

_cargo = [];
_cargo set [0,_cargoReg];
_cargo set [1,_cargoTow];
_cargo set [2,_cargoLift];
_cargo set [3,[_weapons,_magazines,_items]];
_cargo set [4,_ammo];

_cargo;