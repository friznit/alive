/*
  _____
  \_   \_ __  ___ _   _ _ __ __ _  ___ _ __   ___ _   _
   / /\/ '_ \/ __| | | | '__/ _` |/ _ \ '_ \ / __| | | |
/\/ /_ | | | \__ \ |_| | | | (_| |  __/ | | | (__| |_| |
\____/ |_| |_|___/\__,_|_|  \__, |\___|_| |_|\___|\__, |
                            |___/                 |___/

@filename: fn_intelDrop.sqf

Author:

	Hazey

Last modified:

	2/11/2015

Description:

	Call to drop the intel and addAction to it.
	Also see fn_addActionMP.sqf

TODO:

	Add comment lines so people can get a better understand of how and why it works.

______________________________________________________*/

if (isServer || isDedicated) then {
	private["_unit","_intelItems","_selectedItem","_laptop"];

	_unit = _this select 0;
	_intelItems = INS_INTELDROPPED;

	if (ins_debug) then {
		if (random 100 >= 1) then {
			_selectedItem = _intelItems call BIS_fnc_selectRandom;
			_laptop = createVehicle [_selectedItem, _unit, [], 0, "None"];
			[[_laptop,"<t color='#FF0000'>Gather Intel</t>"],"INS_fnc_addactionMP", true, true] spawn BIS_fnc_MP;
			_laptop setPosATL getPosATL (_this select 0);

			["Intel Item Dropped"] call ALIVE_fnc_dump;

			laptop set [count laptop, _laptop];
			publicVariable "laptop";
		};

	} else {

		if (random 100 >= (paramsArray select 10)) then {
			_selectedItem = _intelItems call BIS_fnc_selectRandom;
			_laptop = createVehicle [_selectedItem, _unit, [], 0, "None"];
			[[_laptop,"<t color='#FF0000'>Gather Intel</t>"],"INS_fnc_addactionMP", true, true] spawn BIS_fnc_MP;
			_laptop setPosATL getPosATL (_this select 0);

			laptop set [count laptop, _laptop];
			publicVariable "laptop";
		};
	};
};