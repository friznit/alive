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

if (_num > 6) then {_num = 6};

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

	/*

	// Define [ Gate, Blocks, Barriers, Guides, Nest, Wire, Weapon] for each faction

	_list = switch (_fac) do {
		// RU
		case "RU": {["ZavoraAnim","Land_CncBlock","RoadBarrier_long","Land_arrows_desk_L","Land_arrows_desk_R","Land_fortified_nest_small","Fort_RazorWire","M2StaticMG"]};
		// ACE_RU
	    case "ACE_RU": {["ZavoraAnim","Land_CncBlock","RoadBarrier_long","Land_arrows_desk_L","Land_arrows_desk_R","Land_fortified_nest_small","Fort_RazorWire","M2StaticMG"]};
		// GUE
		case "GUE": {["","Sign_Checkpoint","RoadBarrier_long","RoadCone","RoadCone","Land_BagFenceLong","RoadBarrier_light","SearchLight"]};
		// INS
		case "INS": {["","Sign_Checkpoint","RoadBarrier_long","RoadCone","RoadCone","Land_BagFenceLong","RoadBarrier_light","SearchLight"]};
		// BIS_TK
		case "BIS_TK": {["ZavoraAnim","Land_CncBlock","RoadBarrier_long","Land_arrows_desk_L","Land_arrows_desk_R","Land_fortified_nest_small","Fort_RazorWire","M2StaticMG"]};
		// BIS_TK_INS
		case "BIS_TK_INS": {["","Sign_Checkpoint_TK_EP1","RoadBarrier_long","Land_Pneu","Land_Pneu","","Misc_TyreHeapEP1","SearchLight_TK_INS_EP1"]};
		// Default
		default {["Land_BarGate_F","Land_CncBarrier_F","Land_BagFence_Long_F","ArrowDesk_L_F","ArrowDesk_R_F","Land_BagBunker_Small_F","Land_Razorwire_F","I_HMG_01_high_F"]};
	};

	// Ideally Workout angle (away from unit) of roadblock?

	// Place Gate
	if !(_list select 0 == "") then {
		_bg1 = _list select 0 createVehicle (_roadpos modelToWorld [0,0,0]);
		_bg1 setDir ((_direction) -360);
	};

	// Place Blocking Element (concrete, tyres etc)
	if !(_list select 1 == "") then {
		_cb1 = _list select 1 createVehicle (_roadpos modelToWorld [5,6,0]);
		_cb1 setDir ((_direction) -360);
		_cb2 = _list select 1  createVehicle (_roadpos modelToWorld [10,6,0]);
		_cb2 setDir ((_direction) -360);
		_cb3 = _list select 1  createVehicle (_roadpos modelToWorld [-5,6,0]);
		_cb3 setDir ((_direction) -360);
		_cb4 = _list select 1 createVehicle (_roadpos modelToWorld [-10,6,0]);
		_cb4 setDir ((_direction) -360);
	};

	// Place Road Barriers
	if !(_list select 2 == "") then {
		_rb1 = _list select 2 createVehicle (_roadpos modelToWorld [5,5,0]);
		_rb1 setDir ((_direction) -360);
		_rb2 = _list select 2 createVehicle (_roadpos modelToWorld [10,5,0]);
		_rb2 setDir ((_direction) -360);
		_rb3 = _list select 2 createVehicle (_roadpos modelToWorld [-5,5,0]);
		_rb3 setDir ((_direction) -360);
		_rb4 = _list select 2 createVehicle (_roadpos modelToWorld [-10,5,0]);
		_rb4 setDir ((_direction) -360);
	};

	// Place Guides

	if !(_list select 3 == "") then {
		_s1 = _list select 3 createVehicle (_roadpos modelToWorld [-4,0,0]);
		_s1 setDir ((_direction) -90);
		_s2 = _list select 3 createVehicle (_roadpos modelToWorld [-4,4,0]);
		_s2 setDir ((_direction) -90);
		_s3 = _list select 4 createVehicle (_roadpos modelToWorld [3,4,0]);
		_s3 setDir ((_direction) -270);
		_s4 = _list select 4 createVehicle (_roadpos modelToWorld [3,0,0]);
		_s4 setDir ((_direction) -270);
		_s5 = _list select 4 createVehicle (_roadpos modelToWorld [3,-4,0]);
		_s5 setDir ((_direction) -270);
		_s6 = _list select 4 createVehicle (_roadpos modelToWorld [0,-7,0]);
		_s6 setDir ((_direction) -180);
	};

	// Place Fortification

	if !(_list select 5 == "") then {
		_b1 = _list select 5 createVehicle (_roadpos modelToWorld [10,-6,0]);
		_b1 setDir ((_direction) -180);
		_b2 = _list select 5 createVehicle (_roadpos modelToWorld [-10,-6,0]);
		_b2 setDir ((_direction) -180);
	};

	// Place Wire

	if !(_list select 6 == "") then {
		_rw1 = _list select 6 createVehicle (_roadpos modelToWorld [10,8,0]);
		_rw1 setDir ((_direction) -360);
		_rw2 = _list select 6 createVehicle (_roadpos modelToWorld [-10,8,0]);
		_rw2 setDir ((_direction) -360);
	};

	// Place Weapon

	if !(_list select 7 == "") then {
		_sg1 = _list select 7 createVehicle (_roadpos modelToWorld [10,-7,0]);
		_sg1 setDir ((_direction) -360);
		_sg2 = _list select 7 createVehicle (_roadpos modelToWorld [-10,-7,0]);
		_sg2 setDir ((_direction) -360);
	};
	*/

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
                [_x, "setActiveCommand", ["ALIVE_fnc_garrison","spawn",50]] call ALIVE_fnc_profileEntity;
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

