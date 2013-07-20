private ["_logic","_distances","_Trg","_landE"];
_logic = _this select 0;
_logic setvariable ["HAC_HQ_DefDone", false];

_distances = [];

_Trg = _logic;

_logic setvariable ["HAC_HQ_NearestE", ObjNull];
if (isNil {_logic getvariable "HAC_HQ_Orderfirst"}) then {_logic setvariable ["HAC_HQ_Orderfirst", true];_logic setvariable ["HAC_HQ_FlankReady", false]};

if ((_logic getvariable "HAC_HQ_NObj") == 1) then {_logic setvariable ["HAC_HQ_Obj", (_logic getvariable "HAC_HQ_Obj1")]};
if ((_logic getvariable "HAC_HQ_NObj") == 2) then {_logic setvariable ["HAC_HQ_Obj", (_logic getvariable "HAC_HQ_Obj2")]};
if ((_logic getvariable "HAC_HQ_NObj") == 3) then {_logic setvariable ["HAC_HQ_Obj", (_logic getvariable "HAC_HQ_Obj3")]};
if ((_logic getvariable "HAC_HQ_NObj") >= 4) then {_logic setvariable ["HAC_HQ_Obj", (_logic getvariable "HAC_HQ_Obj4")]};

_Trg = (_logic getvariable "HAC_HQ_Obj");

_landE = (_logic getvariable "HAC_HQ_KnEnemiesG") - ((_logic getvariable "HAC_HQ_EnNavalG") + (_logic getvariable "HAC_HQ_EnAirG"));
if ((count _landE) > 0) then 
	{

	for [{_a = 0},{_a < (count _landE)},{_a = _a + 1}] do
		{
		_enemy = leader (_landE select _a);
		_distance = _logic distance _enemy;
		_distances = _distances + [_distance];
		};
	
    _logic setvariable ["HAC_HQ_NearestE", _landE select 0];

		{
		for [{_r = 0},{_r < (count _distances)},{_r = _r + 1}] do
			{
			_distance = _distances select _r;
			if (isNil ("_distance")) then {_distance = 10000};
			if (_distance <= _x) then {_logic setvariable ["HAC_HQ_NearestE", _landE select _r]};
			if (isNull (_logic getvariable "HAC_HQ_NearestE")) then {_logic setvariable ["HAC_HQ_NearestE", _landE select 0]}
			}
		}
	foreach _distances;

	_Trg = (leader (_logic getvariable "HAC_HQ_NearestE"));
	};
_PosObj1 = position _Trg;
if (isNil {_logic getvariable "HAC_HQ_ReconReserve"}) then {_logic setvariable ["HAC_HQ_ReconReserve", (0.3 * (0.5 + (_logic getvariable "HAC_HQ_Circumspection")))]};

_logic setvariable ["HAC_HQ_ReconAv", []];
_onlyL = (_logic getvariable "HAC_HQ_LArmorG") - (_logic getvariable "HAC_HQ_MArmorG");

{
	private ["_unitvar","_nominal","_current","_Gdamage","_busy","_vehready","_solready","_effective","_ammo","_veh"];
	_unitvar = str _x;
	if (_logic getvariable "HAC_HQ_Orderfirst") then {_x setVariable ["Nominal" + _unitvar,(count (units _x)),true]};
	_busy = false;
	_busy = _x getvariable ("Busy" + _unitvar);
	if (isNil ("_busy")) then {_busy = false};
	_vehready = true;
	_solready = true;
	_effective = true;
	_ammo = true;
	_Gdamage = 0;
	{
		_Gdamage = _Gdamage + (damage _x);
		 if ((count (magazines _x)) == 0) exitWith {_ammo = false};
		//_ammo = _ammo + (count (magazines _x));
		if (((damage _x) > 0.5) or not (canStand _x)) exitWith {_effective = false};
	}foreach (units _x);
	_nominal = _x getVariable ("Nominal" + (str _x));
	_current = count (units _x);
	_Gdamage = _Gdamage + (_nominal - _current);

	if (((_Gdamage/(_current + 0.1)) > (0.4*(((_logic getvariable "HAC_HQ_Recklessness")/1.2) + 1))) or not (_effective) or not (_ammo)) then 
		{
		_solready = false;
		if not (_ammo) then
			{
			_x setVariable ["LackAmmo",true]
			}
		};

	_ammo = 0;
	_veh = ObjNull;

	{
		_veh = assignedvehicle _x;
		if (not (isNull _veh) and (not (canMove _veh) or ((fuel _veh) <= 0.1) or ((damage _veh) > 0.5) or (((group _x) in ((_logic getvariable "HAC_HQ_AirG") - ((_logic getvariable "HAC_HQ_NCAirG") + (_logic getvariable "HAC_HQ_RAirG")) + ((_logic getvariable "HAC_HQ_HArmorG") + (_logic getvariable "HAC_HQ_LArmorG") + ((_logic getvariable "HAC_HQ_CarsG") - ((_logic getvariable "HAC_HQ_NCCargoG") + (_logic getvariable "HAC_HQ_SupportG")))))) and ((count (magazines _veh)) == 0)))) exitwith {_vehready = false};
	} foreach (units _x);

	if (not (_x in ((_logic getvariable "HAC_HQ_ReconAv") + (_logic getvariable "HAC_HQ_SpecForG"))) and not (_busy) and (_vehready) and ((_solready) or (_x in (_logic getvariable "HAC_HQ_RAirG")))) then {_logic setvariable ["HAC_HQ_ReconAv",(_logic getvariable "HAC_HQ_ReconAv") + [_x]]};
} foreach (((_logic getvariable "HAC_HQ_RAirG") + (_logic getvariable "HAC_HQ_ReconG") + (_logic getvariable "HAC_HQ_FOG") + (_logic getvariable "HAC_HQ_SnipersG") + (_logic getvariable "HAC_HQ_NCrewInfG") - ((_logic getvariable "HAC_HQ_SupportG") + (_logic getvariable "HAC_HQ_NCCargoG")) + _onlyL) - ((_logic getvariable "HAC_HQ_AOnly") + (_logic getvariable "HAC_HQ_CargoOnly")));

