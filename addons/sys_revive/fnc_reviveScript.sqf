#include "config.sqf"
SYS_RevPath = "\x\alive\addons\sys_revive\";

["ALIVE Revive starting..."] call ALIVE_fnc_dumpR;

REV_FNCT_code_distant = {
	private ["_unit", "_commande", "_parametre"];
	_unit = _this select 1 select 0;
	_commande = _this select 1 select 1;
	_parametre = _this select 1 select 2;
	
	if (local _unit) then {
		switch (_commande) do {
			case "switchMove": {
				_unit switchMove _parametre;
			};
			case "setDir": {
				_unit setDir _parametre;
			};
			case "playMove": {
				_unit playMove _parametre;
			};
			case "playMoveNow": {
				_unit playMoveNow _parametre;
			};
		};
	};
};

"REV_code_distant" addPublicVariableEventHandler REV_FNCT_code_distant;

if !(isServer && isDedicated) then {
	call compile preprocessFile format["\x\alive\addons\sys_revive\sys_revive\%1_strings_lang.sqf", REV_CFG_langage];
	
	[] spawn {
		REV_Waiting_For_Revive = [] spawn {};
		REV_Player_Respawn = [] spawn {};
		REV_Unconscious_Effect = [] spawn {};
		REV_New_Player_Unit = REV_CFG_Number_Revives;
		REV_FNCT_onKilled = compile preprocessFile "\x\alive\addons\sys_revive\sys_revive\onKilled.sqf";
		REV_FNCT_respawn_camp = compile preprocessFile "\x\alive\addons\sys_revive\sys_revive\respawn_camp.sqf";
		
		REV_FNCT_Create_Unconscious_Marker = {
			if (REV_CFG_Show_Player_Marker && alive player) then {
				private ["_marqueur"];
				_marqueur = createMarker [("REV_mark_" + name player), getPos player];
				_marqueur setMarkerType "mil_triangle";
				_marqueur setMarkerColor "colorRed";
				_marqueur setMarkerText format [STR_REV_Waiting_For_Revive_marker, name player];
			};
		};
		
		REV_FNCT_Delete_Unconcious_Marker = {
			if (REV_CFG_Show_Player_Marker && alive player) then {
				deleteMarker ("REV_mark_" + name player);
			};
		};
		
		if (isNil "REV_CFG_Classnames_That_Can_Revive") then {
			REV_CFG_Classnames_That_Can_Revive = [];
		};
		if (isNil "REV_CFG_Player_Slots_That_Can_Revive") then {
			REV_CFG_Player_Slots_That_Can_Revive = [];
		};
		if (isNil "REV_CFG_All_Medic_Can_Revive") then {
			REV_CFG_All_Medic_Can_Revive = false;
		};
		if (isNil "REV_CFG_Allow_To_Drag_Body") then {
			REV_CFG_Allow_To_Drag_Body = false;
		};
		
		REV_FNCT_peut_revive = {
			if (REV_CFG_All_Medic_Can_Revive && getNumber (configFile >> "CfgVehicles" >> (typeOf player) >> "attendant") == 1) then {
				true;
			} else {
				if (player in REV_CFG_Player_Slots_That_Can_Revive) then {
					true;
				} else {
					if (typeOf player in REV_CFG_Classnames_That_Can_Revive) then {
						true;
					} else {
                        if (count REV_CFG_Classnames_That_Can_Revive < 1) then {
							true;
						} else {
							false;
						};
                    };
				};
			};
		};
		
		REV_FNCT_unconscious = {
			private ["_unit", "_id_action"];
			_unit = _this select 1;
			
			if !(isServer && isDedicated) then {
				if !(isNull _unit) then {
					player reveal _unit;
					
					// _id_action = _unit addAction [STR_REV_Action_Revive, "\x\alive\addons\sys_revive\sys_revive\revive.sqf", [], 10, false, true, "",
					// "player distance _target < 2 && !(player getVariable ""REV_Unconscious"") && call REV_FNCT_peut_revive && alive _target && isPlayer _target && (_target getVariable ""REV_Unconscious"") && isNil {_target getVariable ""REV_Medical_Support_Unit""}"];
					// _unit setVariable ["REV_id_action_revive", _id_action, false];
					
					// _id_action = _unit addAction [STR_REV_Action_Drag_Body, "\x\alive\addons\sys_revive\sys_revive\drag_body.sqf", [], 10, false, true, "",
					// "player distance _target < 2 && !(player getVariable ""REV_Unconscious"") && REV_CFG_Allow_To_Drag_Body && alive _target && isPlayer _target && (_target getVariable ""REV_Unconscious"") && isNil {_target getVariable ""REV_Medical_Support_Unit""}"];
					// _unit setVariable ["REV_id_action_trainer_corps", _id_action, false];
					
					_id_action = _unit addAction [STR_REV_Action_Revive, {call ALIVE_fnc_revive2;}, [], 10, false, true, "",
					"player distance _target < 2 && !(player getVariable ""REV_Unconscious"") && call REV_FNCT_peut_revive && alive _target && isPlayer _target && (_target getVariable ""REV_Unconscious"") && isNil {_target getVariable ""REV_Medical_Support_Unit""}"];
					_unit setVariable ["REV_id_action_revive", _id_action, false];
					
					_id_action = _unit addAction [STR_REV_Action_Drag_Body, {call ALIVE_fnc_reviveDrag;}, [], 10, false, true, "",
					"player distance _target < 2 && !(player getVariable ""REV_Unconscious"") && REV_CFG_Allow_To_Drag_Body && alive _target && isPlayer _target && (_target getVariable ""REV_Unconscious"") && isNil {_target getVariable ""REV_Medical_Support_Unit""}"];
					_unit setVariable ["REV_id_action_trainer_corps", _id_action, false];
				};
			};
		};
		"REV_Unconscious_Player" addPublicVariableEventHandler REV_FNCT_unconscious;
		
		REV_FNCT_End_Unconciousness = {
			private ["_unit"];
			_unit = _this select 1;
			
			if !(isServer && isDedicated) then {
				if !(isNull _unit) then {
					if !(isNil {_unit getVariable "REV_id_action_revive"}) then {
						_unit removeAction (_unit getVariable "REV_id_action_revive");
						_unit setVariable ["REV_id_action_revive", nil, false];
					};
					
					if !(isNil {_unit getVariable "REV_id_action_trainer_corps"}) then {
						_unit removeAction (_unit getVariable "REV_id_action_trainer_corps");
						_unit setVariable ["REV_id_action_trainer_corps", nil, false];
					};
				};
			};
		};
		"REV_End_Unconciousness" addPublicVariableEventHandler REV_FNCT_End_Unconciousness;
		
		waitUntil {
			!(isNull player);
		};
		
		REV_Dead_Body = player;
		
		REV_Revive_Position = getPosATL REV_Dead_Body;
		
		[] call REV_FNCT_Delete_Unconcious_Marker;
		
		player addEventHandler ["killed", REV_FNCT_onKilled];
		
		sleep (0.5 + random 0.5);
		
		player setVariable ["REV_Medical_Support_Unit", nil, true];
		
		if !(isNil {player getVariable "REV_Unconscious"}) then {
			if (player getVariable "REV_Unconscious") then {
				[player, player] call REV_FNCT_onKilled;
			};
		} else {
			player setVariable ["REV_Unconscious", false, true];
		};
		
		{
			["REV_End_Unconciousness", _x] call REV_FNCT_End_Unconciousness;
			
			if (_x != player) then
			{
				if !(isNil {_x getVariable "REV_Unconscious"}) then {
					if (_x getVariable "REV_Unconscious") then {
						["REV_Unconscious_Player", _x] call REV_FNCT_unconscious;
					};
				};
			};
		} forEach (playableUnits + switchableUnits + allUnits);
	};
};