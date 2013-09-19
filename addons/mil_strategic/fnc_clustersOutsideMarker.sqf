//#define DEBUG_MODE_FULL
#include <\x\alive\addons\mil_strategic\script_component.hpp>
SCRIPT(clustersOutsideMarker);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_clustersOutsideMarker
Description:
Return clusters outside the marker

Parameters:
Array - A list of clusters
Marker - The marker to check

Returns:
Array - A list of clusters within the marker

Examples:
(begin example)
_clusters = [_clusters, _marker] call ALIVE_fnc_clustersOutsideMarker;
(end)

See Also:

Author:
ARJay
Peer Reviewed:
nil
---------------------------------------------------------------------------- */


private ["_clusters","_markers","_marker","_markerClusters","_center"];

_clusters = [_this, 0, [], [[]]] call BIS_fnc_param;
_markers = [_this, 1, [], [[]]] call BIS_fnc_param;

_markerClusters = [];

{
	_marker =_x;
	if(_marker call ALIVE_fnc_markerExists) then {			
		_marker setMarkerAlpha 0;		
		{
			_center = [_x,"center"] call ALIVE_fnc_hashGet;
			if!([_marker, _center] call BIS_fnc_inTrigger) then {
				_markerClusters set [count _markerClusters, _x];
			};
		} forEach _clusters;
	};
} forEach _markers;

if(count _markerClusters == 0) then {
	_markerClusters = _clusters;
};


_markerClusters