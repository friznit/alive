#include <\x\alive\addons\mil_IED\script_component.hpp>
SCRIPT(createBomber);


// Suicide Bomber - create Suicide Bomber at location
private ["_location","_debug","_victim","_size"];

if !(isServer) exitWith {diag_log "Suicide Bomber Not running on server!";};

_victim = objNull;
_location = _this select 0;
_victim = (_this select 1) select 0;
_size = _this select 2;

_debug = MOD(mil_ied) getVariable ["debug", false];

		// Create suicide bomber
		private ["_grp","_skins","_bomber","_pos","_time","_marker"];
//		_grp = createGroup CIVILIAN;
		_grp = createGroup EAST;
		_pos = [_location, 0, _size - 10, 3, 0, 0, 0] call BIS_fnc_findSafePos;
//		_skins = ["TK_CIV_Takistani01_EP1","TK_CIV_Takistani02_EP1","TK_CIV_Takistani03_EP1","TK_CIV_Takistani04_EP1","TK_CIV_Takistani05_EP1","TK_CIV_Takistani06_EP1","TK_CIV_Worker01_EP1","TK_CIV_Worker02_EP1"];
		_skins = (BIS_alice_mainscope getvariable "ALICE_classes") call BIS_fnc_selectRandom;
        if (isnil "_skins") then {
          _skins = ["TK_CIV_Takistani01_EP1","TK_CIV_Takistani02_EP1","TK_CIV_Takistani03_EP1","TK_CIV_Takistani04_EP1","TK_CIV_Takistani05_EP1","TK_CIV_Takistani06_EP1","TK_CIV_Worker01_EP1","TK_CIV_Worker02_EP1"];
        };
		_bomber = _grp createUnit [_skins select 0, _pos, [], _size, "NONE"];
		_bomber addweapon "EvMoney";
		if (_debug) then {
			diag_log format ["ALIVE-%1 Suicide Bomber: created at %2", time, _pos];
			_marker = [format ["suic_%1", random 1000], _pos, "Icon", [1,1], "TEXT:", "Suicide", "TYPE:", "Dot", "COLOR:", "ColorRed", "GLOBAL"] call CBA_fnc_createMarker;
			[_marker,_bomber] spawn {
				_marker = _this select 0;
				_bomber = _this select 1;
				while {alive _bomber} do {
					_marker setmarkerpos position _bomber;
					sleep 0.1;
				};
				[_marker] call CBA_fnc_deleteEntity;
			};
		};
		sleep (random 60);
		_victim = units (group _victim) call BIS_fnc_selectRandom;
		_time = time + 600;
		waitUntil {_bomber doMove getposATL _victim; sleep 5; (_bomber distance _victim < 8) || (time > _time) || !(alive _bomber)};
		if ((_bomber distance _victim < 8) && (alive _bomber)) then {
			_bomber addRating -2001;
			_bomber playMoveNow "AmovPercMstpSsurWnonDnon";
			[_bomber, "sound_akbar"] call CBA_fnc_globalSay3d;
			sleep 5;
			_bomber disableAI "ANIM";
			_bomber disableAI "MOVE";
			diag_log format ["BANG! Suicide Bomber %1", _bomber];
			"Sh_82_HE" createVehicle (getposATL _bomber);
		} else {
			sleep 1;
			if (_debug) then {
				diag_log format ["Deleting Suicide Bomber %1 as out of time or dead.", _bomber];
				[_marker] call CBA_fnc_deleteEntity;
			};
			sleep 120;
			deletevehicle _bomber;
		};
