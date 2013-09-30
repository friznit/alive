#include <\x\alive\addons\main\script_component.hpp>
SCRIPT(isHC);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_isHC
Description:
Initialises isHC to indicate a player is a headless client. Designed to run
once during initialisation and all further checks to use the isHC global variable.

Parameters:
Nil

Returns:
Bool - Returns true if player is a headless client

Examples:
(begin example)
// Create instance
call ALIVE_fnc_isHC;

if(isHC) then {hint "I am a headless client";};
(end)

See Also:
- nil

Author:
Wolffy.au

Peer reviewed:
nil
---------------------------------------------------------------------------- */

isHC = false;

if(isNil "headlessClients" && isServer) then {
        headlessClients = [];
        publicVariable "headlessClients";
};

while {isNil "headlessClients"} do {};

_headless = (!(isDedicated) && {!(hasInterface)});
if (_headless) then {
                isHC = true;
                // Random delay
                for [{_x=1},{_x<=random 10000},{_x=_x+1}] do {};
 
                if (!(player in headlessClients)) then {
                        headlessClients set [count headlessClients, player];
                        publicVariable "headlessClients";
                };
};
isHC;