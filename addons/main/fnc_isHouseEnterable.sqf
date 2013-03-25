#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(isHouseEnterable);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_isHouseEnterable

Description:
Returns true if the house is enterable

Parameters:
Object - House

Returns:
Boolean - True if house has one building position

Examples:
(begin example)
if([_house] call MSO_fnc_isHouseEnterable) then{
	hint format["%1 is enterable", _house];
};
(end)

See Also:
- <MSO_fnc_getObjectsByType>
- <MSO_fnc_getAllEnterableHouses>
- <MSO_fnc_getEnterableHouses>

Author:
Wolffy.au
---------------------------------------------------------------------------- */

private ["_house","_err"];

PARAMS_1(_house);
_err = "house not valid";
ASSERT_DEFINED("_house",_err);
ASSERT_TRUE(typeName _house == "OBJECT",_err);

(str (_house buildingPos 0) != "[0,0,0]");