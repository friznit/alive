#include <\x\alive\addons\sys_rwg\script_component.hpp>
SCRIPT(RWGsavegear);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_RWGsavegear
Description:
Saves _units gear

Parameters:
_this select 0: OBJECT - Reference to module


Returns:
Nil

See Also:
- <ALIVE_fnc_RWGsavegear>

Author:
Highhead
Peer Reviewed:
nil
---------------------------------------------------------------------------- */
//save Gear in global vars (local on client only)
private ["_unit"];
_unit = _this select 0;

weaponsP = weapons _unit;
magazinesP = magazinesAmmo _unit;
primesideP = primaryWeaponItems _unit; 
vestP = vest _unit;
uniformP = uniform _unit;
headgearP = headgear _unit;
backpackP = unitBackpack _unit;
secsideP = secondaryWeaponItems _unit;
handgunsideP = handgunItems _unit;
itemsP = items _unit;
assigneditemsP = assignedItems _unit;

hint "Gear saved!";
true;