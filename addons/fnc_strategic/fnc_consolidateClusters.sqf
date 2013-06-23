//#define DEBUG_MODE_FULL
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
Array - Returns the master list

Examples:
(begin example)
// identify redundant clusters after a merge
_clusters = [_master_list, _redundant_list] call ALIVE_fnc_consolidateClusters;
_new_master = _clusters;
(end)

See Also:
- <ALIVE_fnc_findClusterCenter>
- <ALIVE_fnc_findClusters>

Author:
Wolffy.au
Peer Review:
nil
---------------------------------------------------------------------------- */

private ["_master","_redundant","_err","_result","_first"];

TRACE_1("consolidateClusters - input",_this);

_master = [_this, 0, [], [[]]] call BIS_fnc_param;
_redundant = [_this, 1, [], [[]]] call BIS_fnc_param;

_err = "objects provided not valid";
ASSERT_DEFINED("_master", _err);
ASSERT_DEFINED("_redundant", _err);
ASSERT_OP(typeName _master, == ,"ARRAY", _err);
ASSERT_OP(typeName _redundant, == ,"ARRAY", _err);
ASSERT_OP(count _master,>,0,_err);
_result = _master;

{
	if !(_x in _result) then {
		_result set [count _result, _x];
	};
} foreach _redundant;

// iterate through master list of clusters
{
	private["_out","_max","_dist"];
	_out = _x;
	// for each redundant cluster
	{
		// if duplicate of master list - remove
		if(str _out != "-1" && str _x != "-1" && str _out != str _x) then {
			// check for cluster within master cluster
			private ["_out_nodes","_nodes","_out_center","_x_center"];
			_max = ([_x, "size"] call ALIVE_fnc_cluster) + ([_out, "size"] call ALIVE_fnc_cluster);
			_out_center = [_out, "center"] call ALiVE_fnc_cluster;
			_x_center = [_x, "center"] call ALiVE_fnc_cluster;
			if(count _out_center != 0 && count _x_center != 0) then {

				// if cluster is within master cluster
				if((_x_center distance _out_center) < _max) then {

					// select nodes of both clusters
					_nodes_out = ([_out, "nodes"] call ALIVE_fnc_cluster);
					_nodes_x = ([_x, "nodes"] call ALIVE_fnc_cluster);

					// combine them and ensure that old nodes are only added if the master doesnt have them already
					{
						if !(_x in _nodes_out) then {
							_nodes_out set [count _nodes_out, _x];
						};
					} foreach _nodes_x;

					// set the new nodes
					[_out, "nodes", _nodes_out] call ALIVE_fnc_cluster;
					
					// and remove cluster from list
					[_x, "destroy"] call ALIVE_fnc_cluster;
					_result set [_forEachIndex, -1];
				};
			};
		};
	} forEach _result;
} forEach _master;
_result = _result - [-1];

// return master list and remainder of redundant list
//_result = [_master, _redundant];

TRACE_1("consolidateClusters - output",_result);
_result;