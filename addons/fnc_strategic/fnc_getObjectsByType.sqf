#include <\x\alive\addons\fnc_strategic\script_component.hpp>
SCRIPT(getObjectsByType);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_getObjectsByType

Description:
Returns objects by their P3D name for the entire map

Parameters:
Array - Partial P3D type names to search for across the entire map

Returns:
Array - List of all objects across the map matching the types specified

Examples:
(begin example)
// get array of id's and positions from object data
_obj_array = [
	"vez.p3d",
	"barrack",
	"mil_",
	"lhd_",
	"ss_hangar",
	"runway",
	"heli_h_army",
	"dragonteeth"
] call ALIVE_fnc_getObjectsByType;
(end)

See Also:
- <ALIVE_fnc_getNearestObjectInCluster>

Author:
Wolffy.au
---------------------------------------------------------------------------- */

private ["_types","_err","_file","_raw_objects","_object_hash","_expanded","_data_array","_obj_array"];
_types = _this;
_err = "types provided not valid";
ASSERT_DEFINED("_types",_err);
ASSERT_TRUE(typeName _types == "ARRAY", _err);

// read raw object data
_file = format["\x\alive\addons\fnc_strategic\indexes\objects.%1.sqf", worldName];
_raw_objects = call compile preprocessFileLineNumbers _file;
_err = "raw object information not read correctly from file";
ASSERT_DEFINED("_raw_objects",_err);
ASSERT_TRUE(typeName _raw_objects == "ARRAY", _err);

_object_hash = [_raw_objects] call CBA_fnc_hashCreate;
ASSERT_DEFINED("_object_hash",_err);
ASSERT_TRUE(typeName _object_hash == "ARRAY", "_object_hash invalid");

_expanded = [];
{
	private["_p3dname"];
	_p3dname = _x;
	{
		if([_p3dname, _x] call CBA_fnc_find != -1) then {
			_expanded set [count _expanded, _p3dname];
		};
	} forEach _types;
} forEach (_object_hash select 1);


_data_array = [];
{
	private["_name","_data"];
	_name = _x;
	_data = [_object_hash, _name] call CBA_fnc_hashGet;
	if(!isNil "_data") then {
		_data_array = _data_array + _data;
	};
} forEach _expanded;
ASSERT_DEFINED("_data_array",_err);
ASSERT_TRUE(typeName _data_array == "ARRAY", "_data_array invalid");

// create an array of objects from positions
_obj_array = [];
{
	private["_id","_pos"];
	_id = _x select 0;
	_pos = _x select 1;
	_obj_array set [count _obj_array, _pos nearestObject _id];
} forEach _data_array;
ASSERT_DEFINED("_obj_array",_err);
ASSERT_TRUE(typeName _obj_array == "ARRAY", "_obj_array invalid");

_obj_array;
