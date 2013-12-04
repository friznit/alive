/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_multispawnRelocatePlayer

Description:
Moves the player to their currently defined respawn location

Parameters:
Player - The player to be relocted to HQ

Returns:
- nil

Examples:
(begin example)
[player] call ALIVE_fnc_playerRespawn; 
(end)

See Also:
- <ALIVE_fnc_multispawnPlayerSetSpawn>

Author:
WobbleyheadedBob

Peer Reviewed:
- nil
---------------------------------------------------------------------------- */


// When called it sets the player's postion to 'myRespawnPoint' (simples!)
// Author: WobbleyheadedBob aka CptNoPants
private ["_mySoldier","_respawnObject","_positioner"];
_mySoldier = _this select 0;
_respawnObject = _mySoldier getVariable "playerRespawnPoint";

//Check if the player has sign-in somewhere
if (isNil "_respawnObject") then {
	_mySoldier setPos ([myRespawnPoint, 1, 25, 1, 0, 5, 0] call bis_fnc_findSafePos); // he hasn't
} else {
	//Check if the HQ he signed in at is still 'alive'
	if (alive _respawnObject) then {
        _positioner = ([position _respawnObject, 1, 25, 1, 0, 5, 0] call bis_fnc_findSafePos);
		_mySoldier setPos _positioner;
	} else { 
		player sideChat "FOB no longer available, you have spawned back at base.";
		myRespawnPoint = (markerPos format["respawn_%1", faction player]);
		_mySoldier setPos ([myRespawnPoint, 1, 25, 1, 0, 5, 0] call bis_fnc_findSafePos);
	};
};