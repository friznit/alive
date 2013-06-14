if (!isServer) exitWith {};  // test for MP usage, has no impact on SP missions.
/*
	DMZ Delete v 1.1
	by Demonized.
	
	This script does not use any eventhandlers, so it may delay the deleting if there are heavy scripts running.
	Main purpose is to cleanup within a reasonable frame, for most missions it will be 100% accurate on timers, exept maybe for those heavy scripted ones, wich may cause some extra time until delete.
	
	Script will delete any dead man, destroyed/abandoned vehicle and empty group after x seconds within a 10 seconds accuracy (its checking for new dead or vehicles every 10 seconds)
	* abandoned vehicles if option is used, will abort their delete if anyone gets into the vehicle before timer runs out.
	* abandoned vehicles wich are destroyed, will abort their current abandon timer, and will be deleted after same timer as deleting destroyed vehicles.
	* _canmove may be a bad option, any vehicle witouth fuel, will be detected as it cannot move, make sure you want the option in your mission if you use it.
	* mainly created for SP missions, but should be MP compatible.
	* does not delete any objects, only men and vehicles (land, air, sea, static weapons).
	* use DMZ_Included to include or modify timer and distance for ANY object/unit/vehicle.
	
	execute with:
	place in init.sqf or in a object init field:
	_null = [] execVM "DMZ_delete.sqf";
	
	* more info on DMZ_Excluded:
	
	You can add vehicle or units to this global array and they will never be deleted.
	You can either just type unitname directly here in the script, or
	just do this to add unitname in your custom script or trigger or init.
	
		DMZ_Excluded = DMZ_Excluded + [unitname];	// unitname will now never be deleted.
		
	examples:
		DMZ_Excluded = [car1,unit1,unit2];		// vehicle named car1 and men called unit1 and unit2 will never be deleted.
		DMZ_Excluded = [car1,"Air"];			// vehicle named car1 and any Air vehicles will never be deleted.
		DMZ_Excluded = ["Man","Helicopter"];	// any men and any helicopters will never be deleted.
		DMZ_Excluded = ["BAF_Apache_AH1_D"];	// the type BAF Apache helicopters will never be deleted.
		
	DMZ_Excluded will be checked evey cycle for changes, and there is a failsafe before the delete in case of bad luck with timing.
	go here for more cfgVehicle and types: http://community.bistudio.com/wiki/ArmA_2:_CfgVehicles
	
	* more info on DMZ_Included:
	
	you can add just the object/unit/vehicle, or you can add a specific timer AND distance to be used with that vehicle like shown here:
	any object that can be placed in the world via editor or script can be included.
	you cannot use classname or cfgVehicles atm.
	included objects will not care for _canMove OR _abandoned options, they will delete no matter what after _incTimer OR custom seconds if used like below.
	icluded objects will use _viewDist to check if player is to close, if not custom is used like below.
	
		DMZ_Included = [obj1,unit1];			// obj1 and unit1 will be deleted after x seconds(_incTimer).
		DMZ_Included = [[obj1,129],unit1];		// obj1 deletes after 129 seconds, and unit1 will be deleted after x seconds(_incTimer below).
		DMZ_Included = [[obj1,129,200]];		// obj1 deletes after 129 seconds, and only when any player unit is 200 meter or more away from it.
*/

DMZ_Included = [];  				// used to include certain objects into the delete, such as for example any unit/vehicle, ieds, ammo crates, custom buildings/bases/compounds etc. any object can be used, update it same way as DMZ_Excluded runtime with info from below.
DMZ_Excluded = [];  				// used to exclude certain men or vehicles or types/classname from being deleted.

// true/false = on/off.
_canMove = false;  	// if vehicles should be deleted when they are to damaged to move and empty, NOTE empty fuel also means it cannot move.
_abandoned = false;  	// if vehicles should be deleted after being x time un manned, if 1 unit enters in the time period, time is reset, and vehicle is processed again when empty or destroyed.
_groupDel = false;  	// if empty groups should be deleted, to avoid reaching 144 group limit in long missions.
_viewDist = 650;  		// min distance in meter from a player unit to allow delete, if you dont care if player sees the delete, set it to 0.
_manTimer = 300;  		// x seconds until delete of dead man units.
_vehTimer = 600;  		// x seconds until delete of dead vehicles, for destroyed and heavy damaged vehicles.
_abaTimer = 10;  		// x seconds a vehicle must be unmanned to be deleted, for _abandoned option.
_incTimer = 10;		// x seconds any object put inside the DMZ_Included will be deleted no matter condition.

// DO NOT EDIT PAST THIS LINE //

