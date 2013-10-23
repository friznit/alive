if (!isNil { ALIVE_radioLogic getVariable "ALIVE_radioSatalliteObject" }) then 
{
	private ["_obj"];
	_obj = ALIVE_radioLogic getVariable "ALIVE_radioSatalliteObject";
	
	detach _obj;
	deleteVehicle _obj;
	ALIVE_radioLogic = ["ALIVE_radioSatalliteObject", nil];
};

if (!isNil { ALIVE_radioLogic getVariable "ALIVE_radioTalkWithPilot" }) then 
{
	ALIVE_radioLogic setVariable ["ALIVE_radioTalkWithPilot", nil];
};

if (!isNil { ALIVE_radioLogic getVariable "ALIVE_radioTalkWithArty" }) then 
{
	ALIVE_radioLogic setVariable ["ALIVE_radioTalkWithArty", nil];
};

if (!isNil { uinamespace getVariable "ALIVE_radioCurrentAction" }) then 
{
	uinamespace setVariable ["ALIVE_radioCurrentAction", nil];
};

if (!isNil { uinamespace getVariable "ALIVE_radioCbVehicle" }) then 
{
	uinamespace setVariable ["ALIVE_radioCbVehicle", nil];
};

{
	_x setMarkerAlphaLocal 0;
} forEach (ALIVE_radioLogic getVariable "ALIVE_supportArtyMarkers");

(ALIVE_radioLogic getVariable "ALIVE_supportMarker") setMarkerAlphaLocal 0;

showGPS true;
