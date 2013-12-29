//#define DEBUG_MODE_FULL
#include <\x\alive\addons\fnc_strategic\script_component.hpp>
SCRIPT(getParkingPosition);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_getParkingPosition
Description:
Get a parking position for a passed vehicle class and building object

Parameters:
String - Vehicle class name
Object - Building object

Returns:
Array - array containing parking position and direction

Examples:
(begin example)
_result = ["B_Heli_Light_01_F", _building] call ALIVE_fnc_getParkingPosition;
(end)

See Also:

Author:
ARJay
Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_vehicleClass","_building","_debug","_result"];

_vehicleClass = _this select 0;
_building = _this select 1;
_debug = if(count _this > 2) then {_this select 2} else {false};

_result = [];

private ["_direction","_bbox","_bboxA","_bboxB","_bboxX","_bboxY","_difmin","_difmax","_dif","_buildingPosition","_position","_safePos"];

_position = position _building;
_direction = direction _building + (floor random 4)*90;
_bbox = boundingbox _building;
_bboxA = (_bbox select 0);
_bboxB = (_bbox select 1);
_bboxX = abs(_bboxA select 0) + abs(_bboxB select 0);
_bboxY = abs(_bboxA select 1) + abs(_bboxB select 1);
_difmin = (_bboxX min _bboxY);
_difmax = (_bboxX max _bboxY);
_dif = _difmin/2 + sqrt(_difmin)*0.3;

if (_difmax < 15) then {
	_buildingPosition = position _building; //_obj modeltoworld [0,0,0];
	_position = [
		(_buildingPosition select 0)+(sin (_direction + 90) * _dif),
		(_buildingPosition select 1)+(cos (_direction + 90) * _dif),
		0
	];									
};


// DEBUG -------------------------------------------------------------------------------------
if(_debug) then {
	//["POS1: %1",_position] call ALIVE_fnc_dump;
	[_position, 1] call ALIVE_fnc_spawnDebugMarker;
	[_position, 1] call ALIVE_fnc_placeDebugMarker;
};
// DEBUG -------------------------------------------------------------------------------------


// pos min max nearest water gradient shore
_safePos = [_position,0,10,5,0,20,0] call BIS_fnc_findSafePos;

//["SAFE POS: %1",_safePos] call ALIVE_fnc_dump;

_center = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");

//if(((_safePos select 0) == 10801.9) && ((_safePos select 1) == 10589.6)) then {
if(((_safePos select 0) == (_center select 0)) && ((_safePos select 1) == (_center select 1))) then {
	_position = [_position,0,50,5,0,20,0] call BIS_fnc_findSafePos;
}else{
	_position = _safePos;
};

//["SAFE POS: %1",_position] call ALIVE_fnc_dump;


private ["_nearRoads","_road","_roadConnectedTo","_connectedRoad"];

_nearRoads = _position nearRoads 10;
if(count _nearRoads > 0) then
{
	_road = _nearRoads select 0;
	_roadConnectedTo = roadsConnectedTo _road;
	_connectedRoad = _roadConnectedTo select 0;
	if!(isNil '_connectedRoad') then {
		_direction = [_road, _connectedRoad] call BIS_fnc_DirTo;
	};
};


// DEBUG -------------------------------------------------------------------------------------
if(_debug) then {
	//["POS2: %1",_position] call ALIVE_fnc_dump;
	[_position] call ALIVE_fnc_spawnDebugMarker;
	[_position] call ALIVE_fnc_placeDebugMarker;
};
// DEBUG -------------------------------------------------------------------------------------


_result = [_position, _direction];

_result