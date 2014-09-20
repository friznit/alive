#define DEBUG_MODE_FULL
#include <\x\alive\addons\sup_combatsupport2\script_component.hpp>
SCRIPT(combatsupport2);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_combatsupport2
Description:
Creates the server side object to store settings

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array,String,Number,Boolean - The selected parameters

Returns:
Array, String, Number, Any - The expected return value

Examples:
(begin example)
// Create instance by placing editor module
[_logic,"init"] call ALiVE_fnc_combatsupport2
(end)

See Also:
- <ALIVE_fnc_combatsupport2Init>

Author:
Cameroon

Peer reviewed:
nil
---------------------------------------------------------------------------- */
#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_combatsupport2

private ["_result", "_operation", "_args", "_logic"];

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,nil);
_result = nil;

//Listener for special purposes
if (!isnil QMOD(SUP_COMBATSUPPORT2) && {MOD(SUP_COMBATSUPPORT2) getvariable [QGVAR(LISTENER),false]}) then {
    _blackOps = ["id"];
    
    if !(_operation in _blackOps) then {
        _check = "nothing"; if !(isnil "_args") then {_check = _args};
        
        ["op: %1 | args: %2",_operation,_check] call ALiVE_fnc_DumpR;
    };
};

newair_setLoiterPoint = {
    diag_log format["%1",MOD(SUP_COMBATSUPPORT2)];
    private["_veh","_loiterPoint"];

    _veh = _this select 0;
    _loiterPoint = _this select 1;

    [(group (driver _veh)),0] setWaypointPosition [_loiterPoint,0];
};

pickCasTarget = {
    private["_veh","_pos","_radius","_targets","_target","_enemySides","_classList","_parents"];
    _veh = _this select 0;
    _pos = _this select 1;
    _radius = _this select 2;
    _weapon = _this select 3;

    _parents = [ (configFile >> "CfgWeapons" >> _weapon),true] call BIS_fnc_returnParents;
    if("MissileLauncher" in _parents) then {
        _classList = ["Tank", "Wheeled_apc"];
    } else {
        if("RocketPods" in _parents) then {
            _classList = ["Man","Air","Car","Motorcycle","Tank", "Wheeled_apc"];
        } else {
            _classList = ["Man","Air","Car","Motorcycle", "Wheeled_apc"];
        };
    };

    _targets = (_pos nearEntities [_classList, _radius]);
    _target = objNull;

    _enemySides = _veh call BIS_fnc_enemySides;
    {
        if (alive _x && (side _x) in _enemySides ) then {
            if(isNull _target && random 1 > .5) then {
                (group (driver _veh)) reveal _x;
                _target = _x;
            } else {
                _target = _x;
            };
        };
    } forEach _targets;

    _target;
};

disableOtherWeapons = {
    private["_veh","_keepWeapon","_wepCount","_ammoCount","_count"];
    _veh = _this select 0;
    _keepWeapon = _this select 1;
    _ammoCount = [];
    {
        private "_count";
        if (_x == _weapon) then {
            _count = -1;
        } else {
            _count = _veh ammo _x;
            _veh setAmmo [_x, 0];
        };
        _ammoCount set [count _ammoCount, _count];
    } foreach weapons _veh;

    _ammoCount;
};

reenableWeapons = {
    private["_veh","_ammoCount"];
    _veh = _this select 0;
    _ammoCount = _this select 1;

    {
        if( (_ammoCount select _foreachindex) != -1 ) then {
            _veh setAmmo [_x, _ammoCount select _foreachindex];
        };
    } foreach weapons _veh;
};

