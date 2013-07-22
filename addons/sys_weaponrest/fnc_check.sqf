#include "script_component.hpp"

#define __y0 			1.1

#define __standup ["aadjpercmstpsraswrfldup"]
#define __stand ["amovpercmstpsraswrfldnon", "aidlpercmstpsraswrfldnon_aiming01", "aidlpercmstpsraswrfldnon_idlesteady01", "aidlpercmstpsraswrfldnon_idlesteady02", "aidlpercmstpsraswrfldnon_idlesteady03", "aidlpercmstpsraswrfldnon_idlesteady04", "aidlpercmstpsraswrfldnon_aiming02"]
#define __standdown ["aadjpercmstpsraswrflddown"]

#define __kneelup ["aadjpknlmstpsraswrfldup"]
#define __kneel ["amovpknlmstpsraswrfldnon", "aidlpknlmstpsraswrfldnon_player_idlesteady01", "aidlpknlmstpsraswrfldnon_player_idlesteady02", "aidlpknlmstpsraswrfldnon_player_idlesteady03", "aidlpknlmstpsraswrfldnon_player_idlesteady04"]
#define __kneeldown ["aadjpknlmstpsraswrflddown"]

#define __proneup ["aadjppnemstpsraswrfldup"]
#define __prone ["amovppnemstpsraswrfldnon"]
#define __pronedown ["aadjppnemstpsraswrflddown"]

#define __animstanding	__stand	
#define __animkneeling 	__kneel	

#define __animsteadystanding 	"AmovPercMstpSrasWrflDnon_Steady"
#define __animsteadystandingup 	"AadjPercMstpSrasWrflDup_Steady"
#define __animsteadystandingdown 	"AadjPercMstpSrasWrflDdown_Steady"

#define __animsteadykneeling 	"AmovPknlMstpSrasWrflDnon_Steady"
#define __animsteadykneelingup 	"AadjPknlMstpSrasWrflDup_Steady"
#define __animsteadykneelingdown 	"AadjPknlMstpSrasWrflDdown_Steady"

#define __animprone_bipod	"AmovPpneMstpSrasWrflDnon_Bipod"
#define __animsteadyproneup 	"AadjPpneMstpSrasWrflDup_Steady"
#define __animsteadypronedown 	"AadjPpneMstpSrasWrflDdown_Steady"

#define __check getNumber(configFile >> "CfgWeapons" >> primaryWeapon player >> "alive_bipod")

#define __resting_recoil 0.25
	
private["_snd", "_vec", "_men", "_zcoords", "_deleted", "_detectors", "_wd", "_dir0", "_wdx", "_wdy", "_wdz", "_res", "_dir", "_minheight", "_t1", "_offset1", "_z1", "_zinit", "_dy", "_dz", "_cfg", "_n", "_x", "_anim", "_obj", "_t", "_pos", "_z", "_pos1", "_do", "_offset", "_oldanim"];

PARAMS_1(_currentAnim);

// Check for Bipod


// If in prone, check for Bipod and crate/ruck for resting
if ((_currentAnim in __prone) || (_currentAnim in __pronedown)) exitwith {
	
	// Bipods
	if ((__check == 1) && (_currentAnim in __prone)) then {	
		TRACE_2("Bipod Check",__check, primaryWeapon player); 
		[__animprone_bipod,_currentAnim, localize "STR_ALIVE_BIPOD", false] call alive_sys_weaponrest_fnc_bipod; 
	};

	if (_currentAnim in __pronedown) then {
		_anim = __animsteadypronedown;
	} else {
		_anim = __animprone_bipod;
	};
	
	// Rest weapon on ruck or crate (if available)
	if ([player,1.7] call alive_sys_weaponrest_fnc_sB) then { 
		[_anim,_currentAnim, localize "STR_ALIVE_DEPLOYED", true] call alive_sys_weaponrest_fnc_bipod; 
	} else {
		if (__check != 1) then {
			hint "Noting to rest on!";
		};
	};
};

// Rest weapon standing, kneeling or high prone

// Check to see if you can rest on something
if !([_currentAnim] call alive_sys_weaponrest_fnc_canRestWeapon) exitwith { hint "Can't rest the weapon here"};

enableCamShake true;

// Get initial dir
_wd = player weapondirection (primaryweapon player);
_dir0 = (_wd select 0) atan2 (_wd select 1);
if (_dir0 < 0) then { _dir0 = _dir0 + 360 };

// Remember old anim
_oldanim = _currentAnim;

// Switch to steadier animation
switch (true) do {
	case (_currentAnim in __animkneeling): {
		_anim = __animsteadykneeling;
		_offset = [0.1,__y0, 0.9];
	};
	case (_currentAnim in __kneelup): {
		_anim = __animsteadykneelingup;
		_offset = [0.1,__y0, 1.0];
	};
	case (_currentAnim in __kneeldown): {
		_anim = __animsteadykneelingdown;
		_offset = [0.1,__y0, 0.8];
	};
	case (_currentAnim in __animstanding): {
		_anim = __animsteadystanding;
		_offset = [0.1,__y0, 1.3];
	};
	case (_currentAnim in __standup): {
		_anim = __animsteadystandingup;
		_offset = [0.1,__y0, 1.4];
	};
	case (_currentAnim in __standdown): {
		_anim = __animsteadystandingdown;
		_offset = [0.1,__y0, 1.2];
	};
	case (_currentAnim in __proneup): {
		_anim = __animsteadyproneup;
		_offset = [0.1,__y0, 0.4];
	};

};

_offset1 = +_offset;

addCamShake [5, 1, 5];

// Bipods
if (__check == 1) exitwith {	
	TRACE_2("Bipod Check",__check, primaryWeapon player); 
	[_anim,_currentAnim, localize "STR_ALIVE_BIPOD", false] call alive_sys_weaponrest_fnc_bipod;
	addCamShake [5, 1, 5];
};
	
// *** resting the weapon
_snd = format ["alive_deployweapon_%1", round (1 + random 2)];
_t = "ALIVE_LogicDummy" createVehicleLocal (player ModelToWorld _offset1);
_t say _snd;

// *** Visual feedback
hint "Weapon Rested";

// Switch to new anim
player switchmove _anim;

// Set recoil
player setUnitRecoilCoefficient __resting_recoil;

//turn limitation, exit if weapon is turned too much from the initial heading
while {(animationstate player) == _anim } do {
	_wd = player weapondirection (primaryweapon player);
	_dir = (_wd select 0) atan2 (_wd select 1);
	if (_dir < 0) then { _dir = _dir + 360 };
	_res = _dir0 - _dir;
	switch (true) do {
		case (_res < -180): { _res = 360 + _res };
		case (_res > 180): { _res = _res - 360 };
	};
	if (abs _res > 25) exitwith { player switchmove _oldanim;};
	sleep 0.5;
};
addCamShake [5, 1, 5];
player setUnitRecoilCoefficient 1;
hint "Weapon no longer resting";
deletevehicle _t;
