/*
  _____
  \_   \_ __  ___ _   _ _ __ __ _  ___ _ __   ___ _   _
   / /\/ '_ \/ __| | | | '__/ _` |/ _ \ '_ \ / __| | | |
/\/ /_ | | | \__ \ |_| | | | (_| |  __/ | | | (__| |_| |
\____/ |_| |_|___/\__,_|_|  \__, |\___|_| |_|\___|\__, |
                            |___/                 |___/

@filename: fn_spawnCache.sqf

Author:

	Hazey

Last modified:

	2/11/2015

Description:

	This is where the magic happens. Spawns the cache at random locations.
	1 cache at a time the way the good insurgency lords intended.

README BEFORE EDITING:

	This function.... It was written on 1/15/2014 and has since been put through the ringer so many times.
	Lets be honest here, it looks like crap and needs to be re-written...
	That's for another day, right now its doing the job.

	I Hazey, Promise to re-write this function with all my new knowlage very soon.

	Right now, if you feel that the cache is REALLY STUCK or missing... Have your admin use the following code.

	_pos getPos player; cache setPos _pos;

	Simple... Effective... Move along...

______________________________________________________*/

private ["_mkr","_bldgpos","_targetLocation","_cacheHouses","_cities","_cacheTown","_cityPos","_cityRadA","_cityRadB","_cacheHouse","_cachePosition","_helipad","_findHelipad","_findBases","_players"];

//--- Delete Marker Array
if (count INS_marker_array > 0) then {
	{deleteMarker _x} forEach INS_marker_array};
publicVariable "INS_marker_array";

if (ins_debug) then {
	//--- Delete Cache Array
	if (count INS_cache_marker_array > 0) then {
		{deleteMarker _x} forEach INS_cache_marker_array};
	publicVariable "INS_cache_marker_array";
};

//--- Cache Created Debug
if (ins_debug) then {
    ["Insurgency | ALiVE - Buffering Cache - 30 second timeout"] call ALiVE_fnc_DumpR;
};

//--- Initial buffer - and respawn buffer time.
sleep 30;

if (ins_debug) then {
    ["Insurgency | ALiVE - Calling Players"] call ALiVE_fnc_DumpR;
};

//--- Players call.
_players = [] call BIS_fnc_listPlayers;

if (ins_debug) then {
    ["Insurgency | ALiVE - Calling Urban Areas"] call ALiVE_fnc_DumpR;
};

//--- Call to get urbanAreas.
_cities = call INS_fnc_urbanAreas;

sleep 1;

if (ins_debug) then {
    ["Insurgency | ALiVE - Getting random town."] call ALiVE_fnc_DumpR;
};

//--- Get random town from urban areas array.
_cacheTown = _cities call BIS_fnc_selectRandom;

_cityPos = _cacheTown select 1;
_cityRadA = _cacheTown select 2;
_cityRadB = _cacheTown select 3;

if(_cityRadB > _cityRadA) then {
	_cityRadA = _cityRadB;
};

sleep 1;

if (ins_debug) then {
    ["Insurgency | ALiVE - Calling Enter-able houses"] call ALiVE_fnc_DumpR;
};

//--- Call list of all Enter-able Houses -- Might cause bad performance on Altis or large maps.
_cacheHouses = [_cityPos, _cityRadA] call ALIVE_fnc_getEnterableHouses;

sleep 1;

if (ins_debug) then {
    ["Insurgency | ALiVE - Selecting Random House"] call ALiVE_fnc_DumpR;
};

//--- Select random house from the generated list.
_cacheHouse = _cacheHouses call BIS_fnc_selectRandom;

sleep 1;

if (ins_debug) then {
    ["Insurgency | ALiVE - Finding indoor positions"] call ALiVE_fnc_DumpR;
};

//--- Find indoor house position for spawning of the cache.
_bldgpos = [_cacheHouse, 50] call ALIVE_fnc_findIndoorHousePositions;

sleep 1;

if (ins_debug) then {
    ["Insurgency | ALiVE - Selecting Random Position"] call ALiVE_fnc_DumpR;
};

//--- Pull the array and select a random position from it.
_targetLocation = _bldgpos call BIS_fnc_selectRandom;

//--- Create the cache at the random building position.
CACHE = createVehicle ["Box_FIA_Wps_F", _targetLocation, [], 0, "None"];

//--- Cache Created Debug
if (ins_debug) then {
    ["Insurgency | ALiVE - Cache Has been created."] call ALiVE_fnc_DumpR;
};

//--- Empty the cache so no items can be found in it.
clearMagazineCargoGlobal CACHE;
clearWeaponCargoGlobal CACHE;

//--- Add event handlers to the cache
//--- Handle damage for only Satchel and Demo charge.
CACHE addEventHandler ["handledamage", {
	if ((_this select 4) in ["SatchelCharge_Remote_Ammo","DemoCharge_Remote_Ammo"]) then {

		(_this select 0) setdamage 1;
		//--- Event handler to call explosion effect and score.
		(_this select 0) spawn INS_fnc_cacheKilled;
		//--- Event handler to recall script when cache is destroyed.
		(_this select 0) spawn INS_fnc_spawnCache;

	} else {

		(_this select 0) setdamage 0;

	}}];
//--- End of event handlers

//--- Disable simulation of the cache.
CACHE enableSimulation false;

//--- Move the Cache to the above select position
//--- TODO: Verify we even need this.
CACHE setPos _targetLocation;
publicVariable "CACHE";

sleep 1;

if (ins_debug) then {
    ["Insurgency | ALiVE - Check to see if cache has alread spawned near."] call ALiVE_fnc_DumpR;
};

//--- Check to see if cache has already spawned near that location.
//--- TODO: Pass cache into array and check distance of new cache to the array of old caches.
_findHelipad = count nearestObjects [_targetLocation, ["Land_HelipadEmpty_F"], 1800];
_findBases = count nearestObjects [_targetLocation, ["Flag_US_F"], 800];

if ((_findHelipad > 0)|| (_findBases > 0)) then {

	if (ins_debug) then {
        ["Insurgency | ALiVE - Cache trying to spawn in a bad location. Trying Again."] call ALiVE_fnc_DumpR;
    };

	true spawn INS_fncache;
};

sleep 1;

if (ins_debug) then {
    ["Insurgency | ALiVE - Creating HeliPad Empty"] call ALiVE_fnc_DumpR;
};

//--- Create the invisible helipad for the above.
_helipad = createVehicle ["Land_HelipadEmpty_F", _targetLocation, [], 0, "None"];
_helipad enableSimulation false;

//--- Make final check to end mission if cache score complete.
if (INS_west_score == (paramsArray select 6)) then {
	[nil, "INS_fnc_endMission", true, false] spawn BIS_fnc_MP;
};

//--- Debug stuff.
if (ins_debug) then {

    //--- Debug to see where box spawned is if not multi-player
    _mkr = createMarker [format ["box%1",random 1000],getposATL CACHE];
    _mkr setMarkerShape "ICON";
	_mkr setMarkerText format["Cache Location"];
    _mkr setMarkerType "mil_dot";
    _mkr setMarkerColor "ColorRed";

	INS_cache_marker_array set [count INS_cache_marker_array, _mkr];
	publicVariable "INS_cache_marker_array";
};

if (ins_debug) then {
    ["Insurgency | ALiVE - Cache Function Create end"] call ALiVE_fnc_DumpR;
};