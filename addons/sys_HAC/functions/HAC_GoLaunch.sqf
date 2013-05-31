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
				case ("INF") : {_code = ALiVE_fnc_HAC_GoAttInf};
				case ("ARM") : {_code = ALiVE_fnc_HAC_GoAttArmor};
				case ("SNP") : {_code = ALiVE_fnc_HAC_GoAttSniper};
				case ("AIR") : {_code = ALiVE_fnc_HAC_GoAttAir};
				};
			};
		};

	_code