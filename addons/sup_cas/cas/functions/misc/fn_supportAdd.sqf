[nil, ALIVE_radioLogic, "loc", rSPAWN, _this,
{
	private ["_side", "_support", "_array"];
	_side = _this select 0;
	_support = _this select 1;
	_array = _this select 2;
	

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
			[_veh, _grp, _callsign, _pos, _airport] execFSM "cas\fsms\cas.fsm";
			
			private ["_casArray"];
			_casArray = ALIVE_radioLogic getVariable format ["ALIVE_radioCasArray_%1", _side];
			_casArray set [count _casArray, [_veh, _grp, _callsign]];
			ALIVE_radioLogic setVariable [format ["ALIVE_radioCasArray_%1", _side], _casArray, true];
		};
		
		
}] call RE;
