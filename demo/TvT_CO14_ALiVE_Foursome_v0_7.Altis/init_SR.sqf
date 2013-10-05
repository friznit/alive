publicVariable "NEO_coreLogic";

[
	NEO_coreLogic,
	[
		WEST,
		[
			[
				getMarkerPos "NEO_mkr_transport_00", 
				270, 
				"B_Heli_Transport_01_camo_F", 
				"Eagle-One", 
				["pickup", "land", "land (eng off)", "move", "circle"], 
				{}
			],
			[
				getMarkerPos "NEO_mkr_transport_01", 
				270, 
				"B_Heli_Transport_01_camo_F", 
				"Eagle-Two", 
				["pickup", "land", "land (eng off)", "move", "circle"], 
				{}
			]
		],
		[
			[
				getMarkerPos "NEO_mkr_cas_00", 
				270,
				"B_Heli_Attack_01_F",
				"Falcon-One",
				0,
				{}
			]
		],
		[																	//ARTY ARRAY MUST COME IN THIRD, USE EMPTY ARRAY IF NO ARTY UNITS SHOULD BE ADDED TO SIDE
			[																//ARTY Battery 1
				getMarkerPos "NEO_mkr_arty_00",								//Spawn Position
				"MLRS",														//Vehicle Class name
				"MLRS FATMAN",												//Callsign
				2,															//Number of weapons in the battery group
				[["HE", 30]],												//Available Rounds/Ammo (Will be checked later if matches the currect vehicle type of ammo)
				{}															//Code to execute, you can access in _this variable [_battery(gamelogic), _grp, _vehicles, _crew]
			]
		]
	]
] execVM "scripts\NEO_radio\init.sqf";
