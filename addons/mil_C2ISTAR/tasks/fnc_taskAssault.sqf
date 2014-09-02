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

private ["_taskState","_taskID","_args","_state","_debug","_nextState","_nextStateArgs"];

_taskState = _this select 0;
_taskID = _this select 1;
_args = _this select 2;
_debug = _this select 3;
_result = [];

_nextState = _taskState;
_nextStateArgs = [];


switch (_taskState) do {
	case "init":{

	    private["_taskSide","_taskFaction","_taskLocationType","_taskLocation","_taskEnemyFaction","_taskSide","_enemyClusters"];

        ["ASSAULT TASK INIT!"] call ALIVE_fnc_dump;

        // establish the location for the task

        _args call ALIVE_fnc_inspectArray;

        _taskSide = _args select 2;
        _taskFaction = _args select 3;
        _taskLocationType = _taskData select 5;
        _taskLocation = _args select 6;
        _taskEnemyFaction = _taskData select 8;

        _taskSide = _taskEnemyFaction call ALiVE_fnc_factionSide;
        _taskSide = [_taskSide] call ALIVE_fnc_sideObjectToNumber;
        _taskSide = [_taskSide] call ALIVE_fnc_sideNumberToText;

        _enemyClusters = [ALIVE_battlefieldAnalysis,"getClustersOwnedBySide",[_taskSide]] call ALIVE_fnc_battlefieldAnalysis;

        _enemyClusters = [];

        if(count _enemyClusters > 0) then {

            private["_sortedSectors","_countClusters","_targetCluster","_targetPosition"];

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

            private["_enemySectors","_sortedSectors","_countSectors","_targetSector","_targetPosition",
            "_sectorData","_bestPlaces","_flatEmpty","_exposedHills","_compositions"];

            // no enemy held clusters
            // try to find sectors containing enemy profiles

            _enemySectors = [ALIVE_battlefieldAnalysis,"getSectorsContainingSide",[_taskSide]] call ALIVE_fnc_battlefieldAnalysis;

            if(count _enemySectors > 0) then {

                _sortedSectors = [_enemySectors, _taskLocation] call ALIVE_fnc_sectorSortDistance;

                _countSectors = count _sortedSectors;

                if(_taskLocationType == "Map" || _taskLocationType == "Short") then {
                    _targetSector = _sortedSectors select 0;
                };

                if(_taskLocationType == "Medium") then {
                    _targetSector = _sortedSectors select (floor(_countSectors/2));
                };

                if(_taskLocationType == "Long") then {
                    _targetSector = _sortedSectors select (_countSectors-1);
                };

                _targetPosition = [_targetSector, "center"] call ALIVE_fnc_hashGet;

                ["TARGET:"] call ALIVE_fnc_dump;
                _targetSector call ALIVE_fnc_inspectHash;
                [_targetSector,"debug",true] call ALIVE_fnc_sector;

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

                _compositions = [ALIVE_compositions,"objectives"] call ALIVE_fnc_hashGet;
                _composition = _compositions call BIS_fnc_selectRandom;

                _composition = [_composition] call ALIVE_fnc_findComposition;

                if(count _composition > 0) then {
                    [_composition, _targetPosition, random 360] call ALIVE_fnc_spawnComposition;
                };

            };

        }

	};
	case "start":{

    };
};

_result