#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif

titleText ["The ALiVE Team presents...", "BLACK IN",999];

_object = player;
_camx = getposATL _Object select 0;
_camy = getposATL _Object select 1;
_camz = getposATL _Object select 2;

_cam = "camera" CamCreate [_camx -700 ,_camy + 700,_camz+100];

_cam CamSetTarget _object;
_cam CameraEffect ["Internal","Back"];
_cam CamCommit 0;

_cam camsetpos [_camx -15 ,_camy + 15,_camz+3];
_cam CamCommit 30;
sleep 5;

titleText ["A L i V E   |   F o u r s o m e", "BLACK IN",10];
	
sleep 25;
		
_cam CameraEffect ["Terminate","Back"];
CamDestroy _cam;