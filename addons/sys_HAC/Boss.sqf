private 
	[
	"_cntr","_lng","_nmbr","_sectors","_markers","_mark","_secpos","_sPosX","_sPosY","_sUrban","_sForest","_sHills","_sFlat","_sSea","_samplePos","_topArr","_sRoads","_bbCycle",
	"_text","_nbr","_sum","_alpha","_count","_strArea","_loc10","_loc5","_loc2","_loc1","_locHill","_topArr","_frstV","_nmbr","_posGrpX","_sGr","_BBHQs","_BBSide","_urgent",
	"_posGrpY","_posGrp","_valGrp","_armyPos","_ct","_change","_mainPos","_taken","_posStr","_valStr","_posStrX","_posStrY","_amDist","_mDist","_aDist","_gDst","_actDist","_BBStr",
	"_attackAxis","_color","_k","_j","_fAr","_fPnt","_fVal","_fTkn","_fX","_fY","_sAr","_sPnt","_sVal","_sTkn","_sX","_sY","_ForcesRep","_ownGroups","_hostileGroups","_BBHQGrps",
	"_isCiv","_civF","_enemyClose","_allCount","_resCount","_actCount","_flankCount","_centerCount","_BBHQs","_resArr","_chsn","_resDst","_dst","_centerArr","_centerDst","_allAreTaken",
	"_isLeft","_where","_isFlank","_isRear","_leftSectors","_rightSectors","_frontSectors","_leftAn","_leftInf","_leftVeh","_rightAn","_rightInf","_rightVeh","_frontAn","_BBSAL",
	"_frontInf","_frontVeh","_leftSANmbr","_rightSANmbr","_frontSANmbr","_leftSA","_rightSA","_frontSA","_leftSANmbr","_rightSANmbr","_frontSANmbr","_leftSpace","_rightSpace","_ctWait",
	"_frontSpace","_LmaxSpace","_RmaxSpace","_FmaxSpace","_LmaxSA","_RmaxSA","_FmaxSA","_LmaxVeh","_RmaxVeh","_FmaxVeh","_lFlank","_rFlank","_cFront","_flSMaxStr","_flSpace","_pathDone",
	"_flSAMaxStr","_flSA","_fl","_spaceF","_SAF","_flVMaxStr","_flVeh","_vehF","_vehAll","_ldrRep","_forceChar","_vehPerc","_vehAll","_vehAv","_moreVehHQ","_numAll","_forceNum",
	"_numAv","_moreNumHQ","_goingLeft","_goingRight","_goingAhead","_goingReserve","_restHQ","_ldr","_rndF","_leftNotTaken","_tkn","_rightNotTaken","_frontNotTaken","_fPos","_takenPoints",
	"_chosenT","_indx","_cPos","_cVal","_cTaken","_dstFC","_tempMax","_actT","_front","_tObj1","_tObj2","_tObj3","_tObj4","_areas","_sctrs","_pathRep","_tgtsAround","_HQpos","_HQPoints",
	"_acT","_points","_tempAct","_secsAround","_notTaken","_indx","_in","_check","_checkPos","_actPos","_losses","_currentNumber","_ownVal","_enemyVal","_enemyFactor","_lossesFactor","_actRep",
	"_stnc","_nilStance","_stance","_inert","_knEnemy","_ownVal","_perDirPos","_dpX","_dpY","_dirAdd","_angle","_perPos","_perX","_perY","_BBalive","_HQ","_BBUnit","_leftFlankName",
	"_rightFlankName","_leftName","_rightName","_frontName","_isLeftName","_isFlankName","_isRearName","_centerFrontName","_xPr","_yPr","_objCount","_QH","_initD","_aliveHQ","_objRad",
	"_goingReserve0","_lastGLeft","_lastGRight","_lastGAhead","_aliveHQ","_newL","_lastGLeftN","_lastGRightN","_lastGAheadN","_fixedInitStatus","_pos","_enAr","_eA","_eP","_eT","_sA","_sP",
	"_strArea0","_k","_j","_flankOne","_goingOne","_flankTwo","_goingTwo","_resCand","_ctVal"
	];

_BBHQs = (_this select 0) select 0;
_BBSide = (_this select 0) select 1;
_logic = _this select ((count _this)-1);

diag_log format ["Init Input %1 | %2 | %3",_BBHQs,_BBHQs,_logic];

	{
	(group _x) setVariable ["BBProgress",0]
	}
foreach _BBHQs;

if ((_BBSide == "B") and (count (_logic getvariable "HAC_BBa_HQs") > 0)) then 
	{
	waitUntil
		{
		sleep 5;
		(_logic getvariable "HAC_BBa_Init")
		}
	};

if (_logic getvariable "HAC_BB_Debug") then
	{
	_logic globalChat format ["Big Boss %1 awakes (time: %2)",_BBSide,time];
	diag_log format ["Big Boss %1 awakes (time: %2)",_BBSide,time]
	};

_BBHQGrps = [];

	{
	_BBHQGrps set [(count _BBHQGrps),(group _x)]
	}
foreach _BBHQs;

	{
	switch (_x) do
		{
		case (_logic) : {waitUntil {sleep 0.1;diag_log format ["Waiting for HAC_HQ_readyForBB - Input %1 | %2",_BBHQs,_BBSide]; not (isNil {_logic getvariable "HAC_HQ_readyForBB"})}};
		}
	}
foreach _BBHQs;

_cntr = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
if (_BBSide == "A") then
	{
	if not (isNil "HAC_BB_MC") then
		{
		if ((typeName HAC_BB_MC) == "OBJECT") then {_cntr = getPosATL HAC_BB_MC} else {_cntr = HAC_BB_MC};
		}
	else
		{
		HAC_BB_MapC = _cntr;		
		waitUntil {not (isNil "HAC_BB_MapC")};
		};
	_logic setvariable ["HAC_BB_MapC", _cntr];

	//if ((_cntr select 0) < 1000) then {_cntr = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition")};

	//_mark = "center" + str (random 1000);
	//_mark = [_mark,_cntr,"ColorBlue","ICON",[1.5,1.5],0,1,"mil_dot",(str _cntr),_logic] call ALiVE_fnc_HAC_Marker;

	_lng = (_cntr select 0)*2;
	if not (isNil "HAC_BB_MC") then
		{
		if ((typeName HAC_BB_MC) == "OBJECT") then
			{
			_lng = ((triggerArea HAC_BB_MC) select 0)*2
			}
		else
			{
			_lng = _logic getvariable ["HAC_BB_MapLng",10000];
			};

		_logic setvariable ["HAC_BB_MapXMax", ((_logic getvariable "HAC_BB_MapC") select 0) + _lng/2];
		_logic setvariable ["HAC_BB_MapYMax", ((_logic getvariable "HAC_BB_MapC") select 1) + _lng/2];
		_logic setvariable ["HAC_BB_MapXMin", ((_logic getvariable "HAC_BB_MapC") select 0) - _lng/2];
		_logic setvariable ["HAC_BB_MapYMin", ((_logic getvariable "HAC_BB_MapC") select 1) - _lng/2];
		};

	_nmbr = round (_lng/500);

	missionNameSpace setVariable ["BattleF",[_cntr,_lng,_nmbr]];
	_logic setvariable ["HAC_BB_Sectors", ([_cntr,_lng,0,_nmbr,_logic] call ALiVE_fnc_HAC_Sectorize) select 0];
/*
	_markers = [];
	
		{
		_mark = "sector" + str (random 1000);
		_mark = [_mark,position _x,"ColorBlue","RECTANGLE",size _x,direction _x,1,"Border","",_logic] call ALiVE_fnc_HAC_Marker;
		_markers set [(count _markers),_mark];
		_x setVariable ["Over_Mark",_mark];
		}
	foreach HAC_BB_Sectors;
*/	

	_nbr = 0;

//	startloadingscreen ["Big Boss studies the map","RscDisplayLoadCustom"];
	if (_logic getvariable "HAC_BB_Debug") then {diag_log "Big Boss studies the map."};

		{
		_x setVariable ["BBSec",true];		

		_secpos = position _x;
		_sPosX = _secpos select 0;
		_sPosY = _secpos select 1;

		_sUrban = 0;
		_sForest = 0;
		_sHills = 0;
		_sFlat = 0;
		_sSea = 0;
		_sGr = 0;
		_count = 10;

		for "_i" from 1 to _count do
			{
			_samplePos = [_sPosX + ((random 500) - 250),_sPosY + ((random 500) - 250)];

			_topArr = [_samplePos,1,_logic] call ALiVE_fnc_HAC_TerraCognita;

			_sUrban = _sUrban + (_topArr select 0);
			_sForest = _sForest + (_topArr select 1);
			_sHills = _sHills + (_topArr select 2);
			_sFlat = _sFlat + (_topArr select 3);
			_sSea = _sSea + (_topArr select 4);
			_sGr = _sGr + (_topArr select 5);
			};

		_sUrban = round (_sUrban*100/_count);
		_sForest =  round (_sForest*100/_count);
		_sHills =  round(_sHills*100/_count);
		_sFlat =  round (_sFlat*100/_count);
		_sSea = round (_sSea*100/_count);
		_sGr = round (_sGr/_count);

		_x setVariable ["Topo_Urban",_sUrban];
		_x setVariable ["Topo_Forest",_sForest];
		_x setVariable ["Topo_Hills",_sHills];
		_x setVariable ["Topo_Flat",_sFlat];
		_x setVariable ["Topo_Sea",_sSea];
		_x setVariable ["Topo_Grd",_sGr * 10];

		_sRoads = count (_secpos nearRoads 250);

		_x setVariable ["Topo_roads",_sRoads];

		_mark = _x getVariable "Over_Mark";

		_nbr = _nbr + 1;
		_sum = count (_logic getvariable "HAC_BB_Sectors");

		if not (isMultiplayer) then
			{
			//progressLoadingScreen (_nbr/_sum)
			}
		}
	foreach (_logic getvariable "HAC_BB_Sectors");
	//endLoadingScreen;
	};

