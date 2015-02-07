//#define DEBUG_MODE_FULL
#include <\x\alive\addons\sys_xstream\script_component.hpp>
SCRIPT(camera);


private ["_relpos","_cam","_fov","_subChoice","_loopHandle","_logic"];

_logic = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

// Setup params from logic
TargetFired = [];
subjects = [];
infantry = [];


// Spawn process to continually capture camera targets
_loopHandle = [] spawn {

    	// Set Side to show
    private "_sideMask";

	_sideMask = [WEST,EAST,resistance, civilian];

    while {GVAR(cameraStarted)} do {

		// Get List of vehicle subjects from Mission
		{ if ((side _x in _sideMask) && (_x != player) && !(_x iskindOf "ReammoBox_F")) then
			{
				private ["_nn","_fh"];
			 	subjects = subjects + [_x];
				_nn = _x getVariable "EHfired";
				if (isNil "_nn") then {
					_fh = _x addeventhandler["fired", { TargetFired set [count TargetFired, [(_this select 0),time]]}];
					_x setVariable["EHfired", _fh];
				};
			};
		} foreach vehicles;

		// Get List of Man units from Mission
		{ if ((side _x in _sideMask) && (_x != player) && (_x isKindOf "MAN")) then
			{
				private ["_nn","_fh"];
				infantry = infantry + [_x];
				_nn = _x getVariable "EHfired";
				if (isNil "_nn") then {
					_fh = _x addeventhandler["fired", { TargetFired set [count TargetFired, [(_this select 0),time]]}];
					_x setVariable["EHfired", _fh];
				};
			};
		} foreach allUnits;
		diag_log format["Subjects: %1", subjects];
		diag_log format["Infantry: %1", infantry];
		sleep 15;
		subjects = [];
		infantry = [];
	};
};

// Set up visual effects
0 setOvercast random 0.2;

"colorCorrections" ppEffectAdjust [1, 1, -0.004, [0.0, 0.0, 0.0, 0.0], [1, 0.8, 0.6, 0.5],  [0.199, 0.587, 0.114, 0.0]];
"colorCorrections" ppEffectCommit 0;
"colorCorrections" ppEffectEnable false ;
"filmGrain" ppEffectEnable false;
"filmGrain" ppEffectAdjust [0.04, 1, 1, 0.1, 1, false];
"filmGrain" ppEffectCommit 0;

"radialBlur" ppEffectEnable false;
"wetDistortion" ppEffectEnable false;
"chromAberration" ppEffectEnable false;
"dynamicBlur" ppEffectEnable false;

enableRadio false;
showCinemaBorder false;
cameraEffectEnableHUD false;
showHUD false;

// Introductory Scenes =======================================================

titleCut ["", "BLACK FADED", 0];

sleep 5;

_cam = [player] call ALiVE_fnc_addCamera;

