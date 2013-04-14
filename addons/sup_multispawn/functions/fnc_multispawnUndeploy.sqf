/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_multispawnUndeploy

Description:
Packs the static structure up back into a mobile vehicle.

Parameters:
Object - An HQ object to be turned into an MHQ [Object]

Returns:
- nil

Examples:
(begin example)
[hqObject] call ALIVE_fnc_multispawnUndeploy;
(end)

See Also:
- <ALIVE_fnc_multispawnDeploy>

Author:
WobbleyheadedBob

Peer Reviewed:
- nil
---------------------------------------------------------------------------- */
private ["_fobHQ","_fobHQState"];

_fobHQ = _this select 0;
_fobHQState = _fobHQ getVariable "MHQState";

// DEBUG - Check for null stateVariable
if (isNil "_fobHQState") exitWith
{
	player sideChat "MHQState is null. MHQ has not been initialised. use setVariable to initialise MHQState to 1";
};

switch (_fobHQState) do
{
	case 0: // State No. 0 - Mobile/Undeployed
	{
		player sideChat "MHQ is already Mobile!";
	};
	// -------------------------------------------------------------------------------------------------
	
	case 1: // State No. 1 - Deployed
	{
		//Set state to packing up 
		_fobHQ setVariable ["MHQState", 3, true];
		player sideChat "Packing up FOB HQ now...";
		
		//Use createFOB locally if you're a hosting player else, use PV service bus
		if isServer then {
			[_fobHQ] spawn 
			{
				private ["_fobHQ"];
				_fobHQ = _this select 0;
				[_fobHQ] call ALIVE_fnc_multispawnConvert;
			};
		} else {
			PV_server_syncHQState = [3, _fobHQ];
			publicvariable "PV_server_syncHQState";
		};
	};
	// -------------------------------------------------------------------------------------------------
	
	case 2: // State No. 2 - Deploying
	{
		player sideChat "MHQ is currently deploying!";
	};
	// -------------------------------------------------------------------------------------------------
	
	case 3: // State No. 3 - Undeploying/Packing up
	{
		player sideChat "MHQ is already packing up!";
	};
	// -------------------------------------------------------------------------------------------------
	Default 
	{
		player sideChat "Unrecognised MHQState";
	};
};