	private ["_logic","_sectors","_sectors0","_infF","_vehF","_ct","_urbanF","_forestF","_hillsF","_flatF","_seaF","_roadsF","_grF","_actInf","_actVeh"];

	_sectors = _this select 0;
    _logic = _this select ((count _this)-1);

	_sectors0 = _sectors;


	_infF = 0;
	_vehF = 0;
	_ct = 0;

		{
		_urbanF = _x getVariable "Topo_Urban";
		_forestF = _x getVariable "Topo_Forest";
		_hillsF = _x getVariable "Topo_Hills";
		_flatF = _x getVariable "Topo_Flat";
		_seaF = _x getVariable "Topo_Sea";
		_roadsF = _x getVariable "Topo_Roads";
		_grF = _x getVariable "Topo_Grd";

		if not (_seaF >= 90) then 
			{
			//diag_log format ["L - U: %1 F: %2 H: %3, Fl: %4 S: %5 R: %6 G: %7 ",_urbanF,_forestF,_hillsF,_flatF,_seaF,_roadsF,_grF];

			_actInf = _urbanF + _forestF + _grF - _flatF - _hillsF;
			_actVeh = _flatF + _hillsF + _roadsF - _urbanF - _forestF - _grF;

			_x setVariable ["InfFr",_actInf];
			_x setVariable ["VehFr",_actVeh];

			_infF = _infF + _actInf;
			_vehF = _vehF + _actVeh;

			//_txt = format ["Inf: %1 - Veh: %2",_urbanF + _forestF + _grF - _flatF - _hillsF,_flatF + _hillsF + _roadsF - _urbanF - _forestF - _grF];

			//_x setText _txt;
			_ct = _ct + 1
			}
		else
			{
			_sectors = _sectors - [_x];
			}
		}
	foreach _sectors0;

	if (_ct > 0) then {_infF = _infF/_ct};
	if (_ct > 0) then {_vehF = _vehF/_ct};

	[_sectors,_infF,_vehF]