#include <\x\alive\addons\x_lib\script_component.hpp>
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

private ["_x","_headless"];
isHC = false;

if(isNil "headlessClients" && isServer) then {
	headlessClients = [];
	publicVariable "headlessClients";
};

while {isNil "headlessClients"} do {};

_headless = (!(isDedicated) && {!(hasInterface)});
if (_headless) then {
    //Set isHC in PreInit
	isHC = true;
    
	// Random delay
	for [{_x=1},{_x<=random 10000},{_x=_x+1}] do {};
    
    //Check for player object in PostInit call and add to headleassClients arry
    while {isnull player} do {};
	
	if (!(isnull player) && {!(player in headlessClients)}) then {
		headlessClients set [count headlessClients, player];
		publicVariable "headlessClients";
	};
};
isHC;