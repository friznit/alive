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

// create the initial cluster centers
{
        private["_out","_max","_dist"];
        _out = _x;
        {
                _max = ([_out, "size"] call ALIVE_fnc_cluster) + ([_x, "size"] call ALIVE_fnc_cluster);
                _dist = ([_x, "center"] call ALiVE_fnc_cluster) distance ([_out, "center"] call ALiVE_fnc_cluster);
                if(_x != _out && {_dist < _max}) exitWith {
                        private ["_out_nodes","_nodes"];
                        //diag_log format["%1 <-> %2", _x, _out];
                        _nodes = ([_out, "nodes"] call ALIVE_fnc_cluster) + ([_x, "nodes"] call ALIVE_fnc_cluster);
                        [_out, "nodes", _nodes] call ALIVE_fnc_cluster;
                        _remove set [count _remove, _x];
                        [_x, "destroy"] call ALIVE_fnc_cluster;
sleep 3;
                };
        } forEach _redundant;
	_redundant = _redundant - _remove;
} forEach _master;

[_master, _redundant];