TRACE_3("SUP_COMBATSUPPORT2",_logic, _operation, _args);
switch (_operation) do {
    
        case "create": {
            if (isServer) then {
                
                // Ensure only one module is used
                if !(isNil QMOD(SUP_COMBATSUPPORT2)) then {
                    _logic = MOD(SUP_COMBATSUPPORT2);
                    ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_COMBATSUPPORT2_ERROR1");
                } else {
                    _logic = (createGroup sideLogic) createUnit ["ALiVE_SUP_COMBATSUPPORT2", [0,0], [], 0, "NONE"];
                    MOD(SUP_COMBATSUPPORT2) = _logic;
                };
                
                //Push to clients
                PublicVariable QMOD(SUP_COMBATSUPPORT2);
            };
            
            TRACE_1("Waiting for object to be ready",true);
            
            waituntil {!isnil QMOD(SUP_COMBATSUPPORT2)};
            
            TRACE_1("Creating class on all localities",true);
            
            // initialise module game logic on all localities
            MOD(SUP_COMBATSUPPORT2) setVariable ["super", QUOTE(SUPERCLASS)];
            MOD(SUP_COMBATSUPPORT2) setVariable ["class", QUOTE(MAINCLASS)];
            
            _result = MOD(SUP_COMBATSUPPORT2);
        };
        case "getPotentialSupportRoles": {
            private["_unit","_roles"];
            MOD(SUP_COMBATSUPPORT2) = _logic;
            _unit = vehicle (_args select 0);
            _roles = [];

            if( _unit isKindOf "Air" ) then {
                //check for CAS and Transport roles
                if((getNumber (configFile >> "CfgVehicles" >> (typeOf _unit) >> "transportSoldier")) > 0) then {
                    _roles set[count _roles, "transport"];
                };

                _cfgSupportTypes = getArray (configFile >> "CfgVehicles" >> (typeof _unit) >> "availableForSupportTypes");
                {
                    if(_x == "CAS_Bombing" || _x == "CAS" || _x == "CAS_Heli" ) exitWith {
                        _roles set[count _roles,"cas"];
                    };
                } forEach _cfgSupportTypes;

                if(!("cas" in _roles)) then {
                    // check to see if we're mounting weapons, like the Pawnee
                    _weapons = getArray (configFile >> "CfgVehicles" >> (typeof _unit) >> "weapons");
                    {
                        if(_x != "CMFlareLauncher") exitWith {
                            _roles set[count _roles,"cas"];
                        };
                    } foreach _weapons;
                };
            } else {
                _artilleryScanner = getnumber(configfile >> "CfgVehicles" >> (typeof _unit) >> "artilleryScanner");
                if( _artilleryScanner == 1 ) then {
                    _roles set[count _roles,"artillery"];
                } else {
                    private["_errorMessage","_error1","_error2"];
                    _errorMessage = "Unit has unknown role types: %1 %2";
                    _error1 = str(_unit);
                    _error2 = typeOf _unit;
                    [_errorMessage,_error1,_error2] call ALIVE_fnc_dumpR;
                };
            };

            //now check for any config modules
            {
                _syncObj = _x;
            } forEach (synchronizedObjects _unit);
            _result = _roles;
        };
        case "init": {
            private["_obj","_obj2"];
            ["CS2 %1 - Initialisation started...",_logic] call ALiVE_fnc_Dump;
            MOD(SUP_COMBATSUPPORT2) = _logic;

            /*
            MODEL - no visual just reference data
            - module object datastorage parameters
            - Establish data handler on server
            - Establish data model on server and client
            */
            
            TRACE_1("Creating data store",true);

            // Create logistics data storage in memory on all localities
            GVAR(STORE) = [] call ALIVE_fnc_hashCreate;

            call ALiVE_fnc_combatSupport2FncInit;

            // Define module basics on server
            if (isServer) then {
                _errorMessage = "No ALiVE profile module or ALiVE not required, exiting. %1 %2";
                _error1 = ""; _error2 = ""; //defaults
                if(
                    !(["ALiVE_require"] call ALiVE_fnc_isModuleavailable) 
                    && !(["ALiVE_sys_profile"] call ALiVE_fnc_isModuleAvailable) 
                    ) exitwith {
                        [_errorMessage,_error1,_error2] call ALIVE_fnc_dumpR;
                };

                _errorMessage = "Original ALiVE Combat Support module detected, remove it from the map to use the new module. %1 %2";
                if( ["ALiVE_sup_combatsupport"] call ALiVE_fnc_isModuleAvailable ) exitWith {
                    [_errorMessage,_error1,_error2] call ALIVE_fnc_dumpR;
                };

                //not publicVariable to clients yet to let it init before
                NEO_radioLogic = _logic;

                _CS_Set_Respawn = NEO_radioLogic getvariable ["combatsupport_respawn","3"];
                CS_RESPAWN = parsenumber(_CS_Set_Respawn);
                _CAS_SET_RESPAWN_LIMIT = NEO_radioLogic getvariable ["combatsupport_casrespawnlimit","3"];
                CAS_RESPAWN_LIMIT = parsenumber(_CAS_SET_RESPAWN_LIMIT);
                _TRANS_SET_RESPAWN_LIMIT = NEO_radioLogic getvariable ["combatsupport_transportrespawnlimit","3"];
                TRANS_RESPAWN_LIMIT = parsenumber(_TRANS_SET_RESPAWN_LIMIT);
                _ARTY_SET_RESPAWN_LIMIT = NEO_radioLogic getvariable ["combatsupport_artyrespawnlimit","3"];
                ARTY_RESPAWN_LIMIT = parsenumber(_ARTY_SET_RESPAWN_LIMIT);

                _transportArrays = [];
                _casArrays = [];
                _artyArrays = [];
                _sides = [WEST,EAST,RESISTANCE,CIVILIAN];

                for "_i" from 0 to ((count synchronizedObjects _logic)-1) do {
                    private["_obj","_unit","_roles","_syncedObjs","_overrideModule"];
                    private["_veh","_position","_direction","_type","_id","_height","_callsign"];
                    _obj = ((synchronizedObjects _logic) select _i);
                    if(_obj isKindOf "Logic" ) then {

                    } else {
                        _veh =  vehicle (leader (group _obj));
                        _roles = [MOD(SUP_COMBATSUPPORT2),"getPotentialSupportRoles",[_veh]] call MAINCLASS;
                        diag_log format["Adding %1",typeof (vehicle _veh)];
                        _position = getposATL (vehicle _veh);
                        _direction = getDir (vehicle _veh);
                        _type = typeOf (vehicle _veh);
                        _id = [_position] call ALiVE_fnc_getNearestAirportID;
                        _height = _position select 2;
                        _callsign = groupId (group (vehicle _veh));
                        _vehName = vehicleVarName _veh;
                        _veh setVariable["NEO_radioBasePosition",_position,true];
                        diag_log format["%1 has %2",_obj,_roles];
                        
                        //look for an override module
                        _syncedObjs = (synchronizedObjects _obj);
                        _overrideModule = objNull;
                        { if(typeOf _x == "ALIVE_sup_combatsupport2_override") exitWith{_overrideModule = _x;}; } forEach _syncedObjs;

                        {
                            switch(_x) do {
                                case "transport": {
                                    _transportArray = [_position,_direction,_type, _callsign,["Pickup", "Land", "land (Eng off)", "Move", "Circle","Insertion"],{},_height, _veh];
                                    _transportArrays set [count _transportArrays, _transportArray];
                                };
                                case "artillery": {
                                    private["_ordnance"];
                                    //_ordnance =[["HE",30]];
                                    _ordnance = [];
                                    _vehicles = [];
                                    {
                                        _grpVeh = vehicle _x;
                                        if !(_grpVeh in _vehicles) then {
                                            _vehicles set [count _vehicles,_grpVeh];
                                            _magazines = magazinesAmmoFull _grpVeh;
                                            {
                                                _magType = _x select 0;
                                                _magCount = _x select 1;
                                                _foundMatch = false;
                                                {
                                                    if ( (_x select 0) == _magType ) exitWith {
                                                        _x set[1,(_x select 1) + _magCount];
                                                        _foundMatch = true;
                                                    };

                                                } forEach _ordnance;
                                                if (!_foundMatch) then {
                                                    _ordnance set [count _ordnance, [_magType,_magCount]];
                                                };
                                            } forEach _magazines;
                                        };
                                    } forEach (units (group (leader _veh)));

                                    diag_log format["%1 with ordnance %2",_vehicles,_ordnance];

                                    if( !isNull _overrideModule ) then {

                                    };
                                    _artyArray = [_position, _type, _callsign,3,_ordnance,{},_veh];
                                    _artyArrays set [count _artyArrays, _artyArray];
                                };
                                case "cas": {
                                    _casArray = [_position,_direction, _type, _callsign, _id,{},_height,_veh];
                                    _casArrays set [count _casArrays, _casArray];
                                };
                            };
                        } forEach _roles;
                    };
                };

                SUP_CASARRAYS  = _casArrays; PublicVariable "SUP_CASARRAYS";
                SUP_TRANSPORTARRAYS  = _transportArrays; PublicVariable "SUP_TRANSPORTARRAYS";
                SUP_ARTYARRAYS = _artyArrays; PublicVariable "SUP_ARTYARRAYS";

                {
                    NEO_radioLogic setVariable [format ["NEO_radioTrasportArray_%1", _x], [],true];
                    NEO_radioLogic setVariable [format ["NEO_radioCasArray_%1", _x], [],true];
                    NEO_radioLogic setVariable [format ["NEO_radioArtyArray_%1", _x], [],true];
                } foreach _sides;

                private ["_t", "_c", "_a"];
                _t = [];
                _c = [];
                _a = [];


                // Transport
                
                {
                    private ["_pos", "_dir", "_type", "_callsign", "_tasks", "_code","_Height","_side"];
                    private ["_veh"];
                    _pos = _x select 0; _pos set [2, 0];
                    _type = _x select 2;
                    _callsign = toUpper (_x select 3);
                    _tasks = _x select 4;
                    _code = _x select 5;
                    _height = _x select 6;
                    _veh = _x select 7;

                    _faction = gettext(configfile >> "CfgVehicles" >> _type >> "faction");
                    _side = side _veh;

                    // set ownership flag for other modules
                    _veh setVariable ["ALIVE_CombatSupport", true];
                    _grp = group _veh;
                    _veh lockDriver true;
                    _callsign = groupId (group (driver _veh));
                    [_veh] spawn _code;
                    _veh setVariable ["NEO_transportAvailableTasks", _tasks, true];
                    _veh setVariable ["ALIVE_supportAvailabletasks",_tasks,true];

                    //_transportfsm = "\x\alive\addons\sup_combatSupport2\scripts\NEO_radio\fsms\transport.fsm";
                    _transportfsm = "\x\alive\addons\sup_combatSupport2\scripts\NEO_radio\fsms\support.fsm";
                    [_grp, _pos] execFSM _transportfsm;
                    //[_veh,_pos,0.2] execFSM _transportfsm;
                    //[_veh, _grp, _callsign, _pos, direction _veh, _height, _type, CS_RESPAWN] execFSM _transportfsm;

                    _t = NEO_radioLogic getVariable format ["NEO_radioTrasportArray_%1", _side];
                    _t set [count _t, [_veh, _grp, _callsign]];

                    NEO_radioLogic setVariable [format ["NEO_radioTrasportArray_%1", _side], _t,true];

                } forEach SUP_TRANSPORTARRAYS;



                // CAS

                {
                    private ["_pos", "_dir", "_type", "_callsign", "_airport", "_code","_side"];
                    private ["_veh"];
                    _pos = _x select 0; _pos set [2, 0];
                    _dir = _x select 1;
                    _type = _x select 2;
                    _callsign = toUpper (_x select 3);
                    _airport = _x select 4;
                    _code = _x select 5;
                    _height = _x select 6;
                    _veh = _x select 7;

                    _faction = gettext(configfile >> "CfgVehicles" >> _type >> "faction");
                    _side = side _veh; //getNumber(configfile >> "CfgVehicles" >> _type >> "side");

                    // set ownership flag for other modules
                    _veh setVariable ["ALIVE_CombatSupport", true];


                    private ["_grp"];
                    _grp = group _veh;
                    _veh lockDriver true;
                    _callsign = groupId (group (driver _veh));
                    [_veh] spawn _code;

                    _casfsm = "\x\alive\addons\sup_combatSupport\scripts\NEO_radio\fsms\cas.fsm";

                    //FSM
                    [_veh, _grp, _callsign, _pos, _airport, _dir, _height, _type, CS_RESPAWN] execFSM _casfsm;

                    _c = NEO_radioLogic getVariable format ["NEO_radioCasArray_%1", _side];
                    _c set [count _c, [_veh, _grp, _callsign]];

                    NEO_radioLogic setVariable [format ["NEO_radioCasArray_%1", _side], _c,true];

                } forEach SUP_CASARRAYS;



                // ARTY

                {
                    private ["_pos", "_class", "_callsign", "_unitCount", "_rounds", "_code", "_roundsUnit", "_roundsAvailable", "_canMove", "_units", "_grp", "_vehDir"];
                    private ["_veh"];
                    _pos = _x select 0; _pos set [2, 0];
                    _class = _x select 1;
                    _callsign = toUpper (_x select 2);
                    _unitCount = round (_x select 3); if (_unitCount > 4) then { _unitCount = 4 }; if (_unitCount < 1) then { _unitCount = 1 };
                    _rounds = _x select 4;
                    _code = _x select 5;
                    _veh = _x select 6;

                    _side = getNumber(configfile >> "CfgVehicles" >> _class >> "side");

                    switch (_side) do {
                        case 0 : {_side = EAST};
                        case 1 : {_side = WEST};
                        case 2 : {_side = RESISTANCE};
                        default {_side = EAST};
                    };

                    //_roundsUnit = _class call NEO_fnc_artyUnitAvailableRounds;
                    _roundsUnit = [];
                    { _roundsUnit set [count _roundsUnit,_x select 0]; } forEach _rounds;
                    _roundsAvailable = [];
                    if(_veh isKindOf "StaticMortar") then {
                        _canMove = false;
                    } else {
                        _canMove = canMove _veh;
                    };
                    //diag_log format["Artillery can move: %1",canmove _veh];
                    _units = [];
                    _grp = group _veh; //_grp = createGroup _side;
                    _vehDir = 0;

                    if (_side == WEST && _class == "BUS_MotInf_MortTeam") then {
                        // Spawn a mortar team :)
                        {
                            _units set [count _units, _x];
                            _x setVariable ["ALIVE_CombatSupport", true];
                        } foreach units _grp;

                    } else {
                        private ["_vehPos","_i"];
                        {
                            if !( (vehicle _x) in _units ) then {
                                _units set[count _units,vehicle _x];
                                (vehicle _x) setVariable ["ALIVE_CombatSupport", true];
                            };
                        } forEach (units _grp);
                    };

                    { _x setVariable ["NEO_radioArtyModule", [leader _grp, _callsign], true] } forEach _units;

                    _callsign = groupId (group _veh);
                    //[[(units _grp select 0),_callsign], "fnc_setGroupID", false, false] spawn BIS_fnc_MP;

                    //[_veh, _grp, _units, units _grp] spawn _code;
                    diag_log format["%1 %2",_veh,_rounds];
                    //Validate rounds
                    {
                        if ((_x select 0) in _roundsUnit) then
                        {
                            _roundsAvailable set [count _roundsAvailable, _x];
                        };
                    } forEach _rounds;

                    leader _grp setVariable ["NEO_radioArtyBatteryRounds", _roundsAvailable, true];

                    //FSM
                    [_units, _grp, _callsign, _pos, _roundsAvailable, _canMove, _class, leader _grp] execFSM "\x\alive\addons\sup_combatSupport\scripts\NEO_radio\fsms\alivearty.fsm";

                    _a = NEO_radioLogic getVariable format ["NEO_radioArtyArray_%1", _side];
                    _a set [count _a, [leader _grp, _grp, _callsign, _units, _roundsAvailable]];

                    NEO_radioLogic setVariable [format ["NEO_radioArtyArray_%1", _side], _a, true];

                } forEach SUP_ARTYARRAYS;




                for "_i" from 0 to ((count _sides)-1) do {
                    _sideIn = _sides select _i;

                    {
                        if (!(_sideIn == _x) && {(_sideIn getfriend _x >= 0.6)}) then {
                            private ["_sideInArray","_xArray"];
                            _sideInArray = NEO_radioLogic getVariable format["NEO_radioTrasportArray_%1", _sideIn];
                            _xArray = NEO_radioLogic getVariable format["NEO_radioTrasportArray_%1", _x];

                            if (count _xArray > 0) then {
                                _add = [];
                                {
                                    _vehicle = _x select 0;
                                    if (({_vehicle == _x select 0} count _sideInArray) == 0) then {
                                        _add set [count _add,_x];
                                    };
                                } foreach _xArray;
                                NEO_radioLogic setVariable [format ["NEO_radioTrasportArray_%1", _sideIn], _sideInArray + _add,true];
                            };

                            private ["_sideInArray","_xArray"];
                            _sideInArray = NEO_radioLogic getVariable format["NEO_radioCasArray_%1", _sideIn];
                            _xArray = NEO_radioLogic getVariable format["NEO_radioCasArray_%1", _x];

                            if (count _xArray > 0) then {
                                _add = [];
                                {
                                    _vehicle = _x select 0;
                                    if (({_vehicle == _x select 0} count _sideInArray) == 0) then {
                                        _add set [count _add,_x];
                                    };
                                } foreach _xArray;
                                NEO_radioLogic setVariable [format ["NEO_radioCasArray_%1", _sideIn], _sideInArray + _add,true];
                            };

                            private ["_sideInArray","_xArray"];
                            _sideInArray = NEO_radioLogic getVariable format["NEO_radioArtyArray_%1", _sideIn];
                            _xArray = NEO_radioLogic getVariable format["NEO_radioArtyArray_%1", _x];

                            if (count _xArray > 0) then {
                                _add = [];
                                {
                                    _vehicle = _x select 0;
                                    if (({_vehicle == _x select 0} count _sideInArray) == 0) then {
                                        _add set [count _add,_x];
                                    };
                                } foreach _xArray;
                                NEO_radioLogic setVariable [format ["NEO_radioArtyArray_%1", _sideIn], _sideInArray + _add,true];
                            };
                        };
                    } foreach _sides;
                };


                GVAR(STORE) call ALIVE_fnc_inspectHash;
            
                [_logic,"state",GVAR(STORE)] call ALiVE_fnc_combatsupport2;
                
                _logic setVariable ["init", true, true];
                publicVariable "NEO_radioLogic";
            };

            /*
            CONTROLLER  - coordination
            */

            // Wait until server init is finished
            waituntil {_logic getvariable ["init",false]};
            
            TRACE_1("Spawning Server processes",isServer);
            
            if (isServer) then {
                // Start any server-side processes that are needed
            };

            TRACE_1("Spawning clientside processes",hasInterface);

            if (hasInterface) then {
                // Start any client-side processes that are needed
                // and wait for game logic to initialise
                // TODO merge into lazy evaluation
                waitUntil {!isNil "NEO_radioLogic"};
                waitUntil {NEO_radioLogic getVariable ["init", false]};

                /*
                VIEW - purely visual
                */
                NEO_radioLogic setVariable ["NEO_radioPlayerActionArray",
                    [
                        [
                            ("<t color=""#700000"">" + ("Talk To Pilot") + "</t>"),
                            {["talk"] call ALIVE_fnc_radioAction},
                            "talk",
                            -1,
                            false,
                            true,
                            "",
                            "
                                ({(_x select 0) == vehicle _this} count (NEO_radioLogic getVariable format ['NEO_radioTrasportArray_%1', playerSide]) > 0)
                                &&
                                {alive (driver (vehicle _this))}
                            "
                        ]
                    ]
                ];

                {player addAction _x} foreach (NEO_radioLogic getVariable "NEO_radioPlayerActionArray");
                player addEventHandler ["Respawn", { {(_this select 0) addAction _x } foreach (NEO_radioLogic getVariable "NEO_radioPlayerActionArray") }];

                //if there is a real screen it must be a player so hand out the menu item
                if (hasInterface) then {
                    //Initialise Functions and add respawn eventhandler
                    waituntil {(!(isnull player) && !(isnil "NEO_radioLogic"))};

                    if (isNil "SELF_INTERACTION_KEY") then {SELF_INTERACTION_KEY = [221,[false,false,false]]};

                    // if A2 - ACE spectator enabled, seto to allow exit
                    if(!isNil "ace_fnc_startSpectator") then {ace_sys_spectator_can_exit_spectator = true};

                    // check if player has item defined in module TODO!

                    // initialise main menu
                    [
                            "player",
                            [SELF_INTERACTION_KEY],
                            -9500,
                            [
                                    "call ALIVE_fnc_CombatSupportMenuDef",
                                    "main"
                            ]
                    ] call ALIVE_fnc_flexiMenu_Add;
                };
            };
            
           
            TRACE_1("After module init",_logic);
            
            // Indicate Init is finished on server
            if (isServer) then {
                _logic setVariable ["startupComplete", true, true];
            };
            
            ["%1 - Initialisation Completed...",MOD(SUP_COMBATSUPPORT2)] call ALiVE_fnc_Dump;
            
            _result = MOD(SUP_COMBATSUPPORT2);
        };

        case "state": {
            if ((isnil "_args") || {!isServer}) exitwith {_result = GVAR(STORE)};
            
            TRACE_1("ALiVE SYS COMBATSUPPORT2 state called",_logic);
           

            _result = GVAR(STORE);
        };
                        
        case "destroy": {
            [[_logic, "destroyGlobal",_args],"ALIVE_fnc_combatsupport2",true, false] call BIS_fnc_MP;
        };

        case "destroyGlobal": {

                [_logic, "debug", false] call MAINCLASS;

                if (isServer) then {
                        // if server
                        MOD(SUP_COMBATSUPPORT2) = _logic;

                        MOD(SUP_COMBATSUPPORT2) setVariable ["super", nil];
                        MOD(SUP_COMBATSUPPORT2) setVariable ["class", nil];
                        MOD(SUP_COMBATSUPPORT2) setVariable ["init", nil];
                                
                        // and publicVariable to clients
                        
                        publicVariable QMOD(SUP_COMBATSUPPORT2);
                        [_logic, "destroy"] call SUPERCLASS;

                        NEO_radioLogic = _logic;
                        publicVariable "NEO_radioLogic";
                };

                if (hasInterface) then {
                };
        };
                
        default {
            _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};


TRACE_1("ALiVE SYS COMBATSUPPORT2 - output",_result);

if !(isnil "_result") then {
    _result;
};
