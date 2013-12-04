/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_multispawnDeploy

Description:
Deploys the vehicle into a static structure that allows players to choose to spawn there when they die.

Parameters:
- An MHQ object to be turned into an HQ [Object]

Returns:
- nil

Examples:
(begin example)
[mhqObject] call ALIVE_fnc_multispawnDeploy; 
(end)

See Also:
- <ALIVE_fnc_multispawnUndeploy>

Author:
WobbleyheadedBob aka CptNoPants
---------------------------------------------------------------------------- */
private ["_mhq","_mhqState","_mhqLocation","_mhqVector","_camotype","_camo","_validSpeed","_validLocation","_isEmpty"];

_mhq = _this select 0;
_mhqState = _mhq getVariable "MHQState";

// DEBUG - Check for null stateVariable
if (isNil "_mhqState") exitWith
{
	player sideChat "MHQState is null. MHQ has not been initialised. use setVariable to initialise MHQState to 0";
};

switch (_mhqState) do
{
	case 0: // State No. 0 - Mobile/Undeployed
	{
		// Check that MHQ is NOT moving
		if (speed _mhq > 0) then {
			_validSpeed = false;
			player sideChat "MHQ must be stationary to deploy!";
		} else {
			_validSpeed = true;
		};

		// Check MHQ is NOT on the Water
		_mhqLocation = position _mhq;
		if (surfaceIsWater _mhqLocation) then {
			_validLocation = false;
			player sideChat "You cannot setup an HQ in the water!";
		} else {
			_validLocation = true;
		};

		//Check MHQ is Empty
		if (count (crew _mhq) > 0) then {
			_isEmpty = false;
			player sideChat "All crew must exit the vehicle first!";
		} else {
			_isEmpty = true;
		};

		// Check validation and perfom required actions if it passes.
		if (_validSpeed && _validLocation && _isEmpty) then {
			//Empty the fuel & Set state to deploying
			_mhq setVariable ["MHQState", 2, true];
			_mhq setFuel 0;
			_mhqVector = vectorUp _mhq;
			
			if (side player == WEST) then {
				_camotype = "Land_CamoNetB_NATO";
			} else {
				_camotype = "Land_CamoNetB_EAST";
			};
			
			//Create the Cammo Net
			_camo = createVehicle [_camotype, [0,0,0], [], 0, "NONE"];
			_camo setDir direction _mhq;
			_camo setVectorUp _mhqVector;
			_camo setPos _mhqLocation;
			_camo allowDamage false;
			_mhq setVariable ["camo", _camo, true];
			
			player sideChat "Setting up FOB HQ now...";
			
			//Use fnc_multispawnConvert locally if you're a hosting player else, use PV service bus
			if (isServer) then {
				[_mhq] spawn 
				{
					private ["_mhq"];
					_mhq = _this select 0;
					
					[_mhq] call ALIVE_fnc_multispawnConvert;
				};
			} else {
				PV_server_syncHQState = [2, _mhq];
				publicvariable "PV_server_syncHQState";
			};
		};
	};
	// -------------------------------------------------------------------------------------------------
	case 1: // State No. 1 - Deployed
	{
		player sideChat "MHQ is already deployed!";
	};
	// -------------------------------------------------------------------------------------------------
	case 2: // State No. 2 - Deploying
	{
		player sideChat "MHQ is already deploying!";
	};
	// -------------------------------------------------------------------------------------------------
	case 3: // State No. 3 - Undeploying/Packing up
	{
		player sideChat "MHQ is currently packing up, you cannot start deployment yet!";
	};
	// -------------------------------------------------------------------------------------------------
	Default 
	{
		player sideChat "Invalid Request: Unrecognised MHQState";
	};
};