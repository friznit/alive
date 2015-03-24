//#define DEBUG_MODE_FULL
#include <\x\alive\addons\mil_opcom\script_component.hpp>
SCRIPT(INS_helpers);

/* ----------------------------------------------------------------------------
Function: ALiVE_fnc_INS_helpers
Description:
Helper Function to keep transferred and stored code small

Base class for OPCOM objects to inherit from

Parameters:
Several
_timeTaken = _this select 0; //number
_pos = _this select 1; //array
_id = _this select 2; //string
_size = _this select 3; //number
_faction = _this select 4; //string
_factory = _this select 5; //array of [_pos,_class]
_target = _this select 6; //array of [_pos,_class]
_sides = _this select 7; //array of side as strings
_agents = _this select 8; //array of strings
 
Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
none

Examples:
(begin example)
// no example
(end)

See Also:

Author:
Highhead

Peer reviewed:
nil
---------------------------------------------------------------------------- */

ALiVE_fnc_INS_assault = {
				private ["_timeTaken","_pos","_id","_size","_faction","_sides","_agents","_building","_objective"];

				_timeTaken = _this select 0;
				_pos = _this select 1;
				_id = _this select 2;
				_size = _this select 3;
				_faction = _this select 4;
				_sides = _this select 5;
				_agents = _this select 6;
				_allSides = ["EAST","WEST","GUER"];
				_objective = [[],"getobjectivebyid",_id] call ALiVE_fnc_OPCOM;

				// Timeout
				waituntil {time - _timeTaken > 120};

				// Add TACOM suicide command on one ambient civilian agents
				{
					private ["_agent"];
				    _agent = [ALiVE_AgentHandler,"getAgent",_x] call ALiVE_fnc_AgentHandler;
					if !(isnil "_agent") exitwith {[_agent, "setActiveCommand", ["ALIVE_fnc_cc_suicideTarget", "managed", [_sides]]] call ALIVE_fnc_civilianAgent};
				} foreach _agents;

				[_pos,_sides, 20] call ALiVE_fnc_updateSectorHostility;
				[_pos,_allSides - _sides, -20] call ALiVE_fnc_updateSectorHostility;
};

ALiVE_fnc_INS_ambush = {
				private ["_timeTaken","_pos","_id","_size","_faction","_sides","_agents","_road","_roadObject","_objective"];

				_timeTaken = _this select 0;
				_pos = _this select 1;
				_id = _this select 2;
				_size = _this select 3;
				_faction = _this select 4;
				_road = _this select 5;
				_sides = _this select 6;
				_agents = _this select 7;
				_allSides = ["EAST","WEST","GUER"];
				_objective = [[],"getobjectivebyid",_id] call ALiVE_fnc_OPCOM;

				// Convert to data that can be persistet
				_roadObject = [[],"convertObject",_road] call ALiVE_fnc_OPCOM;

				// Establish ambush position
				if (alive _roadObject) then {[_objective,"ambush",_road] call ALiVE_fnc_HashSet};

				// Add TACOM suicide command on one ambient civilian agents
				{
					private ["_agent"];
				    _agent = [ALiVE_AgentHandler,"getAgent",_x] call ALiVE_fnc_AgentHandler;
					if !(isnil "_agent") exitwith {[_agent, "setActiveCommand", ["ALIVE_fnc_cc_suicideTarget", "managed", [_sides]]] call ALIVE_fnc_civilianAgent};
				} foreach _agents;

				[_pos,_sides, 20] call ALiVE_fnc_updateSectorHostility;
				[_pos,_allSides - _sides, -20] call ALiVE_fnc_updateSectorHostility;

				// Wait 15 minutes for any enemy vehicles to pass before reassigning
				_timeTaken = time; waituntil {time - _timeTaken > 900};

				// Remove ambush marker
				if (alive _roadObject) then {deletemarker format["Ambush_%1",getposATL _roadObject]; [_objective,"ambush"] call ALiVE_fnc_HashRem};
};