_HAC_HQ_ReconAv = [(_logic getvariable "HAC_HQ_ReconAv"),_logic] call ALiVE_fnc_HAC_RandomOrd;
    (_logic setvariable ["HAC_HQ_ReconAv",_HAC_HQ_ReconAv]);

if ((_logic getvariable "HAC_HQ_ReconReserve") > 0) then 
	{
	_forRRes = ((_logic getvariable "HAC_HQ_ReconAv") - (_logic getvariable "HAC_HQ_RAirG"));
	for [{_b = 0},{_b < (floor ((count _forRRes)*(_logic getvariable "HAC_HQ_ReconReserve")))},{_b = _b + 1}] do
		{
		_RRp = _forRRes select _b;
		_logic setvariable ["HAC_HQ_ReconAv",(_logic getvariable "HAC_HQ_ReconAv") - [_RRp]];
		}
	};

_logic setvariable ["HAC_HQ_AttackAv",[]];
_logic setvariable ["HAC_HQ_FlankAv", []];

if (isNil {_logic getvariable "HAC_HQ_Exhausted"}) then {_logic setvariable ["HAC_HQ_Exhausted", []]};
//if (isNil ("HAC_HQ_FlankAv")) then {HAC_HQ_FlankAv = []};

if (isNil {_logic getvariable "HAC_HQ_AttackReserve"}) then {_logic setvariable ["HAC_HQ_AttackReserve",(0.5 * (0.5 + ((_logic getvariable "HAC_HQ_Circumspection")/1.5)))]};

{
	private ["_unitvar","_nominal","_current","_Gdamage","_busy","_vehready","_solready","_effective","_ammo","_veh"];
	_unitvar = str _x;
	if (_logic getvariable "HAC_HQ_Orderfirst") then {_x setVariable [("Nominal" + _unitvar),(count (units _x)),true]};
	_busy = false;
	_busy = _x getvariable ("Busy" + _unitvar);
	if (isNil ("_busy")) then {_busy = false};
	_vehready = true;
	_solready = true;
	_effective = true;
	_ammo = true;
	_Gdamage = 0;
		{
		_Gdamage = _Gdamage + (damage _x);
		if ((count (magazines _x)) == 0) exitWith {_ammo = false};
		if (((damage _x) > 0.5) or not (canStand _x)) exitWith {_effective = false};
		}
	foreach (units _x);
	_nominal = _x getVariable ("Nominal" + (str _x));
	_current = count (units _x);
	_Gdamage = _Gdamage + (_nominal - _current);
	if (((_Gdamage/(_current + 0.1)) > (0.4*(((_logic getvariable "HAC_HQ_Recklessness")/1.2) + 1))) or not (_effective) or not (_ammo)) then {_solready = false};
	_ammo = 0;

		{
		_veh = assignedvehicle _x;
		if (not (isNull _veh) and (not (canMove _veh) or ((fuel _veh) <= 0.1) or ((damage _veh) > 0.5) or (((group _x) in (((_logic getvariable "HAC_HQ_AirG") - (_logic getvariable "HAC_HQ_NCAirG")) + ((_logic getvariable "HAC_HQ_HArmorG") + (_logic getvariable "HAC_HQ_LArmorG") + ((_logic getvariable "HAC_HQ_CarsG") - ((_logic getvariable "HAC_HQ_NCCargoG") + (_logic getvariable "HAC_HQ_SupportG")))))) and ((count (magazines _veh)) == 0)))) exitwith {_vehready = false};
		}
	foreach (units _x);
	
	if (not (_x in (_logic getvariable "HAC_HQ_AttackAv")) and not (_busy) and not (_x in (_logic getvariable "HAC_HQ_FlankAv")) and (_vehready) and (_solready) and not (_x in ((_logic getvariable "HAC_HQ_StaticG") + (_logic getvariable "HAC_HQ_ArtG") + (_logic getvariable "HAC_HQ_NavalG") + (_logic getvariable "HAC_HQ_SpecForG") + (_logic getvariable "HAC_HQ_CargoOnly")))) then {_logic setvariable ["HAC_HQ_AttackAv",(_logic getvariable "HAC_HQ_AttackAv") + [_x]]};
        if (not (_x in (_logic getvariable "HAC_HQ_Exhausted")) and (not (_vehready) or not (_solready))) then {_logic setvariable ["HAC_HQ_Exhausted",(_logic getvariable "HAC_HQ_Exhausted") + [_x]]};
 
	if (((_logic getvariable "HAC_HQ_Withdraw") > 0) and not (_x in ((_logic getvariable "HAC_HQ_SpecForG") + (_logic getvariable "HAC_HQ_SnipersG")))) then
		{
		_inD = _x getVariable "NearE";
		if (isNil "_inD") then {_inD = 0};
		if (not (_x in (_logic getvariable "HAC_HQ_Exhausted")) and ((random (2 + (_logic getvariable "HAC_HQ_Recklessness"))) < (_inD * (_logic getvariable "HAC_HQ_Withdraw")))) then {_logic setvariable ["HAC_HQ_Exhausted",(_logic getvariable "HAC_HQ_Exhausted") + [_x]]}; 
		};
} foreach (((_logic getvariable "HAC_HQ_Friends") - ((_logic getvariable "HAC_HQ_reconG") + (_logic getvariable "HAC_HQ_FOG") + ((_logic getvariable "HAC_HQ_NCCargoG") - (_logic getvariable "HAC_HQ_NCrewInfG")) + (_logic getvariable "HAC_HQ_SupportG"))) - (_logic getvariable "HAC_HQ_ROnly"));

