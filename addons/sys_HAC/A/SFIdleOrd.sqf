_logic = _this select ((count _this)-1);
waitUntil {sleep 1; not (isNil {_logic getvariable "HAC_HQ_SpecForG"})};

while {not (isNull (_logic getvariable "HAC_HQ"))} do
	{
	_pos = getposATL (vehicle _logic);

		{
		_isBad = false;
		if (isNull _x) then
			{
			_isBad = true
			}
		else
			{
			if not (alive (leader _x)) then
				{
				_isBad = true
				}
			else
				{
				_isBad = _x getVariable [("Resting" + (str _x)),false];
				if not (_isBad) then
					{
					_isBad = _x getVariable [("Busy" + (str _x)),false]
					}
				}
			};

		if not (_isBad) then
			{
			_unitG = _x;
			[_unitG,_logic] call ALiVE_fnc_HAC_WPdel;

			_pos = getposATL (vehicle _logic);
			_posX = (_pos select 0) + (random 200) - 100;
			_posY = (_pos select 1) + (random 200) - 100;

			_isWater = surfaceIsWater [_posX,_posY];
			_cnt = 0;

			while {((_isWater) or (_cnt > 100))} do
				{
				_cnt = _cnt + 1;
				_posX = (_pos select 0) + (random 200) - 100;
				_posY = (_pos select 1) + (random 200) - 100;
				_isWater = surfaceIsWater [_posX,_posY]
				};

			if not (_isWater) then 
				{
				_UL = leader _unitG;
				_logic setvariable ["HAC_HQ_VCDone",false];
				if (isPlayer _UL) then {[_UL,_logic,_logic] spawn ALiVE_fnc_HAC_VoiceComm;sleep 3;waituntil {sleep 0.1;((_logic getvariable "HAC_HQ_VCDone"))}};

				_tasks = _UL getVariable ["HACAddedTasks",[]];

				if ((count _tasks) == 0) then
					{
					if (isPlayer _UL) then
						{
						_task = [_UL,["Guard HQ.", "Guard", ""],[_posX,_posY],_logic] call ALiVE_fnc_HAC_AddTask
						}
					};

				_wp = [_logic,_unitG,[_posX,_posY],"HOLD","AWARE","RED","NORMAL"] call ALiVE_fnc_HAC_WPadd
				}
			}
		}
	foreach (_logic getvariable "HAC_HQ_SpecForG");

	waitUntil
		{
		sleep 30;

		_nPos = getposATL (vehicle _logic);

		((_nPos distance _pos) > 10)
		}
	};