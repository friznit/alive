#include <\x\alive\addons\fnc_strategic\script_component.hpp>
SCRIPT(chooseInitialCenters);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_chooseInitialCenters

Description:
Use K-means++ to choose the initial centers.

K-means++ code inspired from: http://commons.apache.org/math/api-2.1/index.html?org/apache/commons/math/stat/clustering/KMeansPlusPlusClusterer.html

Parameters:
Array - A list of objects to identify clusters

Returns:
Array - List of seed cluster objects

Examples:
(begin example)
// identify clusters of objects
_seeds = [_obj_array] call ALIVE_fnc_chooseInitialCenters;
(end)

See Also:
- <ALIVE_fnc_getNearestObjectInCluster>
- <ALIVE_fnc_findClusters>

Author:
Wolffy.au
---------------------------------------------------------------------------- */

private ["_points","_err","_k","_p","_nearest","_d","_sum","_r","_pointSet","_resultSet","_firstPoint","_dx2"];
PARAMS_1(_points);
_err = "points array provided not valid";
ASSERT_DEFINED("_points",_err);
ASSERT_TRUE(typeName _points == "ARRAY",_err);
ASSERT_TRUE(count _points > 0,_err);

_k = ceil(sqrt(count _points / 2));

_pointSet = +_points;
_err = "copy of points array not valid";
ASSERT_DEFINED("_pointSet",_err);
ASSERT_TRUE(typeName _pointSet == "ARRAY",_err);
ASSERT_TRUE(count _pointSet > 0,_err);
_resultSet = [];

// Choose one center uniformly at random from among the data points.
_firstPoint = _pointSet call BIS_fnc_selectRandom;
_err = "first point undefined";
ASSERT_DEFINED("_firstPoint",_err);
ASSERT_TRUE(typeName _firstPoint == "OBJECT",_err);
_pointSet = _pointSet - [_firstPoint];
_resultSet set [count _resultSet, _firstPoint];

while {count _resultSet < _k} do {
	// For each data point x, compute D(x), the distance between x and
	// the nearest center that has already been chosen.
	_sum = 0;
	_dx2 = [];
	{
		_p = _x;
		_nearest = [_p, _resultSet] call ALIVE_fnc_getNearestObjectInCluster;
		_d = _p distance _nearest;
		_sum = _sum + _d^2;
		_dx2 set [count _dx2, _sum];
	} forEach _pointSet;
	
	// Add one new data point as a center. Each point x is chosen with
	// probability proportional to D(x)2
	_r = random _sum;
	{
		if (_x >= _r) exitWith {
			_p = _pointSet select _forEachIndex;
			_pointSet = _pointSet - [_p];
			_resultSet set [count _resultSet, _p];
		};
	} forEach _dx2;
};
_err = "initial centres array not valid";
ASSERT_DEFINED("_resultSet",_err);
ASSERT_TRUE(typeName _resultSet == "ARRAY",_err);
ASSERT_TRUE(count _resultSet == ceil(sqrt(count _points / 2)),_err);

_pointSet = [];
{
	_pointSet set [count _pointSet, (createGroup sideLogic) createUnit ["LOGIC", (getPosATL _x), [], 0, "NONE"]];
} forEach _resultSet;
ASSERT_DEFINED("_pointSet",_err);
ASSERT_TRUE(typeName _pointSet == "ARRAY",_err);
ASSERT_TRUE(count _pointSet == ceil(sqrt(count _points / 2)),_err);

_pointSet;