_HAC_HQ_AttackAv = (_logic getvariable "HAC_HQ_AttackAv");
_HAC_HQ_AttackAvtemp = [_HAC_HQ_AttackAv,_logic] call ALiVE_fnc_HAC_RandomOrd;
_logic setvariable ["HAC_HQ_AttackAv",_HAC_HQ_AttackAvtemp];

if ((_logic getvariable "HAC_HQ_AttackReserve") > 0) then 
	{
	for [{_g = 0},{_g < floor ((count (_logic getvariable "HAC_HQ_AttackAv"))*(_logic getvariable "HAC_HQ_AttackReserve"))},{_g = _g + 1}] do
		{
		_ResC = (_logic getvariable "HAC_HQ_AttackAv") select _g;
		if not (_ResC in (_logic getvariable "HAC_HQ_FirstToFight")) then 
			{
			_logic setvariable ["HAC_HQ_AttackAv", (_logic getvariable "HAC_HQ_AttackAv") - [_ResC]];
			if not ((_logic getvariable "HAC_HQ_FlankingDone")) then {if ((random 100 > (30/(0.5 + (_logic getvariable "HAC_HQ_Fineness")))) and not (_ResC in (_logic getvariable "HAC_HQ_FlankAv"))) then {_logic setvariable ["HAC_HQ_FlankAv",(_logic getvariable "HAC_HQ_FlankAv") + [_ResC]]}}
			};
		}
	};

_logic setvariable ["HAC_HQ_FlankAv",(_logic getvariable "HAC_HQ_FlankAv") - (_logic getvariable "HAC_HQ_NoFlank")];

if (!(_logic getvariable "HAC_HQ_FlankingInit") and !((_logic getvariable "HAC_HQ_Order") == "DEFEND")) then {[_logic] spawn ALiVE_fnc_HAC_Flanking};

_stages = 3;
if ([_logic] call ALiVE_fnc_HAC_isNight) then {_stages = 5};

_rcheckArr = [(_logic getvariable "HAC_HQ_Garrison"),(_logic getvariable "HAC_HQ_ReconAv"),(_logic getvariable "HAC_HQ_FlankAv"),(_logic getvariable "HAC_HQ_AOnly"),(_logic getvariable "HAC_HQ_Exhausted"),(_logic getvariable "HAC_HQ_NCCargoG"),_Trg,(_logic getvariable "HAC_HQ_NCVeh")];

