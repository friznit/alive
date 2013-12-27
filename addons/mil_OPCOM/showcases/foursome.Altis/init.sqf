#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif

0 fadesound 0;

titleText ["The ALiVE Team presents...", "BLACK IN",9999];

sleep 2;

titleText ["A L i V E   |   F o u r s o m e", "BLACK IN",9999];

sleep 5;

titleText ["
Following a surprise invasion of Altis by CSAT forces in recent weeks, a BLUFOR Task Force has arrived in theatre with the intention of 
linking up with local militia and removing the hostile threat. CIVPOP has been removed to Agia Marina where they are being held under martial law.
", "BLACK IN",9999];

sleep 5;

titleText ["
REDFOR troops have occupied key strategic points across the Area of Operations.  Strength and dispositions include at least 1 Combined 
Arms Motor Rifle Battalion, 1 Light Infantry Battalion and support units including possible attack helicopters, artillery and special forces. 
A mobile reserve in the South of the Island is poised to react any hostile threat.
", "BLACK IN",9999];

sleep 5;

titleText ["
BLUFOR troops are approaching from the North East to link up with the struggling guerilla factions and to assist Greek forces regaining control over the 
island.  BLUFOR have a formidable array of equipment and support assets at a Forward Operating Base near the Salt Flats, however numbers are limited, 
defences are weak and resupply is difficult.
", "BLACK IN",9999];

sleep 5;

titleText ["
GREENFOR have retreated to a few small strongholds in the mountainous North of the island. Only a few guerillas survived the brutal Iranian assault 
but they are well placed to harass REDFOR rear echelons and supply lines.
", "BLACK IN",9999];

titleText ["
Orders are to advance to contact South West clearing all enemy within boundaries in order to regain control of the island.  Attempt to establish comms with militia factions in the East for coordinated assaults.
", "BLACK IN",9999];

sleep 5;

titleText ["A L i V E   |   F o u r s o m e", "BLACK IN",5];
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
		
sleep 20;
		
_cam CameraEffect ["Terminate","Back"];
CamDestroy _cam;
   
/* 
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
*/