_logic setvariable ["HAC_BB_mapReady", true];

_sectors = (_logic getvariable "HAC_BB_Sectors");

_strArea = [];


if (_logic getvariable "HAC_BB_Debug") then
	{
	_logic globalChat format ["Big Boss %1 is looking for strategic objectives.",_BBSide];
	diag_log format ["Big Boss %1 is looking for strategic objectives.",_BBSide]
	};

_objRad = 25000;

_cntr = (missionNameSpace getVariable "BattleF") select 0;
_lng = (missionNameSpace getVariable "BattleF") select 1;

if not (isNil "HAC_BB_MC") then
	{
	_objRad = _lng/2
	};

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
	_topArr = [(position _x),3,_logic] call ALiVE_fnc_HAC_TerraCognita;
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

if (_BBSide == "A") then {if not (isNil {_logic getvariable "HAC_BBa_Str"}) then {_BBStr = _logic getvariable "HAC_BBa_Str"}};

_fixedInitStatus = [];

	{
	_pos = _x select 0;
	_pos = (_pos select 0) + (_pos select 1);

	_fixedInitStatus set [(count _fixedInitStatus),_pos]
	}
foreach _BBStr;

_BBSAL = _logic;
	{
	_BBStr set [(count _BBStr),[(position _x),_x getVariable "AreaValue",false]]
	}
foreach (synchronizedObjects _BBSAL);

_strArea = _strArea + _BBStr;

if (_logic getvariable "HAC_BB_CustomObjOnly") then {_strArea = _BBStr};

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

switch (_BBSide) do
	{
	case ("A") : {missionNameSpace setVariable ["A_SAreas",_strArea]};
	case ("B") : {missionNameSpace setVariable ["B_SAreas",_strArea]};
	};
////////////////////////////////////////////////////////////////////

_bbCycle = 0;
_leftSA = [];
_rightSA = [];
_frontSA = [];

_leftFlankName = "LeftFlank";
_rightFlankName = "RightFlank";
_centerFrontName = "CenterFront";
_leftName = "A_Left";
_rightName = "A_Right";
_frontName = "A_Front";
_isLeftName = "A_isLeft";
_isFlankName = "A_isFlank";
_isRearName = "A_isRear";

if (_BBSide == "B") then 
	{
	_leftFlankName = "LeftFlankB";
	_rightFlankName = "RightFlankB";
	_centerFrontName = "CenterFrontB";
	_leftName = "B_Left";
	_rightName = "B_Right";
	_frontName = "B_Front";
	_isLeftName = "B_isLeft";
	_isFlankName = "B_isFlank";
	_isrearName = "B_isRear";
	};

_mainPos = _cntr;
_BBalive = true;
_allAreTaken = true;