if (((_logic getvariable "HAC_HQ_NoRec") * ((_logic getvariable "HAC_HQ_Recklessness") + 0.01)) < (random 100)) then 
	{
	if ((count (_logic getvariable "HAC_HQ_KnEnemiesG")) == 0) then
		{
		if (not ((count (_logic getvariable "HAC_HQ_RAirG")) == 0) and ((count (_logic getvariable "HAC_HQ_ReconAv")) > 0) and not ((_logic getvariable "HAC_HQ_ReconDone")) and not ((_logic getvariable "HAC_HQ_ReconStage") > _stages)) then
			{
			_gps = [(_logic getvariable "HAC_HQ_RAirG"),"R",_rcheckArr,20000,true,_logic] call ALiVE_fnc_HAC_Recon;

				{
				if ((_logic getvariable "HAC_HQ_ReconStage") > _stages) exitWith {};
				_logic setvariable ["HAC_HQ_ReconStage",(_logic getvariable "HAC_HQ_ReconStage") + 1];_x setVariable ["Busy" + (str _x),true];
				[_x,_PosObj1,(_logic getvariable "HAC_HQ_ReconStage"),_logic] spawn ALiVE_fnc_HAC_GoRecon;
				}
			foreach _gps
			};

		if (not ((count (_logic getvariable "HAC_HQ_reconG")) == 0) and ((count (_logic getvariable "HAC_HQ_ReconAv")) > 0) and not ((_logic getvariable "HAC_HQ_ReconDone")) and not ((_logic getvariable "HAC_HQ_ReconStage") > _stages)) then
			{
			_gps = [(_logic getvariable "HAC_HQ_ReconG"),"R",_rcheckArr,5000,false,_logic] call ALiVE_fnc_HAC_Recon;

				{
				if ((_logic getvariable "HAC_HQ_ReconStage") > _stages) exitWith {};
				_logic setvariable ["HAC_HQ_ReconStage",(_logic getvariable "HAC_HQ_ReconStage") + 1];_x setVariable ["Busy" + (str _x),true];
				[_x,_PosObj1,(_logic getvariable "HAC_HQ_ReconStage"),_logic] spawn ALiVE_fnc_HAC_GoRecon;
				}
			foreach _gps
			};

		if (not ((count (_logic getvariable "HAC_HQ_FOG")) == 0) and ((count (_logic getvariable "HAC_HQ_ReconAv")) > 0) and not ((_logic getvariable "HAC_HQ_ReconDone")) and not ((_logic getvariable "HAC_HQ_ReconStage") > _stages)) then
			{
			_gps = [(_logic getvariable "HAC_HQ_FOG"),"R",_rcheckArr,5000,false,_logic] call ALiVE_fnc_HAC_Recon;

				{
				if ((_logic getvariable "HAC_HQ_ReconStage") > _stages) exitWith {};
				_logic setvariable ["HAC_HQ_ReconStage",(_logic getvariable "HAC_HQ_ReconStage") + 1];_x setVariable ["Busy" + (str _x),true];
				[_x,_PosObj1,(_logic getvariable "HAC_HQ_ReconStage"),_logic] spawn ALiVE_fnc_HAC_GoRecon;
				}
			foreach _gps
			};

		if (not ((count (_logic getvariable "HAC_HQ_snipersG")) == 0) and ((count (_logic getvariable "HAC_HQ_ReconAv")) > 0) and not ((_logic getvariable "HAC_HQ_ReconDone")) and not ((_logic getvariable "HAC_HQ_ReconStage") > _stages)) then
			{
			_gps = [(_logic getvariable "HAC_HQ_snipersG"),"R",_rcheckArr,5000,false,_logic] call ALiVE_fnc_HAC_Recon;

				{
				if ((_logic getvariable "HAC_HQ_ReconStage") > _stages) exitWith {};
				_logic setvariable ["HAC_HQ_ReconStage",(_logic getvariable "HAC_HQ_ReconStage") + 1];_x setVariable ["Busy" + (str _x),true];
				[_x,_PosObj1,(_logic getvariable "HAC_HQ_ReconStage"),_logic] spawn ALiVE_fnc_HAC_GoRecon;
				}
			foreach _gps
			};

		_onlyL = (_logic getvariable "HAC_HQ_LArmorG") - (_logic getvariable "HAC_HQ_MArmorG");
		if (not ((count _onlyL) == 0) and ((count (_logic getvariable "HAC_HQ_ReconAv")) > 0) and not ((_logic getvariable "HAC_HQ_ReconDone")) and not ((_logic getvariable "HAC_HQ_ReconStage") > _stages)) then
			{
			_gps = [_onlyL,"R",_rcheckArr,20000,false,_logic] call ALiVE_fnc_HAC_Recon;

				{
				if ((_logic getvariable "HAC_HQ_ReconStage") > _stages) exitWith {};
				_logic setvariable ["HAC_HQ_ReconStage",(_logic getvariable "HAC_HQ_ReconStage") + 1];_x setVariable ["Busy" + (str _x),true];
				[_x,_PosObj1,(_logic getvariable "HAC_HQ_ReconStage"),_logic] spawn ALiVE_fnc_HAC_GoRecon;
				}
			foreach _gps
			};

            if (not ((count ((_logic getvariable "HAC_HQ_NCrewInfG") - (_logic getvariable "HAC_HQ_SpecForG"))) == 0) and ((count (_logic getvariable "HAC_HQ_ReconAv")) > 0) and not ((_logic getvariable "HAC_HQ_ReconDone")) and not ((_logic getvariable "HAC_HQ_ReconStage") > _stages)) then
			{
                _gps = [((_logic getvariable "HAC_HQ_NCrewInfG") - (_logic getvariable "HAC_HQ_SpecForG")),"NR",_rcheckArr,10000,false,_logic] call ALiVE_fnc_HAC_Recon;

				{
				if ((_logic getvariable "HAC_HQ_ReconStage") > _stages) exitWith {};
				_logic setvariable ["HAC_HQ_ReconStage",(_logic getvariable "HAC_HQ_ReconStage") + 1];_x setVariable ["Busy" + (str _x),true];
				[_x,_PosObj1,(_logic getvariable "HAC_HQ_ReconStage"),_logic] spawn ALiVE_fnc_HAC_GoRecon;
				}
			foreach _gps
			};

		_LMCUA = (_logic getvariable "HAC_HQ_Friends") - ((_logic getvariable "HAC_HQ_NavalG") + (_logic getvariable "HAC_HQ_StaticG") + (_logic getvariable "HAC_HQ_SupportG") + (_logic getvariable "HAC_HQ_ArtG") + (_logic getvariable "HAC_HQ_AOnly") + (_logic getvariable "HAC_HQ_SpecForG") + (_logic getvariable "HAC_HQ_CargoOnly"));
		if (not ((count _LMCUA) == 0) and not ((_logic getvariable "HAC_HQ_ReconDone")) and not ((_logic getvariable "HAC_HQ_ReconStage") > _stages)) then
			{
			_gps = [_LMCUA,"NR",_rcheckArr,20000,false,_logic] call ALiVE_fnc_HAC_Recon;

				{
				if ((_logic getvariable "HAC_HQ_ReconStage") > _stages) exitWith {};
				_logic setvariable ["HAC_HQ_ReconStage",(_logic getvariable "HAC_HQ_ReconStage") + 1];_x setVariable ["Busy" + (str _x),true];
				[_x,_PosObj1,(_logic getvariable "HAC_HQ_ReconStage"),_logic] spawn ALiVE_fnc_HAC_GoRecon;
				}
			foreach _gps
			}
		}
	} else{
		_logic setvariable ["HAC_HQ_ReconDone", true]
};

if (isNil {_logic getvariable "HAC_HQ_IdleOrd"}) then {_logic setvariable ["HAC_HQ_IdleOrd", true]};

