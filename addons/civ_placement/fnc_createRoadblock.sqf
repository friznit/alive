#include <\x\alive\addons\civ_placement\script_component.hpp>
SCRIPT(createRoadBlock);
/*
 =======================================================================================================================
Script: fnc_createRoadBlock.sqf v1.0
Author(s): Tupolov
		Thanks to Evaider for roadblock layout

Description:
Group will setup a roadblock on the nearest road within 500m and man it

Parameter(s):
_this select 1: radius
_this select 0: defense position (Array)
_this select 2: number

Returns:
Boolean - success flag

Example(s):
null = [group this,(getPos this)] call ALiVE_fnc_createRoadBlock

-----------------------------------------------------------------------------------------------------------------------
Notes:

Type of roadblock will be based on faction.
Roadblock will be deployed on nearest road to the position facing along the road
Group will man static weaponary

to do: Current issue if road ahead bends.
	 Change roadblock based on faction

=======================================================================================================================
*/

private ["_grp","_pos","_roadpos","_vehicle","_vehtype","_blockers","_roads","_fac","_debug","_roadConnectedTo", "_connectedRoad","_direction","_checkpoint","_checkpointComp","_roadpoints","_num"];

_debug = [[MOD(mil_ied) getVariable ["debug", false]], 0, false, [true]] call BIS_fnc_param;
_pos = [_this, 0, [0,0,0], [[]]] call BIS_fnc_param;
_radius = [_this, 1, 100, [-1]] call BIS_fnc_param;
_num = [_this, 2, 1, [-1]] call BIS_fnc_param;

if (_num > 5) then {_num = 5};

_fac = [_pos, _radius] call ALiVE_fnc_getDominantFaction;

if (isNil "_fac") then {
	_fac = "OPF_G_F";
};

// Find all the checkpoints pos
_roads = _pos nearRoads (_radius + 20);
// scan road positions and find those on outskirts
{
	if (_x distance _pos < (_radius - 10)) then {
		_roads = _roads - [_x];
	};
} foreach _roads;

{
	if (_debug) then {
		private "_id";
		_id = floor (random 1000);
		[format["road_%1", _id], _x, "Icon", [1,1], "TYPE:", "mil_dot", "TEXT:", "",  "GLOBAL"] call CBA_fnc_createMarker;
	};
} foreach _roads;

_roadpoints = [];

for "_i" from 1 to _num do {
	private "_roadsel";
	_roadsel = _roads call BIS_fnc_selectRandom;
	_roads = _roads - [_roadsel];
	while {({_roadsel distance _x < 30} count _roadpoints) != 0 && count _roads > 0} do {
		_roadsel = _roads call BIS_fnc_selectRandom;
		_roads = _roads - [_roadsel];
	};

	if (count _roads > 0) then {
		_roadpoints pushback _roadsel;
	};
};

for "_j" from 1 to (count _roadpoints) do {

	_roadpos = _roadpoints select (_j - 1);

	_roadConnectedTo = roadsConnectedTo _roadpos;
	_connectedRoad = _roadConnectedTo select 0;
	_direction = [_roadpos, _connectedRoad] call BIS_fnc_DirTo;

	if (_direction < 181) then {_direction = _direction + 180;} else {_direction = _direction - 180;};


	if (_debug) then {
		private "_id";
		_id = floor (random 1000);
		diag_log format["Position of Road Block is %1, dir %2", getpos _roadpos, _direction];
		[format["roadblock_%1", _id], _roadpos, "Icon", [1,1], "TYPE:", "mil_dot", "TEXT:", "RoadBlock",  "GLOBAL"] call CBA_fnc_createMarker;
	};

	_checkpointComp = ["smallCheckpoint1", "smallCheckpoint2", "mediumCheckpoint1", "mediumCheckpoint2", "smallroadblock1" , "smallroadblock2"];

	_checkpoint = [_checkpointComp call BIS_fnc_selectRandom] call ALiVE_fnc_findComposition;
	[_checkpoint,_roadpos,_direction] spawn {[_this select 0, position (_this select 1), _this select 2] call ALiVE_fnc_spawnComposition};

	// Place a vehicle
	_vehtype = ([1, _fac, "Car"] call ALiVE_fnc_findVehicleType) call BIS_fnc_selectRandom;
	_vehicle = createVehicle [_vehtype, [position _roadpos, 10,20,2,0,5,0] call BIS_fnc_findsafepos, [], 20, "NONE"];
	_vehicle setDir _direction;
	_vehicle setposATL (getposATL _vehicle);

	// Spawn static virtual group if Profile System is loaded and get them to defend
    if !(isnil "ALiVE_ProfileHandler") then {
		_group = ["Infantry",_fac] call ALIVE_fnc_configGetRandomGroup;
        _guards = [_group, position _roadpos, random(360), true, _fac, true] call ALIVE_fnc_createProfilesFromGroupConfig;

        {
            if (([_x,"type"] call ALiVE_fnc_HashGet) == "entity") then {
                [_x, "setActiveCommand", ["ALIVE_fnc_garrison","spawn",30]] call ALIVE_fnc_profileEntity;
                [_x,"busy",true] call ALIVE_fnc_hashSet;
            };
        } foreach _guards;

    // else spawn real AI and get them to defend
    } else {
		[_vehicle, _roadpos, _fac] spawn {
			private["_roadpos","_fac","_vehicle","_side","_blockers"];

			_vehicle = _this select 0;
			_roadpos = _this select 1;
			_fac = _this select 2;
			_side = _fac call ALiVE_fnc_factionSide;

			// Spawn group and get them to defend
		    _blockers = [getpos _roadpos, _side, "Infantry", _fac] call ALiVE_fnc_randomGroupByType;
			_blockers addVehicle _vehicle;

			sleep 1;

			[_blockers, getpos _roadpos, 100, true] call ALiVE_fnc_groupGarrison;
		};
    };
};
