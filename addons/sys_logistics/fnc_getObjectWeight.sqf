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

private ["_objects","_sum","_types"];

_objects = _this;
_sum = 0;

//Order of subclass before main class is important here
_types = [
	["Truck_F",600],
	["Car",200],
    ["Tank",3500],
	["Helicopter",150],
	["Ship",100],
	["Static",200],
	["Reammobox_F",50],
	["ThingX",7]
];

{
    private ["_object","_factor","_weight"];
    
    _object = _x;
    _factor = 100;
    
    {
        if (_object isKindOf (_x select 0)) exitwith {_factor = _x select 1};
    } foreach _types;
    
    _weight = (sizeOf (typeof _object))*_factor;
    _sum = _sum + _weight;

} foreach _objects;

_sum;