// delete function.
_delete = {
	_del = _this select 0;
	_dis = _this select 1;
	_tim = _this select 2;
	_aba = _this select 3;
	_abt = _this select 4;
	_cnm = _this select 5;
	if (isPlayer _del) exitWith {};
	
	_abort = true;
	if ("veh" in _this AND (_aba OR _cnm)) then {
		_sec = _abt;
		while {_sec != 0} do {
			sleep 1;
			if (_aba AND (getDammage _del) < 1 AND ({alive _x} count (crew _del)) == 0) then {_sec = _sec - 1};
			if (_aba AND _sec == 0) then {_abort = false};
			if (((_cnm AND canMove _del) OR _aba) AND ({alive _x} count (crew _del)) != 0) then {
				_sec = 0; _abort = true;
				_del setVariable ["DMZ_delete_readd", true, true];
			};
			if ((getDammage _del) >= 1) then {
				_sec = 0; _abort = false;
				sleep _tim;
			};
			if (isNull _del) then {_sec = 0; _abort = true};
		};
	} else {
		_abort = false;
		sleep _tim;
	};
	// fail safe for excluded and included.
	if (isNull _del OR _abort OR _del in DMZ_Excluded) exitWith {};
	{
		_arr = _x; _obj = ""; _timer = _tim; _dist = _dis;
		if ((typeName _arr) == "ARRAY") then {
			_obj = _arr select 0; _timer = _arr select 1;
			if ((count _arr) == 3) then {_dist = _arr select 2} else {_dist = _viewDist};
		} else {
			_obj = _arr; _timer = _tim; _dist = _dis;
		};
		if (_del == _obj) then {
			_del = _obj;
			_dis = _dist;
			if ((_timer - _tim) > 0) then {sleep (_timer - _tim)};
			// clean up the DMZ_Included array of deleted objects.
			DMZ_Included = DMZ_Included - [_x];
		};
	} foreach DMZ_Included;
	
	if (!isNull _del) then {
		_arr = [];
		waitUntil {sleep 1; ({isPlayer _x AND (_del distance (vehicle _x)) < _dis} count playableUnits) == 0};
		waitUntil {sleep 1; ({isPlayer _x AND (_del distance (vehicle _x)) < _dis} count switchableUnits) == 0};
		if ("veh" in _this OR "incVeh" in _this) then {{_arr = _arr + [_x]; _x setPos (getPos _del); deleteVehicle _x} foreach crew _del} else {
			if (_del isKindOf "man") then {hideBody _del; sleep 10};
		};
		_arr = _arr + [_del];
		deleteVehicle _del;
		//{_x = objNull; waitUntil {sleep 1; isNull _x}; _x = nil} foreach _arr;
		
		{if (_x in DMZ_delete_respawned) then {_arr = _arr - [_x]}} foreach _arr;
		DMZ_delete_respawned = DMZ_delete_respawned + _arr;
	};
};

_processed = []; _todo = []; _types = []; _included = []; DMZ_delete_respawned = [];
while {true} do {
	// check DMZ_Excluded array for changes.
	{if ((typeName _x) == "STRING" AND !(_x in _types)) then {_types = _types + [_x]}} foreach DMZ_Excluded;
	// update types/classnames if changed.
	{if (!(_x in DMZ_Excluded)) then {_types = _types - [_x]}} foreach _types;
	// clean the processed list of all objects that have been deleted.
	{if (isNull _x) then {_processed = _processed - [_x]}} foreach _processed;
	// clean the included list of all objects that have been deleted.
	{if (isNull _x) then {_included = _included - [_x]}} foreach _included;
	
	// process DMZ_Included array.
	{
		_arr = _x; _obj = ""; _timer = 0; _dist = 0;
		if ((typeName _arr) == "ARRAY") then {
			_obj = _arr select 0; _timer = _arr select 1;
			if ((count _arr) == 3) then {_dist = _arr select 2} else {_dist = _viewDist};
		} else {
			_obj = _arr; _timer = _incTimer; _dist = _viewDist;
		};
		if (_x in _included) exitWith {};
		_included = _included + [_obj];
		if (_obj isKindOf "AllVehicles" AND !(_obj isKindOf "Man")) then {
			_null = [_obj,_dist,_timer,false,0,false,"incVeh"] spawn _delete;
		} else {
			_null = [_obj,_dist,_timer,false,0,false,"inc"] spawn _delete;
		};
	} foreach DMZ_Included;
	
	// gather all dead.
	_allD = allDead;
	{if (_x in DMZ_delete_respawned AND _x in _processed) then {_processed = _processed - [_x]}} foreach _allD;
	{
		_unit = _x;
		if (_x in _included) exitWith {};
		if ((vehicle _x) == _x AND !(_x in _processed) AND ({_unit isKindOf _x} count _types) == 0 AND !(_x in DMZ_Excluded)) then {
			if (!(_x in _todo)) then {_todo = _todo + [_x]};
		};
	} foreach _allD;
	
	// gather all vehicles and process depending on options used.
	_allV = vehicles;
	{if (_x in DMZ_delete_respawned AND _x in _processed) then {_processed = _processed - [_x]}} foreach _allV;
	{
		_veh = _x;
		if (_x in _included) exitWith {};
		if (_x getVariable ["DMZ_delete_readd", false]) then {
			_processed = _processed - [_x];
			_x setVariable ["DMZ_delete_readd", false, true];
		};
		if (!(_x in _processed) AND ({_veh isKindOf _x} count _types) == 0 AND !(_x in DMZ_Excluded)) then {
			if ((getDammage _x) >= 1 OR (_canMove AND !canMove _x AND ({alive _x} count (crew _x)) == 0) OR (_abandoned AND ({alive _x} count (crew _x)) == 0)) then {
				if (!(_x in _todo)) then {_todo = _todo + [_x]};
			};
		};
	} foreach _allV;
	
	// run the delete script for todo list.
	{
		if (!(_x in _processed)) then {
			if (_x isKindOf "Man") then {
				_null = [_x,_viewDist,_manTimer,_abandoned,_abaTimer,_canMove] spawn _delete;
			} else {
				_null = [_x,_viewDist,_vehTimer,_abandoned,_abaTimer,_canMove,"veh"] spawn _delete;
			};
			_todo = _todo - [_x]; _processed = _processed + [_x];
		};
	} foreach _todo;
	
	// delete empty groups.
	if (_groupDel) then {{if ((count (units _x)) == 0) then {deleteGroup _x; _x = grpNull; _x = nil}} foreach allGroups};
	
	// sleep 10 seconds, then check if there are any changes to dead or vehicles that are not processed.
	sleep 10;
};