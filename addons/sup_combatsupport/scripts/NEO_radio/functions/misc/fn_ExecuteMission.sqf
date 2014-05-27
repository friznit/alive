
private ["_battery", "_targetPos", "_missionType", "_ordnanceType", "_rateOfFire",
        "_missionRoundCount", "_missionTimeLength", "_unit", "_ordnance", "_eta","_grp","_dummy","_target"];

_battery = _this select 0;
_targetPos = _this select 1;
_missionType = _this select 2;
_ordnanceType = _this select 3;    //"8Rnd_82mm_Mo_shells";
_rateOfFire = _this select 4; //0
_missionRoundCount = _this select 5;  //6
_missionTimeLength = _this select 5; //6
_unit = _this select 6;
_ordnance = _this select 7;


diag_log format["MISSION: %1", _this];

// Arty is on mission
_battery setVariable ["ARTY_SHOTCALLED", false, true];
_battery setVariable ["ARTY_SPLASH", false, true];
_battery setVariable ["ARTY_COMPLETE", false, true];
_battery setVariable ["ARTY_ONMISSION", true, true];

// Ensure that the target position is 3d.
if ((count _targetPos) == 2) then
{
    _targetPos = [_targetPos select 0, _targetPos select 1, 0];
};

sleep 15;

_battery setVariable ["ARTY_SHOTCALLED", true, true];

sleep 2;

_grp = group _battery;

if(_missionRoundCount == 1) then {
	_battery DOArtilleryFire [_targetPos, _ordnance, _missionRoundCount];

} else {
	{
		_x DOArtilleryFire [_targetPos, _ordnance, _missionRoundCount/(count units _grp)];
		sleep _rateOfFire;
	} foreach units _grp;
};

_battery setVariable ["ARTY_COMPLETE", true, true];

//Get position for ETA
_dummy = "Land_HelipadEmpty_F" createVehicleLocal _targetPos;
_eta = (vehicle _battery) getArtilleryETA [getPos _dummy, _ordnance];
deleteVehicle _dummy;
diag_log format["BATTERY: %1 due in %2 seconds", _battery, _eta];

sleep _eta;

_battery setVariable ["ARTY_SPLASH", true, true];

sleep 20;

_battery setVariable ["ARTY_ONMISSION", false, true];
