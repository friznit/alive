// Define player data getting and setting
#define PLACEHOLDER QUOTE(ItemWatch);

if (!isDedicated && !isHC) then {
	placeholdercount = 0;
};

addItemToUniformOrVest = {
	private ["_target","_item"];
	_target = _this select 0;
	_item = _this select 1;
	_saveAmmo = MOD(sys_player) getvariable ["saveAmmo", false];
	TRACE_2("adding item", _target, _item);
	if(typename _item == "ARRAY") then {
		if(_item select 0 != "") then {
			if(_saveAmmo) then {
				_target addMagazine _item;
			} else {
				_target addMagazine (_item select 0);
			};
		};
	} else {
		if(_item != "") then {
			if(isClass(configFile>>"CfgMagazines">>_item)) then {
				_target addMagazine _item;
			} else {
				if(isClass(configFile>>"CfgWeapons">>_item>>"WeaponSlotsInfo") && getNumber(configFile>>"CfgWeapons">>_item>>"showempty")==1) then {
					_target addWeapon _item;  
				} else {
					_target addItem _item;        
				};
			};
		};
	};	
};

fillContainer = {
	//Fill up uniform, vest, backpack with placeholder objects to ensure correct load when restored
};

GVAR(UNIT_DATA) = [
		["lastSaveTime",{ time;}, "SKIP"],
		["name",{ name (_this select 0);}, "SKIP"],
		["class",{typeof  (_this select 0);}, "SKIP"], // {[MOD(sys_player), "checkPlayer", [(_this select 0), (_this select 1)]] call ALIVE_fnc_Player;}
		["rating",{rating  (_this select 0);}, {(_this select 0) addrating (_this select 1);}],
		["rank",{rank (_this select 0);}, {(_this select 0) setUnitRank (_this select 1);}],
		["group",{group  (_this select 0);}, "SKIP"], // {[(_this select 0)] joinSilent (_this select 1);}
		["leader", {(leader  (_this select 0) == (_this select 0));}, "SKIP"] // {(_this select 1) selectLeader (_this select 0);}
		// Identity?
];

GVAR(POSITION_DATA) = [
	["position",{getposATL  (_this select 0);}, {(_this select 0) setposATL (_this select 1);}],
	["dir",{getDir  (_this select 0);}, {(_this select 0) setdir (_this select 1);}],
	["anim",{	_animState = animationState (_this select 0); _animStateChars = toArray _animState;
		_animP = toString [_animStateChars select 5, _animStateChars select 6, _animStateChars select 7]; _thisstance = "";
		switch (_animP) do
		{
			case "erc":
			{
				//diag_log ["player is standing"];
				_thisstance = "Stand";
			};
			case "knl":
			{
				//diag_log ["player is kneeling"];
				_thisstance = "Crouch";
			};
			case "pne":
			{
				//diag_log ["player is prone"];
				_thisstance = "Lying";
			};
		}; 
		_thisstance;
	 }, {(_this select 0) playActionNow (_this select 1);}],
	["side", { side (group (_this select 0));}, "SKIP"],
	["vehicle",{ 
		if (vehicle (_this select 0) != (_this select 0)) then {
			str (vehicle (_this select 0));
	   } else {
	   		"NONE";
	   };
	}, {(_this select 0) setVariable ["vehicle", (_this select 1), true];}
	],
	 ["seat", {_seat = "NONE";
		if (vehicle (_this select 0) != (_this select 0)) then {
			_find = [str(vehicle (_this select 0)), "REMOTE", 0] call CBA_fnc_find;  // http://dev-heaven.net/docs/cba/files/strings/fnc_find-sqf.html
			if ( _find == -1 ) then {
				if (driver (vehicle (_this select 0)) == (_this select 0)) then { _seat = "driver"; };
				if (gunner (vehicle (_this select 0)) == (_this select 0)) then { _seat = "gunner"; };
				if (commander (vehicle (_this select 0)) == (_this select 0)) then { _seat = "commander"; };
			};
		};
	   _seat;
	}, { 
		private ["_thisVehicle","_thisSeat"];
		_thisVehicle = (_this select 0) getVariable ["vehicle", "NONE"];
		if (_thisVehicle != "NONE") then {
			{
				if ( str(_x) == _thisVehicle) exitWith {
						_thisSeat = (_this select 1);
			 			if (_thisSeat != "") then {	
						//	(_this select 0) sideChat format["Player, %1 entered vehicle position  %2", _thisVehicle, _thisSeat];	
									switch (_thisSeat) do
									{
									   case "driver":
										{
					//				   diag_log ["player is driver"];
										   (_this select 0) assignAsDriver _x;
			                               (_this select 0) moveInDriver _x;	
										};
									   case "gunner":
										{
						//					diag_log ["player is gunner"];
											(_this select 0) assignAsGunner _x;
			                            	(_this select 0) moveInGunner _x;

										};
									   case "commander":
										{
							//				diag_log ["player is commander"];
										    (_this select 0) assignAsCommander _x;	
			                            	(_this select 0) moveInCommander _x;
										};
									};
						} else {
							  (_this select 0) assignAsCargo _x;
			         		  (_this select 0) moveInCargo _x;	
						};								
				};
			} forEach vehicles;
		};
	}]
];

