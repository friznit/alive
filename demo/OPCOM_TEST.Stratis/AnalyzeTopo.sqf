_objRad = 2000;
_strArea = [];
_cntr = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
_profiles = [ALIVE_profileHandler, "getProfilesBySide", "EAST"] call ALIVE_fnc_profileHandler;

_loc10 = nearestLocations [_cntr, ["NameCityCapital"], _objRad];
_loc5 = nearestLocations [_cntr, ["NameCity","Airport"], _objRad];
_loc2 = nearestLocations [_cntr, ["NameVillage"], _objRad];
_loc1 = nearestLocations [_cntr, ["BorderCrossing"], _objRad];
_locHill = nearestLocations [_cntr, ["Hill","ViewPoint"], _objRad];

	{
	_strArea set [(count _strArea),[(position _x),10,false]]
	}
foreach _loc10;

	{
	_strArea set [(count _strArea),[(position _x),5,false]]
	}
foreach _loc5;

	{
	_strArea set [(count _strArea),[(position _x),2,false]]
	}
foreach _loc2;

	{
	_strArea set [(count _strArea),[(position _x),1,false]]
	}
foreach _loc1;


	{
	_topArr = [(position _x),3] call ALiVE_fnc_HAC_TerraCognita;
	_frstV = _topArr select 1;
	if (_frstV > 0.25) then 
		{
		_strArea set [(count _strArea),[(position _x),1,false]]
		}
	else
		{
		_strArea set [(count _strArea),[(position _x),2,false]]
		}
	}
foreach _locHill;

_BBStr = [];
_fixedInitStatus = [];

	{
	_pos = _x select 0;
	_pos = (_pos select 0) + (_pos select 1);

	_fixedInitStatus set [(count _fixedInitStatus),_pos]
	}
foreach _BBStr;

	{
    _profile = [ALIVE_profileHandler, "getProfile", _x] call ALIVE_fnc_profileHandler;
	_pos = [_profile,"position"] call ALIVE_fnc_hashGet;
	_BBStr set [(count _BBStr),[_pos,0,false]];
	}
foreach _profiles;

_strArea = _strArea + _BBStr;
_strArea0 = +_strArea;

	{
	_fAr = _x;
	_k = _foreachIndex;
	_fPnt = _fAr select 0;
	_fVal = _fAr select 1;
	_fTkn = _fAr select 2;

	_fX = _fPnt select 0;
	_fY = _fPnt select 1;

		{
		_sAr = _x;
		_j = _foreachIndex;
		_sPnt = _sAr select 0;
		_sVal = _sAr select 1;
		_sTkn = _sAr select 2;

		_sX = _sPnt select 0;
		_sY = _sPnt select 1;

		if (((_fPnt distance _sPnt) < 400) and not ((_fPnt select 0) == (_sPnt select 0))) then 
			{
			
			if (_fVal > _sVal) then
				{
				_strArea set [_k,[[(_fX + _sX)/2,(_fY + _sY)/2,0],_fVal + _sVal,_fTkn]];
				_strArea set [_j,"deleteThis"]
				}
			else
				{
				_strArea set [_j,[[(_fX + _sX)/2,(_fY + _sY)/2,0],_fVal + _sVal,_sTkn]];
				_strArea set [_k,"deleteThis"]
				}
			}
		}
	foreach _strArea0
	}
foreach _strArea0;

_strArea = _strArea - ["deleteThis"];

_strArea0 = nil;

missionNameSpace setVariable ["A_SAreas",_strArea];
player sidechat format["Areas %1",_strArea];
diag_log format["Areas %1",_strArea];

{
_pos = _x select 0;
player sidechat format ["%1",_pos];

_m = createMarkerLocal [str(_foreachIndex), _pos];
_m setMarkerShapeLocal "ICON";
_m setMarkerSizeLocal [1, 1];
_m setMarkerTypeLocal "hd_dot";
_m setMarkerColorLocal "ColorRed";
_m setMarkerTextLocal "destination";

} foreach _strArea;