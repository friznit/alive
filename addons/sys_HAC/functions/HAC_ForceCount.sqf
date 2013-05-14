	private ["_logic","_friends","_inf","_car","_arm","_air","_nc","_current","_initial","_value","_morale","_enemies","_einf","_ecar","_earm","_eair","_enc","_frArr","_enArr",
	"_eInfG","_eCarG","_eArmG","_eAirG","_eNCG","_eAllP","_eInfP","_eCarP","_eArmP","_eAirP","_eNCP","_allP","_infP","_carP","_armP","_airP","_ncP","_enG","_evalue",
	"_frRep","_enRep","_gpHQ"];

	_friends = _this select 0;
	_inf = _this select 1;
	_car = _this select 2;
	_arm = _this select 3;
	_air = _this select 4;
	_nc = _this select 5;

	_current = _this select 6;
	_initial = _this select 7;
	_value = _this select 8;
	_morale = _this select 9;

	_enemies = _this select 10;
	_einf = _this select 11;
	_ecar = _this select 12;
	_earm = _this select 13;
	_eair = _this select 14;
	_enc = _this select 15;
	_evalue = _this select 16;

	_frArr = _this select 17;
	_enArr = _this select 18;

	_enG = _this select 19;
	_gpHQ = _this select 20;

	_eInfG = [];
	_eCarG = [];
	_eArmG = [];
	_eAirG = [];
	_eNCG = [];	

	_eInfP = 0;
	_eCarP = 0;
	_eArmP = 0;
	_eAirP = 0;
	_eNCP = 0;

	_infP = 0;
	_carP = 0;
	_armP = 0;
	_airP = 0;
	_ncP = 0;

	if ((count _enemies) > 0) then 
		{
			{
			if (not (_x in _enG) and (_x in _einf)) then {_eInfG set [(count _eInfG),_x]};
			if (not (_x in _enG) and (_x in _ecar)) then {_eCarG set [(count _eCarG),_x]};
			if (not (_x in _enG) and (_x in _earm)) then {_eArmG set [(count _eArmG),_x]};
			if (not (_x in _enG) and (_x in _eair)) then {_eAirG set [(count _eAirG),_x]};
			if (not (_x in _enG) and (_x in _enc)) then {_eNCG set [(count _eNCG),_x]};	
			}
		foreach _enemies;

		_eAllP = {not (_x in _enG)} count _enemies;

		if (_eAllP > 0) then
			{
			_eInfP = (count _eInf)/_eAllP;
			_eCarP = (count _eCar)/_eAllP;
			_eArmP = (count _eArm)/_eAllP;
			_eAirP = (count _eAir)/_eAllP;
			_eNCP = (count _eNC)/_eAllP
			}
		};
		
	_allP = count _friends;

	if (_allP > 0) then
		{	
		_infP = (count _inf)/_allP;
		_carP = (count _car)/_allP;
		_armP = (count _arm)/_allP;
		_airP = (count _air)/_allP;
		_ncP = (count _nc)/_allP
		};

	_frRep = [_allP,_current,_current - _initial,_value,_morale,[_infP,_carP,_armP,_airP,_ncP]];//liczba grup-liczba jednostek-straty-wartosc-morale-rozklad
	_enRep = [count _enemies,_evalue,[_eInfP,_eCarP,_eArmP,_eAirP,_eNCP]];//liczba grup-wartosc-rozklad

	_gpHQ setVariable ["ForceRep",[_frRep,_enRep]];

	_frArr set [(count _frArr),_frRep];
	_enArr set [(count _enArr),_enRep];

	[_frArr,_enArr];