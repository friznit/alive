// Define player data getting and setting
#define FILLER_ITEM QUOTE(ItemWatch);

if (!isDedicated && !isHC) then {
	PLACEHOLDERCOUNT = 0;
};

getContainerMagazines = {
	private ["_target","_container","_magazines","_contMags"];
	_target = (_this select 0);
	_container = (_this select 1);
	_magazines = magazinesAmmoFull _target;
	TRACE_1("Mags", _magazines);
	_contMags = [];
	{
		private "_mag";
		_mag = _x;
		if ( toLower(_mag select 4) == _container && !(getnumber (configFile>>"CfgMagazines">>(_mag select 0)>>"count") == 1) ) then {
			if(MOD(sys_player) getvariable ["saveAmmo", false]) then {
					_contMags set [count _contMags, [_mag select 0, _mag select 1]];
			} else {
					_contMags set [count _contMags, _mag select 0];
			};
		};
	} foreach _magazines;
	_contMags;
};

getWeaponMagazine = {
		private ["_target","_magazine","_weap"];
		_target = (_this select 0);
		_weap = currentWeapon _target;
		_target selectWeapon (_this select 1);
		if(MOD(sys_player) getvariable ["saveAmmo", false]) then {
				_magazine = [currentMagazine _target, _target ammo (currentWeapon _target)];
		} else {
				_magazine = currentMagazine _target;
		};	
		_target selectWeapon _weap;
		_magazine;
};

addItemToUniformOrVest = {
	private ["_target","_item","_result"];
	_target = _this select 0;
	_item = _this select 1;
	if(typename _item == "ARRAY") then {
		if(_item select 0 != "") then {
			TRACE_2("adding item array", _target, _item);
			_target addMagazine _item;
		};
	} else {
		if(_item != "") then {
			if(isClass(configFile>>"CfgMagazines">>_item)) then {
					TRACE_2("adding item magazine", _target, _item);
					_result = [_target, _item] call CBA_fnc_addMagazine;
					if !(_result) then {TRACE_2("FAILED adding magazine", _target, _item);};
			} else {
				if(isClass(configFile>>"CfgWeapons">>_item>>"WeaponSlotsInfo") && getNumber(configFile>>"CfgWeapons">>_item>>"showempty")==1) then {
					TRACE_2("adding item weapon", _target, _item);
					_target addWeaponGlobal _item;  
				} else {
					TRACE_2("adding item", _target, _item);
					_target addItem _item;        
				};
			};
		};
	};	
};

fillContainer = {
	//Fill up uniform, vest, backpack with placeholder objects to ensure correct load when restored
	private ["_target","_container","_count","_loaded"];
	_target = _this select 0;
	_container = _this select 1;
	_count = PLACEHOLDERCOUNT;
	_loaded = false;
	while{!_loaded} do {
			private "_currentLoad";
			if (_container == "uniform") then {
				_currentLoad = loadUniform _target;
			} else {
				_currentLoad = loadVest _target;
			};
			_target addItem FILLER_ITEM;
			if (_container == "uniform") then {
				if (loadUniform _target == _currentLoad) then {_loaded = true;};
			} else {
				if (loadVest _target == _currentLoad) then {_loaded = true;};
			};
			PLACEHOLDERCOUNT = PLACEHOLDERCOUNT + 1;				
	};
	TRACE_2("Added Filler items", PLACEHOLDERCOUNT - _count, PLACEHOLDERCOUNT);
};

