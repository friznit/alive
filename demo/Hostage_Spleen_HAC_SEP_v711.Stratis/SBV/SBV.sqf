/*
http://forums.bistudio.com/showthread.php?154021-Statistical-Based-Visualizations-Script&p=2384053#post2384053

This script will...
-Provide a semi-cinematic experience
-Enhance upon the fatigue system (player collapses if too exhausted, and even dies)
-Allow you to feel the weight of every step you take
-Tweak the health system with health regeneration and bleedouts
-Integrate new camera effects such as camera shake, color correction, and motion blur
-Blinking
-Screen blacks out when killed
-Uphill climbs will cause more stress on the body
-Feel the roughness of the terrain as you drive, but also feel a smoother drive on roads
-Pilots will appreciate the sense of speed they are flying at and the slight camera sway
-Hit reaction (screen will flicker bright for a split second when taken substantial damage)
-Camshake when firing from vehicles
-If you are too close to another persons gun as it fires, it will temporarily deafen you
-When flying fast and close to the ground, the camera will shake a bit more
-Heartbeats while exhausted
-Blood splatter sounds when shot
-Time slows down when shot
-Enemy AI Melee
-Gunshot reverberation
And a few more gems added into this that you can see in the script.

Made by Zooloo75/Stealthstick

-Recommended to use SweetFX along with this
*/

//Options
/*
Example:
[1,0,1] execVM "Modules\@SUPPORT\Mods\SBV_System\SBV.sqf"; - Terrain Reverb enabled, blinking disabled, AI melee enabled
*/

if(!isNil "_this select 0") then
{
reverbToggle = _this select 0;
};
if(isNil "reverbToggle") then {reverbToggle = 0};

if(!isNil "_this select 1") then
{
blinkingToggle = _this select 1;
};
if(isNil "blinkingToggle") then {blinkingToggle = 0};

if(!isNil "_this select 2") then
{
meleeToggle = _this select 2;
};
if(isNil "meleeToggle") then {meleeToggle = 1};




//Notification of initialization
[] spawn
{
waitUntil {SBVInitialized == 1;};
player globalChat 
hint "Statistical-Based Visualizations Initialized...";
playSound "hints";
sleep 4;
// hint format ["Statistical-Based Visualizations\nTerrain Reverb:%1\nBlinking:%2\nAI Melee:%3",reverbToggle,blinkingToggle,meleeToggle];
// playSound "hintsopen";
};



if(reverbToggle == 1) then 
{
	//Reverberation effects
	maxRevDist = 30;
	speedOfSound = 340.29;
	maxBuildingSearch = 4;
	maxReverbObjects = 6;
	reverberation =
	"
	_projectiles = [];
	_array = _this;
	_unit = _array select 0;
	_weapon = currentWeapon _unit;
	_filter = getText (configFile >> 'CfgMagazines' >> (_array select 5) >> 'nameSound');
	if(_filter == 'handgrenade' || _filter == 'grenadelauncher' || _filter == 'smokeshell') exitWith {};
	_sound = ((getArray (configFile >> 'CfgWeapons' >> _weapon >> 'Single' >> 'begin1')) select 0);
	if(isNil '_sound') then 
	{
	_sound = ((getArray (configFile >> 'CfgWeapons' >> _weapon >> 'close' >> 'begin1')) select 0);
	};
	_filterGun = str(inheritsFrom (configFile >> 'CfgWeapons' >> (currentweapon _unit)));
	if(_filterGun != 'config.bin/CfgWeapons/Pistol_Base_F') then
	{
	for '_i' from 0 to maxReverbObjects-1 do
	{
	_projectile = 'RoadCone_F' createVehicle [0,0,500];
	_projectile hideObject true;
	_projectile setPos [getPosATL _unit select 0,getPosATL _unit select 1, 2.5];
	_projectiles = _projectiles + [_projectile];
	};
	_numProjectile = 0;
	_dirShift = 0;
	{
		_numProjectile = _projectiles find _x;
		if(_numProjectile != 0) then
		{
			_dirShift = _dirShift + ((360/maxReverbObjects)/_numProjectile);
		};
			[_x,_sound,_unit,_projectiles,_dirShift] spawn 
			{
				_projectile = _this select 0;
				_unit = _this select 2;
				_projectiles = _this select 3;
				_dirShift = _this select 4;
				_projectile setVelocity [(speedOfSound*(sin(_dirShift))),(speedOfSound*(cos(_dirShift))),0];
				[_projectile,_unit] spawn {_projectile = _this select 0; _unit = _this select 1; sleep 2; if(_projectile distance _unit < 100) exitWith {deleteVehicle _projectile;};};
				waitUntil {speed _projectile > 10};
				waitUntil {speed _projectile < 10};
				_projectile setVelocity [0,0,0];
				_projectile setPos [position _projectile select 0, position _projectile select 1, 2.5];
				if(_projectile distance _unit > 100) then
				{
					_projectile say3D 'reverbTerrain';
				};
				sleep 5;
				deleteVehicle _projectile;
			};
		_numProjectile = _numProjectile + 1;
	} forEach _projectiles;
	};
	";

	fnreverbToggleeration = compile reverberation;

	_allVehicles = nearestObjects [player,["AllVehicles"],100000];
	{if(_x isKindOf "Man") then {_allVehicles = _allVehicles - [_x];};} forEach _allVehicles;
	{_x addEventHandler ['fired','_this spawn fnreverbToggleeration'];} forEach allUnits + _allVehicles;
};





