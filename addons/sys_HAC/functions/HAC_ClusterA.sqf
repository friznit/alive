	private ["_logic","_points","_clusters","_checked","_newCluster","_point","_range","_sum"];

	_points = _this select 0;
	_range = _this select 1;
    _logic = _this select ((count _this)-1);

	_clusters = [];
	_checked = [];
	_newCluster = [];

	//_points2 = +_points;

		{
		_sum = (_x select 0) + (_x select 1);
		if not (_sum in _checked) then
			{
			_checked set [(count _checked),_sum];
			_point = _x;
			_newCluster = [_point];

				{
				_sum = (_x select 0) + (_x select 1);
				if not (_sum in _checked) then
					{
					if ((_point distance _x) <= _range) then 
						{
						_checked set [(count _checked),_sum];
						_newCluster set [(count _newCluster),_x];
						}
					}
				}
			foreach _points;

			_clusters set [(count _clusters),_newCluster]
			}
		}
	foreach _points;

	_clusters