_reserve = (_logic getvariable "HAC_HQ_Friends") - ((_logic getvariable "HAC_HQ_SpecForG") + (_logic getvariable "HAC_HQ_CargoOnly") + (_logic getvariable "HAC_HQ_AOnly") + (_logic getvariable "HAC_HQ_ROnly") + (_logic getvariable "HAC_HQ_Exhausted") + (_logic getvariable "HAC_HQ_ArtG") + (_logic getvariable "HAC_HQ_AirG") + (_logic getvariable "HAC_HQ_NavalG") + (_logic getvariable "HAC_HQ_StaticG") + (_logic getvariable "HAC_HQ_SupportG") + ((_logic getvariable "HAC_HQ_NCCargoG") - ((_logic getvariable "HAC_HQ_NCrewInfG") + (_logic getvariable "HAC_HQ_SupportG"))));
if (not(_logic getvariable "HAC_HQ_ReconDone") and ((count (_logic getvariable "HAC_HQ_KnEnemies")) == 0)) exitwith 
	{
	if (_logic getvariable "HAC_HQ_Orderfirst") then 
		{
		_logic setvariable ["HAC_HQ_Orderfirst", false]
		};

		{
		_recvar = str _x;
		_resting = false;
		_resting = _x getvariable ("Resting" + _recvar);
		if (isNil ("_resting")) then {_resting = false};
		if not (_resting) then {[_x,_logic] spawn ALiVE_fnc_HAC_GoRest }
		}
	foreach ((_logic getvariable "HAC_HQ_Exhausted") - ((_logic getvariable "HAC_HQ_AirG") + (_logic getvariable "HAC_HQ_StaticG") + (_logic getvariable "HAC_HQ_ArtG") + (_logic getvariable "HAC_HQ_NavalG")));

	if (_logic getvariable "HAC_HQ_IdleOrd") then
		{
			{
			_recvar = str _x;
			_busy = false;
			_deployed = false;
			_capturing = false;
			_capturing = _x getVariable ("Capt" + _recvar);
			if (isNil ("_capturing")) then {_capturing = false};
			_deployed = _x getvariable ("Deployed" + _recvar);
			_busy = _x getvariable ("Busy" + _recvar);
			if (isNil ("_busy")) then {_busy = false};
			if (isNil ("_deployed")) then {_deployed = false};
			if (not (_busy) and ((count (waypoints _x)) <= 1) and not (_deployed) and not (_capturing) and (not (_x in (_logic getvariable "HAC_HQ_NCCargoG")) or ((count (units _x)) > 1))) then {deleteWaypoint ((waypoints _x) select 0);[_x,_logic] spawn ALiVE_fnc_HAC_GoIdle }
			}
		foreach _reserve;
		};

	_logic setvariable ["HAC_xHQ_Done", true];
	};

_logic setvariable ["HAC_HQ_FlankReady", true];

_reconthreat = [];
_FOthreat = [];
_snipersthreat = [];
_ATinfthreat = [];
_AAinfthreat = [];
_Infthreat = [];
_Artthreat = [];
_HArmorthreat = [];
_LArmorthreat = [];
_LArmorATthreat = [];
_Carsthreat = [];
_Airthreat = [];
_Navalthreat = [];
_Staticthreat = [];
_StaticAAthreat = [];
_StaticATthreat = [];
_Supportthreat = [];
_Cargothreat = [];
_Otherthreat = [];


	{
	_GE = (group _x);
	_GEvar = str _GE;
	_checked = _GE getvariable ("Checked" + _GEvar);
	if (isNil ("_checked")) then {_GE setvariable [("Checked" + _GEvar),false]};
	_checked = _GE getvariable ("Checked" + _GEvar);

	if ((_x in (_logic getvariable "HAC_HQ_Enrecon")) and not (_GE in _reconthreat) and not (_checked)) then {_reconthreat set [(count _reconthreat),_GE]};
	if ((_x in (_logic getvariable "HAC_HQ_EnFO")) and not (_GE in _FOthreat) and not (_checked)) then {_FOthreat set [(count _FOthreat),_GE]};
	if ((_x in (_logic getvariable "HAC_HQ_Ensnipers")) and not (_GE in _snipersthreat) and not (_checked)) then {_snipersthreat set [(count _snipersthreat),_GE]};
	if ((_x in (_logic getvariable "HAC_HQ_EnATinf")) and not (_GE in _ATinfthreat) and not (_checked)) then {_ATinfthreat set [(count _ATinfthreat),_GE]};
	if ((_x in (_logic getvariable "HAC_HQ_EnAAinf")) and not (_GE in _AAinfthreat) and not (_checked)) then {_AAinfthreat set [(count _AAinfthreat),_GE]};
	if ((_x in (_logic getvariable "HAC_HQ_EnInf")) and not (_GE in _Infthreat) and not (_checked)) then {_Infthreat set [(count _Infthreat),_GE]};
	if ((_x in (_logic getvariable "HAC_HQ_EnArt")) and not (_GE in _Artthreat) and not (_checked)) then {_Artthreat set [(count _Artthreat),_GE]};
	if ((_x in (_logic getvariable "HAC_HQ_EnHArmor")) and not (_GE in _HArmorthreat) and not (_checked)) then {_HArmorthreat set [(count _HArmorthreat),_GE]};
	if ((_x in (_logic getvariable "HAC_HQ_EnLArmor")) and not (_GE in _LArmorthreat) and not (_checked)) then {_LArmorthreat set [(count _LArmorthreat),_GE]};
	if ((_x in (_logic getvariable "HAC_HQ_EnLArmorAT")) and not (_GE in _LArmorATthreat) and not (_checked)) then {_LArmorATthreat set [(count _LArmorATthreat),_GE]};
	if ((_x in (_logic getvariable "HAC_HQ_EnCars")) and not (_GE in _Carsthreat) and not (_checked)) then {_Carsthreat set [(count _Carsthreat),_GE]};
	if ((_x in (_logic getvariable "HAC_HQ_EnAir")) and not (_GE in _Airthreat) and not (_checked)) then {_Airthreat set [(count _Airthreat),_GE]};
	if ((_x in (_logic getvariable "HAC_HQ_EnNaval")) and not (_GE in _Navalthreat) and not (_checked)) then {_Navalthreat set [(count _Navalthreat),_GE]};
	if ((_x in (_logic getvariable "HAC_HQ_EnStatic")) and not (_GE in _Staticthreat) and not (_checked)) then {_Staticthreat set [(count _Staticthreat),_GE]};
	if ((_x in (_logic getvariable "HAC_HQ_EnStaticAA")) and not (_GE in _StaticAAthreat) and not (_checked)) then {_StaticAAthreat set [(count _StaticAAthreat),_GE]};
	if ((_x in (_logic getvariable "HAC_HQ_EnStaticAT")) and not (_GE in _StaticATthreat) and not (_checked)) then {_StaticATthreat set [(count _StaticATthreat),_GE]};
	if ((_x in (_logic getvariable "HAC_HQ_EnSupport")) and not (_GE in _Supportthreat) and not (_checked)) then {_Supportthreat set [(count _Supportthreat),_GE]};
	if ((_x in (_logic getvariable "HAC_HQ_EnCargo")) and not (_GE in _Cargothreat) and not (_checked)) then {_Cargothreat set [(count _Cargothreat),_GE]};

	if ((_x in (_logic getvariable "HAC_HQ_EnInf")) and ((vehicle _x) in (_logic getvariable "HAC_HQ_EnCargo")) and not (_x in (_logic getvariable "HAC_HQ_EnCrew")) and not (_GE in _Infthreat) and not (_checked)) then {_Infthreat set [(count _Infthreat),_GE]};

	if ((isNil ("_checked")) or not (_checked)) then {_GE setVariable [("Checked" + _GEvar), true]};
	}