ALiVE_fnc_INS_retreat = {
				private ["_timeTaken","_pos","_id","_size","_faction","_sides","_agents","_objective"];

				_timeTaken = _this select 0;
				_pos = _this select 1;
				_id = _this select 2;
				_size = _this select 3;
				_faction = _this select 4;
				_sides = _this select 5;
				_agents = _this select 6;
				_allSides = ["EAST","WEST","GUER"];
				_objective = [[],"getobjectivebyid",_id] call ALiVE_fnc_OPCOM;

				// Timeout
				waituntil {time - _timeTaken > 120};

				// Add TACOM IED command on all selected agents
				{
					private ["_agent"];
				    _agent = [ALiVE_AgentHandler,"getAgent",_x] call ALiVE_fnc_AgentHandler;
					if !(isnil "_agent") exitwith {[_agent, "setActiveCommand", ["ALIVE_fnc_cc_rogueTarget", "managed", [_allSides - _sides]]] call ALIVE_fnc_civilianAgent};
				} foreach _agents;

				//remove installations if existing
				{
					_object = [[],"convertObject",[_objective,_x,[]] call ALiVE_fnc_HashGet] call ALiVE_fnc_OPCOM;

					if (alive _object && {_x in ["ied","suicide"]}) then {deletevehicle _object};
					if (alive _object) then {_object setdamage 1; deleteMarker format["%1_%2",_x,_id]};

					[_objective,_x] call ALiVE_fnc_HashRem;
				} foreach ["factory","hq","ambush","depot","sabotage","ied","suicide"];
};

ALiVE_fnc_INS_factory = {
				private ["_timeTaken","_pos","_center","_id","_size","_faction","_sides","_agents","_building","_objective","_CQB"];

				_timeTaken = _this select 0;
				_pos = _this select 1;
				_id = _this select 2;
				_size = _this select 3;
				_faction = _this select 4;
				_factory = _this select 5;
				_sides = _this select 6;
				_agents = _this select 7;
				_CQB = _this select 8;
				_allSides = ["EAST","WEST","GUER"];
				_objective = [[],"getobjectivebyid",_id] call ALiVE_fnc_OPCOM;

				// Convert to data that can be persistet
				_factory = [[],"convertObject",_factory] call ALiVE_fnc_OPCOM;

				// Convert CQB modules
				{_CQB set [_foreachIndex,[[],"convertObject",_x] call ALiVE_fnc_OPCOM]} foreach _CQB;

				// Timeout
				waituntil {time - _timeTaken > 120};

				// Store center position
				_center = _pos;

				// Establish factory
				if (alive _factory) then {
					// Get indoor position of factory
					_pos = ([getposATL _factory,20] call ALIVE_fnc_findIndoorHousePositions) call BIS_fnc_SelectRandom;

					// Create factory
                    _factory call ALiVE_fnc_INS_spawnIEDfactory;

					// Create virtual guards
					{[_x,"addHouse",_factory] call ALiVE_fnc_CQB} foreach _CQB;

					// Set factory
					[_objective,"factory",[[],"convertObject",_factory] call ALiVE_fnc_OPCOM] call ALiVE_fnc_HashSet;
				};

				// Add TACOM IED command on all selected agents
				{
					private ["_agent"];
				    _agent = [ALiVE_AgentHandler,"getAgent",_x] call ALiVE_fnc_AgentHandler;
					if !(isnil "_agent") exitwith {[_agent, "setActiveCommand", ["ALIVE_fnc_cc_getWeapons", "managed", [_pos]]] call ALIVE_fnc_civilianAgent};
				} foreach _agents;

				// Reset to center position
				_pos = _center;

				[_pos,_sides, 20] call ALiVE_fnc_updateSectorHostility;
				[_pos, _allSides - _sides, -20] call ALiVE_fnc_updateSectorHostility;
};

