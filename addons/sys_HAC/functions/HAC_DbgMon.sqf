	private ["_logic","_txtArr","_dbgMon","_txt"];
    _logic = _this select 0;

	waitUntil 
		{
		sleep 1;
		(not (isNull (_logic getvariable "HAC_HQ")))
		};

	if (_logic getvariable "HAC_BB_Active") then
		{
		waitUntil
			{
			sleep 1;
			not (isNil {_logic getvariable "HAC_BB_mapReady"})
			}
		};

	_txtArr = [];

	while {_logic getvariable "HAC_HQ_Debug"} do
		{
		_txtArr = [];

			{
			if not (isNil "_x") then
				{
				if not (isNull _x) then
					{
					_dbgMon = _x getVariable "DbgMon";
					if not (isNil "_dbgMon") then 
						{
						_txtArr set [(count _txtArr),_dbgMon];
						_txtArr set [(count _txtArr),linebreak];
						}
					}
				}
			}
		foreach [(_logic getvariable "HAC_HQ")];

		if ((count _txtArr) > 0) then
			{
			_txt = composeText _txtArr;

			hintSilent _txt
			};

		sleep 15
		};
    