params ["_profile"];
_timeout = time;

//-- Set the unit to busy so it is not used by OPCOM
[_profile,"busy",true] call ALIVE_fnc_hashSet;

//-- Wait until the unit has zero waypoints or until the profile has been killed
waitUntil {sleep 120;count ([_profile,"waypoints",[]] call ALIVE_fnc_hashGet) == 0 or {([_profile, "unitCount"] call ALIVE_fnc_profileEntity) == 0}};

//-- Check if profile died
if (([_profile, "unitCount"] call ALIVE_fnc_profileEntity) == 0) exitWith {};

//-- Hand unit back to opcom
[_profile,"busy",false] call ALIVE_fnc_hashSet;
