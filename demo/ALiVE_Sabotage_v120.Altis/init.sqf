SABOTAGE_fnc_compileList = {
    		private ["_list"];
                   
            _list = str(_this);
	        _list = [_list, "[", ""] call CBA_fnc_replace;
	        _list = [_list, "]", ""] call CBA_fnc_replace;
            _list = [_list, "'", ""] call CBA_fnc_replace;
            _list = [_list, """", ""] call CBA_fnc_replace;
            _list = [_list, ",", ", "] call CBA_fnc_replace;
            _list;
};

SABOTAGE_fnc_masquerade = {

	private ["_unit","_target"];
	
	_unit = _this select 0;
	_target = _this select 1;

	if (uniform _target == "") exitwith {
		//["The chosen unit does not wear a uniform!"] call ALiVE_fnc_DumpH
	
		_title = "<t size='1.5' color='#68a7b7' shadow='1'>IMPERSONATION</t><br/>";
        _text = format["%1<t>The chosen unit does not wear a uniform!</t>",_title];

        ["openSideSmall",0.3] call ALIVE_fnc_displayMenu;
        ["setSideSmallText",_text] call ALIVE_fnc_displayMenu;
	};

    _unit forceAddUniform (uniform _target);
    _unit addVest (vest _target);
    _unit addHeadGear (headGear _target);
    
    removeUniform _target;
    removeVest _target;
    removeHeadGear _target;
    
    [_unit] spawn {
        _unit = _this select 0;
        
        _uniform = uniform _unit;
        _side = (faction _unit) call ALiVE_fnc_FactionSide;
        _time = time;

        _unit setcaptive true;
        _unit setvariable ["ALiVE_DETECTIONRATE",0];

        _detector = _unit addEventHandler ["fired",{
            
            if !((_this select 4) isKindOf "TimeBombCore") then {
    			_target = cursortarget; if (!isnull _target && {_target isKindOf "AllVehicles"}) then {(_this select 0) setvariable ["ALiVE_DETECTIONRATE",100]};
            };
		}];
                        
        waituntil {
            private ["_detectionRate"];
            
            sleep 5;

            _enemyunits = []; {if (((side _x) getfriend _side) < 0.6) then {_enemyUnits set [count _enemyUnits,_x]}} foreach ((getposATL _unit) nearEntities [["CAmanBase"],50]);
            _enemyunits = _enemyunits - [_unit];
            _detectionRate = _unit getvariable ["ALiVE_DETECTIONRATE",0];
            
            if (count _enemyunits > 0) then {
                if (_unit == vehicle _unit && {speed _unit > 10}) then {_detectionRate = _detectionRate + 1};
                
                if ({_x distance _unit < 3} count _enemyunits > 0) then {
                    _detectionRate = _detectionRate + 30;

                    _title = "<t size='1.5' color='#68a7b7' shadow='1'>IMPERSONATION</t><br/>";
                    _text = format["%1<t>You are impersonating an enemy! Your identity has been revealed to %2 percent!</t>",_title,ceil((_detectionRate/30)*100)];

                    ["openSideSmall",0.3] call ALIVE_fnc_displayMenu;
                    ["setSideSmallText",_text] call ALIVE_fnc_displayMenu;

                } else {
                     if ({_x distance _unit < 15} count _enemyunits > 0) then {
                         _detectionRate = _detectionRate + 5;

                         _title = "<t size='1.5' color='#68a7b7' shadow='1'>IMPERSONATION</t><br/>";
                         _text = format["%1<t>You are impersonating an enemy! Your identity has been revealed to %2 percent!</t>",_title,ceil((_detectionRate/30)*100)];

                         ["openSideSmall",0.3] call ALIVE_fnc_displayMenu;
                         ["setSideSmallText",_text] call ALIVE_fnc_displayMenu;

                     };
                };
            } else {
		        if (_detectionRate > 0) then {_detectionRate = _detectionRate - 1};
            };
            
            //['You are masqued as enemy! Your identity has been revealed to %1 percent!',ceil((_detectionRate/30)*100)] call ALiVE_fnc_DumpH;

			_unit setvariable ["ALiVE_DETECTIONRATE",_detectionRate];
            
            uniform _unit != _uniform || {_detectionRate > 30};
        };
        
        _unit removeEventHandler ["fired",_detector];
        
        _unit setcaptive false;
        _unit setvariable ["ALiVE_DETECTIONRATE",nil];
    };
};

SABOTAGE_fnc_establishHideout = {
    private ["_unit","_pos","_hideouts","_building"];
    
    _unit = _this select 0;
    _pos = getposATL _unit;
    _building = (nearestobjects [_pos, ['House_F'],20]) select 0;
    _hideOuts = (_unit getvariable ["SABOTAGE_HIDEOUTS",[]]);
    _limit = 20;
    
    if (isnil "_building" || {_building in _hideOuts}) exitwith {_hideOuts};
    
	_total = 0; {_total = _total + (count (weaponcargo _x) + (count (itemcargo _x)))} foreach (nearestobjects [getPosATL _building, ['GroundWeaponHolder','ReammoBox_F'],20]); 

	if (_total < _limit) exitwith {
		//["Bring %2 more weapons to this location to establish an hideout!",_total,_limit - _total] call ALiVE_fnc_DumpH; 
		
		_title = "<t size='1.5' color='#68a7b7' shadow='1'>SAFEHOUSE</t><br/>";
        _text = format["%1<t>Bring %3 more weapons to this location to establish a safehouse!</t>",_title,_total,_limit - _total];
		
		["openSideSmall",0.3] call ALIVE_fnc_displayMenu;
        ["setSideSmallText",_text] call ALIVE_fnc_displayMenu;
		
		_hideOuts
	};

    _trigger = createTrigger ["EmptyDetector",getPosATL _building];
    _trigger setTriggerArea [500,500,0,false];
    _trigger setTriggerActivation ["WEST", "GUER D", false];
    _trigger setTriggerStatements ["this", "
			_text = format['<t>Safehouse at %1 has been detected! An assault is to be expected within the next 30 minutes!</t>',(((getposATL thisTrigger) call BIS_fnc_posToGrid) select 0) + (((getposATL thisTrigger) call BIS_fnc_posToGrid) select 1)];
			[['openSideSmall',0.3],'ALIVE_fnc_displayMenu',true,false,false] spawn BIS_fnc_MP;
			[['setSideSmallText',_text],'ALIVE_fnc_displayMenu',true,false,false] spawn BIS_fnc_MP;
    		[[[getposATL thisTrigger],{{[_x,'addObjective',[str(time), _this select 0, 50]] call ALiVE_fnc_OPCOM} foreach OPCOM_INSTANCES}],'BIS_fnc_spawn',false,false] call BIS_fnc_MP;
    	", "
    "];
    
    _unit setvariable ["SABOTAGE_HIDEOUTS",_hideOuts + [_building],true];
    _building setvariable ["SABOTAGE_OWNER",_unit,true];
    _building setvariable ["SABOTAGE_DETECTOR",_trigger];
    
	_building addEventhandler ["killed",{
        _building = (_this select 0);
        _unit = _building getvariable ["SABOTAGE_OWNER",objNull];
        _trigger = _building getvariable ["SABOTAGE_DETECTOR",objNull];
        
        _hideOuts = _unit getvariable ["SABOTAGE_HIDEOUTS",[]];
		_respawn = format["ALiVE_SUP_MULTISPAWN_RESPAWNBUILDING_%1",faction _unit];
    	_respawnBackUp = format["RESPAWN_%1",side _unit];

	    if ([_respawn] call ALiVE_fnc_markerExists) then {_respawn setMarkerPosLocal (getmarkerPos _respawnBackUp)};
        
        _unit setvariable ["SABOTAGE_HIDEOUTS",_hideOuts - [_this select 0],true];
        _building setvariable ["SABOTAGE_DETECTOR",nil];
        
        deletevehicle _trigger;
        {_x setDamage 1} foreach (nearestobjects [getposATL (_this select 0), ['GroundWeaponHolder','ReammoBox_F'],20]);

        _pos = getposATL (_this select 0);

        _nearestTown = [_pos] call ALIVE_fnc_taskGetNearestLocationName;
		
		_title = "<t size='1.5' color='#68a7b7'  shadow='1'>ALERT!</t><br/>";
        _text = format["%1<t>Your safehouse %2 near %3 has been destroyed!</t>",_title,_this select 0, _nearestTown];
		
		[["openSideSmall",0.3],"ALIVE_fnc_displayMenu",true,false,false] spawn BIS_fnc_MP;
		[["setSideSmallText",_text],"ALIVE_fnc_displayMenu",true,false,false] spawn BIS_fnc_MP;

        //["Your hideout %1 at %2 has been destroyed!",_this select 0, getposATL (_this select 0)] call ALiVE_fnc_DumpH;
	}];
        
    _unit getvariable ["SABOTAGE_HIDEOUTS",[]];
};

SABOTAGE_fnc_destroyHideoutsServer = {
    private ["_side","_profileIDs","_killedTotal","_radius"];
    
    _side = _this select 0;
    _radius = _this select 1;
    
    _profileIDs = [ALiVE_ProfileHandler, "getProfilesBySide", _side] call ALIVE_fnc_profileHandler;
    _killedTotal = [];
    _hideOutsTotal = [];
    
    {
        _unit = _x;
        
        _hideouts = _unit getvariable ["SABOTAGE_HIDEOUTS",[]];
        _hideOutsTotal = _hideOutsTotal + _hideouts;
        _killed = [];
        
		{
		    _hideOut = _x;
		        
			{
		        private ["_profile","_pos"];
		
				_profile = [ALiVE_ProfileHandler,"getProfile",_x] call ALiVE_fnc_ProfileHandler;
				_exit = false;
				
				if !(isnil "_profile") then {
					_type = [_profile,"type","entity"] call ALiVE_fnc_HashGet;
                    _isPlayer = [_profile,"isPlayer",false] call ALiVE_fnc_HashGet;
					
					if ((_type == "entity") && {!_isPlayer}) then {
						_pos = [_profile,"position",[0,0,0]] call ALiVE_fnc_HashGet;
						
		                if (_pos distance _hideOut < _radius) exitwith {_killed set [count _killed,_hideOut]; _exit = true};
					};
				};
	            
				if (_exit) exitwith {};
			} foreach _profileIDs;
		} foreach _hideouts;
	
	    if (count _killed > 0) then {_unit setvariable ["SABOTAGE_HIDEOUTS",_hideouts - _killed, true]; _killedTotal = _killedTotal + _killed};
    } foreach ([] call BIS_fnc_listPlayers);
    
    if ((count _hideOutsTotal > 0) && {count _killedTotal == count _hideOutsTotal}) then {
		["All hideouts %1 destroyed!",_hideOutsTotal call SABOTAGE_fnc_compileList] call ALiVE_fnc_Dump;
    };

    {_objects = nearestObjects [_x, ["House_F","Reammobox_F","GroundWeaponHolder"], 20]; {_x setdamage 1} foreach _objects} foreach _killedTotal;
	_killedTotal;
};

SABOTAGE_fnc_selectRespawnHideout = {
    private ["_unit","_hideouts","_pos","_nearestTown"];
    
    _unit = _this select 0;
    
    _pos = getposATL _unit;
    _hideOuts = _unit getvariable ["SABOTAGE_HIDEOUTS",[]];
    _respawn = format["ALiVE_SUP_MULTISPAWN_RESPAWNBUILDING_%1",faction _unit];
    _respawnBackUp = format["RESPAWN_%1",side _unit];

    _hideOuts = [_hideOuts,[_pos],{_Input0 distance (getposATL _x)},"ASCEND"] call BIS_fnc_sortBy;

	if ([_respawn] call ALiVE_fnc_markerExists) then {
        _respawn setMarkerPosLocal (getposATL (_hideOuts select 0));
    } else {
        _respawnBackUp setMarkerPosLocal (getposATL (_hideOuts select 0));
    };

    _nearestTown = [_pos] call ALIVE_fnc_taskGetNearestLocationName;

    _title = "<t size='1.5' color='#68a7b7' shadow='1'>SAFEHOUSE</t><br/>";
    _text = format["%1<t>Your safehouse near %2 will now be used as a respawn point.</t>",_title,_nearestTown];

    ["openSideSmall",0.3] call ALIVE_fnc_displayMenu;
    ["setSideSmallText",_text] call ALIVE_fnc_displayMenu;

    _hideOuts select 0;
};

SABOTAGE_fnc_handleSabotageLocal = {
    private ["_targets","_explosive","_unit","_objects","_collected","_killed","_points","_list"];
    
	_unit = _this select 0;
	_ammo = _this select 4;
    _killed = [];
    
	if !(_ammo isKindOf "TimeBombCore") exitwith {_killed};
        
    _explosive = (position _unit) nearestObject _ammo;

    waituntil {
        sleep 1 + (random 1);
        
        if (alive _explosive) then {
            
            _collected = _unit getvariable ["SABOTAGE_TARGETS",[]];
            
        	_objects = nearestObjects [_explosive, ["AllVehicles","House_F","Reammobox_F","Reammobox"], 20];
    		_targets = []; {if (!isnull _x && {alive _x} && {!(_x in _collected)}) then {_unit setvariable ["SABOTAGE_TARGETS",_collected + [_x]]}} foreach _objects; _targets = _targets - [_unit,_explosive];
            false;
        } else {
            true;
        };
    };

	{if (isnull _x || {!(alive _x)}) then {_killed set [count _killed,_x]}} foreach (_unit getvariable ["SABOTAGE_TARGETS",[]]);
    _unit setvariable ["SABOTAGE_TARGETS",(_unit getvariable ["SABOTAGE_TARGETS",[]]) - _killed];
    
    _points = 0;
    _list = [];
    {
        private ["_o"];
        
        _o = _x;
        
        if (!(isnil "_o") && {!isNull _x}) then {
            
            if (!isnil "ALIVE_militarySupplyBuildingTypes" && {({([toLower (typeOf _o), toLower _x] call CBA_fnc_find) > -1} count ALIVE_militarySupplyBuildingTypes > 0)}) then {
                ["Supply building of type %1 has been destroyed!",typeOf _x] call ALiVE_fnc_Dump;
                
                _list set [count _list, getText(configfile >> "CfgVehicles" >> (typeOf _x) >> "displayName")];
                _points = _points + 25;
            } else {
                if (!isnil "ALIVE_militaryHQBuildingTypes" && {({([toLower (typeOf _o), toLower _x] call CBA_fnc_find) > -1} count ALIVE_militaryHQBuildingTypes > 0)}) then {
                    ["HQ building of type %1 has been destroyed!",typeOf _x] call ALiVE_fnc_Dump;
                    
                    _list set [count _list, getText(configfile >> "CfgVehicles" >> (typeOf _x) >> "displayName")];
                    _points = _points + 25;
                } else {
                    if (!isnil "ALIVE_militaryAirBuildingTypes" && {({([toLower (typeOf _o), toLower _x] call CBA_fnc_find) > -1} count ALIVE_militaryAirBuildingTypes > 0)}) then {
                        ["Air installation of type %1 has been destroyed!",typeOf _x] call ALiVE_fnc_Dump;
                        
                        _list set [count _list, getText(configfile >> "CfgVehicles" >> (typeOf _x) >> "displayName")];
                        _points = _points + 50;
                    } else {
                        if (!isnil "ALIVE_civilianAirBuildingTypes" && {({([toLower (typeOf _o), toLower _x] call CBA_fnc_find) > -1} count ALIVE_civilianAirBuildingTypes > 0)}) then {
                            ["Air installation of type %1 has been destroyed!",typeOf _x] call ALiVE_fnc_Dump;
                            
                            _list set [count _list, getText(configfile >> "CfgVehicles" >> (typeOf _x) >> "displayName")];
                            _points = _points + 50;
                        } else {
                            if (!isnil "ALIVE_militaryBuildingTypes" && {({([toLower (typeOf _o), toLower _x] call CBA_fnc_find) > -1} count ALIVE_militaryBuildingTypes > 0)}) then {
                                ["Military installation of type %1 has been destroyed!",typeOf _x] call ALiVE_fnc_Dump;
                                
                                _list set [count _list, getText(configfile >> "CfgVehicles" >> (typeOf _x) >> "displayName")];
                                _points = _points + 10;
                            } else {
                                ["Object of type %1 has been destroyed!",typeOf _x] call ALiVE_fnc_Dump;
                                
                                _list set [count _list, getText(configfile >> "CfgVehicles" >> (typeOf _x) >> "displayName")];
                                _points = _points + 5;
                            };
                        };
                    };
                };
            };
        };
    } foreach _killed;
    
    if (_points > 0) then {

		_list = _list call SABOTAGE_fnc_compileList;
        
        //["Your factions forces received %1 reinforcements for destruction of %2!",ceil(_points/10),_list] call ALiVE_fnc_DumpH;
		
		_title = "<t size='1.5' color='#68a7b7'  shadow='1'>REINFORCEMENTS</t><br/>";
        _text = format["%1<t>Your factions forces received %2 reinforcements for destruction of %3!</t>",_title,ceil(_points/10),_list];
		
		[["openSideSmall",0.3],"ALIVE_fnc_displayMenu",true,false,false] spawn BIS_fnc_MP;
		[["setSideSmallText",_text],"ALIVE_fnc_displayMenu",true,false,false] spawn BIS_fnc_MP;
        
        _unit setvariable ["SABOTAGE_POINTS",(_unit getvariable ["SABOTAGE_POINTS",0]) + _points,true];
        [[[ceil(_points/10),_unit],{if (!isnil "ALIVE_globalForcePool") then {[ALIVE_globalForcePool,faction (_this select 1),([ALIVE_globalForcePool,faction (_this select 1),0] call ALIVE_fnc_hashGet) + (_this select 0)] call ALIVE_fnc_hashSet}}],"BIS_fnc_spawn",false,false] call BIS_fnc_MP;
    };

    _killed;
};

SABOTAGE_fnc_initPlayer = {
    private ["_unit","_pos"];
    
    _unit = _this;
	_pos = getposATL _unit;
    
	_id = _unit addAction [
		"Establish safehouse",
		{_vars = _this select 3; [_vars select 0, _vars select 1] call SABOTAGE_fnc_establishHideout},
		[_unit, getposATL _unit],
		1,
		false,
		true,
		"",
		"private ['_building']; _building = (nearestobjects [_this, ['House_F'],20]) select 0; !(isnil '_building') && {({((getposATL _this) distance (getposATL _x)) < 500} count (_this getvariable ['SABOTAGE_HIDEOUTS',[]])) == 0}"
	];
    
    _id = _unit addAction [
		"Use safehouse as respawn",
		{_vars = _this select 3; [_vars select 0] spawn SABOTAGE_fnc_selectRespawnHideout},
		[_unit],
		1,
		false,
		true,
		"",
		"({((getposATL _this) distance (getposATL _x)) < 15} count (_this getvariable ['SABOTAGE_HIDEOUTS',[]])) > 0"
	];
	
	_id = _unit addAction [
		"Repair and Refuel",
		{_vars = _this select 3; _unit = _vars select 0; vehicle _unit setdamage 0; vehicle _unit setfuel 1},
		[_unit],
		1,
		false,
		true,
		"",
		"vehicle _this != _this && {damage (vehicle _this) > 0.1 || {!canMove (vehicle _this)} || {fuel vehicle _this < 0.9}} && {({(getposATL _x) distance _this < 25} count (_this getvariable ['SABOTAGE_HIDEOUTS',[]])) > 0}"
	];
	
	_id = _unit addAction [
		"Impersonate",
		{[player,cursortarget] call SABOTAGE_fnc_masquerade},
		[],
		1,
		false,
		true,
		"",
		"isnil {_this getvariable 'ALiVE_DETECTIONRATE'} && {!alive cursortarget} && {cursortarget distance _target < 5} && {cursortarget isKindOf 'CAManBase'}"
	];
};

//Clients
if (hasInterface) then {
    //Intro
    [] spawn {
	    titleText ["The ALiVE Team presents...", "BLACK IN",9999];
		0 fadesound 0;
	
		private ["_cam","_camx","_camy","_camz","_object"];
		_start = time;
	
		waituntil {(player getvariable ["alive_sys_player_playerloaded",false]) || ((time - _start) > 20)};
		playmusic "sabotage";
		sleep 10;
		
		_object = player;
		_camx = getposATL player select 0;
		_camy = getposATL player select 1;
		_camz = getposATL player select 2;
		
		_cam = "camera" CamCreate [_camx -500 ,_camy + 500,_camz+450];
		
		_cam CamSetTarget player;
		_cam CameraEffect ["Internal","Back"];
		_cam CamCommit 0;
		
		_cam camsetpos [_camx -15 ,_camy + 15,_camz+3];
		
		titleText ["A L i V E   |   S A B O T A G E", "BLACK IN",10];
		10 fadesound 0.9;
		_cam CamCommit 20;
		sleep 5;
		sleep 15;
				
		_cam CameraEffect ["Terminate","Back"];
		CamDestroy _cam;
		
		sleep 1;

		_title = "<t size='1.5' color='#68a7b7' shadow='1'>SABOTAGE</t><br/>";
        _text = format["%1<t>Collect and store weapons at buildings to establish safehouses across Altis.</t>",_title];

        ["openSideSmall",0.4] call ALIVE_fnc_displayMenu;
        ["setSideSmallText",_text] call ALIVE_fnc_displayMenu;

        sleep 15;

        _title = "<t size='1.5' color='#68a7b7' shadow='1'>SABOTAGE</t><br/>";
        _text = format["%1<t>Impersonate dead enemy combatants to gain access to secure installations undetected.</t>",_title];

        ["openSideSmall",0.4] call ALIVE_fnc_displayMenu;
        ["setSideSmallText",_text] call ALIVE_fnc_displayMenu;

        sleep 15;

        _title = "<t size='1.5' color='#68a7b7' shadow='1'>SABOTAGE</t><br/>";
        _text = format["%1<t>Sabotage key infrastructure to strike at the occupying forces and gain supplies for the resistance.</t>",_title];

        ["openSideSmall",0.4] call ALIVE_fnc_displayMenu;
        ["setSideSmallText",_text] call ALIVE_fnc_displayMenu;
    };
    
    //Persistent EHs
	player addEventHandler ["RESPAWN",{[] spawn {waituntil {!isnull player}; player call SABOTAGE_fnc_initPlayer}}];
    player addEventHandler ["FIRED",{_this spawn SABOTAGE_fnc_handleSabotageLocal}];

	//Add Actions on mission start
    player call SABOTAGE_fnc_initPlayer;
};

//Server
if (isServer) then {
	[] spawn {

		waitUntil {
			sleep 5;
	
			["GUER",50] call SABOTAGE_fnc_destroyHideoutsServer;
			false;
		};
	};
    
	30 setfog [0.05,0.05,80];
};

//Global


waituntil {!isnil "ALIVE_factionDefaultResupplyVehicleOptions"};

// Adjust combat logistics options to restrict resupply

SABOTAGE_CUSTOM_LOGISTICS_VEHICLES_BLU_G_F = [] call ALIVE_fnc_hashCreate;
[SABOTAGE_CUSTOM_LOGISTICS_VEHICLES_BLU_G_F, "PR_AIRDROP", [["<< Back"],["<< Back"]]] call ALIVE_fnc_hashSet;
[SABOTAGE_CUSTOM_LOGISTICS_VEHICLES_BLU_G_F, "PR_HELI_INSERT", [["<< Back"],["<< Back"]]] call ALIVE_fnc_hashSet;
[SABOTAGE_CUSTOM_LOGISTICS_VEHICLES_BLU_G_F, "PR_STANDARD", [["<< Back"],["<< Back"]]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyVehicleOptions, "BLU_G_F", SABOTAGE_CUSTOM_LOGISTICS_VEHICLES_BLU_G_F] call ALIVE_fnc_hashSet;

SABOTAGE_CUSTOM_LOGISTICS_AMMO_BLU_G_F = [] call ALIVE_fnc_hashCreate;
[SABOTAGE_CUSTOM_LOGISTICS_AMMO_BLU_G_F, "PR_AIRDROP", [["<< Back"],["<< Back"]]] call ALIVE_fnc_hashSet;
[SABOTAGE_CUSTOM_LOGISTICS_AMMO_BLU_G_F, "PR_HELI_INSERT", [["<< Back"],["<< Back"]]] call ALIVE_fnc_hashSet;
[SABOTAGE_CUSTOM_LOGISTICS_AMMO_BLU_G_F, "PR_STANDARD", [["<< Back"],["<< Back"]]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyCombatSuppliesOptions, "BLU_G_F", SABOTAGE_CUSTOM_LOGISTICS_AMMO_BLU_G_F] call ALIVE_fnc_hashSet;

SABOTAGE_CUSTOM_LOGISTICS_INDIVIDUALS_BLU_G_F  = [] call ALIVE_fnc_hashCreate;
[SABOTAGE_CUSTOM_LOGISTICS_INDIVIDUALS_BLU_G_F, "PR_AIRDROP", [["<< Back","Men,","MenRecon","MenSniper","MenSupport"],["<< Back","Men,","MenRecon","MenSniper","MenSupport"]]] call ALIVE_fnc_hashSet;
[SABOTAGE_CUSTOM_LOGISTICS_INDIVIDUALS_BLU_G_F, "PR_HELI_INSERT", [["<< Back","Men,","MenRecon","MenSniper","MenSupport"],["<< Back","Men,","MenRecon","MenSniper","MenSupport"]]] call ALIVE_fnc_hashSet;
[SABOTAGE_CUSTOM_LOGISTICS_INDIVIDUALS_BLU_G_F, "PR_STANDARD", [["<< Back","Men","MenRecon","MenSniper","MenSupport"],["<< Back","Men","MenRecon","MenSniper","MenSupport"]]] call ALIVE_fnc_hashSet;
[ALIVE_factionDefaultResupplyIndividualOptions, "BLU_G_F", SABOTAGE_CUSTOM_LOGISTICS_INDIVIDUALS_BLU_G_F] call ALIVE_fnc_hashSet;



waituntil {!isnil "ALIVE_autoGeneratedTasks"};

// Adjust available auto generated tasks

//ALIVE_autoGeneratedTasks = ["MilAssault","MilDefence","CivAssault","Assassination","TransportInsertion","DestroyVehicles","DestroyInfantry","SabotageBuilding"];
ALIVE_autoGeneratedTasks = ["SabotageBuilding"];



// Adjust Sabotage Building Task Copy

_options = [];

_tasksData = [] call ALIVE_fnc_hashCreate;

_taskData = [] call ALIVE_fnc_hashCreate;
[_taskData,"title","Sabotage in %1"] call ALIVE_fnc_hashSet;
[_taskData,"description","Destroy the %2 in %1!"] call ALIVE_fnc_hashSet;
[_tasksData,"Parent",_taskData] call ALIVE_fnc_hashSet;

_taskData = [] call ALIVE_fnc_hashCreate;
[_taskData,"title","Destroy %1"] call ALIVE_fnc_hashSet;
[_taskData,"description","We received intelligence about a strategically important %3 near %1! Destroy the %2!"] call ALIVE_fnc_hashSet;
[_taskData,"chat_start",[["HQ","We received intelligence about a strategically relevant position near %1! Destroy the objective!"],["PLAYERS","Roger that"]]] call ALIVE_fnc_hashSet;
[_taskData,"chat_success",[["PLAYERS","The objective has been destroyed!"],["HQ","Roger that, well done!"]]] call ALIVE_fnc_hashSet;
[_taskData,"reward",["forcePool",10]] call ALIVE_fnc_hashSet;
[_tasksData,"Destroy",_taskData] call ALIVE_fnc_hashSet;

_options set [count _options,_tasksData];

[ALIVE_generatedTasks, "SabotageBuilding", ["Sabotage installation",_options]] call ALIVE_fnc_hashSet;