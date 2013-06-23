/* ----------------- Intro Video and UAV ||  ----------------- */
[] spawn {
	// plays video intro
	["rsc\ALIVE.ogv", false] spawn BIS_fnc_titlecard;
	waitUntil {!(isNil "BIS_fnc_titlecard_finished")};
			disableUserinput true;
	
	// UAV intro
	_colorWest = WEST call BIS_fnc_sideColor;
	_colorEast = EAST call BIS_fnc_sideColor;
	{_x set [3, 0.33]} forEach [_colorWest, _colorEast];

	[
		getmarkerpos "ALIVE_INTRO_CENTER",			// Pos
		"Iran has taken control of Stratis Island! UAV overflights have been able to assertain the location of 2 hostages, guarded by 4 infantry units, on the edge of the town of Agia Marina. Alpha Company will be pressing forward ot keep the Iranians distracted. Free the hostages quickly and return to your extraction point by any means possible!",			// Title
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
		waitUntil  {!(isnil "SEP_INIT_FINISHED")};
		disableUserinput false;
};

/* ----------------- OPCOM/TACOM SEP Init ||  ----------------- */
	// call SEP (script version) and sync with OPCOM
	waitUntil {!(isNil "BIS_fnc_titlecard_finished") || isDedicated};
	call compile preprocessfilelinenumbers "\A3\modules_f\sites\init_core.sqf";
	if (isnil "SEP_INIT_FINISHED") then {
		call compile preprocessfile "SEP.sqf";
	};
	//[1250] execfsm "fpsmanager.fsm";

/* ----------------- Fog Setup ||  ----------------- */
[] spawn {	
	// set fog level 
	// 0 setfog [0.2,0.02,100];   
	30 setfog [0.05,0.065,60];
	sleep 30;

	3600 setfog [0.01,0.04,45];
	sleep 3600;
};	
	
/* ----------------- Temporary Init Parameters ||  ----------------- */

	waitUntil { !isNull player }; // Wait for player to initialize

	// SBV System - Statistical-Based Visualizations System - player realism
	[0,0,0] execVM "SBV\SBV.sqf";

/* ----------------- Save and Restore Loadout on revive/respawn ||  ----------------- */
	// Compile scripts - meaning, what you died with is what you revive with
	getLoadout = compile preprocessFileLineNumbers 'fnc_get_loadout.sqf';
	setLoadout = compile preprocessFileLineNumbers 'fnc_set_loadout.sqf';
													
	// Save loadout every 120 seconds
	[] spawn {
		while{true} do {
			if(alive player) then {
				loadout = [player] call getLoadout;
			};
		sleep 120;  
		};
	};

	// Loads saved loadout on respawn
	player addEventHandler ["Respawn", {
			[player,loadout] spawn setLoadout;
			player addaction ["Open Debug Console",{createDialog "RscDisplayDebugPublic"}];
		}
	]; 

/* ----------------- Battlefield Clearance ||  ----------------- */
	_null = [] execVM "DMZ_delete.sqf";  // start the cleanup script.

/* ----------------- INS Revive System ||  ----------------- */
	// INS_revive initialize
	[] execVM "INS_revive\revive_init.sqf";

	// Wait for INS_revive initialized
	waitUntil {!isNil "INS_REV_FNCT_init_completed"};

	player addaction ["Open Debug Console",{createDialog "RscDisplayDebugPublic"}];