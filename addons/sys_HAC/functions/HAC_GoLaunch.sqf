	private ["_logic","_side","_kind","_code"];

	_side = _this select 0;
	_kind = _this select 1;

	_code = {};

	switch (_side) do
		{
		case ("A") : 
			{
			switch (_kind) do
				{
				case ("INF") : {_code = A_GoAttInf};
				case ("ARM") : {_code = A_GoAttArmor};
				case ("SNP") : {_code = A_GoAttSniper};
				case ("AIR") : {_code = A_GoAttAir};
				};
			};
		};

	_code