#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif

0 fadesound 0;

titleText ["The ALiVE Mod Team presents...", "BLACK IN",9999];

sleep 5;

titleText ["A L i V E   |   G e t t i n g  S t a r t e d", "BLACK IN",9999];

sleep 10;

titleText ["A L i V E   |   G e t t i n g  S t a r t e d", "BLACK IN",15];

15 fadesound 1;

_object = player;
_camx = getposATL _Object select 0;
_camy = getposATL _Object select 1;
_camz = getposATL _Object select 2;

_cam = "camera" CamCreate [_camx -100 ,_camy + 100,50];

_cam CamSetTarget _object;
_cam CameraEffect ["Internal","Back"];
_cam CamCommit 0;

_cam camsetpos [_camx -15 ,_camy + 15,3];
_cam CamCommit 10;

// disable AI slots
disabledAI = 1;

sleep 7;

_cam CameraEffect ["Terminate","Back"];
CamDestroy _cam;
