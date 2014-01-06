#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif

[] spawn {
	sleep 30;
	30 setfog [0.07,0.055,130];
};

if (hasInterface) then {
	private ["_cam","_camx","_camy","_camz","_object"];
	
	titleText ["The ALiVE Team presents...", "BLACK IN",9999];
	
	waituntil {!(isnull player)};
	sleep 10;
	
	_object = player;
	_camx = getposATL player select 0;
	_camy = getposATL player select 1;
	_camz = getposATL player select 2;
	
	_cam = "camera" CamCreate [_camx,_camy,_camz+200];
	
	_cam CamSetTarget player;
	_cam CameraEffect ["Internal","Back"];
	_cam CamCommit 0;
	
	_cam camsetpos [_camx,_camy,_camz];
	_cam CamCommit 30;
	sleep 5;
	
	titleText ["A L i V E   |   T h e  G r i n d", "BLACK IN",10];
		
	sleep 25;
			
	_cam CameraEffect ["Terminate","Back"];
	CamDestroy _cam;
};