foreach (_logic getvariable "HAC_HQ_KnEnemies");

_logic setvariable ["HAC_HQ_AAthreat", (_AAinfthreat + _StaticAAthreat)];
_logic setvariable ["HAC_HQ_ATthreat", (_ATinfthreat + _StaticATthreat + _HArmorthreat + _LArmorATthreat)];
_logic setvariable ["HAC_HQ_Airthreat", _Airthreat];
_reconthreat = _reconthreat - _Airthreat;

_FPool = 
	[
	(_logic getvariable "HAC_HQ_snipersG"),
	(_logic getvariable "HAC_HQ_NCrewInfG") - (_logic getvariable "HAC_HQ_SpecForG"),
	(_logic getvariable "HAC_HQ_AirG") - ((_logic getvariable "HAC_HQ_NCAirG") + (_logic getvariable "HAC_HQ_NCrewInfG")),
	(_logic getvariable "HAC_HQ_LArmorG"),
	(_logic getvariable "HAC_HQ_HArmorG"),
	(_logic getvariable "HAC_HQ_CarsG") - ((_logic getvariable "HAC_HQ_ATInfG") + (_logic getvariable "HAC_HQ_AAInfG") + (_logic getvariable "HAC_HQ_SupportG") + (_logic getvariable "HAC_HQ_NCCargoG")),
	(_logic getvariable "HAC_HQ_LArmorATG"),
	(_logic getvariable "HAC_HQ_ATInfG"),
	(_logic getvariable "HAC_HQ_AAInfG"),
	(_logic getvariable "HAC_HQ_Recklessness"),
	(_logic getvariable "HAC_HQ_AttackAv"),
	(_logic getvariable "HAC_HQ_Garrison"),
	(_logic getvariable "HAC_HQ_GarrR"),
	(_logic getvariable "HAC_HQ_FlankAv"),
	(_logic getvariable "HAC_HQ_AirG"),
	(_logic getvariable "HAC_HQ_NCVeh")
	];

_constant = [(_logic getvariable "HAC_HQ_AAthreat"),(_logic getvariable "HAC_HQ_ATthreat"),_HArmorthreat + _LArmorATthreat,_FPool];

if (count (_reconthreat + _FOthreat + _snipersthreat) > 0) then 
	{
	([_logic,_reconthreat + _FOthreat + _snipersthreat,"Recon","A",0,0,0] + _constant) call ALiVE_fnc_HAC_Dispatcher;
	};

if (count _ATinfthreat > 0) then 
	{
	([_logic,_ATinfthreat,"ATInf","A",0,0,85] + _constant) call ALiVE_fnc_HAC_Dispatcher;
	};

if (count _Infthreat > 0) then 
	{
	([_logic,_Infthreat,"Inf","A",75,80,85] + _constant) call ALiVE_fnc_HAC_Dispatcher;
	};

if (count (_LArmorthreat + _HArmorthreat) > 0) then 
	{
	([_logic,_LArmorthreat + _HArmorthreat,"Armor","A",50,0,85] + _constant) call ALiVE_fnc_HAC_Dispatcher;
	};

if (count _Carsthreat > 0) then 
	{
	([_logic,_Carsthreat,"Cars","A",75,80,85] + _constant) call ALiVE_fnc_HAC_Dispatcher;
	};

if (count _Artthreat > 0) then 
	{
	([_logic,_Artthreat,"Art","A",70,75,75] + _constant) call ALiVE_fnc_HAC_Dispatcher;
	};

if (count _Airthreat > 0) then 
	{
	([_logic,_Airthreat,"Air","A",0,0,75] + _constant) call ALiVE_fnc_HAC_Dispatcher;
	};

if (count (_Staticthreat - _Artthreat) > 0) then 
	{
	([_logic,_Staticthreat - _Artthreat,"Static","A",75,80,85] + _constant) call ALiVE_fnc_HAC_Dispatcher;
	};

