/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_multispawnPlayerSetSpawn

Description:
Sets the HQ object as the player's respawn location.

Parameters:
- None

Returns:
- nil

Examples:
(begin example)
[_fobHQ] call ALIVE_fnc_multispawnPlayerSetSpawn; 
(end)

See Also:
- <ALIVE_fnc_multispawnRelocatePlayer>

Author:
WobbleyheadedBob

Peer Reviewed:
nil
---------------------------------------------------------------------------- */
private ["_fobHQ","_fobState"];
_fobHQ = _this select 0;
_fobState = _fobHQ getVariable "MHQState";

// DEBUG - Check for null stateVariable
if (isNil "_fobState") exitWith
{
	player sideChat "MHQState is null. MHQ has not been initialised. use setVariable to initialise MHQState to 1";
};

switch (_fobState) do
{
// -------------------------------------------------------------------------------------------------
	case 0: // State No. 0 - Mobile/Undeployed
	{
		player sideChat "You need to deploy the MHQ first!";
	};
	
	case 1: // State No. 1 - Deployed
	{
		player setVariable ["playerRespawnPoint", _fobHQ, false];
		player sideChat "You will spawn here if KIA";
	};
	
	case 2: // State No. 2 - Deploying
	{
		player sideChat "MHQ is currently deploying! You cannot Sign-in here until it has finnished setting up.";
	};
		
	case 3: // State No. 3 - Undeploying/Packing up
	{
		player sideChat "MHQ is currently packing up, you cannot Sign-in here!";
	};
	
	Default 
	{
		player sideChat "Unrecognised MHQState. Valid states are from 0 to 3";
	};
};