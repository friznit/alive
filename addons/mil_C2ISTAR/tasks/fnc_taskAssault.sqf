#include <\x\alive\addons\mil_C2ISTAR\script_component.hpp>
SCRIPT(taskAssault);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_taskAssault

Description:
Assault Task

Parameters:

Returns:

Examples:
(begin example)
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_taskState","_taskID","_task","_params","_debug","_result","_nextState"];

_taskState = _this select 0;
_taskID = _this select 1;
_task = _this select 2;
_params = _this select 3;
_debug = _this select 4;
_result = [];

switch (_taskState) do {
	case "init":{

	    private["_taskID","_requestPlayerID","_taskSide","_taskFaction","_taskLocationType","_taskLocation","_taskEnemyFaction","_taskEnemySide","_enemyClusters","_targetPosition"];

        ["ASSAULT TASK INIT!"] call ALIVE_fnc_dump;

        _taskID = _task select 0;
        _requestPlayerID = _task select 1;
        _taskSide = _task select 2;
        _taskFaction = _task select 3;
        _taskLocationType = _task select 5;
        _taskLocation = _task select 6;
        _taskPlayers = _task select 7;
        _taskEnemyFaction = _task select 8;

        _taskEnemySide = _taskEnemyFaction call ALiVE_fnc_factionSide;
        _taskEnemySide = [_taskEnemySide] call ALIVE_fnc_sideObjectToNumber;
        _taskEnemySide = [_taskEnemySide] call ALIVE_fnc_sideNumberToText;


        // establish the location for the task

        _enemyClusters = [ALIVE_battlefieldAnalysis,"getClustersOwnedBySide",[_taskEnemySide]] call ALIVE_fnc_battlefieldAnalysis;

        _enemyClusters = [];

        if(count _enemyClusters > 0) then {

            private["_sortedSectors","_countClusters","_targetCluster"];

            // there are enemy held clusters

            _sortedClusters = [_enemyClusters,[],{_taskLocation distance ([_x, "position"] call ALIVE_fnc_hashGet)},"ASCEND"] call BIS_fnc_sortBy;

            _countClusters = count _sortedClusters;

            if(_taskLocationType == "Map" || _taskLocationType == "Short") then {
                _targetCluster = _sortedClusters select 0;
            };

            if(_taskLocationType == "Medium") then {
                _targetCluster = _sortedClusters select (floor(_countClusters/2));
            };

            if(_taskLocationType == "Long") then {
                _targetCluster = _sortedClusters select (_countClusters-1);
            };

            _targetPosition = [_targetCluster, "position"] call ALIVE_fnc_hashGet;

            ["TARGET:"] call ALIVE_fnc_dump;
            _targetCluster call ALIVE_fnc_inspectHash;
            [_targetPosition] call ALIVE_fnc_placeDebugMarker;

        }else{

            private["_enemySectors","_sortedSectors","_countSectors","_spawnSectors","_position","_targetSector",
            "_sectorData","_bestPlaces","_flatEmpty","_exposedHills"];

            // no enemy held clusters
            // try to find sectors containing enemy profiles

            _enemySectors = [ALIVE_battlefieldAnalysis,"getSectorsContainingSide",[_taskEnemySide]] call ALIVE_fnc_battlefieldAnalysis;

            if(count _enemySectors > 0) then {

                _sortedSectors = [_enemySectors, _taskLocation] call ALIVE_fnc_sectorSortDistance;

                _spawnSectors = [];

                {
                    _position = [_x, "position"] call ALIVE_fnc_hashGet;
                    if([_position, 1000] call ALiVE_fnc_anyPlayersInRange == 0) then {
                        _spawnSectors set [count _spawnSectors, _x];
                    };
                } forEach _sortedSectors;

                _countSectors = count _spawnSectors;

                if(_countSectors > 0) then {

                    if(_taskLocationType == "Map" || _taskLocationType == "Short") then {
                        _targetSector = _spawnSectors select 0;
                    };

                    if(_taskLocationType == "Medium") then {
                        _targetSector = _spawnSectors select (floor(_countSectors/2));
                    };

                    if(_taskLocationType == "Long") then {
                        _targetSector = _spawnSectors select (_countSectors-1);
                    };

                    _targetPosition = [_targetSector, "position"] call ALIVE_fnc_hashGet;

                    ["TARGET:"] call ALIVE_fnc_dump;
                    _targetSector call ALIVE_fnc_inspectHash;
                    [_targetSector,"debug",true] call ALIVE_fnc_sector;

                    // got a sector with enemy
                    // refine position with more analysis data

                    _sectorData = [_targetSector,"data"] call ALIVE_fnc_hashGet;
                    _bestPlaces = [_sectorData,"bestPlaces"] call ALIVE_fnc_hashGet;
                    _flatEmpty = [_sectorData,"flatEmpty"] call ALIVE_fnc_hashGet;

                    if("exposedHills" in (_bestPlaces select 1)) then {
                        _exposedHills = [_bestPlaces,"exposedHills"] call ALIVE_fnc_hashGet;
                        if(count _exposedHills > 0) then {
                            _targetPosition = _exposedHills call BIS_fnc_selectRandom;
                        }else{
                            if(count _flatEmpty > 0) then {
                                _targetPosition = _flatEmpty call BIS_fnc_selectRandom;
                            };
                        };
                    }else{
                        if(count _flatEmpty > 0) then {
                            _targetPosition = _flatEmpty call BIS_fnc_selectRandom;
                        };
                    };

                    [_targetPosition] call ALIVE_fnc_placeDebugMarker;

                    private["_compositions","_composition","_group","_infantryGroups","_guardGroup","_guards","position"];

                    // spawn a composition at the position

                    _compositions = [ALIVE_compositions,"objectives"] call ALIVE_fnc_hashGet;
                    _composition = _compositions call BIS_fnc_selectRandom;

                    _composition = [_composition] call ALIVE_fnc_findComposition;

                    if(count _composition > 0) then {
                        [_composition, _targetPosition, random 360] call ALIVE_fnc_spawnComposition;
                    };

                    _infantryGroups = [];
                    for "_i" from 0 to _countInfantry -1 do {
                        _group = ["Infantry",_taskEnemyFaction] call ALIVE_fnc_configGetRandomGroup;
                        if!(_group == "FALSE") then {
                            _infantryGroups set [count _infantryGroups, _group];
                        }
                    };

                    if(count _infantryGroups > 0) then {
                        _guardGroup = _infantryGroups call BIS_fnc_selectRandom;
                        _guards = [_guardGroup, _targetPosition, random(360), true, _taskEnemyFaction, true] call ALIVE_fnc_createProfilesFromGroupConfig;

                        {
                            if (([_x,"type"] call ALiVE_fnc_HashGet) == "entity") then {
                                [_x, "setActiveCommand", ["ALIVE_fnc_garrison","spawn",200]] call ALIVE_fnc_profileEntity;
                            };
                        } foreach _guards;
                    };

                    for "_i" from 0 to (count _infantryGroups) -1 do {

                        _group = _infantryGroups select _i;

                        _position = [_targetPosition, (random(50)), random(360)] call BIS_fnc_relPos;

                        if!(surfaceIsWater _position) then {

                            [_group, _position, random(360), false, _faction, true] call ALIVE_fnc_createProfilesFromGroupConfig;

                        };
                    };

                };

            };

        };

        if!(isNil "_targetPosition") then {

            private["_parentTask","_childTask1ID","_childTask1","_childTask2ID","_childTask2","_taskParams"];

            _parentTask = [_taskID,_requestPlayerID,_taskSide,_targetPosition,_taskFaction,"ASSAULT","ASSAULT",_taskPlayers,"Created","Group","N","None","Assault"];

            _childTask1ID = format["%1_c1",_taskID];
            _childTaskSource = format["%1-Assault-Travel",_taskID];
            _childTask1 = [_childTask1ID,_requestPlayerID,_taskSide,_targetPosition,_taskFaction,"TRAVEL","TRAVEL",_taskPlayers,"Created","Group","N",_taskID,_childTaskSource];

            _childTask2ID = format["%1_c2",_taskID];
            _childTaskSource = format["%1-Assault-Destroy",_taskID];
            _childTask2 = [_childTask2ID,_requestPlayerID,_taskSide,_targetPosition,_taskFaction,"DESTROY","DESTROY",_taskPlayers,"Created","Group","N",_taskID,_childTaskSource];

            _taskParams = [] call ALIVE_fnc_hashCreate;
            [_taskParams,"nextTask",_childTask1ID] call ALIVE_fnc_hashSet;
            [_taskParams,"taskIDs",[_taskID,_childTask1ID,_childTask2ID]] call ALIVE_fnc_hashSet;

            _result = [[_parentTask,_childTask1,_childTask2],_taskParams];

        };

	};
	case "Travel":{

	    private["_taskID","_requestPlayerID","_taskSide","_taskPosition","_taskFaction","_taskTitle","_taskDescription","_taskPlayers",
	    "_player","_position","_distance","_taskIDs"];

	    _taskID = _task select 0;
        _requestPlayerID = _task select 1;
        _taskSide = _task select 2;
        _taskPosition = _task select 3;
        _taskFaction = _task select 4;
        _taskTitle = _task select 5;
        _taskDescription = _task select 6;
        _taskPlayers = _task select 7 select 0;

        {
            _player = [_x] call ALIVE_fnc_getPlayerByUID;

            if !(isNull _player) then {
                _position = position _player;
                _distance = _position distance _taskPosition;

                // if any player is near the travel position
                // mark the task as succeeded
                // set the destroy task as the next task

                if(_distance <= 50) exitWith {

                    _taskIDs = [_params,"taskIDs"] call ALIVE_fnc_hashGet;
                    [_params,"nextTask",_taskIDs select 2] call ALIVE_fnc_hashSet;

                    _task set [8,"Succeeded"];
                    _task set [10, "N"];
                    _result = _task;
                };
            };

        } forEach _taskPlayers;


    };
    case "Destroy":{

        private["_taskID","_requestPlayerID","_taskSide","_taskPosition","_taskFaction","_taskTitle","_taskDescription","_taskPlayers",
        "_playersNear","_player","_position","_distance"];

        _taskID = _task select 0;
        _requestPlayerID = _task select 1;
        _taskSide = _task select 2;
        _taskPosition = _task select 3;
        _taskFaction = _task select 4;
        _taskTitle = _task select 5;
        _taskDescription = _task select 6;
        _taskPlayers = _task select 7 select 0;

        _playersNear = false;

        {
            _player = [_x] call ALIVE_fnc_getPlayerByUID;

            if !(isNull _player) then {
                _position = position _player;
                _distance = _position distance _taskPosition;

                // if any player is near the position

                if(_distance < 1000) exitWith {

                    _playersNear = true;
                };
            };

        } forEach _taskPlayers;

        // there are players near the objective

        if(_playersNear) then {

            _enemyNear = [_taskPosition, _taskSide, 500] call ALIVE_fnc_isEnemyNear;

            if!(_enemyNear) then {

                [_params,"nextTask",""] call ALIVE_fnc_hashSet;

                _task set [8,"Succeeded"];
                _task set [10, "N"];
                _result = _task;

            };

        };

    };
};

_result