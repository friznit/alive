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
- <ALIVE_fnc_findClusterCenter>
- <ALIVE_fnc_findClusters>

Author:
Wolffy.au
---------------------------------------------------------------------------- */

private ["_master","_redundant","_err","_remove"];


PARAMS_1(_master);
DEFAULT_PARAM(1,_redundant,+_master);

_err = "objects provided not valid";
ASSERT_DEFINED("_master", _err);
ASSERT_DEFINED("_redundant", _err);
ASSERT_OP(typeName _master, == ,"ARRAY", _err);
ASSERT_OP(typeName _redundant, == ,"ARRAY", _err);
ASSERT_OP(count _master,>,0,_err);
ASSERT_OP(count _redundant,>,0,_err);
_remove = [];

// iterate through master list of clusters
{
        private["_out","_max","_dist"];
        _out = _x;
        // for each redundant cluster
        {
                // if duplicate of master list - remove
                if(_out == _x) exitWith {
                        _redundant = _redundant - [_x];
                };
                // check for cluster within master cluster
                private ["_out_nodes","_nodes"];
                _max = ([_out, "size"] call ALIVE_fnc_cluster);
                _dist = ([_x, "center"] call ALiVE_fnc_cluster) distance ([_out, "center"] call ALiVE_fnc_cluster);
                
                // if cluster is within master cluster
                if(_dist < _max) then {
                        // move nodes between clusters as required
                        _nodes = ([_out, "nodes"] call ALIVE_fnc_cluster) + ([_x, "nodes"] call ALIVE_fnc_cluster);
                        [_out, "nodes", _nodes] call ALIVE_fnc_cluster;
                        // and remove cluster from list
                        _redundant = _redundant - [_x];
                        [_x, "destroy"] call ALIVE_fnc_cluster;
                };
        } forEach +_redundant;
} forEach _master;

// return master list and remainder of redundant list
[_master, _redundant];
