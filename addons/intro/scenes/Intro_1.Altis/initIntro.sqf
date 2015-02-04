{_x allowFleeing 0} forEach allUnits;

private ["_colorWest", "_colorEast"];
_colorWest = WEST call BIS_fnc_sideColor;
_colorEast = EAST call BIS_fnc_sideColor;
{_x set [3, 0.33]} forEach [_colorWest, _colorEast];


switch true do {

		//--- Default
		default {

				0 setFog [0.01, 0.06, 55];

				private ["_cam","_camx","_camy","_camz","_object1","_object2","_object3","_object4","_header1","_Line1","_header2","_Line2","_header3","_Line3","_header4","_Line4"];


				//--- Play ALiVE Intro Music.
				playMusic "ALiVE_Intro";
				addMusicEventHandler ["MusicStop", {[] spawn {sleep 12; playMusic "Track14_MainMenu"}}];

				//--- Define Cam Positions
				_object1 = loc1;
				_object2 = loc2;

				//--- Camera number 1 - NATO Boarding chopper.
				_camx = getposATL _object1 select 0;
				_camy = getposATL _object1 select 1;
				_camz = getposATL _object1 select 2;
				_cam = "camera" CamCreate [_camx -1 ,_camy + 0,_camz+0];
				_cam CamSetTarget _object1;
				_cam CameraEffect ["Internal","Back"];
				_cam CamCommit 0;

				//--- Setup AAN News Macre. Still works! Neat!
				_header1 = parsetext "<t size='2.0'>Iran Annexes Altis</t><br />President Taylor Deploys AAF Counter Forces";
				_line1 = parsetext "- Breaking News - Iran forces annex island of Altis - Breaking News - AAF Forces Deployed in Altis - Breaking News - AAF President Taylor calls on NATO";

				nul = [_header1,_line1] spawn BIS_fnc_AAN;

				//--- End

				sleep 24;

				//--- Camera number 2 - UAV Fly By.
				_camx = getposATL _object2 select 0;
				_camy = getposATL _object2 select 1;
				_camz = getposATL _object2 select 2;
				_cam = "camera" CamCreate [_camx + 4 ,_camy + 0,_camz + 50];
				_cam CamSetTarget _object2;
				_cam CameraEffect ["Internal","Back"];
				_cam CamCommit 0;

				//--- Setup AAN News Macre. Still works! Neat!
				_header2 = parsetext "<t size='2.0'>Breaking News!</t><br />FIA Guerilla Forces become desperate for foothold.";
				_line2 = parsetext "- Militant pull out of Lebanese border town with captives - China Police investigate U.S citizen near border of North Korea";

				nul = [_header2,_line2] spawn BIS_fnc_AAN;

				//--- End

				sleep 20;

				//--- Don't go breaking my immersion
				titleText ["Establishing UAV Connection.", "BLACK IN",9999];
				sleep 1;
				titleText ["Establishing UAV Connection..", "BLACK IN",9999];
				sleep 1;
				titleText ["Establishing UAV Connection...", "BLACK IN",9999];
				sleep 1;
				titleText ["Establishing UAV Connection....", "BLACK IN",9999];
				sleep 1;

				//--- Terminate Cam
				_cam CameraEffect ["Terminate","Back"];
				CamDestroy _cam;

				//--- Terminate AAN News Feed - Okay so the above might work, but the only way to disable it is to kill it with fire.
				(uinamespace getvariable "BIS_AAN") closedisplay 1;

				//--- Setup UAV Camera (Orbit!)

				[
				[14517.5,17589,0],"",if (viewDistance < 1500) then {150} else {200},200,400,1,[
				["\a3\ui_f\data\map\markers\nato\b_recon.paa", _colorWest, BIS_BLU_group1, 1, 1, 0, "", 0],
				["\a3\ui_f\data\map\markers\nato\b_inf.paa", _colorWest, BIS_BLU_group2, 1, 1, 0, "", 0],
				["\a3\ui_f\data\map\markers\nato\o_inf.paa", _colorEast, BIS_OP_group1, 1, 1, 0, "", 0],
				["\a3\ui_f\data\map\markers\nato\o_inf.paa", _colorEast, BIS_OP_group2, 1, 1, 0, "", 0],
				["\a3\ui_f\data\map\markers\nato\o_inf.paa", _colorEast, BIS_OP_group3, 1, 1, 0, "", 0]
				], 1] spawn BIS_fnc_establishingShot;

				waitUntil {!(isNil "BIS_fnc_establishingShot_playing")};

				//--- Cheese!
				titleText ["Established", "BLACK IN", 3];

				sleep 1;

				//--- Enjoy the action. -Haze

		};

};