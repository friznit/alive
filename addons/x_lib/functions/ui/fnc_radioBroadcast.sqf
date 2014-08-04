#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(radioBroadcast);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_radioBroadcast

Description:
Broadcast radio messages including to all friendly sides, with HQ is desired
Only for use with BIS_fnc_MP

Parameters:
Object - the sender
String - the message
String - the radio channel (global,side,group,vehicle,sideRadio)
Side - the side
Boolean - from HQ
Boolean - include friends

Returns:

Examples:
(begin example)
// dump variable 
["String"] call ALIVE_fnc_radioBroadcast;
(end)

See Also:

Author:
ARJay, Gunny
---------------------------------------------------------------------------- */
private ["_unit","_message","_channel","_side","_fromHQ","_toHQ"];

_unit = _this select 0;
_message = _this select 1;
_channel = if(count _this > 2) then {_this select 2} else {"side"};
_side = if(count _this > 3) then {_this select 3} else {WEST};
_fromHQ = if(count _this > 4) then {_this select 4} else {false};
_toHQ = if(count _this > 5) then {_this select 5} else {false};


switch (_channel) do
{
    case "global" : {
        player globalChat _message
    };
    case "side" : {
        if(_toHQ) then {
            _hq = [_side,"HQ"];
            _message = format["%1 %2",_hq,_message];
        };
        if(_fromHQ) then {
            [_side,"HQ"] sideChat _message;
        }else{
            _unit sideChat _message;
        };
    };
    case "group" : {
        player groupChat _message
    };
    case "vehicle" : {
        player vehicleChat _message
    };
    case "sideRadio" : {
        player sideRadio _message
    };
};