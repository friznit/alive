	private ["_logic","_points","_clusters","_centers","_cluster","_midX","_midY","_center","_clustersC","_newClusters","_newCluster","_clusterNearby","_centerC"];

	_points = _this select 0;
    _logic = _this select ((count _this)-1);

	_clusters = [_points,_logic] call ALiVE_fnc_HAC_ClusterB;

	_centers = [];


		{
		_cluster = _x;	

		_midX = 0;
		_midY = 0;

			{
			_midX = _midX + (_x select 0);
			_midY = _midY + (_x select 1);
			}
		foreach _cluster;

		_center = [_midX/(count _cluster),_midY/(count _cluster),0];
		_centers set [(count _centers),_center];
		}
	foreach _clusters;

	_clusters set [(count _clusters),_centers];

	_clustersC = [_centers,500,_logic] call ALiVE_fnc_HAC_ClusterA;

	_newClusters = [];

		{
		_newCluster = [];
		_clusterNearby = [];

			{
			_centerC = _x;

				{
				if (((_centers select _foreachIndex) select 0) == (_centerC select 0)) then {_clusterNearby set [(count _clusterNearby),(_clusters select _foreachIndex)]}
				}
			foreach _clusters
			}
		foreach _x;

			{
				{
				_newCluster set [(count _newCluster),_x]
				}
			foreach _x
			}
		foreach _clusterNearby;

		_newClusters set [(count _newClusters),_newCluster]
		}
	foreach _clustersC;

	_clusters = _newClusters;

	_clusters