ALiVE_fnc_INS_ied = {
				private ["_timeTaken","_pos","_id","_size","_faction","_sides","_agents","_building","_section","_objective"];

				_timeTaken = _this select 0;
				_pos = _this select 1;
				_id = _this select 2;
				_size = _this select 3;
				_faction = _this select 4;
				_factory = _this select 5;
				_sides = _this select 6;
				_agents = _this select 7;
				_allSides = ["EAST","WEST","GUER"];
				_objective = [[],"getobjectivebyid",_id] call ALiVE_fnc_OPCOM;

				// Convert to data that can be persistet
				_factory = [[],"convertObject",_factory] call ALiVE_fnc_OPCOM;

				// Timeout
				waituntil {time - _timeTaken > 120};

				// Place ambient IED trigger
				if (!isnil "ALiVE_mil_IED") then {
					_trg = createTrigger ["EmptyDetector",_pos];
					_trg setTriggerArea [_size + 250, _size + 250,0,false];
					_trg setTriggerActivation ["ANY","PRESENT",true];
					_trg setTriggerStatements [
						"this && {(vehicle _x in thisList) && ((getposATL _x) select 2 < 25)} count ([] call BIS_fnc_listPlayers) > 0",
   						 format["null = [getpos thisTrigger,%1,%2,%3] call ALIVE_fnc_createIED",_size,str(_id),ceil(_size/100)],
   						 format["null = [getpos thisTrigger,%1] call ALIVE_fnc_removeIED",str(_id)]
					];
					[_objective,"ied",[[],"convertObject",_trg] call ALiVE_fnc_OPCOM] call ALiVE_fnc_HashSet;
				};

				// Add TACOM rogue command on all selected agents
				{
					private ["_agent"];
				    _agent = [ALiVE_AgentHandler,"getAgent",_x] call ALiVE_fnc_AgentHandler;
					if !(isnil "_agent") exitwith {[_agent, "setActiveCommand", ["ALIVE_fnc_cc_rogueTarget", "managed", [_sides]]] call ALIVE_fnc_civilianAgent};
				} foreach _agents;

				[_pos,_sides, 20] call ALiVE_fnc_updateSectorHostility;
				[_pos, _allSides - _sides, -20] call ALiVE_fnc_updateSectorHostility;
};

ALiVE_fnc_INS_suicide = {
				private ["_timeTaken","_pos","_id","_size","_faction","_sides","_agents","_building","_objective","_civFactions"];

				_timeTaken = _this select 0;
				_pos = _this select 1;
				_id = _this select 2;
				_size = _this select 3;
				_faction = _this select 4;
				_factory = _this select 5;
				_sides = _this select 6;
				_agents = _this select 7;
				_civFactions = _this select 8;
				_allSides = ["EAST","WEST","GUER"];
				_objective = [[],"getobjectivebyid",_id] call ALiVE_fnc_OPCOM;

				// Convert to data that can be persistet
				_factory = [[],"convertObject",_factory] call ALiVE_fnc_OPCOM;

				// Timeout
				waituntil {time - _timeTaken > 120};

				// Place ambient suiciders trigger
				if (!isnil "ALiVE_mil_IED") then {
					_trg = createTrigger ["EmptyDetector",_pos];
					_trg setTriggerArea [_size + 250, _size + 250,0,false];
					_trg setTriggerActivation ["ANY","PRESENT",true];
					_trg setTriggerStatements [
						"this && ({(vehicle _x in thisList) && ((getposATL _x) select 2 < 25)} count ([] call BIS_fnc_listPlayers) > 0)",
						format ["null = [[getpos thisTrigger,%1,'%2'],thisList] call ALIVE_fnc_createBomber", _size, _civFactions call BIS_fnc_SelectRandom],
				 		""
					];
					[_objective,"suicide",[[],"convertObject",_trg] call ALiVE_fnc_OPCOM] call ALiVE_fnc_HashSet;
				};

				// Add TACOM suicide command on one ambient civilian agents
				{
					private ["_agent"];
				    _agent = [ALiVE_AgentHandler,"getAgent",_x] call ALiVE_fnc_AgentHandler;
					if !(isnil "_agent") exitwith {[_agent, "setActiveCommand", ["ALIVE_fnc_cc_suicideTarget", "managed", [_sides]]] call ALIVE_fnc_civilianAgent};
				} foreach _agents;

				[_pos,_sides, 20] call ALiVE_fnc_updateSectorHostility;
				[_pos, _allSides - _sides, -20] call ALiVE_fnc_updateSectorHostility;
};

