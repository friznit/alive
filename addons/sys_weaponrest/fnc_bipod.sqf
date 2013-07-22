/* alive_sys_weaponrest | fnc_bipod.sqf - " Useable bipods " | (c) 2009 by rocko */

#include "script_component.hpp"

#define __resting_recoil 0.25

TRACE_1("",_this);

PARAMS_4(_nanim,_oldanim,_text,_SB);

_snd = format ["alive_deployweapon_%1", round (1 + random 2)];
_t = "ALIVE_LogicDummy" createVehicleLocal (player ModelToWorld [0, 0, 0]);
_t say _snd;

player switchmove _nanim;

if (_SB) then { 
	hint "Resting Weapon on Ruck/Crate";
	TRACE_1("Resting Weapon on SB",_SB);
} else {
	hint "Bipod Deployed";
	TRACE_1("BIPOD",_text);
};

#define __WD (player weaponDirection (currentWeapon player))
#define __DIR ((_wd select 0) atan2 (_wd select 1))
#define __resting_recoil_prone 0.50

_wd = __WD;
_dir0 = __DIR;

// reduce the recoil
player setUnitRecoilCoefficient __resting_recoil_prone;

while {animationstate player == _nanim } do {
	_wd = __WD;
	_dir = __DIR;
	if (_dir < 0) then { _dir = _dir + 360 };
	_res = _dir0 - _dir;
	if (_res < -180) then { _res = 360 + _res };
	if (_res > 180) then { _res = _res - 360 };
	sleep 0.5;
	if ( (abs _res > 15) && {_SB} ) exitwith {player switchmove _oldanim};
};
TRACE_3("UNRESTING WEAPON",_res, animationstate player, _nanim);

player setUnitRecoilCoefficient 1;

if (!_SB) then {
	hint "Bipod Retracted";
} else {
	hint "Weapon no longer resting on Ruck/Crate"; 
};
deletevehicle _t;