#include <\x\alive\addons\x_lib\script_component.hpp>
SCRIPT(isServerAdmin);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_isServerAdmin
Description:
Checks if a player is currently logged in as server admin.

Parameters:
Nil

Returns:
Bool - Returns true if server admin or in editor/single player

Examples:
(begin example)
// Create instance
_isAdmin = call ALIVE_fnc_isServerAdmin;
(end)

See Also:
- nil

Author:
Wolffy.au

Peer reviewed:
nil
---------------------------------------------------------------------------- */

if (isServer) exitwith {};

////serverCommandAvailable "#kick" || !isMultiplayer;

//Workaround (ugh...) until this is deployed http://feedback.arma3.com/view.php?id=21137! Thanks, BIS!
//remove ASAP
with uiNamespace do {
    if (isnil QMOD(SERVERADMIN_DETECTOR)) then {
        MOD(SERVERADMIN_DETECTOR) = true;
        
	    MOD(SERVERADMIN_CTRL) = findDisplay 46 ctrlCreate ["RscMapControlEmpty", -1];
	    MOD(SERVERADMIN_CTRL) ctrlsetposition [0,0,0,0];
	    MOD(SERVERADMIN_CTRL) ctrlCommit 0;
	    MOD(SERVERADMIN_EH) = MOD(SERVERADMIN_CTRL) ctrlAddEventHandler [
			"Draw", {
	            with uiNamespace do {
	                _isAdmin = serverCommandAvailable "#kick";
	                player setvariable [QMOD(ISADMIN),_isAdmin];
	                
	                MOD(SERVERADMIN_CTRL) ctrlRemoveEventHandler ["Draw", MOD(SERVERADMIN_EH)];
	                [] spawn {ctrlDelete MOD(SERVERADMIN_CTRL); MOD(SERVERADMIN_DETECTOR) = nil};
	            };
		}];
    };
};

(player getvariable [QMOD(ISADMIN),false]) || {serverCommandAvailable "#kick"} || {!isMultiplayer}