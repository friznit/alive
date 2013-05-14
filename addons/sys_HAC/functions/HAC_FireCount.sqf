	private ["_logic","_unit","_count","_fEH"];

	_unit = _this select 0;
    _logic = _this select ((count _this)-1);

	_count = _unit getVariable ["FireCount",0];

	if (_count >= 2) exitWith 
		{
		_fEH = _unit getVariable "HAC_FEH";
		if not (isNil "_fEH") then
			{
			_unit removeEventHandler ["Fired",_fEH];
			_unit setVariable ["HAC_FEH",nil]
			}
		};

	_unit setVariable ["FireCount",_count + 1]