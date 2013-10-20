//#define DEBUG_MODE_FULL
#include <\x\alive\addons\mil_placement\script_component.hpp>
SCRIPT(getParkingPosition);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_getParkingPosition
Description:
Set cluster values on array of clusters

Parameters:
String - Vehicle class
Array - Position
Scalar - Direction
Scalar - Min distance
Scalar - Max distance
Bool - On water

Returns:
Array - array containing good parking position and direction

Examples:
(begin example)
_result = ["B_Heli_Light_01_F", getPos player, 0] call ALIVE_fnc_getParkingPosition;
(end)

See Also:

Author:
ARJay
Peer Reviewed:
nil
---------------------------------------------------------------------------- */