// Loop through series of scenes
while { ((count subjects + count infantry) > 0) && GVAR(cameraStarted)} do {

	private ["_timely","_shotTime","_duration","_sceneType","_speed","_cameraShots","_cameraTarget"];

	diag_log format["TargetFired count:%1 - %2", count TargetFired, TargetFired];
	_duration = 2.5;
	_timely = 6;
	_shotTime = 0;
	_cameraTarget = objNull;

	//Choose a subject - check to see if someone fired a shot else choose a random subject
	if (count TargetFired < 1) then {
		_subChoice = (random 1);
		if (count subjects > 0 && _subChoice > 0.4) then {
			_cameraTarget = (subjects select (floor(random count subjects)));
		} else {
			_cameraTarget = (infantry select (floor(random count infantry)));
		};
	} else {
		private ["_i"];
		_i = 0;
		while {(_i <= (count TargetFired - 1) )} do {
			_cameraTarget = (TargetFired select _i) select 0;
			_shotTime = (TargetFired select _i) select 1;
			TargetFired set [_i,-1];
			TargetFired = TargetFired - [-1];
			_timely = time - _shotTime;
			if (_timely < 6 && alive _cameraTarget) exitWith {};
			_i = _i + 1;
		};
	};

	if (isNull _cameraTarget) then {
		_cameraTarget = (infantry select (floor(random count infantry)));
	};

	// If the subject is a Man and he is in a vehicle, make the vehicle the subject
	if (vehicle _cameraTarget != _cameraTarget) then {
		_cameraTarget = vehicle _cameraTarget;
	};

	// Get target speed
	_speed = speed _cameraTarget;

	_sceneType = "None";

	// Make sure the subject is not dead or fatally wounded
	if (((alive _cameraTarget) && ((damage _cameraTarget) < 0.4) && _speed > 0) || ((_timely > 0) && (_timely < 6)) ) then {

		// Destroy last camera
		[_cam] call ALiVE_fnc_removeCamera;

		// Create new camera
		_cam = [_cameraTarget] call ALiVE_fnc_addCamera;

		// set a Field of View
		_fov = 0.6;

		// Set up scene and Fade into the shot
		_cam camPrepareTarget _cameraTarget;
		_cam camPrepareFOV _fov;
		titleCut ["", "BLACK IN", 1.5];

		enableCamShake false;

		// If target has fired within the last 6 seconds, go to behind/over shoulder vehicle/unit shot
		if (_timely < 6) exitWith {
			// Check to see if it is a Man, if so get closer
			if (_timely < 1.5) then {
				[_cam, _cameraTarget, 3] call ALiVE_fnc_firedShot; // bullet cam
			} else {
				[_cam, _cameraTarget, 3] call ALiVE_fnc_firedShot;
			};
			_sceneType = "FiredShot";
		};

		// If not fired, then get shot selection based on target type
		switch (true) do {
			case (_cameraTarget isKindOf "LandVehicle") : {
				if (_speed > 5) then {
					_cameraShots = ["chaseShot","chaseAngleShot","chaseSideShot","chaseWheelShot","flyByShot","zoomShot","panShot","followShot"];
				} else {
					_cameraShots = ["zoomShot","rotateShot"];
				};
			};
			case (_cameraTarget isKindOf "Air") : {
				if (_speed > 50) then {
					_cameraShots = ["chaseShot","cockpitShot","firstpersonShot","flyByShot","zoomShot","panShot","followShot"];
				} else {
					_cameraShots = ["zoomShot","rotateShot"];
				};
			};
			case (_cameraTarget isKindOf "Man") : {
				if (_speed > 2) then {
					_cameraShots = ["chaseShot","chaseAngleShot","chaseSideShot","followShot","firstpersonShot"];
				} else {
					_cameraShots = ["rotateShot","faceShot","followShot","firstpersonShot"];
				};
			};
			default {
				if (_speed > 5) then {
					_cameraShots = ["chaseShot","chaseAngleShot","chaseSideShot","chaseWheelShot","flyByShot","zoomShot","panShot","followShot"];
				} else {
					_cameraShots = ["zoomShot","rotateShot"];
				};
			};
		};

		_sceneType = (_cameraShots select (floor(random count _cameraShots)));

		switch (_sceneType) do {
			case "chaseShot";
			case "chaseAngleShot";
			case "chaseWheelShot";
			case "chaseSideShot" : { [_cam, _cameraTarget, _duration] call compile format ["ALiVE_fnc_%1",_sceneType]; };
			case "panShot" : {
				_cam attachTo [_cameraTarget,[50-(random 100), 50-(random 100), 2]];
				[_cam, _cameraTarget, assignedTarget _cameraTarget, _duration] call ALiVE_fnc_panShot;
			};
			case "zoomShot" : {
				_cam attachTo [_cameraTarget,[50-(random 100), 50-(random 100), 20]];
				[_cam, _cameraTarget, _duration] call ALiVE_fnc_zoomShot;
			};
			case "flyByShot" : {
				private ["_x","_y","_z"];
				if (_cameraTarget iskindof "MAN") then {
					_x = 10-(round(random 20));
					_y = 10-(round(random 20));
					_z = 1+(round(random 10));
				} else {
					_x = 60-(round(random 120));
					_y = 60-(round(random 120));
					_z = 10+(round(random 20));
				};
				_relpos = [_x, _y, _z];
				_cam camSetTarget _cameraTarget;
				_cam camPrepareRelPos _relpos;
				_cam camSetRelPos _relpos;
				_cam camSetFOV _fov;
				_cam cameraEffect ["INTERNAL", "BACK"];
				_cam camCommit 0;
				sleep _duration;
			};
			case "followShot" : {
				private ["_x","_y","_z"];
				// Check to see if it is a Man, if so get closer
				if (_cameraTarget iskindof "MAN") then {
					_x = (2-(round(random 4)));
					_y = (1+(round(random 3)));
					_z = ((eyepos _cameraTarget) select 2) - ((getposASL _cameraTarget) select 2);
				} else {
					_fov = _fov + 0.3;
					_x = (5-(round(random 10)));
					_y = (12+(round(random 8)));
					_z = (1+(round(random 10)));
				};
				_relpos = [_x, _y, _z];
				_cam attachTo [_cameraTarget,_relpos];
				_cam camSetTarget _cameraTarget;
				_cam camSetFOV _fov;
				_cam cameraEffect ["INTERNAL", "BACK"];
				_cam camCommit 0;
				sleep _duration;
			};
			case "firstPersonShot" : {
				_cam camPreparePos (position _cameraTarget);
				_cam cameraEffect ["terminate","back"];
				camDestroy _cam;
				_cameraTarget switchCamera "INTERNAL";
				sleep _duration;
			};
			default {
				[_cam, _cameraTarget, _duration] call ALiVE_fnc_firedShot;
			};
		};

	 	diag_log format["sys_xstream target:%1, scene:%2, speed:%3",typeOf _cameraTarget, _sceneType, _speed];
		/*
		// Pan
		if (_sceneChoice > 10) then {
			// If the target is a person, get closer
			if (_cameraTarget iskindof "MAN") then {
				_dist = 1+(random 4);
				_alt = 1+(random 2);
			} else {
				_dist = (sizeOf (typeOf _cameraTarget)) + (random 10);
                _alt = ((random _dist)/3) + 6;
			};

			_stopScene = false;
			_startTime = time;
			_stopTime = _startTime + 8;
			_newTarget = objNull;
			_istep = 0.22 + (random 3) * (0.001 * 1);
			_groupTarget = createGroup sideLogic;
			_newTarget = _groupTarget createUnit ["Logic", (position _cameraTarget), [], 0, "NONE"];
			_iterator = 0;
			_switchDir = (round(random 1));
			_angle = 0;
			_targetPos = [];
			x = (position _cameraTarget select 0) + _dist;
			y = (position _cameraTarget select 1) + _dist;
			z = (position _cameraTarget select 2) + _alt;
			_relpos = [x , y, z];
			_cam camSetTarget _newTarget;
			_cam camSetPos _relpos;
			_cam camSetFOV _fov;
			_cam cameraEffect ["INTERNAL", "BACK"];
			_cam camCommit 0;
			_startangle = [_cam,_cameraTarget] call BIS_fnc_relativeDirTo;
			_startangle = _startangle % 360;

			while {!_stopScene} do {
				_iterator = _iterator + 1;
				_angle = _startangle + (_iterator * _istep);
				if (_switchDir == 0) then {
					_targetPos = [x + _dist * cos(_angle), y + _dist * sin(_angle), z];
				} else {
					_targetPos = [x + _dist * cos(_angle), y - _dist * sin(_angle), z];
				};
				_newTarget setPos _targetPos;
				sleep 0.001;
				if (time > _stopTime) then {_stopScene = true};
			};
			deleteVehicle _newTarget;
			deleteGroup _groupTarget;
		};
		*/
	};

};

//exit
_cam cameraEffect ["terminate","back"];
camDestroy _cam;
exit;