ALiVE_fnc_INS_sabotage = {
				private ["_timeTaken","_pos","_id","_size","_faction","_sides","_agents","_building","_target","_profileID","_objective"];

				_timeTaken = _this select 0;
				_pos = _this select 1;
				_id = _this select 2;
				_size = _this select 3;
				_faction = _this select 4;
				_factory = _this select 5;
				_target = _this select 6;
				_sides = _this select 7;
				_agents = _this select 8;
				_allSides = ["EAST","WEST","GUER"];
				_objective = [[],"getobjectivebyid",_id] call ALiVE_fnc_OPCOM;

				// Convert to data that can be persistet
				_factory = [[],"convertObject",_factory] call ALiVE_fnc_OPCOM;
				_target = [[],"convertObject",_target] call ALiVE_fnc_OPCOM;

				// Timeout
				waituntil {time - _timeTaken > 120};

				// Assign sabotage target
				if (alive _target) then {[_objective,"sabotage",[[],"convertObject",_target] call ALiVE_fnc_OPCOM] call ALiVE_fnc_HashSet};

				// Add TACOM Sabotage command on all selected agents
				{
					private ["_agent"];
				     _agent = [ALiVE_AgentHandler,"getAgent",_x] call ALiVE_fnc_AgentHandler;
					if !(isnil "_agent") exitwith {[_agent, "setActiveCommand", ["ALIVE_fnc_cc_sabotage", "managed", [getposATL _target]]] call ALIVE_fnc_civilianAgent};
				} foreach _agents;

				[_pos,_sides, 20] call ALiVE_fnc_updateSectorHostility;
				[_pos, _allSides - _sides, -20] call ALiVE_fnc_updateSectorHostility;
};

ALiVE_fnc_INS_roadblocks = {
				private ["_timeTaken","_pos","_id","_size","_faction","_sides","_agents","_building","_CQB","_objective"];

				_timeTaken = _this select 0;
				_pos = _this select 1;
				_id = _this select 2;
				_size = _this select 3;
				_faction = _this select 4;
				_building = _this select 5;
				_sides = _this select 6;
				_agents = _this select 7;
				_CQB = _this select 8;
				_allSides = ["EAST","WEST","GUER"];
				_objective = [[],"getobjectivebyid",_id] call ALiVE_fnc_OPCOM;

				// Convert to data that can be persistet
				_building = [[],"convertObject",_building] call ALiVE_fnc_OPCOM;

				// Timeout
				waituntil {time - _timeTaken > 120};

				// Add TACOM IED command on all selected agents
				{
					private ["_agent"];
				    _agent = [ALiVE_AgentHandler,"getAgent",_x] call ALiVE_fnc_AgentHandler;
					if !(isnil "_agent") exitwith {[_agent, "setActiveCommand", ["ALIVE_fnc_cc_rogueTarget", "managed", [_sides]]] call ALIVE_fnc_civilianAgent};
				} foreach _agents;

				// Convert CQB modules
				{_CQB set [_foreachIndex,[[],"convertObject",_x] call ALiVE_fnc_OPCOM]} foreach _CQB;

				// Spawn CQB
				[_pos,_size,_CQB] spawn ALiVE_fnc_addCQBpositions;
				
				// Spawn roadblock
				[_pos, _size, ceil(_size/200), true] call ALiVE_fnc_createRoadblock;

				[_pos, _sides, 20] call ALiVE_fnc_updateSectorHostility;
				[_pos, _allSides - _sides, -20] call ALiVE_fnc_updateSectorHostility;
};

