/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_multispawnSyncState

Description:
Determines what actions to take based on changes to PV_server_syncHQState/PV_client_syncHQState

Parameters:
Int - The new state that the MHQ is being set to
Object - The MHQ Vehicle/Building

Returns:
- nil

Examples:
(begin example)
[_mhqState, _mhqObject]  call ALIVE_fnc_multispawnSyncState;
(end)

See Also:
- <ALIVE_fnc_multispawnConvert>
- <ALIVE_fnc_multispawnDeploy>
- <ALIVE_fnc_multispawnUndeploy>

Author:
WobbleyheadedBob

Peer Reviewed:
- nil

Notes:
This need to be refactored to get rid of the PublicVarbiale. 
The completion messages probably dont wok on client insances since this function is called via a spawned thread.
---------------------------------------------------------------------------- */
private ["_mhqObject","_mhqState"];
_mhqState = _this select 0;
_mhqObject = _this select 1;

switch (_mhqState) do
{
	case 0: // State No. 0 - Mobile/Undeployed
	{
		if isDedicated then {
			PV_server_syncHQState = [99, ""];
			PV_client_syncHQState = [0, ""];
			publicVariable "PV_client_syncHQState";
		} else {
			PV_client_syncHQState = [99, ""];
			[_mhqObject] call ALIVE_fnc_multispawnAddAction;
			player sideChat format ["FOB has been packed up."];
		};
	};
	// -------------------------------------------------------------------------------------------------
	case 1: // State No. 1 - Deployed
	{
		if isDedicated then {
			PV_server_syncHQState = [99, ""];
			PV_client_syncHQState = [1, ""];
			publicVariable "PV_client_syncHQState";
		} else {
			PV_client_syncHQState = [99, ""];
			[_mhqObject] call ALIVE_fnc_multispawnAddAction;
			player sideChat format ["FOB has been deployed."];
		};
	};
	// -------------------------------------------------------------------------------------------------
	case 2: // State No. 2 - Deploying
	{
		if isDedicated then {
			PV_server_syncHQState = [99, ""];
			[_mhqObject] spawn 
				{
					private ["_mhq"];
					_mhq = _this select 0;
					[_mhq] call ALIVE_fnc_multispawnConvert;
				};
		} else {
			PV_client_syncHQState = [99, ""];
		};
	};
	// -------------------------------------------------------------------------------------------------
	case 3: // State No. 3 - Undeploying/Packing up
	{
		if isDedicated then {
			PV_server_syncHQState = [99, ""];
			[_mhqObject] spawn
				{
					private ["_mhq"];
					_mhq = _this select 0;
					[_mhq] call ALIVE_fnc_multispawnConvert;
				};
		} else {
			PV_client_syncHQState = [99, ""];
		};
	};
	// -------------------------------------------------------------------------------------------------
	Default 
	{
		if isDedicated then {
			PV_server_syncHQState = [99, ""];
		} else {
			PV_client_syncHQState = [99, ""];
		};
	};
};