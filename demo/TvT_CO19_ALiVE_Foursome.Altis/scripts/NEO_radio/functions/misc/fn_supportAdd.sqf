[nil, NEO_radioLogic, "loc", rSPAWN, _this,
{
	private ["_side", "_support", "_array"];
	_side = _this select 0;
	_support = _this select 1;
	_array = _this select 2;
	
	switch (_support) do
	{
		case "TRANSPORT" : 
		{
			private ["_pos", "_dir", "_type", "_callsign", "_tasks", "_code"];
			_pos = _array select 0; _pos set [2, 0];
			_dir = _array select 1;
			_type = _array select 2;
			_callsign = toUpper (_array select 3);
			_tasks = _array select 4;
			_code = _array select 5;
			
			private ["_veh"];
			_veh = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
			_veh setDir _dir;
			_veh setPosATL _pos;
			_veh setVelocity [0,0,-1];
			
			private ["_grp"];
			_grp = createGroup _side;
			[_veh, _grp] call BIS_fnc_spawnCrew;
			_veh lockDriver true;
			{ _veh lockturret [[_x], true] } forEach [0,1,2];
			[nil, (units _grp select 0), "per", rSETGROUPID, _callsign] call RE;
			_veh setVariable ["NEO_transportAvailableTasks", _tasks, true];
			[_veh, _grp, units _grp] spawn _code;
			
            //call RE not working in A3, actions are added in init for JIP
            /*
			[nil, _veh, "per", rAddAction, "Support Radio", "scripts\NEO_radio\radio_action.sqf", "radio", -1, false, true, "", 
			"
				_this in _target
				&&
				_this hasWeapon ""itemRadio""
				&&
				isNil { NEO_radioLogic getVariable format ['NEO_radioInUseBy_%1', side _this] }
			"] call RE;
			
			[nil, _veh, "per", rAddAction, "Talk with pilot", "scripts\NEO_radio\radio_action.sqf", "talk", -1, false, true, "", 
			"
				_this in _target
				&&
				{
					rankID _x > rankID _this
					&&
					_x in (assignedCargo _target)
					&&
					lifeState _x != ""UNCONSCIOUS""
				}
				count (crew _target) == 0
			"] call RE;
            */
			
			//FSM
			[_veh, _grp, _callsign, _pos] execFSM "scripts\NEO_radio\fsms\transport.fsm";
			
			private ["_transportArray"];
			_transportArray = NEO_radioLogic getVariable format ["NEO_radioTrasportArray_%1", _side];
			_transportArray set [count _transportArray, [_veh, _grp, _callsign]];
			NEO_radioLogic setVariable [format ["NEO_radioTrasportArray_%1", _side], _transportArray, true];
		};
		
		case "CAS" :
		{
			private ["_pos", "_dir", "_type", "_callsign", "_airport", "_code"];
			_pos = _array select 0; _pos set [2, 0];
			_dir = _array select 1;
			_type = _array select 2;
			_callsign = toUpper (_array select 3);
			_airport = _array select 4;
			_code = _array select 5;
			
			private ["_veh"];
			_veh = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
			_veh setDir _dir;
			_veh setPosATL _pos;
			_veh setVelocity [0,0,-1];
			
			private ["_grp"];
			_grp = createGroup _side;
			[_veh, _grp] call BIS_fnc_spawnCrew;
			_veh lockDriver true;
			{ _veh lockturret [[_x], true] } forEach [0,1,2];
			[nil, (units _grp select 0), "per", rSETGROUPID, _callsign] call RE;
			[_veh, _grp, units _grp] spawn _code;
			
			//FSM
			[_veh, _grp, _callsign, _pos, _airport] execFSM "scripts\NEO_radio\fsms\cas.fsm";
			
			private ["_casArray"];
			_casArray = NEO_radioLogic getVariable format ["NEO_radioCasArray_%1", _side];
			_casArray set [count _casArray, [_veh, _grp, _callsign]];
			NEO_radioLogic setVariable [format ["NEO_radioCasArray_%1", _side], _casArray, true];
		};
		
		case "ARTY" : 
		{
			private ["_pos", "_class", "_callsign", "_unitCount", "_rounds", "_code", "_roundsUnit", "_roundsAvailable", "_canMove", "_units", "_grp", "_vehDir"];
			_pos = _array select 0; _pos set [2, 0];
			_class = _array select 1;
			_callsign = toUpper (_array select 2);
			_unitCount = round (_array select 3); if (_unitCount > 4) then { _unitCount = 4 }; if (_unitCount < 1) then { _unitCount = 1 };
			_rounds = _array select 4;
			_code = _array select 5;
			_roundsUnit = _class call NEO_fnc_artyUnitAvailableRounds;
			_roundsAvailable = [];
			_canMove = if (_class in ["MLRS", "GRAD_CDF", "GRAD_INS", "GRAD_RU"]) then { true } else { false };
			_units = [];
			_grp = createGroup _side;
			_vehDir = 0;
			
			for "_i" from 0 to (_unitCount - 1) do
			{
				private ["_vehPos", "_veh"];
				_vehPos = [_pos, 15, _vehDir] call BIS_fnc_relPos; _vehPos set [2, 0];
				_veh = createVehicle [_class, _vehPos, [], 0, "CAN_COLLIDE"];
				[nil, nil, rCALLVAR, [_veh], BIS_ARTY_F_initVehicle] call RE;
				_veh setDir _vehDir;
				_veh setPosATL _vehPos;
				[_veh, _grp] call BIS_fnc_spawnCrew;
				_veh lock true;
				_vehDir = _vehDir + 90;
				_units set [count _units, _veh];
			};
			
			private ["_battery"];
			_battery = (createGroup _side) createUnit ["BIS_ARTY_Logic", _pos, [], 0, "NONE"];
			waitUntil { !isNil { BIS_ARTY_LOADED } };
			
			_battery synchronizeObjectsAdd [_units select 0];
			waitUntil { (_units select 0) in (synchronizedObjects _battery) };
			[nil, nil, "per", rSPAWN, [_grp, _callsign], { (_this select 0) setGroupId [(_this select 1)] }] call RE;
			
			//Validate rounds
			{
				if ((_x select 0) in _roundsUnit) then
				{
					_roundsAvailable set [count _roundsAvailable, _x];
				};
			} forEach _rounds;
			_battery setVariable ["NEO_radioArtyBatteryRounds", _roundsAvailable, true];
			
			//Code to spawn
			[_battery, _grp, _units, units _grp] spawn _code;
			
			//FSM
			[_units, _grp, _callsign, _pos, _roundsAvailable, _canMove, _class, _battery] execFSM "scripts\NEO_radio\fsms\arty.fsm";
			
			private ["_artyArray"];
			_artyArray = NEO_radioLogic getVariable format ["NEO_radioArtyArray_%1", _side];
			_artyArray set [count _artyArray, [_battery, _grp, _callsign, _units, _roundsAvailable]];
			NEO_radioLogic setVariable [format ["NEO_radioArtyArray_%1", _side], _artyArray, true];
		};
	};
}] call RE;
