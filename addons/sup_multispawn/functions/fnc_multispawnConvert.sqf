/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_multispawnConvert

Description:
Converts an MHQ object into either a static FOB building of mobile HQ vehicle

Parameters:
- Object - MHQ to be switched to deployed/undeployed state.

Returns:
- nil

Examples:
(begin example)
// reassign objects to nearest cluster
[_mhqVehicle]  call ALIVE_fnc_multispawnConvert;
(end)

See Also:
- <ALIVE_fnc_deployHQ>
- <ALIVE_fnc_undeployHQ>

Author:
WobbleyheadedBob aka CptNoPants

Peer reviewed:
- nil
---------------------------------------------------------------------------- */
// Requires: ALIVE_fnc_multispawnSyncState 

private ["_mhq","_mhqLocation","_mhqVector","_mhqDirection","_mhqType","_mhqState","_camo"];
_mhq = _this select 0;
_mhqLocation = position _mhq;
_mhqVector = vectorUp _mhq;
_mhqDirection = direction _mhq;
_mhqType = [_mhq] call ALIVE_fnc_multispawnMHQType;
_mhqState = _mhq getVariable "MHQState";

// Wait a while... (Parameter specified delay or hardcoded???)
sleep 7;

switch (_mhqState) do
{
	case 0: // State No. 0 - Mobile/Undeployed
	{
		player sideChat "Invalid Request: MHQ is currently deploying!";
	};
	// -------------------------------------------------------------------------------------------------
	case 1: // State No. 1 - Deployed
	{
		player sideChat "Invalid Request: MHQ is already packing up!";
	};
	// -------------------------------------------------------------------------------------------------
	case 2: // State No. 2 - Deploying
	{
		// Remove the MHQ from the list of active HQs, delete the mobile vehicle and camo net
		PV_hqArray = PV_hqArray - [_mhq];	
		_camo = _mhq getVariable "camo";
		deleteVehicle _camo;
		deleteVehicle _mhq;

		// Create the new FOB HQ
		_mhq = createVehicle [_mhqType, [0,0,0], [], 0, "NONE"];
		_mhq setDir _mhqDirection;
		_mhq setVectorUp _mhqVector;
		_mhq setPos _mhqLocation;
		_mhq setVariable ["MHQState", 1, true];

		// Add the new FOB to the list of active HQ's and broadcast the PV
		PV_hqArray set [count PV_hqArray, _mhq];
		publicvariable "PV_hqArray";

		// Broadcast the returnMessage and ALIVE_fnc_multispawnAddAction to all other clients
		PV_client_syncHQState = [1, _mhq];
		publicVariable "PV_client_syncHQState";

		if !isDedicated then 
		{
			[1, _mhq] call ALIVE_fnc_multispawnSyncState;
		};
	};
	// -------------------------------------------------------------------------------------------------
	case 3: // State No. 3 - Undeploying/Packing up
	{
		// Delete the FOBHQ and Remove from the list of active HQs
		PV_hqArray = PV_hqArray - [_mhq];
		deleteVehicle _mhq;

		// Create new MHQ
		_mhq = createVehicle [_mhqType, [0,0,0], [], 0, "NONE"];
		_mhq setDir _mhqDirection;
		_mhq setVectorUp _mhqVector;
		_mhq setPos _mhqLocation;
		_mhq setVariable ["MHQState", 0, true];

		// Add the new MHQ to the list of active HQ's and broadcast the PV
		PV_hqArray set [count PV_hqArray, _mhq];
		publicvariable "PV_hqArray";

		// Broadcast the returnMessage and ALIVE_fnc_multispawnAddAction to all other clients
		PV_client_syncHQState = [0, _mhq];
		publicVariable "PV_client_syncHQState";

		if !isDedicated then 
		{
			[0, _mhq] call ALIVE_fnc_multispawnSyncState;
		};
	};
	// -------------------------------------------------------------------------------------------------
	Default 
	{
		player sideChat "Invalid Request: Unrecognised MHQState";
	};
};