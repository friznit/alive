[nil, ALIVE_radioLogic, "loc", rSPAWN, _this,
{
	private ["_side", "_support", "_callsign"];
	_side = _this select 0;
	_support = _this select 1;
	_callsign = _this select 2;

			private ["_array", "_index"];
			_array = ALIVE_radioLogic getVariable format ["ALIVE_radioCasArray_%1", _side];
			_index = 99;
			
			{
				if ((_x select 2) == _callsign) then
				{
					_index = _forEachIndex;
				};
			} forEach _array;
			
			if (_index != 99) then
			{
				{
					switch (_forEachIndex) do
					{
						case 0 : { { deletevehicle _x } forEach crew _x; deleteVehicle _x };
						case 1 : { deleteGroup _x };
					};
				} forEach (_array select _index);
				
				_array set [_index, "DELETEPLEASE"];
				_array = _array - ["DELETEPLEASE"];
				ALIVE_radioLogic setVariable [format ["ALIVE_radioCasArray_%1", _side], _array, true];
			}
			else
			{
				diag_log format ["Support with callsign %1 not found in Cas units", _callsign];
			};
		};
		
}] call RE;
