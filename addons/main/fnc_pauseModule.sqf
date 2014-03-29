#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(PauseModule);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_pauseModule

Description:
pauses the given module(s) after pause

Parameters:
Array with strings - pass modules like ["ALiVE_sys_profile","ALiVE_mil_OPCOM"] 

Examples:
(begin example)
["ALiVE_sys_profile","ALiVE_mil_OPCOM"] call ALiVE_fnc_pauseModule
(end)

See Also:
ALiVE_fnc_unPauseModule

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_modules"];

_modules = _this;

if (isnil "ALiVE_ALLMODULES") then {ALiVE_ALLMODULES = entities "Module_F"; ALiVE_ALLMODULES = +ALiVE_ALLMODULES};

{
    private ["_mod","_handler","_mainclass"];
    
    _mod = _x;
    
    if ((typeOf _mod) in _modules) then {
        
    	_handler = _mod getvariable ["handler",[]];
        _mainclass = _mod getvariable ["class",([_handler,"class",{}] call ALiVE_fnc_HashGet)];
        
	    switch (typeOf _mod) do {
            
            //Example for special cases if needed, add your module pause code in here
	        case ("") : {};
            
            //Default: Call "pause" operation of the module main class
	        default {
                if (count _handler > 0) then {
			        [_handler,"pause",true] call _mainclass;
				} else {
			        [_mod,"pause",true] call _mainclass;
			    };
            };
	    };
    };
} foreach ALiVE_ALLMODULES;
