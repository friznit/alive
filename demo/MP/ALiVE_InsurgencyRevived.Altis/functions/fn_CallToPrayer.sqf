/*
  _____
  \_   \_ __  ___ _   _ _ __ __ _  ___ _ __   ___ _   _
   / /\/ '_ \/ __| | | | '__/ _` |/ _ \ '_ \ / __| | | |
/\/ /_ | | | \__ \ |_| | | | (_| |  __/ | | | (__| |_| |
\____/ |_| |_|___/\__,_|_|  \__, |\___|_| |_|\___|\__, |
                            |___/                 |___/

@filename: fn_CallToPrayer.sqf

Author:

	Hazey

Last modified:

	2/12/2015

Description:

	Add's a insurgent loudspeaker with muslim prayer during call to prayer times.

TODO:

	Add comment lines so people can get a better understand of how and why it works.

______________________________________________________*/

if(isServer || isDedicated) then  {
	private ["_towns","_list","_cities","_cityPos","_daytime","_m","_mkr"];

	_towns = call INS_fnc_urbanAreas;
	_daytime = daytime;
	INS_createdLoudSpeakers = [];

	{
		_cityPos = _x select 1;

		_list = nearestobjects [_cityPos, INS_CTPLOCATIONS, 600];

		if (count _list > 0) then {

			if(ins_debug) then {

				{
					_m = createMarker [format ["box%1",random 1000],getposATL _x];
					_m setMarkerShape "ICON";
					_m setMarkerType "mil_dot";
					_m setMarkerColor "ColorGreen";

					if(ins_debug) then {
						["fn_CallToPrayer:: Creating Marker on: %1", _list] call ALIVE_fnc_dumpR;
					};

				} forEach _list;

				{
					private ["_dir","_prePolePosition","_brokenPole","_loudSpeaker","_mkr"];
					_dir = random 359;

					_loudSpeaker = createVehicle ["Land_Loudspeakers_F",[ (getPos _x select 0)-15*sin(_dir),(getPos _x select 1)-15*cos(_dir)], [], 0, "CAN_COLLIDE"];

					if(ins_debug) then {
						["fn_CallToPrayer:: Creating loudspeaker ID: %1", _loudSpeaker] call ALIVE_fnc_dumpR;
					};

					_loudSpeaker addEventHandler ["handledamage", {
						if ((_this select 4) in ["SatchelCharge_Remote_Ammo","DemoCharge_Remote_Ammo","SatchelCharge_Remote_Ammo_Scripted","DemoCharge_Remote_Ammo_Scripted"]) then {

							_prePolePosition = getPosATL (_this select 0);
							_brokenPole = createVehicle ["Land_PowerPoleWooden_small_F", _prePolePosition, [], 0, "CAN_COLLIDE"];
							deleteVehicle (_this select 0);

							if(ins_debug) then {
								["fn_CallToPrayer:: Loudspeaker destroyed"] call ALIVE_fnc_dumpR;
							};

						} else {

							(_this select 0) setdamage 0;
						}
					}];

					_mkr = createMarker [format ["box%1",random 1000],getposATL _loudSpeaker];
					_mkr setMarkerShape "ICON";
					_mkr setMarkerType "mil_dot";
					_mkr setMarkerColor "ColorBlue";

					INS_createdLoudSpeakers set [count INS_createdLoudSpeakers, _loudSpeaker];

				} forEach _list;

			} else {

				{
					private ["_dir","_prePolePosition","_brokenPole","_loudSpeaker"];
					_dir = random 359;

					_loudSpeaker = createVehicle ["Land_Loudspeakers_F",[ (getPos _x select 0)-15*sin(_dir),(getPos _x select 1)-15*cos(_dir)], [], 0, "CAN_COLLIDE"];

					_loudSpeaker addEventHandler ["handledamage", {
						if ((_this select 4) in ["SatchelCharge_Remote_Ammo","DemoCharge_Remote_Ammo","SatchelCharge_Remote_Ammo_Scripted","DemoCharge_Remote_Ammo_Scripted"]) then {

							_prePolePosition = getPosATL (_this select 0);
							_brokenPole = createVehicle ["Land_PowerPoleWooden_small_F", _prePolePosition, [], 0, "CAN_COLLIDE"];
							deleteVehicle (_this select 0);

						} else {

							(_this select 0) setdamage 0;
						}
					}];

					INS_createdLoudSpeakers set [count INS_createdLoudSpeakers, _loudSpeaker];

				} forEach _list;

			};
		};

	} foreach _towns;

	if(ins_debug) then {
		["fn_CallToPrayer:: Calling Prayer Loop"] call ALIVE_fnc_dumpR;
	};

	[] call INS_fnc_prayerLoop;
};