#include <\x\alive\addons\sys_rwg\script_component.hpp>
SCRIPT(RWGloadgear);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_RWGloadgear
Description:
Loads players gear

Parameters:
_this select 0: OBJECT - Reference to module


Returns:
Nil

See Also:
- <ALIVE_fnc_RWGloadgear>

Author:
Highhead
Peer Reviewed:
nil
---------------------------------------------------------------------------- */
//Load Gear in from global vars (local on client only)
private ["_unit","_primw"];
_unit = _this select 0;

removeAllWeapons _unit;

_unit addUniform uniformP;
_unit addVest vestP;
_unit addHeadgear headgearP;
{_unit addWeapon _x} forEach weaponsP;
{_unit addMagazines _x} forEach magazinesP;
{_unit addPrimaryWeaponItem _x} forEach primesideP;
{_unit addSecondaryWeaponItem _x} forEach secsideP;
{_unit addHandgunItem _x} forEach handgunsideP;
{_unit addItem _x} forEach itemsP;
{_unit assignItem _x} forEach assigneditemsP;

if (!(isnil "backpackP") && {!(isnull backpackP)}) then {_unit addBackpack backpackP};

_primw = primaryWeapon _unit;
if (_primw != "") then {
    _unit selectWeapon _primw;
    _muzzles = getArray(configFile>>"cfgWeapons" >> _primw >> "muzzles");
    _unit selectWeapon (_muzzles select 0);
};
hint "Loadout restored!";
true;
