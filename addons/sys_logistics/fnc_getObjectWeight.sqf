#include <\x\alive\addons\sys_logistics\script_component.hpp>
SCRIPT(getObjectWeight);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_getObjectWeight
Description:

Gets an approximate weight value of the given objects.
If only one object is given, it returns the approx. weight of this object

Parameters:
_this: ARRAY of OBJECTs

Returns:
Number - approximate weight

See Also:
- <ALIVE_fnc_getObjectSize>

Author:
Highhead

Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_objects","_sum","_types","_weight"];

_objects = _this;
_sum = 0;

_types = [
		["Truck_F",1],
		["Car",1],
		["Tank",1],
		["Helicopter",1],
		["Ship",1],
		["Reammobox_F",1],
		["Static",100],
		["ThingX",7],
		["Man",13]
];

{
    private ["_object","_weight"];
    
    _object = _x;
    _weight = getMass _object;
    
    if (_weight == 0) then {
         {if (_object isKindOf (_x select 0)) exitwith {_weight = (sizeOf (typeof _object))*(_x select 1)}} foreach _types;
    };

    _sum = _sum + _weight;
} foreach _objects;

_sum;