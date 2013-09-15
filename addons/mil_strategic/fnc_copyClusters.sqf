//#define DEBUG_MODE_FULL
#include <\x\alive\addons\mil_strategic\script_component.hpp>
SCRIPT(copyClusters);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_copyClusters
Description:
Duplicate an array of clusters

Parameters:
Array - Array of clusters

Returns:
Array - array of duplicated clusters

Examples:
(begin example)
_clusters = [_clusters] call ALIVE_fnc_copyClusters;
(end)

See Also:

Author:
Wolffy
ARJay
Peer Reviewed:
nil
---------------------------------------------------------------------------- */


private ["_clusters","_sizeFilter","_priorityFilter","_clustersCopy","_priority",
"_size","_nodes","_newNodes","_parkingPositions","_newParkingPositions","_cluster"];

_clusters = [_this, 0, [], [[]]] call BIS_fnc_param;
_sizeFilter = [_this, 1, 0, [0]] call BIS_fnc_param;
_priorityFilter = [_this, 2, 0, [0]] call BIS_fnc_param;

_clustersCopy = [];

{
	_priority = [_x,"priority"] call ALIVE_fnc_hashGet;
	_size = [_x,"size"] call ALIVE_fnc_hashGet;	
	
	if((_size >= _sizeFilter) && (_priority >= _priorityFilter)) then {
		_cluster = [nil, "create"] call ALIVE_fnc_cluster;
		
		_nodes = [_x,"nodes"] call ALIVE_fnc_hashGet;
		_newNodes = [];
		{
			_newNodes set [count _newNodes, _x];
		} forEach _nodes;
		
		[_cluster,"nodes",_newNodes] call ALIVE_fnc_hashSet;
		
		_parkingPositions = [_x,"parkingPositions"] call ALIVE_fnc_hashGet;
		_newParkingPositions = [];
		{
			_newParkingPositions set [count _newParkingPositions, _x];
		} forEach _parkingPositions;
		
		[_cluster,"parkingPositions",_newParkingPositions] call ALIVE_fnc_hashSet;		
		
		[_cluster,"center",[_x,"center"] call ALIVE_fnc_hashGet] call ALIVE_fnc_hashSet;
		[_cluster,"size",_size] call ALIVE_fnc_hashSet;
		[_cluster,"type",[_x,"type"] call ALIVE_fnc_hashGet] call ALIVE_fnc_hashSet;
		[_cluster,"priority",_priority] call ALIVE_fnc_hashSet;
		[_cluster,"debugColor",[_x,"debugColor"] call ALIVE_fnc_hashGet] call ALIVE_fnc_hashSet;
		_clustersCopy set [count _clustersCopy, _cluster];
	};
} forEach _clusters;

_clustersCopy