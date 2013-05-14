_logic = _this select ((count _this)-1);
if (isNil ("HAC_HQ_KnowTL")) then {_logic setvariable ["HAC_HQ_KnowTL", true]};
	
while {not (isNull (_logic getvariable "HAC_HQ"))} do
	{
	waituntil {sleep 1; not (isNil ("HAC_HQ_KnEnemies"))};
	sleep 20;
	_players = [];
	if ((_logic getvariable "HAC_HQ_KnowTL")) then 
		{
			{
			if (isPlayer (leader _x)) then {_players = _players + [_x]};
			}
		foreach (_logic getvariable "HAC_HQ_Friends");
		};

	for [{_z = 0},{_z < (count (_logic getvariable "HAC_HQ_KnEnemies"))},{_z = _z + 1}] do
		{
		_KnU = (_logic getvariable "HAC_HQ_KnEnemies") select _z;

			{
			if ((_x knowsAbout _KnU) > 0.01) then 
				{
					{
					_x reveal [_KnU,2]
					} 
				foreach ([(_logic getvariable "HAC_HQ")] + _players);

				if ((_logic getvariable "HAC_xHQ_NEAware") > 0) then
					{
						{
						_ldr = vehicle (leader _x);
						_dst = _ldr distance (vehicle _KnU); 
						if (_dst < (_logic getvariable "HAC_xHQ_NEAware")) then
							{
							_x reveal [_KnU,2]
							}
						}
					foreach (_logic getvariable "HAC_HQ_Friends");
					}
				}
			}
		foreach (_logic getvariable "HAC_HQ_Friends")
		};

	for [{_z = 0},{_z < (count (_logic getvariable "HAC_HQ_Friends"))},{_z = _z + 1}] do
		{
		_KnU = (_logic getvariable "HAC_HQ_Friends") select _z;

			{
			_x reveal [(vehicle (leader _KnU)),4]
			} 
		foreach ([(_logic getvariable "HAC_HQ")] + _players)
		};
	};