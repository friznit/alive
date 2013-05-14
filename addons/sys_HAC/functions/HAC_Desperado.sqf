_HQ = _this select 0;
_logic = _this select ((count _this)-1);

_reck = _logic getvariable "HAC_HQ_Recklessness";
_rInit = _reck;

while {not (isNull _HQ)} do
	{
	_reck = _logic getvariable "HAC_HQ_Recklessness";
	_ally = _logic getvariable "HAC_HQ_Friends";
	_enemy = _logic getvariable "HAC_HQ_KnEnemiesG";

	_leader = leader _HQ;
	_distAllyS = 0;

		{
		_dist = (vehicle (leader _x)) distance _leader;
		_distAllyS = _distAllyS + _dist;
		}
	foreach _ally;

	_cAlly = count _ally;
	_midD = 20000;
	if not (_cAlly == 0) then {_midD = _distAllyS/_cAlly};


	_distEnemyS = 0;
	_nearE = false;

		{
		_distE = (vehicle (leader _x)) distance _leader;
		_distEnemyS = _distEnemyS + _distE;
		if (_distE < 600) then {_nearE = true};
		}
	foreach _enemy;

	_cEnemy = count _enemy;
	_midDE = 20000;
	if not (_cEnemy == 0) then {_midDE = _distEnemyS/_cEnemy};

	if (((_midD > _midDE) and (_midDE < 2000)) or (_nearE)) then 
		{
			_logic setvariable ["HAC_HQ_Recklessness",(_rInit + 0.2) * 10];
		}
	else
		{
			_logic setvariable ["HAC_HQ_Recklessness",_rInit];
		};
	
	sleep 60;
	};
