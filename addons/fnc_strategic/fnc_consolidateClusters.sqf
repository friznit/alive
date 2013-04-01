#include <\x\alive\addons\fnc_strategic\script_component.hpp>
SCRIPT(consolidateClusters);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_consolidateClusters

Description:
Returns a consolidated list of logics representing clusters of objects

Parameters:
Array - A master list of objects to identify clusters
Array - A list of clusters possibly over-lapping master entries (optional)

Returns:
Array - Contains two arrays, the master list and the remaining entires in the redundant list

Examples:
(begin example)
// identify redundant clusters after a merge
_clusters = [_master_list, _redundant_list] call ALIVE_fnc_consolidateClusters;
_new_master = _clusters select 0;
_new_redundant = _clusters select 1;
(end)

See Also:
- <ALIVE_fnc_chooseInitialCenters>
- <ALIVE_fnc_assignPointsToClusters>
- <ALIVE_fnc_findClusterCenter>
- <ALIVE_fnc_findClusters>

Author:
Wolffy.au
---------------------------------------------------------------------------- */

#define MIN_DISTANCE 250

private ["_master","_redundant","_err"];
PARAMS_1(_master)
DEFAULT_PARAM(1,_redundant,_master);
_err = "objects provided not valid";
ASSERT_DEFINED("_master", _err);
ASSERT_DEFINED("_redundant", _err);
ASSERT_OP(typeName _master, == ,"ARRAY", _err);
ASSERT_OP(typeName _redundant, == ,"ARRAY", _err);
ASSERT_OP(count _master,>,0,_err);
ASSERT_OP(count _redundant,>,0,_err);

// create the initial cluster centers
{
        private["_out"];
        _out = _x;
        {
                if(_x distance _out < MIN_DISTANCE && _x != _out) exitWith {
                        private ["_out_nodes","_nodes"];
                        //diag_log format["%1 <-> %2", _x, _out];
                        _nodes = _x getVariable ["ClusterNodes", []];
                        _out_nodes = _out getVariable ["ClusterNodes", []];
                        _out setVariable ["ClusterNodes", _out_nodes + _nodes];
                        _redundant = _redundant - [_x];
                        _x setPos [0,0,0];
                        _x setVariable ["ClusterNodes", []];
                        deleteVehicle _x;
                };
        } forEach _redundant;
} forEach _master;

[_master, _redundant];
