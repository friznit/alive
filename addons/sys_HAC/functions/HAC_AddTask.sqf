	private ["_logic","_unit","_descr","_dstn","_task","_tasks","_tName"];
diag_log format["AddTask: %1",_this];
	_unit = _this select 0;
	_descr = _this select 1;
	_dstn = _this select 2;
    _logic = _this select 3;
	_task = taskNull;
	_tasks = _unit getVariable ["HACAddedTasks",[]];
    //player sidechat format["Group: %1 Task: %2 Dest: %3",group _unit,_descr,_dstn];
    diag_log format["Group: %1 Task: %2 Dest: %3",group _unit,_descr,_dstn];

	if (isPlayer _unit) then {
		if not (isMultiplayer) then {
			{
				_unit removeSimpleTask _x
			} foreach _tasks;

			_task = _unit createSimpleTask ["title"];
			_tasks = _unit getVariable ["HACAddedTasks",[]];
			_tasks set [(count _tasks),_task];
			_unit setVariable ["HACAddedTasks",_tasks];
			_task setSimpleTaskDescription _descr;
			_task setSimpleTaskDestination _dstn
		} else {
			{
				[nil,nil, "per", rSETTASKSTATE,_x,"Succeeded"] call RE
			} foreach _tasks;
			
			_tName = (str (group _unit)) + (str (count _tasks)) + "HACtask";
			_task = _tName;
			[_unit,nil, "per", rCREATESIMPLETASK,_tName] call RE;

			_tasks = _unit getVariable ["HACAddedTasks",[]];
			_tasks set [(count _tasks),_tName];
			_unit setVariable ["HACAddedTasks",_tasks];

			[nil,nil, "per", rSETSIMPLETASKDESCRIPTION, _tName,_descr] call RE;
			[nil,nil, "per", rSETSIMPLETASKDESTINATION, _tName,_dstn] call RE
		}
	};

	_task