//Handles falling down when exhausted
fatigueAnim =
"
if(playerFatigued == 1) exitWith {};
playerFatigued = 1;
player groupChat 'You are exhausted';
player switchMove 'AmovPercMsprSnonWnonDf_AmovPpneMstpSnonWnonDnon';
[] spawn 
{
waitUntil {getFatigue player < 0.7};
playerFatigued = 0;
};

[] spawn 
{
while {playerFatigued == 1} do {playMusic 'heartBeat'; sleep 3;};
};
";

fn_FatigueAnim = compile fatigueAnim;


//Handles deafening from gunfire
deafTonePlaying = 0;
deafening =
"
if(!alive player) exitWith {};
_dist = _this select 0;
if((_dist) <= 2 && _dist != 0) then 
{
addCamShake [(abs(3-((_dist/3)*(-3))))/3, 0.8, 20+random 5];
	[] spawn 
	{
		if(deafTonePlaying == 0) then
		{
			deafTonePlaying = 1;
			playMusic 'deafTone';
			0.1 fadeSound 0;
			0.1 fadespeech 0;
			0.1 fadeRadio 0;
			sleep 4; 
			5 fadeSound 1;
			8 fadespeech 1;
			8 fadeRadio 1;
			sleep 5;
			deafTonePlaying = 0;
		};
		
	};
};


";

fn_Deafening = compile deafening;



//Handles deafening from gunfire & slowing down of time
bloodSplatter =
"
if(!((_this select 0) isKindOf 'Man')) exitWith {};
_bloodSFX = ['blood1','blood2','blood3','blood4','blood5'];
_chooseSFX = _bloodSFX select (round(random((count(_bloodSFX))-1)));
if(isNil '_chooseSFX') then {_chooseSFX = 5;};
playMusic _chooseSFX;
	[] spawn 
	{
		if(slowDownRunning == 1) exitWith {};
		slowDownRunning = 1;
		setAccTime (0.05+(1-(damage player))/4);
		sleep 0.1 + random 0.5;
			[] spawn 
			{
					while {true} do 
					{
					if(accTime >= 1) exitWith {setAccTime 1; [] spawn {sleep 3; slowDownRunning = 0;};};
					setAccTime (0.1 + ((accTime) + ((accTime/3))));
					 sleep 0.05;
					};
			};
	};
";

fn_bloodSplatter = compile bloodSplatter;


// Color Corrections
"colorCorrections" ppEffectAdjust[1, 1, -0.02, [4.5, 3.5, 1.6, -0.02],[1.8, 1.6, 1.6, 1],[-1.5,0,-0.2,1]] ;    "colorCorrections" ppEffectCommit 0;  "colorCorrections" ppEffectEnable true;
defaultCC = [1, 1, -0.02, [4.5, 3.5, 1.6, -0.02],[1.8, 1.6, 1.6, 1],[-1.5,0,-0.2,1]];

setCamShakeParams [0.003, 0.1, 0.5, 0.6, true]; 


playerIsShooting = 0;
heatExhaustion = 0;
playerKnifed = 0;


// Deafening from gunfire
player addEventHandler ["firedNear","[ _this select 2] spawn fn_Deafening"];


// Shooting effects
player addEventHandler ["fired","[] spawn {playerIsShooting = 1; addCamShake [0.5+(getFatigue player)*5, 0.5, 10+random 10]; player setUnitRecoilCoefficient ((0.3 + (getFatigue player)*3) + ((damage player)*4)); sleep 0.5; playerIsShooting = 0;};"];


