	private ["_logic","_gp","_All","_unit","_pos","_posX","_posY","_type","_muzzles"];

	_gp = _this select 0;
    _logic = _this select ((count _this)-1);
	_All = units _gp;

		{
		_unit = _x;
		_pos = getPosATL _unit;

		_posX = _pos select 0;
		_posY = _pos select 1;

		_posX = _posX + (random 0.25) - 0.125;
		_posY = _posY + (random 0.25) - 0.125;

		_unit setPos [_posX,_posY,1];

		sleep 0.05;

		_unit doMove [_posX,_posY,0];

		sleep 0.05;

		_unit setDir (getDir player);

		sleep 0.05;

		_unit forcespeed -1;

		sleep 0.05;

		if ((count (weapons _unit)) > 0) then
			{
			private["_logic","_type", "_muzzles"];

			_type = (weapons _unit) select 0;
			_muzzles = getArray(configFile >> "cfgWeapons" >> _type >> "muzzles");

			if (count _muzzles > 1) then
				{
				_unit selectWeapon (_muzzles select 0);
				}
			else
				{
				_unit selectWeapon _type
				}
			}
		}
	foreach _All;

	sleep 0.5;

		{
		_x doWatch ObjNull;
		sleep 0.05;
		_x doTarget ObjNull;
		sleep 0.05;
		_x enableReload false;
		sleep 0.05;
		_x stop true;
		sleep 0.05;
		_x setUnitPos "UP";
		sleep 0.05
		}
	foreach _All;

	sleep 0.5;

		{
		_x switchMove "";
		sleep 0.05;
		_x disableAI "TARGET";
		sleep 0.05;
		_x disableAI "AUTOTARGET";
		sleep 0.05;
		_x disableAI "MOVE";
		sleep 0.05;
		_x disableAI "FSM";
		sleep 0.05;
		_x disableAI "ANIM";
		sleep 0.05
		}
	foreach _All;

	sleep 5;

		{
		_x setUnitPos "AUTO";
		sleep 0.05;
		_x enableAI "TARGET";
		sleep 0.05;
		_x enableAI "AUTOTARGET";
		sleep 0.05;
		_x enableAI "MOVE";
		sleep 0.05;
		_x enableAI "FSM";
		sleep 0.05;
		_x enableAI "ANIM";
		sleep 0.05;
		_x stop false;
		sleep 0.05;
		_x enableReload true;
		sleep 0.05
		}
	foreach _All;