while {(_logic getvariable "HAC_BB_Active")} do
	{
	if not (_BBalive) exitWith 
		{
		if (_logic getvariable "HAC_BB_Debug") then
			{
			_logic globalChat format ["Big Boss %1 has no army!",_BBSide];
			diag_log format ["Big Boss %1 has no army!",_BBSide]
			};
		};
/*
	waitUntil 
		{
		sleep 5;
*/
		_allAreTaken = true;

			{
			if not (_x select 2) exitWith {_allAreTaken = false}
			}
		foreach _strArea;

		//not (_allAreTaken)
		//};

	_bbCycle = _bbCycle + 1;

	if (_bbCycle == 1) then
		{
		[_BBHQs,_BBSide] spawn
			{
			private ["_logic","_HQg","_side","_HQg0"];

			_HQg = _this select 0;
			_side = _this select 1;	

			_HQg0 = _HQg;

			while {(_logic getvariable "HAC_BB_Active")} do
				{
					{
					if (isNull (group _x)) then
						{
						_HQg = _HQg - [_x]
						}
					else 
						{
						if (({(alive _x)} count (units (group _x))) == 0) then
							{
							_HQg = _HQg - [_x]
							}
						};
					}
				foreach _HQg0;

				if ((count _HQg) == 0) exitWith 
					{
					if (_logic getvariable "HAC_BB_Debug") then
						{
						_logic globalChat format ["Big Boss %1 has no army!",_side];
						diag_log format ["Big Boss %1 has no army!",_side]
						};
					};

				sleep 10;
				}
			}
		};

	_BBHQs = [];

		{
		if not (isNull _x) then 
			{
			if (({(alive _x)} count (units _x)) > 0) then
				{
				_BBHQs set [(count _BBHQs),(leader _x)]
				}
			};
		}
	foreach _BBHQGrps;

	if ((count _BBHQs) == 0) exitWith 
		{
		if (_logic getvariable "HAC_BB_Debug") then
			{
			_logic globalChat format ["Big Boss %1 has no army!",_BBSide];
			diag_log format ["Big Boss %1 has no army!",_BBSide]
			};
		};

	if (_logic getvariable "HAC_BB_Debug") then
		{
		_logic globalChat format ["Big Boss %1 is analyzing forces...",_BBSide];
		diag_log format ["Big Boss %1 is analyzing forces...",_BBSide]
		};

	_ForcesRep = [_BBHQs,_logic] call ALiVE_fnc_HAC_ForceAnalyze;

	_ownGroups = (_ForcesRep select 0) select ((count (_ForcesRep select 0)) - 1);
	_hostileGroups = (_ForcesRep select 1) select ((count (_ForcesRep select 1)) - 1);

	if (_BBCycle == 1) then
		{
		if (_logic getvariable "HAC_BB_Debug") then
			{
			_logic globalChat format ["Big Boss %1 is checking own forces placement...",_BBSide];
			diag_log format ["Big Boss %1 is checking own forces placement...",_BBSide]
			};

		_nmbr = 0;
		_posGrpX = 0;
		_posGrpY = 0;

			{
			_posGrp = position (vehicle (leader _x));
			_valGrp = count (units _x);

			//_mark = "GrpPos" + (str (random 1000));
			//_mark = [_mark,_posGrp,"ColorGreen","ICON",[_valGrp/10,_valGrp/10],0,0.5,"mil_dot",(str _valGrp),_logic] call ALiVE_fnc_HAC_Marker;

			for "_j" from 1 to _valGrp do
				{
				_posGrpX = _posGrpX + (_posGrp select 0);
				_posGrpY = _posGrpY + (_posGrp select 1);
				};

			_nmbr = _nmbr + _valGrp
			}
		foreach _ownGroups;

		_armyPos = _cntr;

		if (_nmbr > 0) then {_armyPos = [_posGrpX/_nmbr,_posGrpY/_nmbr,0]};

		//_mark = "Army" + (str (random 1000));
		//_mark = [_mark,_ArmyPos,"ColorGreen","ICON",[1,1],0,1,"mil_triangle","",_logic] call ALiVE_fnc_HAC_Marker;


		_ct = 0;
		_change = true;

		_enAr = missionNameSpace getVariable ["B_SAreas",[]];
		if (_BBSide == "B") then {_enAr = missionNameSpace getVariable ["A_SAreas",[]]};

		while {(_change)} do
			{
			_nmbr = 0;
			_posStrX = 0;
			_posStrY = 0;

				{
				_taken = _x select 2;

				if not (_taken) then 
					{
					_posStr = _x select 0;
					_valStr = _x select 1;

					for "_j" from 1 to _valStr do
						{
						_posStrX = _posStrX + (_posStr select 0);
						_posStrY = _posStrY + (_posStr select 1);
						};

					_nmbr = _nmbr + (_x select 1)
					}
				}
			foreach _strArea;

			if (_nmbr > 0) then {_mainPos = [_posStrX/_nmbr,_posStrY/_nmbr,0]};

			_amDist = _armyPos distance _mainPos;

			_change = false;

			_civF = ["CIV","CIV_RU","BIS_TK_CIV","BIS_CIV_special"];
			if not (isNil {_logic getvariable "HAC_BB_CivF"}) then {_civF = _logic getvariable "HAC_BB_CivF"};

				{
				_posStr = _x select 0;
				_valStr = _x select 1;
				_taken = _x select 2;

				_mDist = _posStr distance _mainPos;
				_aDist = _posStr distance _ArmyPos;

				_enemyClose = false;

					{
					if (((side _x) getFriend (side (_ownGroups select 0))) < 0.6) then
						{
						_isCiv = false;
						if ((faction (leader _x)) in _civF) then {_isCiv = true};
						if not (_isCiv) then
							{
							if (((vehicle (leader _x)) distance _posStr) < 500) exitwith {_enemyClose = true}
							}
						};

					if (_enemyClose) exitwith {}
					}
				foreach (Allgroups - _ownGroups);

				_gDst = 1000000;
				
					{
					_actDist = (vehicle (leader _x)) distance _posStr;
					if (_actDist < _gDst) then {_gDst = _actDist}
					}
				foreach _ownGroups;

				if ((((_mDist > _amDist) and (_mDist > _aDist) and (_amDist > _aDist) and (_aDist < 5000)) or (_gDst < 500) or (_aDist < 1000)) and not (_enemyClose)) then 
					{
					if not (_taken) then {_change = true};
					_pos = _x select 0;
					_pos = (_pos select 0) + (_pos select 1);
					if not (_pos in _fixedInitStatus) then {_x set [2,true]};
					}
				else
					{
					if (_taken) then {_change = true};
					_pos = _x select 0;
					_pos = (_pos select 0) + (_pos select 1);
					if not (_pos in _fixedInitStatus) then {_x set [2,false]};
					}
				}
			foreach _strArea;

			_ct = _ct + 1;

			if (_ct > 10) then {_change = false}
			};
		
		if ((count _enAr) > 0) then
			{
				{
				_eA = _x;
				_eP = _eA select 0;
				_eT = _eA select 2;

					{
					_sA = _x;
					_sP = _sA select 0;

					if ((_sP distance _eP) < 100) then
						{
						if (_eT) then
							{
							_sA set [2,false];
							}
						}
					}
				foreach _strArea
				}
			foreach _enAr
			};


		//_mark = "Main" + (str (random 1000));
		//_mark = [_mark,_mainPos,"ColorRed","ICON",[1,1],0,1,"mil_triangle","",_logic] call ALiVE_fnc_HAC_Marker;

		_attackAxis = [_ArmyPos,_mainPos,10,_logic] call ALiVE_fnc_HAC_AngTowards;
if ((true) and (true)) then
	{
		if (_logic getvariable "HAC_BB_Debug") then
			{
				{
				_posStr = _x select 0;
				_valStr = _x select 1;
				_taken = _x select 2;
				_mark = "StrArea" + (str (random 1000));
				_color = "ColorYellow";
				_alpha = 0.1;
				if ((_taken) and (_BBSide == "A")) then {_color = "ColorBlue";_alpha = 0.5};
				if ((_taken) and (_BBSide == "B")) then {_color = "ColorRed";_alpha = 0.5};
				_mark = [_mark,_posStr,_color,"ICON",[_valStr/2,_valStr/2],0,_alpha,"mil_dot",(str _valStr),_logic] call ALiVE_fnc_HAC_Marker;

				[_x,_mark,_BBSide,_logic] spawn ALiVE_fnc_HAC_ObjMark
				}
			foreach _strArea;
			};
};
		if (_logic getvariable "HAC_BB_Debug") then
			{
			_logic globalChat format ["Big Boss %1 orients the flanks.",_BBSide];
			diag_log format ["Big Boss %1 orients the flanks.",_BBSide]
			};

			{
			_isLeft = ([(getPosATL _x),_ArmyPos,_attackAxis,_logic] call ALiVE_fnc_HAC_WhereIs) select 0;
			(group _x) setVariable ["isLeft",_isLeft]
			}
		foreach _BBHQs;

			{
			_isLeft = ([(_x select 0),_ArmyPos,_attackAxis,_logic] call ALiVE_fnc_HAC_WhereIs) select 0;
			_x set [3,_isLeft]
			}
		foreach _strArea;



		_leftSectors = [];
		_rightSectors = [];
		_frontSectors = [];

			{
			_where = [(position _x),_ArmyPos,_attackAxis,_logic] call ALiVE_fnc_HAC_WhereIs;
			_isLeft = _where select 0;
			_isFlank = _where select 1;
			_isRear = _where select 2;

			if (_isLeft) then 
				{
				_leftSectors set [(count _leftSectors),_x]
				} 
			else 
				{
				_rightSectors set [(count _rightSectors),_x]
				};

			if not (_isFlank) then 
				{
				_frontSectors set [(count _frontSectors),_x]
				};

			_x setVariable [_isLeftName,_isLeft];
			_x setVariable [_isFlankName,_isFlank];
			_x setVariable [_isRearName,_isRear];
			}
		foreach _sectors;

		if (_logic getvariable "HAC_BB_Debug") then
			{
			_logic globalChat format ["Big Boss %1 assigns front sections to divisions.",_BBSide];
			diag_log format ["Big Boss %1 assigns front sections to divisions.",_BBSide]
			};

		_leftAn = [_leftSectors,_logic] call ALiVE_fnc_HAC_TopoAnalize;

		_leftSectors = _leftAn select 0;
		_leftInf = _leftAn select 1;
		_leftVeh = _leftAn select 2;

		_rightAn = [_rightSectors,_logic] call ALiVE_fnc_HAC_TopoAnalize;

		_rightSectors = _rightAn select 0;
		_rightInf = _rightAn select 1;
		_rightVeh = _rightAn select 2;

		_frontAn = [_frontSectors,_logic] call ALiVE_fnc_HAC_TopoAnalize;

		_frontSectors = _frontAn select 0;
		_frontInf = _frontAn select 1;
		_frontVeh = _frontAn select 2;

		_leftSANmbr = 0;
		_rightSANmbr = 0;
		_frontSANmbr = 0;
		_leftSA = [];
		_rightSA = [];
		_frontSA = [];

			{
			_where = [(_x select 0),_ArmyPos,_attackAxis,_logic] call ALiVE_fnc_HAC_WhereIs;
			_isLeft = _where select 0;
			_isFlank = _where select 1;
			_isRear = _where select 2;

			if (_isFlank) then
				{
				if (_isLeft) then 
					{
					_x set [3,_leftName];
					_leftSA set [(count _leftSA),_x];
					_leftSANmbr = _leftSANmbr + 1
					} 
				else 
					{
					_x set [3,_rightName];
					_rightSA set [(count _rightSA),_x];
					_rightSANmbr = _rightSANmbr + 1
					}
				}
			else
				{
				_x set [3,_frontName];
				_frontSA set [(count _frontSA),_x];
				_frontSANmbr = _frontSANmbr + 1
				}
			}
		foreach _strArea;

		_leftSpace = count _leftSectors;
		_rightSpace = count _rightSectors;
		_frontSpace = count _frontSectors;

		_LmaxSpace = false;
		_RmaxSpace = false;
		_FmaxSpace = false;

		_LmaxSA = false;
		_RmaxSA = false;
		_FmaxSA = false;

		_LmaxVeh = false;
		_RmaxVeh = false;
		_FmaxVeh = false;

		switch (true) do
			{
			case ((_leftSpace >= _rightSpace) and (_leftSpace >= _frontSpace)) : {_LmaxSpace = true};
			case ((_rightSpace >= _leftSpace) and (_rightSpace >= _frontSpace)) : {_RmaxSpace = true};
			case ((_frontSpace >= _leftSpace) and (_frontSpace >= _rightSpace)) : {_FmaxSpace = true};
			};

		switch (true) do
			{
			case (((count _leftSA) >= (count _rightSA)) and ((count _leftSA) >= (count _frontSA))) : {_LmaxSA = true};
			case (((count _rightSA) >= (count _leftSA)) and ((count _rightSA) >= (count _frontSA))) : {_RmaxSA = true};
			case (((count _frontSA) >= (count _leftSA)) and ((count _frontSA) >= (count _rightSA))) : {_FmaxSA = true};
			};

		switch (true) do
			{
			case ((_leftVeh >= _rightVeh) and (_leftVeh >= _frontVeh)) : {_LmaxVeh = true};
			case ((_rightVeh >= _leftVeh) and (_rightVeh >= _frontVeh)) : {_RmaxVeh = true};
			case ((_frontVeh >= _leftVeh) and (_frontVeh >= _rightVeh)) : {_FmaxVeh = true};
			};

		missionNamespace setVariable [_leftFlankName,[_leftSectors,_LmaxSpace,_LmaxSA,_LmaxVeh,_leftSpace,_leftSA,_leftInf,_leftVeh]];
		missionNamespace setVariable [_rightFlankName,[_rightSectors,_RmaxSpace,_RmaxSA,_RmaxVeh,_rightSpace,_rightSA,_rightInf,_rightVeh]];
		missionNamespace setVariable [_centerFrontName,[_frontSectors,_FmaxSpace,_FmaxSA,_FmaxVeh,_frontSpace,_frontSA,_frontInf,_frontVeh]];

		_lFlank = missionNamespace getVariable _leftFlankName;
		_rFlank = missionNamespace getVariable _rightFlankName;
		_cFront = missionNamespace getVariable _centerFrontName;

		_flSMaxStr = _leftFlankName;
		_flSpace = (missionNamespace getVariable _leftFlankName) select 1;

		if not (_flSpace) then
			{
				{
				_fl = missionNamespace getVariable _x;
				_spaceF = _fl select 1;
				if (_spaceF) exitWith {_flSMaxStr = _x}
				}
			foreach [_rightFlankName,_centerFrontName];
			};

		_flSAMaxStr = _leftFlankName;
		_flSA = (missionNamespace getVariable _leftFlankName) select 2;

		if not (_flSA) then
			{
				{
				_fl = missionNamespace getVariable _x;
				_SAF = _fl select 2;
				if (_SAF) exitWith {_flSAMaxStr = _x}
				}
			foreach [_rightFlankName,_centerFrontName];
			};

		_flVMaxStr = _leftFlankName;
		_flVeh = (missionNamespace getVariable _leftFlankName) select 3;

		if not (_flVeh) then
			{
				{
				_fl = missionNamespace getVariable _x;
				_vehF = _fl select 3;
				if (_vehF) exitWith {_flVMaxStr = _x}
				}
			foreach [_rightFlankName,_centerFrontName];
			};



		_vehAll = 0;

			{
			_ldrRep = ((group _x) getVariable "ForceRep") select 0;
			_forceChar = _ldrRep select 5;
			_vehPerc = (_forceChar select 1) + (_forceChar select 2) + (_forceChar select 3);

			_vehAll = _vehAll + _vehPerc
			}
		foreach _BBHQs;

		_vehAv = _vehAll/(count _BBHQs);

		_moreVehHQ = [];

			{
			_ldrRep = ((group _x) getVariable "ForceRep") select 0;
			_forceChar = _ldrRep select 5;
			_vehPerc = (_forceChar select 1) + (_forceChar select 2) + (_forceChar select 3);

			if (_vehPerc >= _vehAv) then 
				{
				_moreVehHQ set [(count _moreVehHQ),_x];
				(group _x) setVariable ["ForceProfile","V"]
				}
			else
				{
				(group _x) setVariable ["ForceProfile","I"]
				}
			}
		foreach _BBHQs;

		_numAll = 0;

			{
			_ldrRep = ((group _x) getVariable "ForceRep") select 0;
			_forceNum = _ldrRep select 1;

			_numAll = _numAll + _forceNum
			}
		foreach _BBHQs;

		_numAv = _numAll/(count _BBHQs);

		_moreNumHQ = [];

			{
			_ldrRep = ((group _x) getVariable "ForceRep") select 0;
			_forceNum = _ldrRep select 1;

			if (_forceNum >= _numAv) then 
				{
				_moreNumHQ set [(count _moreNumHQ),_x];
				(group _x) setVariable ["NumProfile","A"]
				}
			else
				{
				(group _x) setVariable ["NumProfile","B"]
				}

			}
		foreach _BBHQs;

		_goingLeft = [];
		_goingRight = [];
		_goingAhead = [];

		_allCount = count (_BBHQs);
		_resCount = floor ((count (_BBHQs))/3);

		_actCount = _allCount - _resCount;

		_flankCount = floor (2 * (_actCount/3));

		_centerCount = _actCount - _flankCount;

		_restHQ = _BBHQs - (_moreVehHQ + _moreNumHQ);

		_goingReserve = [];
		
		_resCand = [];

			{
			if (((group _x) getVariable ["ForceProfile","V"]) == "I") then {_resCand set [(count _resCand),_x]}
			}
		foreach _moreNumHQ;
		
		while {(_resCount > 0)} do
			{

			if (((count _resCand) > 0) and ((random 100) < 90)) then
				{
				_ldr = _resCand select (floor (random (count _resCand)));

				_goingReserve set [(count _goingReserve),_ldr];
				_moreVehHQ = _moreVehHQ - [_ldr];
				_moreNumHQ = _moreNumHQ - [_ldr];
				_resCand = _resCand - [_ldr];
				_resCount = _resCount - 1;

				};

			if (_resCount <= 0) exitWith {};

			_ldr = (_BBHQs - _goingReserve) select (floor (random (count (_BBHQs - _goingReserve))));

			_goingReserve set [(count _goingReserve),_ldr];
			_moreVehHQ = _moreVehHQ - [_ldr];
			_moreNumHQ = _moreNumHQ - [_ldr];
			_resCand = _resCand - [_ldr];
			_resCount = _resCount - 1;
			};
	
		if not (_allAreTaken) then
			{
			if ((count _BBHQs) > 1) then
				{
				if (((count _moreVehHQ) > 0) and ((random 100) < 90)) then
					{
					_ldr = _moreVehHQ select (floor (random (count _moreVehHQ)));
					switch (_flVMaxStr) do
						{
						case (_leftFlankName) : 
							{
							_goingLeft set [(count _goingLeft),_ldr];
							_moreVehHQ = _moreVehHQ - [_ldr];
							_moreNumHQ = _moreNumHQ - [_ldr];
							_flankCount = _flankCount - 1;
							};

						case (_rightFlankName) : 
							{
							_goingRight set [(count _goingRight),_ldr];
							_moreVehHQ = _moreVehHQ - [_ldr];
							_moreNumHQ = _moreNumHQ - [_ldr];
							_flankCount = _flankCount - 1
							};

						case (_centerFrontName) : 
							{
							_goingAhead set [(count _goingAhead),_ldr];
							_moreVehHQ = _moreVehHQ - [_ldr];
							_moreNumHQ = _moreNumHQ - [_ldr];
							_centerCount = _centerCount - 1
							};
						};
					};

				if (((count _moreNumHQ) > 0) and ((random 100) < 90)) then
					{
					_ldr = _moreNumHQ select (floor (random (count _moreNumHQ)));
					switch (_flSAMaxStr) do
						{
						case (_leftFlankName) : 
							{
							_goingLeft set [(count _goingLeft),_ldr];
							_moreVehHQ = _moreVehHQ - [_ldr];
							_moreNumHQ = _moreNumHQ - [_ldr];
							_flankCount = _flankCount - 1;
							};

						case (_rightFlankName) : 
							{
							_goingRight set [(count _goingRight),_ldr];
							_moreVehHQ = _moreVehHQ - [_ldr];
							_moreNumHQ = _moreNumHQ - [_ldr];
							_flankCount = _flankCount - 1
							};

						case (_centerFrontName) : 
							{
							_goingAhead set [(count _goingAhead),_ldr];
							_moreVehHQ = _moreVehHQ - [_ldr];
							_moreNumHQ = _moreNumHQ - [_ldr];
							_centerCount = _centerCount - 1
							};
						};
					};

				_allFree = +(_BBHQs - (_goingReserve + _goingLeft + _goingRight + _goingAhead));

					{
					_ldr = _x;
					_rndF = random 100;

					_flankOne = _leftFlankName;
					_goingOne = _goingLeft;
					_flankTwo = _rightFlankName;
					_goingTwo = _goingRight;

					if ((random 100) >= 50) then 
						{
						_flankOne = _rightFlankName;
						_goingOne = _goingRight;
						_flankTwo = _leftFlankName;
						_goingTwo = _goingLeft;
						};

					switch (true) do
						{
						case ((_ldr in _moreVehHQ) and (_ldr in _moreNumHQ) and (_rndF < 90)) : 
							{
							switch (true) do
								{
								case ((((_flVMaxStr == _flankOne) and (((count _goingOne) <= (count _goingTwo)) or ((random 100) < 10))) or (((count _goingOne) == 0) and ((count _goingTwo) > 0) and ((random 100) > 75))) and (_flankCount > 0)) : 
									{
									_goingOne set [(count _goingOne),_ldr];
									_moreVehHQ = _moreVehHQ - [_ldr];
									_moreNumHQ = _moreNumHQ - [_ldr];
									_flankCount = _flankCount - 1;
									};

								case ((((_flVMaxStr == _flankTwo) and (((count _goingTwo) <= (count _goingOne)) or ((random 100) < 10))) or (((count _goingTwo) == 0) and ((count _goingOne) > 0) and ((random 100) > 75))) and (_flankCount > 0)) : 
									{
									_goingTwo set [(count _goingTwo),_ldr];
									_moreVehHQ = _moreVehHQ - [_ldr];
									_moreNumHQ = _moreNumHQ - [_ldr];
									_flankCount = _flankCount - 1
									};

								case ((_centerCount > 0) and ((count _moreNumHQ) == 0)) : 
									{
									_goingAhead set [(count _goingAhead),_ldr];
									_moreVehHQ = _moreVehHQ - [_ldr];
									_moreNumHQ = _moreNumHQ - [_ldr];
									_centerCount = _centerCount - 1
									};

								case ((((_flSAMaxStr == _flankOne) and (((count _goingOne) <= (count _goingTwo)) or ((random 100) < 10))) or (((count _goingOne) == 0) and ((count _goingTwo) > 0) and ((random 100) > 75))) and (_flankCount > 0)) : 
									{
									_goingOne set [(count _goingOne),_ldr];
									_moreVehHQ = _moreVehHQ - [_ldr];
									_moreNumHQ = _moreNumHQ - [_ldr];
									_flankCount = _flankCount - 1;
									};

								case ((((_flSAMaxStr == _flankTwo) and (((count _goingTwo) <= (count _goingOne)) or ((random 100) < 10))) or (((count _goingTwo) == 0) and ((count _goingOne) > 0) and ((random 100) > 75))) and (_flankCount > 0)) : 
									{
									_goingTwo set [(count _goingTwo),_ldr];
									_moreVehHQ = _moreVehHQ - [_ldr];
									_moreNumHQ = _moreNumHQ - [_ldr];
									_flankCount = _flankCount - 1
									};

								case (_centerCount > 0) : 
									{
									_goingAhead set [(count _goingAhead),_ldr];
									_moreVehHQ = _moreVehHQ - [_ldr];
									_moreNumHQ = _moreNumHQ - [_ldr];
									_centerCount = _centerCount - 1
									};

								default 
									{
									_rndF = random 100;

									if (_rndF < 50) then
										{
										_goingLeft set [(count _goingLeft),_ldr];
										_moreVehHQ = _moreVehHQ - [_ldr];
										_moreNumHQ = _moreNumHQ - [_ldr];
										_flankCount = _flankCount - 1;
										}
									else
										{
										_goingRight set [(count _goingRight),_ldr];
										_moreVehHQ = _moreVehHQ - [_ldr];
										_moreNumHQ = _moreNumHQ - [_ldr];
										_flankCount = _flankCount - 1
										}
									};
								};
							};

						case ((_ldr in _moreVehHQ) and (_rndF < 90)) : 
							{

							switch (true) do
								{
								case ((((_flVMaxStr == _flankOne) and (((count _goingOne) <= (count _goingTwo)) or ((random 100) < 10))) or (((count _goingOne) == 0) and ((count _goingTwo) > 0) and ((random 100) > 75))) and (_flankCount > 0)) : 
									{
									_goingOne set [(count _goingOne),_ldr];
									_moreVehHQ = _moreVehHQ - [_ldr];
									_moreNumHQ = _moreNumHQ - [_ldr];
									_flankCount = _flankCount - 1;
									};

								case ((((_flVMaxStr == _flankTwo) and (((count _goingTwo) <= (count _goingOne)) or ((random 100) < 10))) or (((count _goingTwo) == 0) and ((count _goingOne) > 0) and ((random 100) > 75))) and (_flankCount > 0)) : 
									{
									_goingTwo set [(count _goingTwo),_ldr];
									_moreVehHQ = _moreVehHQ - [_ldr];
									_moreNumHQ = _moreNumHQ - [_ldr];
									_flankCount = _flankCount - 1
									};

								case (_centerCount > 0) : 
									{
									_goingAhead set [(count _goingAhead),_ldr];
									_moreVehHQ = _moreVehHQ - [_ldr];
									_moreNumHQ = _moreNumHQ - [_ldr];
									_centerCount = _centerCount - 1
									};

								default 
									{
									_rndF = random 100;

									if (_rndF < 50) then
										{
										_goingLeft set [(count _goingLeft),_ldr];
										_moreVehHQ = _moreVehHQ - [_ldr];
										_moreNumHQ = _moreNumHQ - [_ldr];
										_flankCount = _flankCount - 1;
										}
									else
										{
										_goingRight set [(count _goingRight),_ldr];
										_moreVehHQ = _moreVehHQ - [_ldr];
										_moreNumHQ = _moreNumHQ - [_ldr];
										_flankCount = _flankCount - 1
										}
									};
								};
							};

						case ((_ldr in _moreNumHQ) and (_rndF < 90)) : 
							{

							switch (true) do
								{
								case ((((_flSAMaxStr == _flankOne) and (((count _goingOne) <= (count _goingTwo)) or ((random 100) < 10))) or (((count _goingOne) == 0) and ((count _goingTwo) > 0) and ((random 100) > 75))) and (_flankCount > 0)) : 
									{
									_goingOne set [(count _goingOne),_ldr];
									_moreVehHQ = _moreVehHQ - [_ldr];
									_moreNumHQ = _moreNumHQ - [_ldr];
									_flankCount = _flankCount - 1;
									};

								case ((((_flSAMaxStr == _flankTwo) and (((count _goingTwo) <= (count _goingOne)) or ((random 100) < 10))) or (((count _goingTwo) == 0) and ((count _goingOne) > 0) and ((random 100) > 75))) and (_flankCount > 0)) : 
									{
									_goingTwo set [(count _goingTwo),_ldr];
									_moreVehHQ = _moreVehHQ - [_ldr];
									_moreNumHQ = _moreNumHQ - [_ldr];
									_flankCount = _flankCount - 1
									};

								case (_centerCount > 0) : 
									{
									_goingAhead set [(count _goingAhead),_ldr];
									_moreVehHQ = _moreVehHQ - [_ldr];
									_moreNumHQ = _moreNumHQ - [_ldr];
									_centerCount = _centerCount - 1
									};

								default 
									{
									_rndF = random 100;

									if (_rndF < 50) then
										{
										_goingLeft set [(count _goingLeft),_ldr];
										_moreVehHQ = _moreVehHQ - [_ldr];
										_moreNumHQ = _moreNumHQ - [_ldr];
										_flankCount = _flankCount - 1;
										}
									else
										{
										_goingRight set [(count _goingRight),_ldr];
										_moreVehHQ = _moreVehHQ - [_ldr];
										_moreNumHQ = _moreNumHQ - [_ldr];
										_flankCount = _flankCount - 1
										}
									};
								};
							};

						default 
							{
							if ((({((_x in _moreVehHQ) or (_x in _moreNumHQ))} count (_BBHQs - _goingReserve)) < (_flankCount + _centerCount)) or (_rndF >= 90)) then
								{
								_rndF = random 100;

								switch (true) do
									{
									case (_rndF < 33) :
										{
										_goingLeft set [(count _goingLeft),_ldr];
										_moreVehHQ = _moreVehHQ - [_ldr];
										_moreNumHQ = _moreNumHQ - [_ldr];
										_flankCount = _flankCount - 1;
										};

									case (_rndF < 66) :
										{ 
										_goingRight set [(count _goingRight),_ldr];
										_moreVehHQ = _moreVehHQ - [_ldr];
										_moreNumHQ = _moreNumHQ - [_ldr];
										_flankCount = _flankCount - 1
										};

									default 
										{
										_goingAhead set [(count _goingAhead),_ldr];
										_moreVehHQ = _moreVehHQ - [_ldr];
										_moreNumHQ = _moreNumHQ - [_ldr];
										_centerCount = _centerCount - 1
										};
									}
								}
							};
						};
					}
				foreach _allFree;

				if ((count (_BBHQs - (_goingReserve + _goingLeft + _goingRight + _goingAhead))) > 0) then 
					{

						{
						_ldr = _x;
						if (_flankCount > 0) then 
							{
							_rndF = random 100;

							switch (true) do
								{
								case (_rndF < 50) :
									{
									_goingLeft set [(count _goingLeft),_ldr];
									_moreVehHQ = _moreVehHQ - [_ldr];
									_moreNumHQ = _moreNumHQ - [_ldr];
									_flankCount = _flankCount - 1;
									};

								case (_rndF >= 50) :
									{ 
									_goingRight set [(count _goingRight),_ldr];
									_moreVehHQ = _moreVehHQ - [_ldr];
									_moreNumHQ = _moreNumHQ - [_ldr];
									_flankCount = _flankCount - 1
									};
								}
							}
						else
							{
							_goingAhead set [(count _goingAhead),_ldr];
							_moreVehHQ = _moreVehHQ - [_ldr];
							_moreNumHQ = _moreNumHQ - [_ldr];
							_centerCount = _centerCount - 1
							}
						}
					foreach (_BBHQs - (_goingReserve + _goingLeft + _goingRight + _goingAhead))
					}
				}
			else
				{
				_goingAhead set [(count _goingAhead),(_BBHQs select 0)];
				_centerCount = _centerCount - 1
				}
			}
		else
			{
			for "_i" from 0 to (_actCount - 1) do
				{
				_ldr = _BBHQs select _i;
				_goingAhead set [(count _goingAhead),_ldr]
				}
			};

		if (_logic getvariable "HAC_BB_Debug") then
			{
			_logic globalChat format ["Assignment of Big Boss %5 : Left: %1 Right: %2 Front: %3 Reserve: %4",_goingLeft,_goingRight,_goingAhead,_goingReserve,_BBSide];
			diag_log format ["Assignment of Big Boss %5 : Left: %1 Right: %2 Front: %3 Reserve: %4",_goingLeft,_goingRight,_goingAhead,_goingReserve,_BBSide];
			};

		if (((_logic getvariable "HAC_BBa_SimpleDebug") and (_BBSide == "A")) or ((_logic getvariable "HAC_BBb_SimpleDebug") and (_BBSide == "B"))) then {[_BBHQs,_BBSide,_logic] spawn ALiVE_fnc_HAC_BBSimpleD};
		};

	if (_logic getvariable "HAC_BB_Debug") then
		{
		_logic globalChat format ["Big Boss %1 issues orders.",_BBSide];
		diag_log format ["Big Boss %1 issues orders.",_BBSide];
		};

	_goingReserve0 = _goingReserve;

		{
		_aliveHQ = true;
		if not (alive _x) then {_aliveHQ = false};
		if (isNull _x) then {_aliveHQ = false};
		if not (_aliveHQ) then {_goingReserve = _goingReserve - [_x]};
		}
	foreach _goingReserve0;

	if ((count _goingReserve) > 0) then
		{
		_lastGLeft = _goingLeft;
		_lastGRight = _goingRight;
		_lastGAhead = _goingAhead;

		_lastGLeftN = count _goingLeft;
		_lastGRightN = count _goingRight;
		_lastGAheadN = count _goingAhead;

			{
			_aliveHQ = true;
			if not (alive _x) then {_aliveHQ = false};
			if (isNull _x) then {_aliveHQ = false};
			if not (_aliveHQ) then {_goingAhead = _goingAhead - [_x]};
			}
		foreach _lastGAhead;

		if ((count _goingAhead) < _lastGAheadN) then
			{
			if ((count _goingReserve) > 0) then 
				{
				_newL = _goingReserve select 0;
				_goingReserve = _goingReserve - [_newL];
				_goingAhead set [(count _goingAhead),_newL];
				}
			};

			{
			_aliveHQ = true;
			if not (alive _x) then {_aliveHQ = false};
			if (isNull _x) then {_aliveHQ = false};
			if not (_aliveHQ) then {_goingLeft = _goingLeft - [_x]};
			}
		foreach _lastGLeft;

		if ((count _goingLeft) <  _lastGLeftN) then
			{
			if ((count _goingReserve) > 0) then 
				{
				_newL = _goingReserve select 0;
				_goingReserve = _goingReserve - [_newL];
				_goingLeft set [(count _goingLeft),_newL];
				}
			};

			{
			_aliveHQ = true;
			if not (alive _x) then {_aliveHQ = false};
			if (isNull _x) then {_aliveHQ = false};
			if not (_aliveHQ) then {_goingRight = _goingRight - [_x]};
			}
		foreach _lastGRight;

		if ((count _goingRight) < _lastGRightN) then
			{
			if ((count _goingReserve) > 0) then 
				{
				_newL = _goingReserve select 0;
				_goingReserve = _goingReserve - [_newL];
				_goingRight set [(count _goingRight),_newL];
				}
			};
		};

	_stnc = _stance;
	_nilStance = isNil "_stance";
	_stance = "N";
	if (_nilStance) then {_stance = "O"} else {_stance = _stnc};

	_losses = 0;
	_currentNumber = 0;
	_ownVal = 0;

	for "_i" from 0 to ((count (_ForcesRep select 0)) - 2) do
		{
		_actRep = (_ForcesRep select 0) select _i;
		_losses = _losses - (_actRep select 2);
		_currentNumber = _currentNumber + (_actRep select 1);
		_ownVal = _ownVal + (_actRep select 3)
		};

	_enemyVal = 0;

	for "_i" from 0 to ((count (_ForcesRep select 1)) - 2) do
		{
		_actRep = (_ForcesRep select 1) select _i;
		_enemyVal = _enemyVal + (_actRep select 1)
		};

	_inert = 1;

	if (_stance == "D") then {_inert = 1.2};
	//if (_stance == "O") then {_inert = 0.8};

	_enemyFactor = _ownVal/((_enemyVal + 1) * _inert);
	_lossesFactor = (_losses/(_currentNumber + 1)) * _inert;


	if (_logic getvariable "HAC_BB_Debug") then
		{
		_logic globalChat format ["Side: %7 - Losses: %1 Number: %2 Value: %3 enValue: %4 enFactor: %5 lossFactor: %6",_losses,_currentNumber,_ownVal,_enemyVal,_enemyFactor,_lossesFactor,_BBSide];
		diag_log format ["Side: %7 - Losses: %1 Number: %2 Value: %3 enValue: %4 enFactor: %5 lossFactor: %6",_losses,_currentNumber,_ownVal,_enemyVal,_enemyFactor,_lossesFactor,_BBSide];
		};

	if ((_enemyFactor < (0.5 + (random 0.25))) or (_lossesFactor > (0.4 + (random 0.4))) or (_allAreTaken)) then
		{
		_stance = "D";

			{
			_aliveHQ = true;
			if (isNull _x) then {_aliveHQ = false};
			if not (alive _x) then {_aliveHQ = false};

			if (_aliveHQ) then
				{
				_front = _logic getvariable "FrontA";
				_tObj1 = _logic getvariable "HAC_HQ_Obj1";
				_tObj2 = _logic getvariable "HAC_HQ_Obj2";
				_tObj3 = _logic getvariable "HAC_HQ_Obj3";
				_tObj4 = _logic getvariable "HAC_HQ_Obj4";
				_knEnemy = _logic getvariable "HAC_HQ_KnEnPos";

				switch (_x) do
					{
					case (_logic) : 
						{
						_logic setvariable ["HAC_HQ_Order", "DEFEND"];
						_logic setvariable ["HAC_HQ_NObj", 5];
						_front = _logic getvariable "FrontA";
						_tObj1 = _logic getvariable "HAC_HQ_Obj1";
						_tObj2 = _logic getvariable "HAC_HQ_Obj2";
						_tObj3 = _logic getvariable "HAC_HQ_Obj3";
						_tObj4 = _logic getvariable "HAC_HQ_Obj4";
						_knEnemy = _logic getvariable "HAC_HQ_KnEnPos";
						};
					};

				_perDirPos = _mainPos;
				_actT = (group _x) getVariable "ActualTarget";
				if not (isNil "_actT") then {_perDirPos = _actT select 0};
				if not ((count _knEnemy) == 0) then
					{
					_dpX = 0;
					_dpY = 0;

						{
						_dpX = _dpX + (_x select 0);
						_dpY = _dpY + (_x select 1)
						}
					foreach _knEnemy;

					_dpX = _dpX/(count _knEnemy);
					_dpY = _dpY/(count _knEnemy);

					_perDirPos = [_dpX,_dpY,0];
					};

				_HQ = _x;

				_HQPos = getPosATL (vehicle _HQ);

				_dirAdd = -60;

					{
					_angle = [_HQPos,_perDirPos,10,_logic] call ALiVE_fnc_HAC_AngTowards;
					_angle = _angle + _dirAdd;

					_dirAdd = _dirAdd + 40;

					_perPos = [_HQPos,_angle,(350 + (random 100)),_logic] call ALiVE_fnc_HAC_PosTowards2D;

					_perX = _perPos select 0;
					_perY = _perPos select 1;

					_x setPosATL [_perX,_perY,0];

					//_mark = [(str (random 1000)),[_perX,_perY,0],"ColorPink","ICON",[0.5,0.5],0,1,"mil_dot",(str _HQ),_logic] call ALiVE_fnc_HAC_Marker;
					}
				foreach [_tObj1,_tObj2,_tObj3,_tObj4];

				[_front,_HQPos,_perDirPos,1500,_logic] call ALiVE_fnc_HAC_LocLineTransform;
				}
			}
		foreach (_goingLeft + _goingRight + _goingAhead)
		}
	else
		{
		_stance = "O";
		_leftNotTaken = [];

			{
			_tkn = _x select 2;
			if not (_tkn) then {_leftNotTaken set [(count _leftNotTaken),_x]}
			}
		foreach _leftSA;

		_rightNotTaken = [];

			{
			_tkn = _x select 2;
			if not (_tkn) then {_rightNotTaken set [(count _rightNotTaken),_x]}
			}
		foreach _rightSA;

		_frontNotTaken = [];

			{
			_tkn = _x select 2;
			if not (_tkn) then {_frontNotTaken set [(count _frontNotTaken),_x]}
			}
		foreach _frontSA;

			{
			_notTaken = _leftNotTaken;
			if ((count _notTaken) == 0) then {_notTaken = _frontNotTaken};
			if ((count _notTaken) == 0) then {_notTaken = _rightNotTaken};

			_fPos = getPosATL (vehicle _x);

			if ((count _notTaken) == 0) exitWith {(group _x) setVariable ["ActualTarget",[_fPos,1,false,"Zero"]]};

			_chosenT = _notTaken select 0;
			_indx = 0;
			_cPos = _chosenT select 0;
			_cVal = _chosenT select 1;
			_cTaken = _chosenT select 2;
			_dstFC = _fPos distance _cPos;
			_tempMax = 0;
			if (_dstFC > 0) then {_tempMax = _cVal/((_dstFC/1000) * (_dstFC/1000))};

			for "_i" from 1 to ((count _notTaken) - 1) do
				{
				_actT = _notTaken select _i;

				_cPos = _actT select 0;
				_cVal = _actT select 1;
				_cTaken = _actT select 2;
				_dstFC = _fPos distance _cPos;
				_tempAct = 0;
				if (_dstFC > 0) then {_tempAct = (_cVal/((_dstFC/1000) * (_dstFC/1000))) * (0.5 + (random 0.5) + (random 0.5))};

				if (_tempAct > _tempMax) then {_chosenT = _actT;_tempMax = _tempAct;_indx = _i};
				};

			(group _x) setVariable ["ActualTarget",_chosenT];

			if ((count _leftNotTaken) > 0) then 
				{
				_leftNotTaken set [_indx,"ToDelete"]; 
				_leftNotTaken = _leftNotTaken - ["ToDelete"]
				}
			else
				{
				if ((count _frontNotTaken) > 0) then 
					{
					_frontNotTaken set [_indx,"ToDelete"]; 
					_frontNotTaken = _frontNotTaken - ["ToDelete"]
					}
				else
					{
					if ((count _rightNotTaken) > 0) then 
						{
						_rightNotTaken set [_indx,"ToDelete"]; 
						_rightNotTaken = _rightNotTaken - ["ToDelete"]
						}
					}
				}
			}
		foreach _goingLeft;

			{
			_notTaken = _rightNotTaken;
			if ((count _notTaken) == 0) then {_notTaken = _frontNotTaken};
			if ((count _notTaken) == 0) then {_notTaken = _leftNotTaken};

			_fPos = getPosATL (vehicle _x);

			if ((count _notTaken) == 0) exitWith {(group _x) setVariable ["ActualTarget",[_fPos,1,false,"Zero"]]};

			_chosenT = _notTaken select 0;
			_indx = 0;
			_cPos = _chosenT select 0;
			_cVal = _chosenT select 1;
			_cTaken = _chosenT select 2;
			_dstFC = _fPos distance _cPos;
			_tempMax = 0;
			if (_dstFC > 0) then {_tempMax = _cVal/((_dstFC/1000) * (_dstFC/1000))};

			for "_i" from 1 to ((count _notTaken) - 1) do
				{
				_actT = _notTaken select _i;

				_cPos = _actT select 0;
				_cVal = _actT select 1;
				_cTaken = _actT select 2;
				_dstFC = _fPos distance _cPos;
				_tempAct = 0;
				if (_dstFC > 0) then {_tempAct = (_cVal/((_dstFC/1000) * (_dstFC/1000))) * (0.5 + (random 0.5) + (random 0.5))};

				if (_tempAct > _tempMax) then {_chosenT = _actT;_tempMax = _tempAct;_indx = _i};
				};

			(group _x) setVariable ["ActualTarget",_chosenT];

			if ((count _rightNotTaken) > 0) then 
				{
				_rightNotTaken set [_indx,"ToDelete"]; 
				_rightNotTaken = _rightNotTaken - ["ToDelete"]
				}
			else
				{
				if ((count _frontNotTaken) > 0) then 
					{
					_frontNotTaken set [_indx,"ToDelete"]; 
					_frontNotTaken = _frontNotTaken - ["ToDelete"]
					}
				else
					{
					if ((count _leftNotTaken) > 0) then 
						{
						_leftNotTaken set [_indx,"ToDelete"]; 
						_leftNotTaken = _leftNotTaken - ["ToDelete"]
						}
					}
				}
			}
		foreach _goingRight;

			{
			_notTaken = _frontNotTaken;
			if ((count _notTaken) == 0) then {_notTaken = _leftNotTaken};
			if ((count _notTaken) == 0) then {_notTaken = _rightNotTaken};
			_fPos = getPosATL (vehicle _x);

			if ((count _notTaken) == 0) exitWith {(group _x) setVariable ["ActualTarget",[_fPos,1,false,"Zero"]]};

			_chosenT = _notTaken select 0;

			_indx = 0;
			_cPos = _chosenT select 0;
			_cVal = _chosenT select 1;
			_cTaken = _chosenT select 2;
			_dstFC = _fPos distance _cPos;
			_tempMax = 0;
			if (_dstFC > 0) then {_tempMax = _cVal/((_dstFC/1000) * (_dstFC/1000))};


			for "_i" from 1 to ((count _notTaken) - 1) do
				{
				_actT = _notTaken select _i;

				_cPos = _actT select 0;
				_cVal = _actT select 1;
				_cTaken = _actT select 2;
				_dstFC = _fPos distance _cPos;
				_tempAct = 0;
				if (_dstFC > 0) then {_tempAct = (_cVal/((_dstFC/1000) * (_dstFC/1000))) * (0.5 + (random 0.5) + (random 0.5))};

				if (_tempAct > _tempMax) then {_chosenT = _actT;_tempMax = _tempAct;_indx = _i};
				};

			(group _x) setVariable ["ActualTarget",_chosenT];

			if ((count _frontNotTaken) > 0) then 
				{
				_frontNotTaken set [_indx,"ToDelete"]; 
				_frontNotTaken = _frontNotTaken - ["ToDelete"]
				}
			else
				{
				if ((count _leftNotTaken) > 0) then 
					{
					_leftNotTaken set [_indx,"ToDelete"]; 
					_leftNotTaken = _leftNotTaken - ["ToDelete"]
					}
				else
					{
					if ((count _rightNotTaken) > 0) then 
						{
						_rightNotTaken set [_indx,"ToDelete"]; 
						_rightNotTaken = _rightNotTaken - ["ToDelete"]
						}
					}
				}
			}
		foreach _goingAhead;

			{
				{
				_aliveHQ = true;
				if (isNull _x) then {_aliveHQ = false};
				if not (alive _x) then {_aliveHQ = false};

				if (_aliveHQ) then
					{
					_pathDone = (group _x) getVariable "PathDone";
					if (isNil "_pathDone") then {_pathDone = true};		

					if (_pathDone) then
						{
						_front = _logic getvariable "FrontA";
						_tObj1 = _logic getvariable "HAC_HQ_Obj1";
						_tObj2 = _logic getvariable "HAC_HQ_Obj2";
						_tObj3 = _logic getvariable "HAC_HQ_Obj3";
						_tObj4 = _logic getvariable "HAC_HQ_Obj4";

						switch (_x) do
							{
							case (_logic) : 
								{
								_logic setvariable ["HAC_HQ_Order", "ATTACK"];
								_front = _logic getvariable "FrontA";
								_tObj1 = _logic getvariable "HAC_HQ_Obj1";
								_tObj2 = _logic getvariable "HAC_HQ_Obj2";
								_tObj3 = _logic getvariable "HAC_HQ_Obj3";
								_tObj4 = _logic getvariable "HAC_HQ_Obj4";
								};
							};

						_areas = _leftNotTaken; 
						_sctrs = _leftSectors;

						switch (true) do
							{
							case (_x in _goingRight) : {_areas = _rightNotTaken;_sctrs = _rightSectors};
							case (_x in _goingAhead) : {_areas = _frontNotTaken;_sctrs = _frontSectors};
							};

						if ((count _areas) == 0) then {_areas = (_leftNotTaken + _rightNotTaken + _frontNotTaken)};

						_acT = (group _x) getVariable "ActualTarget";

						_areas = _areas + [_acT];

						_acT = _acT select 0;

						_HQpos = getPosATL (vehicle _x);

						_pathRep = [_sctrs,_areas,_HQpos,_acT,_BBSide,_logic] call ALiVE_fnc_HAC_Itinerary;

						_secsAround = _pathRep select 0;
						_tgtsAround = _pathRep select 1;

						_points = [];

							{
							_points set [(count _points),_x select 0]
							}
						foreach _tgtsAround;

							{
							_points set [(count _points),_x]
							}
						foreach [_HQpos,_acT];
					
						[_front,_points,1200,_logic] call ALiVE_fnc_HAC_LocMultiTransform;

						[_x,_tgtsAround,_tObj1,_tObj2,_tObj3,_tObj4,_BBHQs,_HQpos,_front,_secsAround,_goingReserve,_BBSide,_logic] spawn ALiVE_fnc_HAC_ExecutePath;
						waitUntil
							{
							sleep 0.01;
							_initD = (group _x) getVariable "ObjInit";
							if (isNil "_initD") then {_initD = false};
							(_initD)
							};
						}
					}
				}
			foreach _x
			}
		foreach [_goingLeft,_goingRight,_goingAhead]
		};

	_points = [];

		{
		_tkn = _x select 2;
		if (_tkn) then {_points set [(count _points),_x]}
		}
	foreach _strArea;

	_HQpoints = [];

		{
		_HQpoints set [(count _HQpoints),getPosATL (vehicle _x)]
		}
	foreach _BBHQs;

		{
		_aliveHQ = true;
		if (isNull _x) then {_aliveHQ = false};
		if not (alive _x) then {_aliveHQ = false};

		if (_aliveHQ) then
			{
			_front = _logic getvariable "FrontA";
			_tObj1 = _logic getvariable "HAC_HQ_Obj1";
			_tObj2 = _logic getvariable "HAC_HQ_Obj2";
			_tObj3 = _logic getvariable "HAC_HQ_Obj3";
			_tObj4 = _logic getvariable "HAC_HQ_Obj4";

			_takenPoints = _points;

			_points = [];

				{
				_points set [(count _points),(_x select 0)]
				}
			foreach _takenPoints;

			_points = _points + _HQpoints;
	/*
				{
				_mark = [(str (random 1000)),_x,"ColorOrange","ICON",[0.5,0.5],0,1,"mil_dot","R",_logic] call ALiVE_fnc_HAC_Marker;
				}
			foreach _points;
	*/
			[_front,_points,1000,_logic] call ALiVE_fnc_HAC_LocMultiTransform;

			[_x,_goingAhead,_tObj1,_tObj2,_tObj3,_tObj4,_BBHQs,_front,_takenPoints,_hostileGroups,_BBSide,_logic] spawn ALiVE_fnc_HAC_ReserveExecuting;

			waitUntil
				{
				sleep 0.01;
				_initD = (group _x) getVariable "ObjInit";
				if (isNil "_initD") then {_initD = false};
				(_initD)
				};
			}
		}
	foreach _goingReserve;

	if (_BBcycle == 1) then
		{
		if (_BBSide == "A") then {_logic setvariable ["HAC_BBa_InitDone", true]};
		};

	if (_BBSide == "A") then {_logic setvariable ["HAC_BBa_Urgent", false]};

	if (_BBCycle == 1) then {[_strArea,_BBSide,(_BBHQs select 0),_logic] spawn ALiVE_fnc_HAC_ObjectivesMon};

	if ((_BBSide == "A") and (_BBCycle == 1)) then {_logic setvariable ["HAC_BBa_Init", true]};

	if (_logic getvariable "HAC_BB_Debug") then
		{
		_logic globalChat format ["For Big Boss %3 cycle is completed: %1 (mission time: %2)",_BBCycle,time,_BBSide];
		diag_log format ["For Big Boss %3 cycle is completed: %1 (mission time: %2)",_BBCycle,time,_BBSide]
		};

	_ctWait = 0;
	_ctVal = 20;
	if not (isNil "HAC_BB_MainInterval") then {_ctVal = _logic getvariable "HAC_BB_MainInterval"};

	if (_logic getvariable "HAC_BB_Debug") then
		{
		_logic globalChat format ["Big Boss %1 will now take a moment to ash his cigar.",_BBSide];
		diag_log format ["Big Boss %1 will now take a moment to ash his cigar.",_BBSide];
		};
	waitUntil
		{
		sleep 60;
		_ctWait = _ctWait + 1;
		if (_BBSide == "A") then 
			{
			if (_logic getvariable "HAC_BBa_Urgent") then 
				{
				_ctWait = _ctVal;
				}
			}
		else 
			{
			if (_logic getvariable "HAC_BBb_Urgent") then 
				{
				_ctWait = _ctVal
				}
			};

		if not (_logic getvariable "HAC_BB_Active") then {_ctWait = _ctVal};

		(_ctWait >= _ctVal)
		};

	_urgent = _logic getvariable "HAC_BBa_Urgent";
	if (_BBSide == "B") then {_urgent = _logic getvariable "HAC_BBb_Urgent"};

	if (_logic getvariable "HAC_BB_Debug") then
		{
		if (_urgent) then
			{
			_logic globalChat format ["Situation on the frontline forces Big Boss %1 to react quickly.",_BBSide];
			diag_log format ["Situation on the frontline forces Big Boss %1 to react quickly.",_BBSide];
			}
		else
			{
			_logic globalChat format ["For Big Boss %1 it is time to a routine review the situation.",_BBSide];
			diag_log format ["For Big Boss %1 it is time to a routine review the situation.",_BBSide];
			}
		};

	if (_urgent) then
		{
			{
			if not (isNull (group _x)) then {(group _x) setVariable ["PathDone",true]};
			}
		foreach _BBHQs
		};

	_BBalive = true;

	if (_logic getvariable "HAC_BB_BBOnMap") then
		{
		_BBUnit = _logic getvariable "HAC_BBaHQ";
		if (_BBSide == "B") then {_BBUnit = _logic getvariable "HAC_BBbHQ"};

		if (isNull _BBUnit) exitWith {_BBalive = false};
		if not (alive _BBUnit) exitWith {_BBalive = false};
		if (captive _BBUnit) then {_BBalive = false}
		};

	if not (_BBalive) then 
		{
		if (_BBSide == "A") then {_logic setvariable ["HAC_BBa_HQs",[]]} else {_logic setvariable ["HAC_BBb_HQs",[]]}
		};

	if not (_BBalive) exitWith 
		{
		if (_logic getvariable "HAC_BB_Debug") then
			{
			_logic globalChat format ["Big Boss %1 is dead!",_BBSide];
			diag_log format ["Big Boss %1 is dead!",_BBSide];
			}
		};
	};

