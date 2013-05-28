_logic = _this select ((count _this)-1);
_logic setvariable ["HAC_HQ_FlankingInit", true];
sleep 10;
waituntil {sleep 5;((_logic getvariable "HAC_HQ_FlankReady") and ((count (_logic getvariable "HAC_HQ_KnEnemies")) > 0) and not ((_logic getvariable "HAC_HQ_DefDone")))};
_default = [];
_Epos0 = [];
_Epos1 = [];

if (isNil {_logic getvariable "HAC_HQ_Obj"}) then {_default = position _logic} else {_default = position (_logic getvariable "HAC_HQ_Obj")};

sleep (60 * (1 + (_logic distance _default)/1000));

if not ((count (_logic getvariable "HAC_HQ_KnEnemies")) == 0) then 
	{
		{
		_Epos0 = _Epos0 + [((getposATL _x) select 0)];
		_Epos1 = _Epos1 + [((getposATL _x) select 1)]
		}
	foreach (_logic getvariable "HAC_HQ_KnEnemies")
	};

_Epos0Max = _default select 0;
_Epos0Min = _default select 0;
_sel0Max = 0;
_sel0Min = 0;

for [{_a = 0},{_a < (count _Epos0)},{_a = _a + 1}] do 
	{
	_EposA = _Epos0 select _a;
	if (_a == 0) then {_Epos0Min = _EposA;_sel0Min = _a};
	if (_a == 0) then {_Epos0Max = _EposA;_sel0Max = _a};
	if (_Epos0Min >= _EposA) then {_Epos0Min = _EposA;_sel0Min = _a};
	if (_Epos0Max < _EposA) then {_Epos0Max = _EposA;_sel0Max = _a};
	};

_Epos1Max = _default select 1;
_Epos1Min = _default select 1;
_sel1Max = 1;
_sel1Min = 1;

for [{_b = 0},{_b < (count _Epos1)},{_b = _b + 1}] do 
	{
	_EposB = _Epos1 select _b;
	if (_b == 0) then {_Epos1Min = _EposB;_sel1Min = _b};
	if (_b == 0) then {_Epos1Max = _EposB;_sel1Max = _b};
	if (_Epos1Min >= _EposB) then {_Epos1Min = _EposB;_sel1Min = _b};
	if (_Epos1Max < _EposB) then {_Epos1Max = _EposB;_sel1Max = _b};
	};

_max0Enemy = _logic;
_min0Enemy = _logic;

_max1Enemy = _logic;
_min1Enemy = _logic;

if not (isNil {_logic getvariable "HAC_HQ_Obj"}) then 
	{
	_max0Enemy = (_logic getvariable "HAC_HQ_Obj");
	_min0Enemy = (_logic getvariable "HAC_HQ_Obj");

	_max1Enemy = (_logic getvariable "HAC_HQ_Obj");
	_min1Enemy = (_logic getvariable "HAC_HQ_Obj")
	};

if not ((count (_logic getvariable "HAC_HQ_KnEnemies")) == 0) then 
	{
	_max0Enemy = (_logic getvariable "HAC_HQ_KnEnemies") select _sel0Max;
	_min0Enemy = (_logic getvariable "HAC_HQ_KnEnemies") select _sel0Min;

	_max1Enemy = (_logic getvariable "HAC_HQ_KnEnemies") select _sel1Max;
	_min1Enemy = (_logic getvariable "HAC_HQ_KnEnemies") select _sel1Min
	};

_PosMid0 = (_Epos0Min + _Epos0Max)/2;
_PosMid1 = (_Epos1Min + _Epos1Max)/2;

_dX = (_PosMid0) - ((getposATL _logic) select 0);
_dY = (_Posmid1) - ((getposATL _logic) select 1);

_angle0 = _dX atan2 _dY;

if (_angle0 < 0) then {_angle0 = _angle0 + 360}; 

_BEnemyPosA = [];
_BEnemyPosB = [];
_BEnemyPos = [];

if ((_angle0 <= 45) or ((_angle0 > 135) and (_angle0 <= 225)) or (_angle0 > 315)) then {_BEnemyPosA = position _min0Enemy;_BEnemyPosB = position _max0Enemy} else {_BEnemyPosA = position _min1Enemy;_BEnemyPosB = position _max1Enemy};

_rnd1 = random 100;

_minF = false;
_maxF = false;
_bothF = false;
_HAC_HQ_Fineness = (_logic getvariable ["HAC_HQ_Fineness",1]);

switch (true) do
	{
	case ((_rnd1 >= (10/(0.5 + _HAC_HQ_Fineness))) and  (_rnd1 < (55/(0.5 + _HAC_HQ_Fineness))) and (_rnd2 < 50)) : {_minF =  true};
	case ((_rnd1 >= (10/(0.5 + _HAC_HQ_Fineness))) and  (_rnd1 < (55/(0.5 + _HAC_HQ_Fineness))) and (_rnd2 >= 50)) : {_maxF = true};
	case (_rnd1 >= (55/(0.5 + _HAC_HQ_Fineness))) : {_bothF = true};
	};

switch true do
	{
	case (_minF or _maxF) : 
		{
			{
			if (_minF) then {[_x,_BEnemyPosA,_PosMid0,_PosMid1,_angle0,true,_logic] spawn A_GoFlank } else {[_x,_BEnemyPosB,_PosMid0,_PosMid1,_angle0,false,_logic] spawn A_GoFlank };
			}
		foreach (_logic getvariable "HAC_HQ_FlankAv");
		
		};
	case (_bothF) : 
		{

		for [{_b = 0},{_b < (count (_logic getvariable "HAC_HQ_FlankAv"))},{_b = _b + 1}] do
			{
			_FlankU = (_logic getvariable "HAC_HQ_FlankAv") select _b;
			if ((_b/2 - floor (_b/2)) == 0) then 
				{
				[_FlankU,_BEnemyPosA,_PosMid0,_PosMid1,_angle0,true,_logic] spawn A_GoFlank;
				} 
			else 
				{
				[_FlankU,_BEnemyPosB,_PosMid0,_PosMid1,_angle0,false,_logic] spawn A_GoFlank 
				}
			}		
		}
	};

_logic setvariable ["HAC_HQ_FlankingDone",true];
_logic setvariable ["HAC_HQ_FlankAv",[]];
