#include <\x\alive\addons\fnc_strategic\script_component.hpp>
SCRIPT(getNearestObjectInCluster);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_getNearestObjectInCluster

Description:
Returns the nearest object to the given object from a list of objects

K-means++ code inspired from: http://commons.apache.org/math/api-2.1/index.html?org/apache/commons/math/stat/clustering/KMeansPlusPlusClusterer.html

Parameters:
Object - The object for comparison
Array - A list of objects to compare

Returns:
Object - Nearest object

Examples:
(begin example)
_nearest = [_point, _obj_array] call ALIVE_fnc_getNearestObjectInCluster;
(end)

See Also:
- <ALIVE_fnc_getObjectsByType>
- <ALIVE_fnc_chooseInitialCenters>

Author:
Wolffy.au
---------------------------------------------------------------------------- */

private ["_point","_cluster","_minDistance","_minObject","_distance","_err"];
PARAMS_2(_point,_cluster);
_err = "point provided not valid";
ASSERT_DEFINED("_point",_err);
ASSERT_TRUE(typeName _point == "OBJECT", _err);
_err = "array of objects provided not valid";
ASSERT_DEFINED("_cluster",_err);
ASSERT_TRUE(typeName _cluster == "ARRAY", _err);
ASSERT_TRUE(count _cluster > 0,_err);

_minDistance = 999999;
_minObject = nil;
{
	_distance = _point distance _x;
	if (_point != _x && _distance < _minDistance) then {
		_minDistance = _distance;
		_minObject = _x;
	};
} forEach _cluster;

if(isNil "_minObject") then {_minObject = _point;};
_minObject;
