/*
  _____
  \_   \_ __  ___ _   _ _ __ __ _  ___ _ __   ___ _   _
   / /\/ '_ \/ __| | | | '__/ _` |/ _ \ '_ \ / __| | | |
/\/ /_ | | | \__ \ |_| | | | (_| |  __/ | | | (__| |_| |
\____/ |_| |_|___/\__,_|_|  \__, |\___|_| |_|\___|\__, |
                            |___/                 |___/

@filename: fn_intelPickup.sqf

Author:

	Hazey

Last modified:

	2/11/2015

Description:

	Call for picking up intel.
	Also see fn_intelDrop.sqf

TODO:

	Add comment lines so people can get a better understand of how and why it works.

______________________________________________________*/

private ["_intelItems","_intel","_used","_ID","_cases","_case","_cache","_x"];

_intelItems = INS_INTELDROPPED + INS_INTELSPAWNED;
_intel = _this select 0;
_used = _this select 1;
_ID = _this select 2;
_intel removeAction _ID;
_cache = cache;
_cases = nearestObjects[getPos player, _intelItems, 4.5];

if (count _cases == 0) exitWith {};

{
	deleteVehicle _x;
	[_cache, "INS_fnc_createIntel", false, false] spawn BIS_fnc_MP;
} forEach _cases;

player groupChat "You retrieved some INTEL on the general location of an ammo cache";

if (isNil "_cache") exitWith {
	hint "Currently, there is no Intel on caches within your AO. Time to move on and look elsewhere!";
};

[nil, "INS_fnc_pickedUpIntel", true, false] spawn BIS_fnc_MP;