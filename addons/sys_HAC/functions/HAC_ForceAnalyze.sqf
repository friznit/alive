	private ["_logic","_HQarr","_frArr","_enArr","_frG","_enG","_HQs","_arr"];

	_HQarr = _this select 0;
    _logic = _this select ((count _this)-1);
    
    diag_log _HQarr;
    diag_log _logic;

	_frArr = [];
	_enArr = [];

	_frG = [];
	_enG = [];

	_HQs = [];

		{
		switch (true) do
			{
			case ((_x == _logic) and not (isNull (_logic getvariable "HAC_HQ"))) : 
				{
				_arr = ((_logic getvariable "HAC_BB_arrA") + [_frArr,_enArr,_enG,(_logic getvariable "HAC_HQ")]) call ALiVE_fnc_HAC_ForceCount;
				_frArr = _arr select 0;
				_enArr = _arr select 1;
				_HQs set [(count _HQs),(group _x)];
				_frG = _frG + (_logic getvariable "HAC_HQ_Friends") - (_logic getvariable "HAC_HQ_Exhausted");

					{
					if not (_x in _enG) then {_enG set [(count _enG),_x]};
					}
				foreach (_logic getvariable "HAC_HQ_KnEnemiesG")
				};
			default {false};
			}
		}
	foreach _HQarr;

	_frArr set [(count _frArr),_frG];
	_enArr set [(count _enArr),_enG];
	
	_exp = [_frArr,_enArr,_HQs];
    diag_log _exp;
    _exp;
    