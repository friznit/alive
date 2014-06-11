#include <\x\alive\addons\sys_logistics\script_component.hpp>
SCRIPT(getObjectSize);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_getObjectSize
Description:

Gets an approximate volume of the given objects.
If only one object is given, it returns the approx. volume of this object

Parameters:
_this: ARRAY of OBJECTs

Returns:
Number - approximate volume

See Also:
- <ALIVE_fnc_getObjectWeight>

Author:
Highhead

Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_objects","_sum"];

_objects = _this;
_sum = 0; {_sum = _sum + (sizeOf (typeof _x))} foreach _objects;

_sum;