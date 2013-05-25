call compile preprocessfilelinenumbers "\A3\modules_f\sites\init_core.sqf";
		[] spawn {
			scriptName "initMission.hpp: mission start";

			["rsc\ALIVE.ogv", false] spawn BIS_fnc_titlecard;
			waitUntil {!(isNil "BIS_fnc_titlecard_finished")};

			_colorWest = WEST call BIS_fnc_sideColor;
			_colorEast = EAST call BIS_fnc_sideColor;
			{_x set [3, 0.33]} forEach [_colorWest, _colorEast];


			[
			getmarkerpos "ALIVE_INTRO_CENTER",			// Pos
			"ALiVE Mission Just Pure Death!",			// Title
			1000,							// 500m altitude
			300,							// 200m radius
			90,							// 0 degrees viewing angle
			1,							// Clockwise movement
			[
				["\a3\ui_f\data\map\markers\nato\n_inf.paa", _colorWest, markerPos "ALIVE_BLU", 1, 1, 0, "Highhead", 0],
				["\a3\ui_f\data\map\markers\nato\n_inf.paa", _colorWest, markerPos "ALIVE_BLU_1", 1, 1, 0, "Gunny", 0],
				["\a3\ui_f\data\map\markers\nato\n_inf.paa", _colorWest, markerPos "ALIVE_BLU_2", 1, 1, 0, "Wolffy", 0],
				["\a3\ui_f\data\map\markers\nato\n_inf.paa", _colorWest, markerPos "ALIVE_BLU_3", 1, 1, 0, "Chris", 0],
				["\a3\ui_f\data\map\markers\nato\n_inf.paa", _colorWest, markerPos "ALIVE_BLU_4", 1, 1, 0, "Tup", 0],
				["\a3\ui_f\data\map\markers\nato\n_inf.paa", _colorWest, markerPos "ALIVE_BLU_5", 1, 1, 0, "Friznit", 0],
				["\a3\ui_f\data\map\markers\nato\o_inf.paa", _colorEast, markerPos "ALIVE_ENEMY", 1, 1, 0, "", 0],
				["\a3\ui_f\data\map\markers\nato\o_inf.paa", _colorEast, markerPos "ALIVE_ENEMY_1", 1, 1, 0, "", 0],
				["\a3\ui_f\data\map\markers\nato\o_inf.paa", _colorEast, markerPos "ALIVE_ENEMY_2", 1, 1, 0, "", 0],
				["\a3\ui_f\data\map\markers\nato\o_inf.paa", _colorEast, markerPos "ALIVE_ENEMY_3", 1, 1, 0, "", 0],
				["\a3\ui_f\data\map\markers\nato\o_inf.paa", _colorEast, markerPos "ALIVE_ENEMY_4", 1, 1, 0, "", 0],
				["\a3\ui_f\data\map\markers\nato\o_inf.paa", _colorEast, markerPos "ALIVE_ENEMY_5", 1, 1, 0, "", 0],
				["\a3\ui_f\data\map\markers\nato\o_plane.paa", _colorEast, markerPos "ALIVE_ENEMY_6", 1, 1, 0, "", 0]
			]
		] spawn BIS_fnc_establishingShot;   
		};

0 setfog [0.2,0.02,100];        
initAllSites = compile preprocessfile "SEP.sqf";
initSite = compile preprocessfilelinenumbers "\A3\modules_f\sites\site_inits\military_base.sqf";

[] spawn {
	sleep 10;
	player sidechat format["INIT sites starting - time: %1...",time];
	[] call initAllSites;
	waituntil {!isnil "initAllSitesFinished"};
	player sidechat format["INIT sites ended - time: %1...",time];

	//diag_log "starting FPS";                        
	//[1250] execfsm "fpsmanager.fsm";
};