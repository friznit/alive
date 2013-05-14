	private ["_logic","_points","_clusters","_point","_sumC","_sumS","_sumMin","_pointMin","_dstMin","_sum","_dstAct","_added","_cluster","_inside"];

	_points = _this select 0;
    _logic = _this select ((count _this)-1);

	_clusters = [];

		{
		_point = _x;
		_sumC = (_point select 0) + (_point select 1);

		_added = false;
		_inside = false;

			{
				{
				_sum = (_x select 0) + (_x select 1);
				if (_sum == _sumC) exitWith {_inside = true}
				}
			foreach _x;

			if (_inside) exitWith {}
			}
		foreach _clusters;

		if not (_inside) then
			{
			_sumMin = _sumC;
			_pointMin = _point;
			_dstMin = 100000;

				{
				_sum = (_x select 0) + (_x select 1);

				if not (_sumC == _sum) then
					{
					_dstAct = _point distance _x;
					if (_dstAct < _dstMin) then
						{
						_dstMin = _dstAct;
						_pointMin = _x;
						_sumMin = _sum;
						}
					}
				}
			foreach _points;

				{
				_cluster = _x;

					{
					_sumS = (_x select 0) + (_x select 1);
					if (_sumS == _sumMin) exitWith 
						{
						_added = true;
						_cluster set [(count _cluster),_point]
						};
					}
				foreach _cluster;

				if (_added) exitWith {}
				}
			foreach _clusters;

			if not (_added) then 
				{
				_clusters set [(count _clusters),[_point,_pointMin]];
				};
			}
		}
	foreach _points;

	_clusters