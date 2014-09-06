#include <\x\alive\addons\mil_C2ISTAR\script_component.hpp>
SCRIPT(taskGetEnemyCluster);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_taskGetEnemyCluster

Description:
Get a enemy cluster for a task

Parameters:

Returns:

Examples:
(begin example)
(end)

See Also:

Author:
ARJay
---------------------------------------------------------------------------- */

private ["_taskLocation","_taskLocationType","_side","_enemyClusters","_debug","_result","_nextState"];

_taskLocation = _this select 0;
_taskLocationType = _this select 1;
_side = _this select 2;
_type = if(count _this > 3) then {_this select 3} else {""};

if(_type != "") then {
    _enemyClusters = [ALIVE_battlefieldAnalysis,"getClustersOwnedBySideAndType",[_side,_type]] call ALIVE_fnc_battlefieldAnalysis;
}else{
    _enemyClusters = [ALIVE_battlefieldAnalysis,"getClustersOwnedBySide",[_side]] call ALIVE_fnc_battlefieldAnalysis;
};


_targetPosition = [];

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

};

_targetPosition