ALiVE_fnc_INS_depot = {
				private ["_timeTaken","_center","_id","_size","_faction","_sides","_agents","_depot","_CQB","_objective"];

				_timeTaken = _this select 0;
				_pos = _this select 1;
				_id = _this select 2;
				_size = _this select 3;
				_faction = _this select 4;
				_depot = _this select 5;
				_sides = _this select 6;
				_agents = _this select 7;
				_CQB = _this select 8;
				_allSides = ["EAST","WEST","GUER"];
				_objective = [[],"getobjectivebyid",_id] call ALiVE_fnc_OPCOM;
                
                // Store center position
                _center = _pos;

				// Convert to data that can be persistet
				_depot = [[],"convertObject",_depot] call ALiVE_fnc_OPCOM;

				// Convert CQB modules
				{_CQB set [_foreachIndex,[[],"convertObject",_x] call ALiVE_fnc_OPCOM]} foreach _CQB;

				// Timeout
				waituntil {time - _timeTaken > 120};

				// Establish Depot
				if (alive _depot) then {
					// Get indoor position of factory
					_pos = ([getposATL _depot,15] call ALIVE_fnc_findIndoorHousePositions) call BIS_fnc_SelectRandom;

					// Create Box
					_box = "Box_East_AmmoOrd_F" createVehicle _pos; _pos set [2,1]; _box setposATL _pos; _box setvelocity [0,0,-0.01]; _box setdir getdir _depot;

					// Create virtual guards
					{[_x,"addHouse",_depot] call ALiVE_fnc_CQB} foreach _CQB;

					// Set depot
					[_objective,"depot",[[],"convertObject",_depot] call ALiVE_fnc_OPCOM] call ALiVE_fnc_HashSet;
				};

				// Add TACOM get weapons command on all selected agents
				{
					private ["_agent"];
				    _agent = [ALiVE_AgentHandler,"getAgent",_x] call ALiVE_fnc_AgentHandler;
					if (!isnil "_agent" && {_foreachIndex < 3}) then {[_agent, "setActiveCommand", ["ALIVE_fnc_cc_getWeapons", "managed", [_pos]]] call ALIVE_fnc_civilianAgent};
				} foreach _agents;
                
                // Restore center position
                _pos = _center;                

				// Spawn CQB
				[_pos,_size,_CQB] spawn ALiVE_fnc_addCQBpositions;

				[_pos,_sides, 20] call ALiVE_fnc_updateSectorHostility;
				[_pos,_allSides - _sides, -20] call ALiVE_fnc_updateSectorHostility;
};

ALiVE_fnc_INS_recruit = {
				private ["_timeTaken","_pos","_id","_size","_faction","_sides","_agents","_HQ","_CQB","_objective"];

				_timeTaken = _this select 0;
				_pos = _this select 1;
				_id = _this select 2;
				_size = _this select 3;
				_faction = _this select 4;
				_HQ = _this select 5;
				_sides = _this select 6;
				_agents = _this select 7;
				_CQB = _this select 8;
				_allSides = ["EAST","WEST","GUER"];
				_objective = [[],"getobjectivebyid",_id] call ALiVE_fnc_OPCOM;

                // Store center position
                _center = _pos;

				// Convert to data that can be persistet
				_HQ = [[],"convertObject",_HQ] call ALiVE_fnc_OPCOM;

				// Convert CQB modules
				{_CQB set [_foreachIndex,[[],"convertObject",_x] call ALiVE_fnc_OPCOM]} foreach _CQB;

				// Timeout
				waituntil {time - _timeTaken > 120};

				// Establish HQ
				if (alive _HQ) then {
                    // Create HQ
                    _HQ call ALiVE_fnc_INS_spawnHQ;
                    
                    // Get indoor Housepos
                    _pos = ([getposATL _HQ,15] call ALIVE_fnc_findIndoorHousePositions) call BIS_fnc_SelectRandom;
                    
					// Create virtual guards
					{[_x,"addHouse",_HQ] call ALiVE_fnc_CQB} foreach _CQB;
					
					// Set HQ
					[_objective,"HQ",[[],"convertObject",_HQ] call ALiVE_fnc_OPCOM] call ALiVE_fnc_HashSet;
				};

				// Add TACOM IED command on all selected agents
				{
					private ["_agent"];
				    _agent = [ALiVE_AgentHandler,"getAgent",_x] call ALiVE_fnc_AgentHandler;
					if (!isnil "_agent" && {_foreachIndex < 3}) then {[_agent, "setActiveCommand", ["ALIVE_fnc_cc_getWeapons", "managed", [_pos]]] call ALIVE_fnc_civilianAgent};
				} foreach _agents;

                // Restore center position
                _pos = _center;

				// Add CQB
				[_pos,_size,_CQB] spawn ALiVE_fnc_addCQBpositions;

				// Recruit 5 times
				[_pos,_size,_id,_faction,_HQ,_sides,_agents] spawn {
					private ["_pos","_size","_id","_faction","_targetBuilding","_sides","_agents"];
					
					_pos = _this select 0;
					_size = _this select 1;
					_id = _this select 2;
					_faction = _this select 3;
					_HQ = _this select 4;
					_sides = _this select 5;
					_agents = _this select 6;
					_allSides = ["EAST","WEST","GUER"];

					for "_i" from 1 to (count _agents) do {
						_group = ["Infantry",_faction] call ALIVE_fnc_configGetRandomGroup;
						_recruits = [_group, [_pos,_size] call CBA_fnc_RandPos, random(360), true, _faction] call ALIVE_fnc_createProfilesFromGroupConfig;
						{[_x, "setActiveCommand", ["ALIVE_fnc_ambientMovement","spawn",_size + 200]] call ALIVE_fnc_profileEntity} foreach _recruits;

						[_pos,_sides, 10] call ALiVE_fnc_updateSectorHostility;
						[_pos,_allSides - _sides, -10] call ALiVE_fnc_updateSectorHostility;	
					
						sleep (900 + random 600);
					};
				};
};

