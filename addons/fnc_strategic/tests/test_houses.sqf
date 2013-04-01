// ----------------------------------------------------------------------------

#include <\x\alive\addons\fnc_strategic\script_component.hpp>
SCRIPT(test_houses);

// ----------------------------------------------------------------------------

private ["_err","_obj_array","_house","_maxpos","_expected","_m"];

LOG("Testing Strategic Houses");

ASSERT_DEFINED("ALIVE_fnc_getMaxBuildingPositions","");
ASSERT_DEFINED("ALIVE_fnc_getBuildingPositions","");
ASSERT_DEFINED("ALIVE_fnc_getEnterableHouses","");
ASSERT_DEFINED("ALIVE_fnc_getAllEnterableHouses","");
ASSERT_DEFINED("ALIVE_fnc_findNearHousePositions","");
ASSERT_DEFINED("ALIVE_fnc_findIndoorHousePositions","");
ASSERT_DEFINED("ALIVE_fnc_isHouseEnterable","");

// find nearest house
_house = (getPosATL player) nearestObject "House";
_err = "no house found";
ASSERT_DEFINED("_house",_err);
ASSERT_TRUE(typeName _house == "OBJECT",PFORMAT_1(_err,_house));
_m = createMarker [str _house, getPosATL _house];
_m setMarkerShape "Icon";
_m setMarkerSize [1, 1];
_m setMarkerType "mil_dot";
_m setMarkerColor "ColorGreen";

// get number of building positions for an object
_maxpos = _house call ALIVE_fnc_getMaxBuildingPositions;
_err = "max positions invalid";
ASSERT_DEFINED("_maxpos",_err);
ASSERT_TRUE(typeName _maxpos == "SCALAR",PFORMAT_1(_err,_maxpos));

// confirm not [0,0,0]
_maxpos = _house buildingPos _maxpos;
_expected = "[0,0,0]";
_err = "max house positions incorrect";
ASSERT_DEFINED("_maxpos",_err);
ASSERT_TRUE(typeName _maxpos == "ARRAY",_err);
ASSERT_TRUE(str _maxpos != _expected,PFORMAT_1(_err,_maxpos));

// get number of building positions for a non-building
_maxpos = [player] call ALIVE_fnc_getBuildingPositions;
_expected = "[0,0,0]";
_err = "no positions check invalid";
ASSERT_DEFINED("_maxpos",_err);
ASSERT_TRUE(typeName _maxpos == "ARRAY",_err);
ASSERT_TRUE(str _maxpos != _expected,PFORMAT_1(_err,_maxpos));

// ALIVE_fnc_isHouseEnterable is tested by ALIVE_fnc_getEnterableHouses

// get array of all enterable houses around the player
_obj_array = [getPosATL player, 300] call ALIVE_fnc_getEnterableHouses;
_err = "no enterable houses";
ASSERT_DEFINED("_obj_array",_err);
ASSERT_TRUE(typeName _obj_array == "ARRAY",PFORMAT_1(_err,_obj_array));
ASSERT_TRUE(count _obj_array > 0,PFORMAT_1(_err,_obj_array));
{
        _m = createMarker [str _x, getPosATL _x];
        _m setMarkerShape "Icon";
        _m setMarkerSize [1, 1];
        _m setMarkerType "mil_dot";
        _m setMarkerColor "ColorBlue";
} forEach _obj_array;

// get array of all enterable houses across the map
_obj_array = call ALIVE_fnc_getAllEnterableHouses;
_err = "no enterable houses";
ASSERT_DEFINED("_obj_array",_err);
ASSERT_TRUE(typeName _obj_array == "ARRAY", PFORMAT_1(_err,_obj_array));
ASSERT_TRUE(count _obj_array > 0,PFORMAT_1(_err,_obj_array));
{
        _m = createMarker [str _x, getPosATL _x];
        _m setMarkerShape "Icon";
        _m setMarkerSize [1, 1];
        _m setMarkerType "mil_dot";
        _m setMarkerColor "ColorYellow";
} forEach _obj_array;

// get array of all house positions around the player
_obj_array = [getPosATL player, 300] call ALIVE_fnc_findNearHousePositions;
_err = "no house positions";
ASSERT_DEFINED("_obj_array",_err);
ASSERT_TRUE(typeName _obj_array == "ARRAY",PFORMAT_1(_err,_obj_array));
ASSERT_TRUE(count _obj_array > 0,PFORMAT_1(_err,_obj_array));
{
        _m = createMarker [str _x + str _forEachIndex, _x];
        _m setMarkerShape "Icon";
        _m setMarkerSize [0.5, 0.5];
        _m setMarkerType "mil_dot";
        _m setMarkerColor "ColorRed";
} forEach _obj_array;

// get array of all indoor house positions around the player
_obj_array = [getPosATL player, 300] call ALIVE_fnc_findIndoorHousePositions;
_err = "no indoor house positions";
ASSERT_DEFINED("_obj_array",_err);
ASSERT_TRUE(typeName _obj_array == "ARRAY",PFORMAT_1(_err,_obj_array));
ASSERT_TRUE(count _obj_array > 0,PFORMAT_1(_err,_obj_array));
{
        _m = createMarker [str _x + str _forEachIndex + "i", _x];
        _m setMarkerShape "Icon";
        _m setMarkerSize [0.5, 0.5];
        _m setMarkerType "mil_dot";
        _m setMarkerColor "ColorOrange";
} forEach _obj_array;

nil;