// Damage Indication
player addEventHandler ["hit","[_this select 1] spawn fn_bloodSplatter; 'colorCorrections' ppEffectAdjust[1, 1.8, -0.2, [4.5 - ((damage player)*5), 3.5, 1.6, -0.02],[1.8 - ((damage player)*5), 1.6, 1.6, 1],[-1.5 + ((damage player)*5),0,-0.2,1]] ; 'colorCorrections' ppEffectCommit 0.05; addCamShake [1 + random 2, 0.4 + random 1, 15];"];


// Death
player addEventHandler ["killed","setAccTime 1; titleText ['', 'BLACK OUT', 0.05]; 0 fadeSound 0; 0 fadeMusic 0; [] spawn {sleep 3; 'dynamicBlur' ppEffectAdjust[0];'dynamicBlur' ppEffectCommit 2;};"];

// Respawn
player addEventHandler ["respawn","[0,0,1] execVM 'SBV\SBV.sqf'; 1 fadeSound 1; 1 fadeMusic 1;"];


if(blinkingToggle == 1) then
{
	// Blinking
	[] spawn 
	{
		while {alive player} do 
		{
			if(cameraView == "INTERNAL") then 
			{ 
			sleep (3 + random 7); if(cameraView == "INTERNAL") then 
			{
				if(alive player) then 
				{
				titleText ["", "BLACK OUT", 0.05];
				sleep ((0.05 + random 0.05) + (getFatigue player) + (damage player))/4;
				titleText ["", "BLACK IN", 0.01];
				};
			};
			};
		};
	};
};

