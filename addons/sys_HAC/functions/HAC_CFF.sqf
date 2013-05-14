	private ["_logic","_artG","_knEnemies","_enArmor","_friends","_Debug","_CFFMissions","_tgt","_ammo","_bArr","_possible","_UL","_ldr"];

	_artG = _this select 0;
	_knEnemies = _this select 1;
	_enArmor = _this select 2;
	_friends = _this select 3;
	_Debug = _this select 4;
	_ldr = _this select 5;
    _logic = _this select ((count _this)-1);

	_CFFMissions = ceil (random (count _artG));

	for "_i" from 1 to _CFFMissions do
		{
		_tgt = [_knEnemies,_logic] call ALiVE_fnc_HAC_CFF_TGT;
		if not (isNull _tgt) then
			{
			_ammo = "HE";
			if ((random 100) > 75) then {_ammo = "WP"};
			if (_tgt in _enArmor) then {_ammo = "SADARM"};	

			_bArr = [(getPosATL _tgt),_artG,_ammo,6,objNull,_logic] call ALiVE_fnc_HAC_ArtyMission;
			_possible = _bArr select 0;

			_UL = leader (_friends select (floor (random (count _friends))));

			if not (isPlayer _UL) then {if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_UL,(_logic getvariable "HAC_xHQ_AIC_ArtyReq"),"ArtyReq",_logic] call ALiVE_fnc_HAC_AIChatter}};

			if (_possible) then
				{
				if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_ldr,(_logic getvariable "HAC_xHQ_AIC_ArtAss"),"ArtAss",_logic] call ALiVE_fnc_HAC_AIChatter};
				[_bArr select 1,_tgt,_bArr select 2,_ammo,_friends,_Debug,_logic] spawn ALiVE_fnc_HAC_CFF_FFE
				}
			else
				{
				switch (true) do
					{
					case (_ammo in ["SADARM","WP"]) : {_ammo = "HE"};
					case (_ammo in ["HE"]) : {_ammo = "WP"};
					};

				_bArr = [(getPosATL _tgt),_artG,_ammo,6,objNull,_logic] call ALiVE_fnc_HAC_ArtyMission;

				_possible = _bArr select 0;
				if (_possible) then
					{
					if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_ldr,(_logic getvariable "HAC_xHQ_AIC_ArtAss"),"ArtAss",_logic] call ALiVE_fnc_HAC_AIChatter};
					[_bArr select 1,_tgt,_bArr select 2,_ammo,_friends,_Debug,_logic] spawn ALiVE_fnc_HAC_CFF_FFE
					}
				else
					{
					if ((random 100) < (_logic getvariable "HAC_xHQ_AIChatDensity")) then {[_ldr,(_logic getvariable "HAC_xHQ_AIC_ArtDen"),"ArtDen",_logic] call ALiVE_fnc_HAC_AIChatter}
					}
				}
			};

		sleep (5 + (random 5));
		};