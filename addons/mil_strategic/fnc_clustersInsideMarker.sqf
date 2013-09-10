//#define DEBUG_MODE_FULL
#include <\x\alive\addons\mil_strategic\script_component.hpp>
SCRIPT(clustersInsideMarker);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_clustersInsideMarker
Description:
Return clusters inside the marker

Parameters:
Array - A list of clusters
Marker - The marker to check

Returns:
Array - A list of clusters within the marker

Examples:
(begin example)
_clusters = [_clusters, _marker] call ALIVE_fnc_clustersInsideMarker;
(end)

See Also:

Author:
ARJay
Peer Reviewed:
nil
---------------------------------------------------------------------------- */


private ["_clusters","_marker","_markerClusters","_center"];

_clusters = [_this, 0, [], [[]]] call BIS_fnc_param;
_marker = [_this, 1, "", [""]] call BIS_fnc_param;

_markerClusters = _clusters;

if(_marker call ALIVE_fnc_markerExists) then {			
	_marker setMarkerAlpha 0;
	_markerClusters = [];
	{
		_center = [_x,"center"] call ALIVE_fnc_hashGet;
		if([_marker, _center] call BIS_fnc_inTrigger) then {
			_markerClusters set [count _markerClusters, _x];
		};
	} forEach _clusters;
};

_markerClusters