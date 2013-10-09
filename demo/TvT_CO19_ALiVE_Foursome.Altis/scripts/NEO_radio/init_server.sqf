publicVariable "NEO_radioLogic";

private ["_sides"];
_sides = _this;
_sides set [0, "DELETE"];
_sides = _sides - ["DELETE"];

{
	private ["_currentArray"];
	_currentArray = _x;
	
	private ["_side", "_transportArray", "_casArray", "_artyArray"];
	_side = _currentArray select 0;
	_transportArray = _currentArray select 1;
	_casArray = _currentArray select 2;
	_artyArray = _currentArray select 3;
	
	private ["_t", "_c", "_a"];
	_t = [];
	_c = [];
	_a = [];
	
	NEO_radioLogic setVariable [format ["NEO_radioTrasportArray_%1", _side], [],true];
	NEO_radioLogic setVariable [format ["NEO_radioCasArray_%1", _side], [],true];
	NEO_radioLogic setVariable [format ["NEO_radioArtyArray_%1", _side], [],true];
	
	//Transport
	{
		private ["_pos", "_dir", "_type", "_callsign", "_tasks", "_code"];
		_pos = _x select 0; _pos set [2, 0];
		_dir = _x select 1;
		_type = _x select 2;
		_callsign = toUpper (_x select 3);
		_tasks = _x select 4;
		_code = _x select 5;
		
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
		[[(units _grp select 0),_callsign], "fnc_setGroupID", false, false] spawn BIS_fnc_MP;
		//[nil, (units _grp select 0), "per", SETGROUPID, _callsign] spawn BIS_fnc_MP;
		_veh setVariable ["NEO_transportAvailableTasks", _tasks, true];
		[_veh, _grp, units _grp] spawn _code;
 
		[[_veh, ["Support Radio", "scripts\NEO_radio\radio_action.sqf", "radio", -1, false, true, "", "_this in _target
			&&
			_this hasWeapon ""itemRadio""
			&&
			_this hasWeapon ""itemGps""
		"]],"fnc_addAction",true,true] spawn BIS_fnc_MP; 

		[[ _veh, ["Talk with pilot", "scripts\NEO_radio\radio_action.sqf", "talk", -1, false, true, "", 
		"
			_this in _target
			&&
			{
				lifeState _x == ""ALIVE""
				&&
				_x in (assignedCargo _target)
				&&
				rankID _x > rankID _this
			}
			count (crew _target) == 0
		"]],"fnc_addAction",true,true] spawn BIS_fnc_MP;  
		
		//FSM
		[_veh, _grp, _callsign, _pos] execFSM "scripts\NEO_radio\fsms\transport.fsm";
		
		_t = NEO_radioLogic getVariable format ["NEO_radioTrasportArray_%1", _side];
		_t set [count _t, [_veh, _grp, _callsign]];
		
	} forEach _transportArray;
	
	//CAS
	{
		private ["_pos", "_dir", "_type", "_callsign", "_airport", "_code"];
		_pos = _x select 0; _pos set [2, 0];
		_dir = _x select 1;
		_type = _x select 2;
		_callsign = toUpper (_x select 3);
		_airport = _x select 4;
		_code = _x select 5;
		
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
		[[(units _grp select 0),_callsign], "fnc_setGroupID", false, false] spawn BIS_fnc_MP;
		//[nil, (units _grp select 0), "per", SETGROUPID, _callsign] spawn BIS_fnc_MP;
		[_veh, _grp, units _grp] spawn _code;
		
		//FSM
		[_veh, _grp, _callsign, _pos, _airport] execFSM "scripts\NEO_radio\fsms\cas.fsm";
		
		_c = NEO_radioLogic getVariable format ["NEO_radioCasArray_%1", _side];
		_c set [count _c, [_veh, _grp, _callsign]];
		
	} forEach _casArray;
	
	//ARTY
	/*
	{
		private ["_pos", "_class", "_callsign", "_unitCount", "_rounds", "_code", "_roundsUnit", "_roundsAvailable", "_canMove", "_units", "_grp", "_vehDir"];
		_pos = _x select 0; _pos set [2, 0];
		_class = _x select 1;
		_callsign = toUpper (_x select 2);
		_unitCount = round (_x select 3); if (_unitCount > 4) then { _unitCount = 4 }; if (_unitCount < 1) then { _unitCount = 1 };
		_rounds = _x select 4;
		_code = _x select 5;
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
			_veh setDir _vehDir;
			_veh setPosATL _vehPos;
			[_veh, _grp] call BIS_fnc_spawnCrew;
			_veh lock true;
			_vehDir = _vehDir + 90;
			_units set [count _units, _veh];
			//[nil, _veh, "per", AddAction, "Talk with Artillery Crew", "scripts\NEO_radio\radio_action.sqf", "talkarty", -1, false, true, "", "_this distance _target <= 5"] spawn BIS_fnc_MP;
		};
		
		private ["_battery"];
		_battery = (createGroup _side) createUnit ["BIS_ARTY_Logic", _pos, [], 0, "NONE"];
		//waitUntil { !isNil { BIS_ARTY_LOADED } };
		{ _x setVariable ["NEO_radioArtyModule", [_battery, _callsign], true] } forEach _units;
		
		_battery synchronizeObjectsAdd [_units select 0];
		//waitUntil { (_units select 0) in (synchronizedObjects _battery) };
		[[(units _grp select 0),_callsign], "fnc_setGroupID", false, false] spawn BIS_fnc_MP;
		//[nil, (units _grp select 0), "per", SETGROUPID, _callsign] spawn BIS_fnc_MP;
		[_battery, _grp, _units, units _grp] spawn _code;
		
		//Validate rounds
		{
			if ((_x select 0) in _roundsUnit) then
			{
				_roundsAvailable set [count _roundsAvailable, _x];
			};
		} forEach _rounds;
		_battery setVariable ["NEO_radioArtyBatteryRounds", _roundsAvailable, true];
		
		//FSM
		[_units, _grp, _callsign, _pos, _roundsAvailable, _canMove, _class, _battery] execFSM "scripts\NEO_radio\fsms\arty.fsm";
		
		_a = NEO_radioLogic getVariable format ["NEO_radioArtyArray_%1", _side];
		_a set [count _a, [_battery, _grp, _callsign, _units, _roundsAvailable]];
		
	} forEach _artyArray;*/
	
	NEO_radioLogic setVariable [format ["NEO_radioTrasportArray_%1", _side], _t, true];
	NEO_radioLogic setVariable [format ["NEO_radioCasArray_%1", _side], _c, true];
	NEO_radioLogic setVariable [format ["NEO_radioArtyArray_%1", _side], _a, true];
	 diag_log format ["NEO_radioLogic: %1", NEO_radioLogic];
	
} forEach _sides;
