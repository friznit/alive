_logic = _this select ((count _this)-1);
_expression = "(1 + (2 * Meadow)) * (1 - Forest) * (1 - (0.5 * Trees)) * (1 - (10 * sea)) * (1 - (2 * Houses))";
_radius = 100;
_precision = 20;
_sourcesCount = 1;

waituntil {sleep 1;not (isNil {_logic getvariable "HAC_HQ_NCCargoG"})};

while {not (isNull (_logic getvariable "HAC_HQ"))} do
	{
	sleep 60;
	if (isNull (_logic getvariable "HAC_HQ")) exitWith {};

		{
		sleep 1;
		_LU = leader _x;
		_lastpos = _x getvariable ("START" + (str _x));
		if (isNil ("_lastpos")) then {_x setVariable [("START" + (str _x)),(position (assignedvehicle _LU))]};
		_lastpos = _x getvariable ("START" + (str _x));
		_position = [((position _logic) select 0) + (random 800) - 400,((position _logic) select 1) + (random 800) - 400];
		_Spot = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];
		_Spot = _Spot select 0;
		_Spot = _Spot select 0;

		_posX = _Spot select 0;
		_posY = _Spot select 1;
		
		_isWater = surfaceIsWater [_posX,_posY];

		if (not (_x in (_logic getvariable "HAC_HQ_AirG")) and not
			(_iswater) and
				((_lastpos distance (_logic getvariable "HAC_HQ_Obj")) > 2000) and 
					((_lastpos distance _logic) > 1000) and 
						((isNull (_logic FindNearestEnemy [_posX,_posY])) or (((_logic findNearestEnemy [_posX,_posY]) distance [_posX,_posY]) > 600)) or
							(not (isNull (_LU FindNearestEnemy _LU)) and (((_LU findNearestEnemy _LU) distance _LU) < 500))) then 
			{
			_x setVariable [("START" + (str _x)),[_posX,_posY]];
			};
		}   
	foreach (_logic getvariable "HAC_HQ_NCCargoG");
	}