/////////////////////////////////////////
// Capture Objective

_Trg = (_logic getvariable "HAC_HQ_Obj");

	{
	_x setVariable [("Capturing" + (str _x)),[0,0]]
	}
foreach ([(_logic getvariable "HAC_HQ_Obj1"),(_logic getvariable "HAC_HQ_Obj2"),(_logic getvariable "HAC_HQ_Obj3"),(_logic getvariable "HAC_HQ_Obj4")] - [(_logic getvariable "HAC_HQ_Obj")]);

if (isNil ("_Trg")) then {_Trg = _logic};

_isAttacked = _Trg getvariable ("Capturing" + (str _Trg));

if (isNil ("_isAttacked")) then {_isAttacked = [0,0]};

_captCount = _isAttacked select 1;
_isAttacked = _isAttacked select 0;
_captLimit = (_logic getvariable "HAC_HQ_CaptLimit") * (1 + ((_logic getvariable "HAC_HQ_Circumspection")/(2 + (_logic getvariable "HAC_HQ_Recklessness"))));
if ((_isAttacked <= 3) or (_captCount < _captLimit)) then
	{	
	if (not ((_logic getvariable "HAC_HQ_NObj") > 4) and 
		((random 100) > ((count (_logic getvariable "HAC_HQ_KnEnemies"))*(5/(0.5 + (2*(_logic getvariable "HAC_HQ_Recklessness")))))) and not 
			((_logic getvariable "HAC_HQ_Orderfirst")) and 
        ((random 100) < ((((count (_logic getvariable "HAC_HQ_Friends"))*(0.5 + (_logic getvariable "HAC_HQ_Recklessness")))/(5*(0.5 + count (_logic getvariable "HAC_HQ_KnEnemiesG"))))*((((_logic getvariable "HAC_HQ_Cyclecount") - 5)*2*(1 + (_logic getvariable "HAC_HQ_Recklessness")))))) or
					((((_logic getvariable "HAC_HQ_RapidCapt") * ((_logic getvariable "HAC_HQ_Recklessness") + 0.01)) > (random 100)) and ((_logic getvariable "HAC_HQ_NObj") <= 4))) then   
		{
		_checked = [];
		_forCapt = (_logic getvariable "HAC_HQ_NCrewInfG") - ((_logic getvariable "HAC_HQ_SupportG") + (_logic getvariable "HAC_HQ_SpecForG") + (_logic getvariable "HAC_HQ_CargoOnly") + (_logic getvariable "HAC_HQ_Garrison"));
		_forCapt = [_forCapt,_logic] call ALiVE_fnc_HAC_SizeOrd;
		if (not ((count _forCapt) == 0) and ((count (_logic getvariable "HAC_HQ_AttackAv")) > 0)) then
			{
			for [{_m = 500},{_m <= 5000},{_m = _m + 500}] do
				{
				_isAttacked = _Trg getvariable ("Capturing" + (str _Trg));
				if (isNil ("_isAttacked")) then {_isAttacked = [1,0]};
				_captCount = _isAttacked select 1;
				_isAttacked = _isAttacked select 0;
				if ((_isAttacked > 3) and (_captCount >= _captLimit)) exitwith {};

					{
					_isAttacked = _Trg getvariable ("Capturing" + (str _Trg));
					if (isNil ("_isAttacked")) then {_isAttacked = [1,0]};
					_captCount = _isAttacked select 1;
					_isAttacked = _isAttacked select 0;

					if ((_isAttacked > 3) and (_captCount >= _captLimit)) exitwith {};
					if (_x in (_logic getvariable "HAC_HQ_AttackAv")) then
						{
						if (((leader _x) distance _Trg) <= _m) then
							{
							if (not (_x in (_logic getvariable "HAC_HQ_NCCargoG")) or ((count (units _x)) > 1)) then 
								{
								_ammo = [_x,(_logic getvariable "HAC_HQ_NCVeh")] call ALiVE_fnc_HAC_AmmoCount;
								if (_ammo > 0) then
									{
									_busy = _x getvariable [("Busy" + (str _x)),false];
									if not (_busy) then
										{
										_x setVariable [("Busy" + (str _x)),true];
										_checked set [(count _checked),_x];
										_groupCount = count (units _x);

										switch (_isAttacked) do
											{
											case (4) : {_Trg setvariable [("Capturing" + (str  _Trg)),[5,_captCount + _groupCount]]};
											case (3) : {_Trg setvariable [("Capturing" + (str  _Trg)),[4,_captCount + _groupCount]]};
											case (2) : {_Trg setvariable [("Capturing" + (str  _Trg)),[3,_captCount + _groupCount]]};
											case (1) : {_Trg setvariable [("Capturing" + (str  _Trg)),[2,_captCount + _groupCount]]};
											case (0) : {_Trg setVariable [("Capturing" + (str  _Trg)),[1,_captCount + _groupCount]]};
											};

										[_x,_isAttacked,_logic] spawn ALiVE_fnc_HAC_GoCapture;
										}
									}
								}
							}
						}
					}
				foreach _forCapt;
				_forCapt = _forCapt - _checked
				}
			};

		if ((_isAttacked > 3) and (_captCount >= _captLimit)) exitwith {};

            _LMCU = (_logic getvariable "HAC_HQ_Friends") - (((_logic getvariable "HAC_HQ_AirG") - (_logic getvariable "HAC_HQ_NCrewInfG")) + (_logic getvariable "HAC_HQ_SpecForG") + (_logic getvariable "HAC_HQ_CargoOnly") + (_logic getvariable "HAC_HQ_NavalG") + (_logic getvariable "HAC_HQ_StaticG") + (_logic getvariable "HAC_HQ_SupportG") + (_logic getvariable "HAC_HQ_ArtG") + (_logic getvariable "HAC_HQ_Garrison") + ((_logic getvariable "HAC_HQ_NCCargoG") - ((_logic getvariable "HAC_HQ_NCrewInfG") - (_logic getvariable "HAC_HQ_SupportG"))));
		_LMCU = [_LMCU,_logic] call ALiVE_fnc_HAC_SizeOrd;
		if (not ((count _LMCU) == 0) and ((count (_logic getvariable "HAC_HQ_AttackAv")) > 0)) then
			{
			for [{_m = 1000},{_m <= 20000},{_m = _m + 1000}] do
				{
				_isAttacked = _Trg getvariable ("Capturing" + (str _Trg));
				if (isNil ("_isAttacked")) then {_isAttacked = [1,0]};
				_captCount = _isAttacked select 1;
				_isAttacked = _isAttacked select 0;
				if ((_isAttacked > 3) and (_captCount >= _captLimit)) exitwith {};

					{
					_isAttacked = _Trg getvariable ("Capturing" + (str _Trg));
					if (isNil ("_isAttacked")) then {_isAttacked = [1,0]};
					_captCount = _isAttacked select 1;
					_isAttacked = _isAttacked select 0;

					if ((_isAttacked > 3) and (_captCount >= _captLimit)) exitwith {};
					if (_x in (_logic getvariable "HAC_HQ_AttackAv")) then
						{
						if (((leader _x) distance _Trg) <= _m) then
							{
							_ammo = [_x,(_logic getvariable "HAC_HQ_NCVeh")] call ALiVE_fnc_HAC_AmmoCount;
							if (_ammo > 0) then
								{
								_busy = _x getvariable [("Busy" + (str _x)),false];
								if not (_busy) then
									{
									_x setVariable [("Busy" + (str _x)),true];
									_checked set [(count _checked),_x];
									_groupCount = count (units _x);

									switch (_isAttacked) do
										{
										case (4) : {_Trg setvariable [("Capturing" + (str  _Trg)),[5,_captCount + _groupCount]]};
										case (3) : {_Trg setvariable [("Capturing" + (str  _Trg)),[4,_captCount + _groupCount]]};
										case (2) : {_Trg setvariable [("Capturing" + (str  _Trg)),[3,_captCount + _groupCount]]};
										case (1) : {_Trg setvariable [("Capturing" + (str  _Trg)),[2,_captCount + _groupCount]]};
										case (0) : {_Trg setVariable [("Capturing" + (str  _Trg)),[1,_captCount + _groupCount]]};
										};

									[_x,_isAttacked,_logic] spawn ALiVE_fnc_HAC_GoCapture;
									}
								}
							}
						}
					}
				foreach _LMCU;
				_LMCU = _LMCU - _checked
				}
			}
		}
	};

    if ((_logic getvariable "HAC_HQ_IdleOrd")) then
	{
	_reserve = (_logic getvariable "HAC_HQ_Friends") - ((_logic getvariable "HAC_HQ_SpecForG") + (_logic getvariable "HAC_HQ_CargoOnly") + (_logic getvariable "HAC_HQ_AOnly") + (_logic getvariable "HAC_HQ_ROnly") + (_logic getvariable "HAC_HQ_Exhausted") + (_logic getvariable "HAC_HQ_ArtG") + (_logic getvariable "HAC_HQ_AirG") + (_logic getvariable "HAC_HQ_NavalG") + (_logic getvariable "HAC_HQ_StaticG") + ((_logic getvariable "HAC_HQ_NCCargoG") - ((_logic getvariable "HAC_HQ_NCrewInfG") + (_logic getvariable "HAC_HQ_SupportG"))));
		
		{
		_recvar = str _x;
		_busy = false;
		_deployed = false;
		_capturing = false;
		_capturing = _x getVariable ("Capt" + _recvar);
		if (isNil ("_capturing")) then {_capturing = false};
		_deployed = _x getvariable ("Deployed" + _recvar);
		_busy = _x getvariable ("Busy" + _recvar);
		if (isNil ("_busy")) then {_busy = false};
		if (isNil ("_deployed")) then {_deployed = false};
		if (not (_busy) and ((count (waypoints _x)) <= 1) and not (_deployed) and not (_capturing) and (not (_x in (_logic getvariable "HAC_HQ_NCCargoG")) or ((count (units _x)) > 1))) then {deleteWaypoint ((waypoints _x) select 0);[_x,_logic] spawn ALiVE_fnc_HAC_GoIdle};
		}
	foreach _reserve
	};

	{
	_recvar = str _x;
	_resting = false;
	_resting = _x getvariable ("Resting" + _recvar);
	if (isNil ("_resting")) then {_resting = false};
	if not (_resting) then {[_x,_logic] spawn ALiVE_fnc_HAC_GoRest }
	}
foreach ((_logic getvariable "HAC_HQ_Exhausted") - ((_logic getvariable "HAC_HQ_AirG") + (_logic getvariable "HAC_HQ_StaticG") + (_logic getvariable "HAC_HQ_ArtG") + (_logic getvariable "HAC_HQ_NavalG")));

	{
	_GE = (group _x);
	_GEvar = str _GE;
	_GE setvariable [("Checked" + _GEvar),false];
	}
foreach (_logic getvariable "HAC_HQ_KnEnemies");

if ((_logic getvariable "HAC_HQ_Orderfirst")) then {_logic setvariable ["HAC_HQ_Orderfirst", false]};

_logic setvariable ["HAC_xHQ_Done", true];