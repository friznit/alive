#include <\x\alive\addons\amb_civ_population\script_component.hpp>
SCRIPT(selectRoleAction);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_selectRoleAction

Description:
Selects civilian action:
1. Hostility Level by random chance
2. .... more to come

Parameters:

Returns:
Bool - true

Examples:
(begin example)
//
_result = [_target,_caller] call ALIVE_fnc_selectRoleAction;
(end)

See Also:

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_target","_caller","_pos","_reduceHostility"];

_target = _this select 0;
_caller = _this select 1;
_reduceHostility = if (count _this > 2) then {_this select 2} else {random 1 < 0.1};

// prepare on all locs
if (_reduceHostility) then {
	_title = "<t size='1.5' color='#68a7b7'  shadow='1'>COMMUNICATION</t><br/>";
    _text = format["%1<t>By cleverly argumenting you manage to decrease hostility towards your forces in this sector!</t>",_title];
	
	["openSideSmall",0.3] call ALIVE_fnc_displayMenu;
	["setSideSmallText",_text] spawn ALIVE_fnc_displayMenu;
} else {
	_title = "<t size='1.5' color='#68a7b7'  shadow='1'>COMMUNICATION</t><br/>";
    _text1 = format["%1<t>You try to approach the person carefully, but there is no reaction at all!</t>",_title];
    _text2 = format["%1<t>You get the slight feeling the the person you are talking to doesnt understand any word!</t>",_title];
    _text3 = format["%1<t>The person doesn't want to talk to you!</t>",_title];
    _text4 = format["%1<t>The person wants to be left alone!</t>",_title];
    
    _text = [_text1,_text2,_text3,_text4] call BIS_fnc_SelectRandom;
	
	["openSideSmall",0.3] call ALIVE_fnc_displayMenu;
	["setSideSmallText",_text] spawn ALIVE_fnc_displayMenu;
};

// execute only on server
if !(isServer) exitwith {[[_target,_caller,_reduceHostility],"ALIVE_fnc_selectRoleAction",false,false] call BIS_fnc_MP};

if (_reduceHostility) then {
    _townelder = _target getVariable ["townelder", false];
    _major = _target getVariable ["major", false];
    _muezzin = _target getVariable ["muezzin", false];
    _priest = _target getVariable ["priest", false];
    _politician = _target getVariable ["politician", false];
    
    _pos = getposATL _target;
    _value = 10;
    
    if (_townelder) then {_value = 35};
    if (_major) then {_value = 30};
    if (_muezzin) then {_value = 25};
    if (_priest) then {_value = 20};
    if (_politician) then {_value = 15};
    
    [_pos,[str(side _caller)], _value * -1] call ALiVE_fnc_updateSectorHostility;
    [_pos,["EAST","WEST","GUER","INDEP"] - [str(side _caller)], _value] call ALiVE_fnc_updateSectorHostility;
};

true;