/*
//kto gdzie: ilosc sektorow, celow i obecnosc wroga -> liczebnosc, topografia i ilosc sektorów oraz celów, sklad sil wroga -> sklad armii



//to do


	//nasi

		//ilu liderow mamy

		//czym kazdy dysponuje

		//rozmieszczenie sil wzgledem osi natarcia


	//wrog

		//liczebnosc

		//sklad

		//rozmieszczenie wzgledem osi natarcia

		//przewidywane kierunki natarcia wroga

	
	//dotychczasowy bilans

		//straty

		//morale

		//zasoby


//decyzja

	//strategia

		//stosunek sil i bilans strat

		//co zostalo do zdobycia

		//pelna obrona, pelny atak czy kombinacja


	//zarzadzanie rezerwami

		//czy zachowac lidera w rezerwie

		//czy uzyc rezerwy

			//do zabezpieczenia flanki

			//do oflankowania

			//do wzmocnienia odcinka

			//na garnizony

			//przeniesc sily do innego Lidera


	//garnizony punktow zdobytych

		//ile grup

		//komu odebrac - zdobywcy czy rezerwie


	//wybor kolejnych punktow docelowych dla Liderow

		//punkt strategiczny

		//flanka

		//oflankowanie

		//rezerwa


//wykonanie

	//przydzielenie frontow i celow

	//monitorowanie sytuacji, czy nie wymaga naglej interwencji

		//wrog na tylach/flance

		//wrog blisko sztabu

		//utrata waznych pozycji

		//zniszczenie sztabu

		//nagly wzrost strat
*/