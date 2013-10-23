private ["_sides"];
_sides = _this;
 diag_log format ["Server Sides1: %1", _sides];
_sides set [0, "DELETE"];
 diag_log format ["Server Sides2: %1", _sides];
_sides = _sides - ["DELETE"];
 diag_log format ["Server Sides3: %1", _sides];




	private ["_currentArray"];
	_currentArray =  ALIVE_coreLogic;
	 diag_log format ["CurrArray: %1", _currentArray];

	private ["_side", "_casArray"];
	_side = WEST;
	_casArray = _currentArray;
	 diag_log format ["Side: %1", _side];
	  diag_log format ["CasArray: %1", _casArray];
	
//	private ["_c"];
//	_c = [];
	
	//ALIVE_radioLogic = [format ["ALIVE_radioCasArray_%1", _side], []];
	// diag_log format ["ALIVE_radioLogic %1", ALIVE_radioLogic];
	
	//CAS
	//{
		private ["_pos", "_dir", "_type", "_callsign", "_airport", "_code"];
		_pos = _currentArray select 0; 
		 diag_log format ["pos %1", _pos];
		_dir = _currentArray select 1;
		_type = _currentArray select 2;
		_callsign = toUpper (_currentArray select 3);
		_airport = _currentArray select 4;

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
		_grp setGroupid [_callsign,"GroupColor0"];
		 diag_log format ["Group %1", _grp];
		//FSM
		[_veh, _grp, _callsign, _pos, _airport] execFSM "\x\alive\addons\sup_cas\cas\fsms\cas.fsm";
		
		// ALIVE_radioLogic = [format ["ALIVE_radioCasArray_%1", _side]];
		 //_c = ALIVE_radioLogic;
		 //diag_log format ["C: %1", _c];
		//_c set [count _c, [_veh, _grp, _callsign]];
		//diag_log format ["C: %1", _c];
	//} forEach _casArray;
	
	//ALIVE_radioLogic = [format ["ALIVE_radioCasArray_%1", _side], _c, true];
	 diag_log format ["SALIVE_radioLogic: %1", ALIVE_radioLogic];
	