GVAR(HEALTH_DATA) = [
	["damage",{damage  (_this select 0);}, {(_this select 0) setdamage (_this select 1);}],
	["lifestate",{ lifestate  (_this select 0);}, {
		if (tolower(_this select 1) == "unconscious") then {
			(_this select 0) setUnconscious true;
		};
	}],
	["head_hit",{(_this select 0) getVariable ["head_hit",0];}, {(_this select 0) setVariable ["head_hit",(_this select 1),true];}],
	["body",{(_this select 0) getVariable ["body",0];}, {(_this select 0) setVariable ["body",(_this select 1),true];}],
	["hands",{ (_this select 0) getVariable ["hands",0];}, {(_this select 0) setVariable ["hands",(_this select 1),true];}],
	["legs",{(_this select 0) getVariable ["legs",0];}, {(_this select 0) setVariable ["legs",(_this select 1),true];}],
	["fatigue",{ getFatigue (_this select 0);}, {(_this select 0) setFatigue (_this select 1);}],
	["bleeding",{ getBleedingRemaining (_this select 0);}, {(_this select 0) setBleedingRemaining (_this select 1);}],
	["oxygen",{ getOxygenRemaining (_this select 0);}, {(_this select 0) setOxygenRemaining (_this select 1);}]
];

GVAR(LOADOUT_DATA) = [
	["primaryweapon", {primaryWeapon (_this select 0);}, {
		(_this select 0) removeWeapon (primaryWeapon (_this select 0)); 
		(_this select 0) addWeapon (_this select 1);
	}],
	["primaryWeaponItems", {primaryWeaponItems (_this select 0);}, {
		private ["_target","_primw"];
		_target = _this select 0;
		{
			_target removePrimaryWeaponItem _x;
		} foreach (primaryWeaponItems _target);
		{
			if (_x !="" && !(_x in (primaryWeaponItems _target))) then { 
				_target addPrimaryWeaponItem _x; 
			}; 
		} foreach (_this select 1);
	}],
	["handgunWeapon", {handgunWeapon (_this select 0);}, {
		(_this select 0) removeWeapon (handgunWeapon (_this select 0)); 
		(_this select 0) addWeapon (_this select 1);
	}],
	["handgunItems", {handgunItems (_this select 0);}, {
		{
			(_this select 0) removeHandGunItem _x;
		} foreach (handgunItems (_this select 0));
		{
			if (_x !="" && !(_x in (handgunItems (_this select 0)))) then { 
				(_this select 0) addHandGunItem _x; 
			}; 
		} foreach (_this select 1);
	}],
	["secondaryWeapon", {secondaryWeapon (_this select 0);}, {
		(_this select 0) removeWeapon (secondaryWeapon (_this select 0)); 
		if ((_this select 1) != "") then {
			(_this select 0) addWeapon (_this select 1);
		};
	}],
	["secondaryWeaponItems", {secondaryWeaponItems (_this select 0);}, { 
		private ["_target","_primw"];
		_target = _this select 0;
		/*_primw = primaryWeapon _target;
		_target selectWeapon (secondaryWeapon _target);
		{
			_target removePrimaryWeaponItem _x;
		} foreach (primaryWeaponItems _target);*/
		{
			if (_x !="" && !(_x in (secondaryWeaponItems _target))) then { 
				_target addsecondaryWeaponItem _x; 
			}; 
		} foreach (_this select 1);
		//_target selectWeapon _primw;
	}],
	["uniform", {uniform (_this select 0);}, {
		removeUniform (_this select 0); 
		(_this select 0) addUniform (_this select 1);
	}],
	["uniformItems", {uniformItems (_this select 0);}, {
		{
			[(_this select 0), _x] call addItemToUniformOrVest;
		} foreach (_this select 1);
	}],
	["vest", {vest (_this select 0);}, {
		removeVest (_this select 0); 
		(_this select 0) addVest (_this select 1);
	}],
	["vestItems", {vestItems (_this select 0);}, {
		{
			[(_this select 0), _x] call addItemToUniformOrVest;
		} foreach (_this select 1);
	}],
	["backpack", {backpack (_this select 0);}, {removeBackpack (_this select 0); (_this select 0) addBackpack (_this select 1);}],
	["backpackitems", {	
		private ["_cargo","_backpacks","_target"];
		_cargo = getbackpackcargo (unitbackpack (_this select 0));
		_backpacks = [];
		{
			for "_i" from 1 to ((_cargo select 1) select _foreachindex) do {
				_backpacks set [count _backpacks, _x];
			};
		} foreach (_cargo select 0);	
		(backpackitems (_this select 0)) + _backpacks;
	}, {
		clearAllItemsFromBackpack (_this select 0);
		private ["_target","_item"];
		_target = _this select 0;
		_item = _this select 1;
		if(typename _item == "ARRAY") then {
			if(_item select 0 != "") then {
					_target addMagazine (_item select 0);
			};
		} else {
			if(isClass(configFile>>"CfgMagazines">>_item)) then {
				(unitBackpack _target) addMagazineCargo [_item,1];
			} else {
				if(_item != "") then {
					if(getNumber(configFile>>"CfgVehicles">>_item>>"isbackpack")==1) then {
						(unitBackpack _target) addBackpackCargo [_item,1];  
					} else {
						if(isClass(configFile>>"CfgWeapons">>_item>>"WeaponSlotsInfo") && getNumber(configFile>>"CfgWeapons">>_item>>"showempty")==1) then {
							(unitBackpack _target) addWeaponCargo [_item,1];  
						} else {
							_target addItem _item;         
						};
					};
				};
			};
		};
	}],
	["assigneditems", {	
		private ["_data", "_headgear", "_goggles", "_target"];
		_target = (_this select 0);
		_data = assignedItems _target;
		_headgear = headgear _target;
    	_goggles = goggles _target;
    	if((_headgear != "") && !(_headgear in _data)) then {
            _data set [count _data, _headgear];
    	};
   		if((_goggles != "") && !(_goggles in _data)) then {
            _data set [count _data, _goggles];
    	};
		_data;
	}, {
		removeAllAssignedItems (_this select 0);
		{
			(_this select 0) addItem _x;
			(_this select 0) assignItem _x;
		} foreach (_this select 1);
	}],
	["weaponstate", { 
		private ["_currentweapon","_currentmode","_isFlash","_isIR","_data"];
		if (vehicle (_this select 0) == (_this select 0)) then {
			_currentweapon = currentMuzzle (_this select 0);
			_currentmode = currentWeaponMode (_this select 0);
		    _isFlash = (_this select 0) isFlashlightOn _currentweapon;
		    _isIR = (_this select 0) isIRLaserOn _currentweapon;
		    _nvg = currentVisionMode (_this select 0); 
		    _data = [_currentweapon, _currentmode, _isFlash, _isIR, _nvg];
		} else { // Player in vehicle
			_currentweapon = currentWeapon (_this select 0);
			_data = [_currentweapon];
		};
		_data;
	}, {
		if (vehicle (_this select 0) == (_this select 0)) then {
			private ["_ammo","_target","_weap"];
			_target = _this select 0;
			_weap = ((_this select 1) select 0);
			// Set weapon
			_target selectWeapon _weap;
			// Set firemode
			_ammo = _target ammo _weap;
			_target setAmmo [_weap, 0];
			(_this select 0) forceWeaponFire [_weap, (_this select 1) select 1];
			_target setAmmo [_weap, _ammo];
			// Set magazine?
			// (_this select 0) action ["SwitchMagazine", (_this select 0), (_this select 0), ((_this select 1) select 1)];
			// Set Gun Light
			if ((_this select 1) select 2) then {
				(_this select 0) action ["GunLightOn", (_this select 0)];
			};
			// Set IR Laser
			if ((_this select 1) select 3) then {
				(_this select 0) action ["IRLaserOn", (_this select 0)];
			};
			// Set NVG
			if ( ((_this select 1) select 4) == 1 ) then {
				(_this select 0) action ["nvGoggles", (_this select 0)];
			};
		} else { // Player in vehicle
			(_this select 0) selectWeapon ((_this select 1) select 0);
		};
	}]

];

GVAR(AMMO_DATA) = [
	//get set Ammo - uniform, vest, backpack
];

GVAR(SCORE_DATA) = [
	["score",{score  (_this select 0);},  {(_this select 0) addScore (_this select 1);}]
];