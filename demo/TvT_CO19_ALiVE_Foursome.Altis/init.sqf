#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif

titleText ["ALiVE | Foursome", "BLACK IN",3];

_object = player;
_camx = getposATL _Object select 0;
_camy = getposATL _Object select 1;
_camz = getposATL _Object select 2;

_cam = "camera" CamCreate [_camx -500 ,_camy + 500,_camz+100];

_cam CamSetTarget _object;
_cam CameraEffect ["Internal","Back"];
_cam CamCommit 0;

_cam camsetpos [_camx -15 ,_camy + 15,_camz+3];
_cam CamCommit 20;
		
sleep 20;
		
_cam CameraEffect ["Terminate","Back"];
CamDestroy _cam;
    
if (isServer) then {

	//Allmissionobjects analyzer
	ABORTCHECK = false;
	[] spawn {
		_lastexport = time;
		waituntil {
			private ["_cnt"];

			sleep 60;
			_cnt = count (allmissionobjects "");
		
			if (time-_lastexport > 1800) then {
			{diag_log format["Total count: %4 | %1 | %2 | %3", _x,getposATL _x,typeof _x,_cnt]} foreach (allmissionobjects "");
			_lastexport = time;
		};

		diag_log format["Count allmissionobjects %1",_cnt];
		player sidechat format["Count allmissionobjects %1",_cnt];
		(ABORTCHECK);
	};
	};
};