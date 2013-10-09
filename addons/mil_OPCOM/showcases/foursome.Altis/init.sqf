startLoadingScreen ["Loading..."];;
titleText ["ALiVE initialising...", "BLACK IN",9999];
0 fadesound 0;

sleep 140;
endloadingscreen;
titleText ["ALiVE | Foursome", "BLACK IN",3];

	playmusic "Track09_Night_percussions";
	60 fadesound 0.5;
	2 fademusic 1;

[] spawn {	
	// set fog level 
	0 setfog [0.1,0.001,100];
	sleep 30;

	3600 setfog [0.01,0.04,50];
};

sleep 30;

_time = time;
_cam = nil;
_objects = [];

while {(time - _time) < 180} do {
	if (count allunits > 10) then {
	
		_Object = leader group (allunits select (4 + floor(random(count allunits - 4))));

		if (((count waypoints _object) > 1) && {!(_object in _objects)} && {_object distance player < 1000}) then {
			_objects set [count _objects,_object];
			
			_cam = "camera" CamCreate getposATL player;
        		_cam CamSetTarget player;
        		_cam CameraEffect ["Internal","Back"];
			_cam CamCommit 0;

			_cam attachto [vehicle player,[20,20,15]];

			sleep 1;
            
			_camx = getposATL _Object select 0;
			_camy = getposATL _Object select 1;
			_camz = getposATL _Object select 2;

			_cam CamSetTarget _object;
			_cam CamCommit 2;
		
			sleep 5;

			detach _cam;
			//Create a camera and place it 15 meters from the object 3 meter above the ground
			_cam camsetpos [_camx -15 ,_camy + 15,_camz+3];
		
			//Point the camera to the passed object
			_cam CamSetTarget _object;
		
			//Set an effect for the camera
			_cam CameraEffect ["Internal","Back"];
		
			//Apply the changes!
			_cam CamCommit 0;
			sleep 5;
			
			_cam CameraEffect ["Terminate","Back"];
			CamDestroy _cam;
		};
	};
};
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
		
			if (time-_lastexport > 300) then {
				{diag_log format["Total count: %4 | %1 | %2 | %3", _x,getposATL _x,typeof _x,_cnt]} foreach (allmissionobjects "");
				_lastexport = time;
			};
	
			diag_log _cnt;
			//player sidechat format["Count allmissionobjects %1",_cnt];
			(ABORTCHECK);
		};
	};
} else {};