ALiVE_fnc_INS_idle = {true};

ALiVE_fnc_createRandomFurniture = {
    
	_building = _this;
    
    _furniture = ["Land_TableDesk_F","Land_WoodenTable_small_F","Land_RattanTable_01_F"];
    
    _furniture = _furniture call BIS_fnc_SelectRandom;
	_pos = ([getpos _building,15] call ALIVE_fnc_findIndoorHousePositions) call BIS_fnc_SelectRandom;
	
	_furniture = createVehicle [_furniture, _pos, [], 0, "CAN_COLLIDE"];
	_furniture setdir getdir _building;
	
	_furniture;
};

ALiVE_fnc_getRelativeTop = {

	_object = _this;

	_bbr = boundingBoxReal _object;
	_p1 = _bbr select 0; _p2 = _bbr select 1;
	_height = abs((_p2 select 2)-(_p1 select 2));
    _height/2;
};

ALiVE_fnc_INS_spawnIEDfactory = {

	_building = _this;

	for "_i" from 1 to (ceil (([_building] call ALIVE_fnc_getMaxBuildingPositions)/3)) do {
	    _furniture = _building call ALiVE_fnc_createRandomFurniture;
	    
		_bomb = createVehicle [["DemoCharge_Remote_Ammo_Scripted","IEDLandBig_Remote_Ammo","IEDLandSmall_Remote_Ammo","IEDUrbanBig_Remote_Ammo","IEDUrbanSmall_Remote_Ammo"] call BIS_fnc_SelectRandom, getposATL _furniture, [], 0, "CAN_COLLIDE"];
		_bomb attachTo [_furniture, [0,0,_furniture call ALiVE_fnc_getRelativeTop]];
	};
};

ALiVE_fnc_INS_spawnHQ = {

	_building = _this;
    
    _maxPos = [_building] call ALIVE_fnc_getMaxBuildingPositions;

	for "_i" from 1 to (ceil (_maxPos/3)) do {
	    _furniture = _building call ALiVE_fnc_createRandomFurniture;
	    
		_bomb = createVehicle [["DemoCharge_Remote_Ammo_Scripted","IEDLandBig_Remote_Ammo","IEDLandSmall_Remote_Ammo","IEDUrbanBig_Remote_Ammo","IEDUrbanSmall_Remote_Ammo"] call BIS_fnc_SelectRandom, getposATL _furniture, [], 0, "CAN_COLLIDE"];
		_bomb attachTo [_furniture, [0,0,_furniture call ALiVE_fnc_getRelativeTop]];
        
        _object = createVehicle [["Fridge_01_open_F","Land_MapBoard_F","Land_WaterCooler_01_new_F"] call BIS_fnc_SelectRandom, _building buildingpos (floor(random _maxPos)), [], 0, "CAN_COLLIDE"];
	};
};