// The Loop
while {alive player} do
{

	
		// Var handling
		_fatigue = getFatigue player;
		_oxygen = getOxygenRemaining player;
		heightOld = getPosATL player select 2;
		
		
		if(meleeToggle == 1) then
		{
			// Enemy AI melee
			if(playerKnifed == 0 && (side player != CIVILIAN)) then
			{
				[] spawn 
				{
					if(vehicle player != player) exitWith {};
					kniferAI = objNull;
					_ais = nearestObjects [player,["CAManBase"],3];
					_ais = _ais - [player];
					if(count _ais == 0) exitWith {};
					{
						if((side _x == side player) || (side _x == civilian) || (!alive _x)) then {_ais = _ais - [_x];};
					} forEach _ais;
					kniferAI = _ais select 0;
					
					
						_eyeDV = eyeDirection kniferAI;
						_eyeD = ((_eyeDV select 0) atan2 (_eyeDV select 1));
						if (_eyeD < 0) then {_eyeD = 360 + _eyeD};
						_dirTo = [player, kniferAI] call BIS_fnc_dirTo;
						_eyePb = eyePos kniferAI;
						_eyePa = eyePos player;
						if ((abs(_dirTo - _eyeD) >= 90 && (abs(_dirTo - _eyeD) <= 270))) then 
						{
						[] spawn
							{
							if(playerKnifed == 1) exitWith {};
							playerKnifed = 1;
							kniferAI setDir ([kniferAI, player] call BIS_fnc_dirTo);
							kniferAI switchMove "AwopPercMstpSgthWnonDnon_end";
							kniferAI say3D "knife";
							addCamShake [15, 1, 18];
							sleep 0.3;
							kniferAI switchMove "normal";
							playMusic "blood5";
							player setDamage 1;
							};
						};
					
				};
			};
		};
		
		
		// Cam Shake when firing in vehicles
		if(vehicle player != player) then
		{
			_veh = vehicle player;
			_checkEH = _veh getVariable "hasFiredEH";
			if(isNil "_checkEH") then {_veh setVariable ["hasFiredEH",1,false]; _veh addEventHandler ["fired","[] spawn {playerIsShooting = 1; sleep 1; playerIsShooting = 0;}; if(player in (_this select 0)) then {addCamShake [0.5+random 1, 1, 10+random 5]};"]};
		};
		
		
		
		// Fatigues player when going up steep terrain
		if(vehicle player == player) then {
			[] spawn {
			sleep 0.2;
				heightNew = getPosATL player select 2;
				heightDif = (heightNew - heightOld);
				if(heightDif > 0) then {
					player setFatigue ((getFatigue player) + _heightDif);
				};
			};
		};
		
		
		// Cam Shake
		if(playerIsShooting == 0) then 
		{
			if(vehicle player == player) then {addCamShake [abs(0.2 + (_fatigue*2) + speed player/10 + ((damage player)*2)), 0.4 + random 1, (abs(1+(speed player)/5) + ((damage player)*4) + (_fatigue*2))];}
			else
			{
				if(vehicle player isKindOf "air") then
				{
					if(((getPosATL (vehicle player)) select 2) < 40 && (speed (vehicle player)) > 30) then
					{
					addCamShake [abs(0.2 + (speed vehicle player)/150 + ((damage vehicle player)*2)), 1 + random 0.5, 1+(abs(40-((getPosATL (vehicle player)) select 2)))/6];
					}
					else
					{
					addCamShake [abs(0.2 + (speed vehicle player)/150 + ((damage vehicle player)*2)), 0.4 + random 1, 2];
					};
				}
					else
					{
						if(isOnRoad position (vehicle player)) then {addCamShake [abs(0.2 + (speed vehicle player)/100 + ((damage vehicle player)*2)), 0.4 + random 1, 5];}
						else
						{addCamShake [abs(0.2 + (speed vehicle player)/70 + ((damage vehicle player)*2)), 0.4 + random 1, 10];};
					};
			};
		};
		
		// Health Regeneration/Bleedout
		_hRegenRate = 1-_fatigue;
		if(_hRegenRate == 0) then {_hRegenRate = 1;};
		if(damage player <= 0.6) then {player setDamage ((damage player) - (_hRegenRate*(0.001)))};
		if(damage player > 0.6) then {player setDamage (damage player + random(0.0001) + (_fatigue/200));};
		
			// Blur Above Ground
			if(getPosASLW player select 2 > 0) then
			{		
			// Health/Fatigue ColorCorrection
			"colorCorrections" ppEffectAdjust[1, (1-(damage player)/4)+_fatigue/3, ((-0.02)-((damage player)/10)), [4.5 - ((damage player)*5) - _fatigue/2, 3.5, 1.6+_fatigue/3, -0.02],[1.8 - ((damage player)*5), 1.6, 1.6, 1],[-1.5 + ((damage player)*5),0,-0.2,1]] ;
			"colorCorrections" ppEffectCommit 0.1;
			
			// Motion Blur
			if(vehicle player == player) then
			{
			"RadialBlur" ppEffectEnable true; 
			"RadialBlur" ppEffectAdjust[abs(speed player)/10000,abs(speed player)/20000 + _fatigue,0.3,0.1];
			"RadialBlur" ppEffectCommit 0.1;
			// }
				// else
				// {
					// if(vehicle player isKindOf "air") then
					// {
					// "RadialBlur" ppEffectEnable true; 
					// "RadialBlur" ppEffectAdjust[abs(speed vehicle player)/45000,abs(speed vehicle player)/100000,0.3,0.1];
					// "RadialBlur" ppEffectCommit 0.1;
					// }
					// else
					// {
					// "RadialBlur" ppEffectEnable true; 
					// "RadialBlur" ppEffectAdjust[abs(speed vehicle player)/30000,abs(speed vehicle player)/40000,0.3,0.2];
					// "RadialBlur" ppEffectCommit 0.1;
					// };
				};
			
			//Health/Fatigue Blur
			"dynamicBlur" ppEffectEnable true; 
			"dynamicBlur" ppEffectAdjust[((damage player)/2) + _fatigue/3];
			"dynamicBlur" ppEffectCommit 0.1;
			
				//Exhausted Effect
				// if(_fatigue > 0.8) then 
				// {
				// if(_fatigue == 1) then 
				// {
					// if(heatExhaustion != 1) then
					// {
						// [_fatigue] spawn 
							// {
							// if(heatExhaustionRunning == 1) exitWith {};
							// heatExhaustionRunning = 1;
								// sleep 3;
								// if(_this select 0 == 1) then
								// {
								// heatExhaustion = 1;
								// player switchMove "AmovPercMsprSnonWnonDf_AmovPpneMstpSnonWnonDnon";
								// "dynamicBlur" ppEffectEnable true; 
								// "dynamicBlur" ppEffectAdjust[10];
								// "dynamicBlur" ppEffectCommit 1;
								// titleText ["", "BLACK OUT", 2];
								// player groupChat "You have died due to heat exhaustion";
								// sleep 3;
								// player setDamage 1;
								// }
								// else
								// {
								// heatExhaustionRunning = 0;
								// };
							// };
					// };
				// }
				// else 
				// {
				// [] spawn fn_FatigueAnim;
				// };
				// };
			} 
			//Underwater Blur
			else
			{
			"RadialBlur" ppEffectEnable true; 
			"RadialBlur" ppEffectAdjust[abs(speed player)/10000,abs(speed player)/20000 + _fatigue,0.3,0.1];
			"RadialBlur" ppEffectCommit 0.1;
			"dynamicBlur" ppEffectEnable true; 
			"dynamicBlur" ppEffectAdjust[(1-_oxygen)*3];
			"dynamicBlur" ppEffectCommit 0.1;
			};
		SBVInitialized = 1;
		sleep 0.2;
	};