GVAR(UNIT_DATA) = [
		["lastSaveTime",{ time;}, "SKIP"],
		["name",{ name (_this select 0);}, {(_this select 0) setName (_this select 1);}],
		["speaker",{ speaker (_this select 0);}, {(_this select 0) setSpeaker (_this select 1);}],
		["nameSound",{ nameSound (_this select 0);}, {(_this select 0) setNameSound (_this select 1);}],
		["pitch",{ pitch (_this select 0);}, {(_this select 0) setPitch (_this select 1);}],
		["face",{ face (_this select 0);}, {(_this select 0) setFace (_this select 1);}],
		["class",{typeof  (_this select 0);}, {[MOD(sys_player), "checkPlayer", [(_this select 0), (_this select 1)]] call ALIVE_fnc_Player;}],
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
	["assignedItemMagazines", {
		private ["_target","_magazines","_weap"];
		_target = (_this select 0);
		_magazines = [];
		_weap = currentWeapon _target;
		{
			private "_magazine";
			_target selectWeapon _x;
			if(currentWeapon _target==_x) then {
				_magazine = currentMagazine _target;
				if(_magazine != "") then {
					_magazines set[count _magazines, _magazine];
				};	
			};
		} forEach (assignedItems _target);
		_target selectWeapon _weap;
		_magazines;}, 
	 {
		(_this select 0) addbackpack "B_Bergen_mcamo"; // as a place to put items temporarily
		{
			[(_this select 0), _x] call addItemToUniformOrVest;
		} foreach (_this select 1);
	}],
	["primaryWeaponMagazine", { [(_this select 0), primaryWeapon (_this select 0)] call getWeaponmagazine;}, 
	 { removeAllWeapons (_this select 0);  
	   [(_this select 0), (_this select 1)] call addItemToUniformOrVest;
	}],
	["primaryweapon", {primaryWeapon (_this select 0);}, {
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
	["handgunWeaponMagazine", { [(_this select 0), handgunWeapon (_this select 0)] call getWeaponmagazine;}, 
	 { [(_this select 0), (_this select 1)] call addItemToUniformOrVest;
	}],
	["handgunWeapon", {handgunWeapon (_this select 0);}, {
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
	["secondaryWeaponMagazine", { [(_this select 0), secondaryWeapon (_this select 0)] call getWeaponmagazine;}, 
	 { 
	 	[(_this select 0), (_this select 1)] call addItemToUniformOrVest;
	}],
	["secondaryWeapon", {secondaryWeapon (_this select 0);}, {
		if ((_this select 1) != "") then {
			(_this select 0) addWeapon (_this select 1);
		};
		removeBackpack (_this select 0);
	}],
	["secondaryWeaponItems", {secondaryWeaponItems (_this select 0);}, { 
		private ["_target","_primw"];
		_target = _this select 0;
		{
			if (_x !="" && !(_x in (secondaryWeaponItems _target))) then { 
				_target addsecondaryWeaponItem _x; 
			}; 
		} foreach (_this select 1);
	}],
	["uniform", {uniform (_this select 0);}, {
		removeUniform (_this select 0); 
		(_this select 0) addUniform (_this select 1);
	}],
	["uniformItems", {
		private ["_uniformItems"];
		_uniformItems = [(_this select 0), "uniform"] call getContainerMagazines;
		{
			TRACE_1("Uniform Item", _x);
			if ( getnumber (configFile>>"CfgMagazines">>_x>>"count") == 1 || !isClass (configFile>>"CfgMagazines">>_x) ) then {
				_uniformItems set [count _uniformItems, _x];
			};
		} foreach uniformItems (_this select 0);
		_uniformItems;
	 }, {
		PLACEHOLDERCOUNT = 0;
		{
			[(_this select 0), _x] call addItemToUniformOrVest;
		} foreach (_this select 1);
		[(_this select 0),"uniform"] call fillContainer;
	}],
	["vest", {vest (_this select 0);}, {
		removeVest (_this select 0); 
		(_this select 0) addVest (_this select 1);
	}],
	["vestItems", {
		private ["_vestItems"];
		_vestItems = [(_this select 0), "vest"] call getContainerMagazines;
		{
			TRACE_1("Vest Item", _x);
			if ( getnumber (configFile>>"CfgMagazines">>_x>>"count") == 1 || !isClass (configFile>>"CfgMagazines">>_x) ) then {
				_vestItems set [count _vestItems, _x];
			};
		} foreach vestItems (_this select 0);
		_vestItems;
	}, {
		{
			[(_this select 0), _x] call addItemToUniformOrVest;
		} foreach (_this select 1);
		[(_this select 0),"vest"] call fillContainer;
	}],
	["backpack", {backpack (_this select 0);}, {
		removeBackpack (_this select 0);
		if ((_this select 1) != "") then { 
			TRACE_1("Adding Backpack", (_this select 1)); 
			(_this select 0) addBackpack (_this select 1);
		};
	}],
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
		private ["_target"];
		_target = _this select 0;
		{
			private "_item";
			_item = _x;
			TRACE_2("adding item to backpack", _target, _item);
			if(typename _item == "ARRAY") then {
				if(_item select 0 != "") then {
						_target addMagazineGlobal (_item select 0);
				};
			} else {
				if(isClass(configFile>>"CfgMagazines">>_item)) then {
					(unitBackpack _target) addMagazineCargoGlobal [_item,1];
				} else {
					if(_item != "") then {
						if(getNumber(configFile>>"CfgVehicles">>_item>>"isbackpack")==1) then {
							(unitBackpack _target) addBackpackCargoGlobal [_item,1];  
						} else {
							if(isClass(configFile>>"CfgWeapons">>_item>>"WeaponSlotsInfo") && getNumber(configFile>>"CfgWeapons">>_item>>"showempty")==1) then {
								(unitBackpack _target) addWeaponCargoGlobal [_item,1];  
							} else {
								_target addItem _item;         
							};
						};
					};
				};
			};
		} foreach (_this select 1);
		// remove item placeholders from vest and uniform
		TRACE_2("Removing placeholder items", FILLER_ITEM, PLACEHOLDERCOUNT);
		for "_i" from 1 to PLACEHOLDERCOUNT do {
			_target removeItem FILLER_ITEM; 
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
			// Check to see if item is a binocular type which in fact is treated as a weapon
			if !(isClass(configFile>>"CfgWeapons">>_x>>"WeaponSlotsInfo")) then {
				(_this select 0) addItem _x;
				(_this select 0) assignItem _x;
			} else {
				(_this select 0) addWeaponGlobal _x;
			};
		} foreach (_this select 1);
	}],
	["weaponstate", { 
		private ["_currentweapon","_currentmode","_isFlash","_isIR","_weapLow","_data"];
		if (vehicle (_this select 0) == (_this select 0)) then {
			_currentweapon = currentMuzzle (_this select 0);
			_currentmode = currentWeaponMode (_this select 0);
		    _isFlash = (_this select 0) isFlashlightOn _currentweapon;
		    _isIR = (_this select 0) isIRLaserOn _currentweapon;
		    _nvg = currentVisionMode (_this select 0); 
		    _weapLow = weaponLowered (_this select 0);
		    _data = [_currentweapon, _currentmode, _isFlash, _isIR, _nvg, _weapLow];
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
			} else {
				(_this select 0) action ["nvGogglesOff", (_this select 0)];
			};
			// Lower Weapon
			if ((_this select 1) select 5) then {
				(_this select 0) action ["WeaponOnBack", (_this select 0)];
			};
		} else { // Player in vehicle
			(_this select 0) selectWeapon ((_this select 1) select 0);
		};
	}]

];

GVAR(SCORE_DATA) = [
	["score",{score  (_this select 0);},  {(_this select 0) addScore (_this select 1);}]
];