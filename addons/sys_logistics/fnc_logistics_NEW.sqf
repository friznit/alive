#include <\x\alive\addons\sys_logistics\script_component.hpp>
SCRIPT(logistics);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_logistics
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
[_logic,"init"] call ALiVE_fnc_logistics;
(end)

See Also:
- <ALIVE_fnc_logisticsInit>

Author:
Highhead

Peer reviewed:
nil
---------------------------------------------------------------------------- */

#define SUPERCLASS ALIVE_fnc_baseClass
#define MAINCLASS ALIVE_fnc_logistics

private ["_result", "_operation", "_args", "_logic"];

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,nil);

///* Listener for special purposes
_blackOps = ["id"];
if !(_operation in _blackOps) then {
    _check = "nothing";
    if !(isnil "_args") then {_check = _args};
	["_operation %1 | _args %2 (is default)",_operation,_check] call ALiVE_fnc_DumpR;
};
//*/

TRACE_3("SYS_LOGISTICS",_logic, _operation, _args);

switch (_operation) do {
    
    	case "create": {
            _logic = (createGroup sideLogic) createUnit ["LOGIC", [0,0], [], 0, "NONE"];
            _result = _logic;
        };

        case "init": {
            
            // Ensure only one module is used
            if (isServer && !(isNil QMOD(SYS_LOGISTICS))) exitWith {
                    ERROR_WITH_TITLE(str _logic, localize "STR_ALIVE_LOGISTICS_ERROR1");
            };
            
            ["%1 - Initialisation started...",_logic] call ALiVE_fnc_Dump;

            /*
            MODEL - no visual just reference data
            - module object datastorage parameters
            - Establish data handler on server
            - Establish data model on server and client
            */
            
            TRACE_1("Creating class on all localities",true);
            
			// initialise module game logic on all localities
			_logic setVariable ["super", QUOTE(SUPERCLASS)];
			_logic setVariable ["class", QUOTE(MAINCLASS)];
            
            TRACE_1("Creating data store",true);

            // Create logistics data storage in memory on all localities
            GVAR(STORE) = [] call ALIVE_fnc_hashCreate;
            
            // Define logistics properties on all localities
            GVAR(CARRYABLE) = [["Man"],["Reammobox_F","Static","ThingX"]];
            GVAR(TOWABLE) = [["Truck_F"],["Car"]];
            GVAR(STOWABLE) = [["Car","Truck_F","Helicopter"],(GVAR(CARRYABLE) select 1)];
            GVAR(LIFTABLE) = [["Helicopter"],(GVAR(CARRYABLE) select 1) + (GVAR(TOWABLE) select 1)];
            
            //Define actions on all localities
			GVAR(ACTIONS) = {
	                [MOD(SYS_LOGISTICS),"addAction",[player,"carryObject"]] call ALiVE_fnc_logistics;
	                [MOD(SYS_LOGISTICS),"addAction",[player,"dropObject"]] call ALiVE_fnc_logistics;
	                [MOD(SYS_LOGISTICS),"addAction",[player,"stowObjects"]] call ALiVE_fnc_logistics;
	                [MOD(SYS_LOGISTICS),"addAction",[player,"unloadObjects"]] call ALiVE_fnc_logistics;
                    [MOD(SYS_LOGISTICS),"addAction",[player,"towObject"]] call ALiVE_fnc_logistics;
                    [MOD(SYS_LOGISTICS),"addAction",[player,"untowObject"]] call ALiVE_fnc_logistics;
                    [MOD(SYS_LOGISTICS),"addAction",[player,"liftObject"]] call ALiVE_fnc_logistics;
                    [MOD(SYS_LOGISTICS),"addAction",[player,"releaseObject"]] call ALiVE_fnc_logistics;
			};
                                    
			// Define module basics on server
			if (isServer) then {
                MOD(SYS_LOGISTICS) = _logic;
                
                // Set Module (default) parameters as correct types
                MOD(SYS_LOGISTICS) setVariable ["debug", call compile (_logic getvariable ["debug","false"]), true];

                //Wait for data to init?
                //not yet, but do so once pers is on the way for this module

                // Mock Data
                // _state = ["#CBA_HASH#",["B_Truck_01_transport_F_2342818642","Box_IND_Support_F_2344918632","B_MRAP_01_gmg_F_2343718643","Box_NATO_AmmoVeh_F_2345218636","C_Van_01_transport_F_2341918643","Box_NATO_Wps_F_2346518637","Land_Can_V1_F_2345818641","Box_NATO_WpsLaunch_F_2346618627","B_Heli_Light_01_F_2346018631","B_Soldier_F_2345518625"],[["#CBA_HASH#",["id","type","position","vectorDirAndUp","cargo"],["B_Truck_01_transport_F_2342818642","B_Truck_01_transport_F",[23438.5,18723.3,-0.00120616],[[0.939248,0.343063,-0.0110239],[0.0103529,0.00378736,0.99994]],[[],["B_MRAP_01_gmg_F_2343718643"],[],[[[],[]],[[],[]],[["FirstAidKit"],[4]]]]],""],["#CBA_HASH#",["id","type","position","vectorDirAndUp","cargo","container"],["Box_IND_Support_F_2344918632","Box_IND_Support_F",[23425.5,18718.4,0],[[0.526442,-0.850212,4.44089e-016],[0,0,1]],[[],[],[],[[["Binocular","Rangefinder","Laserdesignator"],[1,1,1]],[["Laserbatteries"],[5]],[["FirstAidKit","Medikit","ToolKit","MineDetector","ItemGPS","acc_flashlight","acc_pointer_IR","muzzle_snds_acp","muzzle_snds_L","muzzle_snds_M","muzzle_snds_H_MG","muzzle_snds_B","ALIVE_Tablet"],[10,1,1,1,5,5,5,5,5,5,1,5,4]]]],"B_MRAP_01_gmg_F_2343718643"],""],["#CBA_HASH#",["id","type","position","vectorDirAndUp","cargo","container"],["B_MRAP_01_gmg_F_2343718643","B_MRAP_01_gmg_F",[23426.9,18719,-0.0502141],[[0.939248,0.343063,-0.0110239],[0.0103529,0.00378736,0.99994]],[["Box_IND_Support_F_2344918632"],[],[],[[["arifle_MX_F"],[2]],[["30Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag","HandGrenade","1Rnd_HE_Grenade_shell","1Rnd_Smoke_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokeBlue_Grenade_shell","16Rnd_9x21_Mag","SmokeShell","SmokeShellGreen","SmokeShellOrange","SmokeShellBlue","NLAW_F"],[16,6,10,10,4,4,4,4,12,4,4,4,4,2]],[["FirstAidKit"],[10]]]],"B_Truck_01_transport_F_2342818642"],""],["#CBA_HASH#",["id","type","position","vectorDirAndUp","cargo","container"],["Box_NATO_AmmoVeh_F_2345218636","Box_NATO_AmmoVeh_F",[23435.9,18719.6,0],[[-0.306149,0.951983,8.27181e-025],[0,0,1]],[[],[],[],[[[],[]],[[],[]],[[],[]]]],"B_Truck_01_transport_F_2342818642"],""],["#CBA_HASH#",["id","type","position","vectorDirAndUp","cargo"],["C_Van_01_transport_F_2341918643","C_Van_01_transport_F",[23419.9,18643.1,0.0307512],[[8.05002e-005,0.999702,-0.0244217],[0.000906534,0.0244216,0.999701]],[["Box_NATO_Wps_F_2346518637"],[],[],[[[],[]],[[],[]],[["FirstAidKit"],[2]]]]],""],["#CBA_HASH#",["id","type","position","vectorDirAndUp","cargo","container"],["Box_NATO_Wps_F_2346518637","Box_NATO_Wps_F",[23419.2,18642.8,0],[[-0.998517,0.054448,0],[0,0,1]],[[],[],[],[[["arifle_MX_F","arifle_MX_GL_F","arifle_MX_SW_F","arifle_MXC_F","SMG_01_F","hgun_P07_F","hgun_Pistol_heavy_01_F"],[4,2,2,2,1,1,1]],[["30Rnd_65x39_caseless_mag","16Rnd_9x21_Mag","11Rnd_45ACP_Mag","30Rnd_45ACP_Mag_SMG_01","100Rnd_65x39_caseless_mag_Tracer"],[8,1,1,1,2]],[[],[]]]],"C_Van_01_transport_F_2341918643"],""],["#CBA_HASH#",["id","type","position","vectorDirAndUp","cargo","container"],["Land_Can_V1_F_2345818641","Land_Can_V1_F",[23459.9,18634.4,0],[[-0.00804819,0.999968,4.65663e-010],[0,0,1]],[[],[],[],[[[],[]],[[],[]],[[],[]]]],"B_Heli_Light_01_F_2346018631"],""],["#CBA_HASH#",["id","type","position","vectorDirAndUp","cargo","container"],["Box_NATO_WpsLaunch_F_2346618627","Box_NATO_WpsLaunch_F",[23463.5,18625.3,0],[[-0.998493,0.0548821,0],[0,0,1]],[[],[],[],[[["launch_Titan_F","launch_Titan_short_F","launch_NLAW_F"],[1,1,1]],[["Titan_AA","Titan_AT","Titan_AP","NLAW_F"],[3,3,3,3]],[[],[]]]],"B_Heli_Light_01_F_2346018631"],""],["#CBA_HASH#",["id","type","position","vectorDirAndUp","cargo"],["B_Heli_Light_01_F_2346018631","B_Heli_Light_01_F",[23460,18631.5,0.00622153],[[-0.000393216,0.999999,0.00153543],[1.92159e-006,-0.00153543,0.999999]],[[],[],[],[[["arifle_MXC_F"],[2]],[["SmokeShell","SmokeShellBlue","30Rnd_65x39_caseless_mag"],[2,2,4]],[["FirstAidKit","ToolKit","ItemGPS"],[2,1,1]]]]],""],["#CBA_HASH#",["id","type","position","vectorDirAndUp","cargo"],["B_Soldier_F_2345518625","B_Soldier_F",[23424.3,18720.1,0.00143886],[[0.526442,-0.850212,4.44089e-016],[0,0,1]],[[],[],[],[[[],[]],[[],[]],[[],[]]]]],""]],""];
            	_state = ["#CBA_HASH#",["B_Soldier_F_25395582","Box_IND_Support_F_25375583","C_Van_01_transport_F_25075594","Box_NATO_AmmoVeh_F_25405588","B_Truck_01_transport_F_25155594"],[["#CBA_HASH#",["id","type","position","vectorDirAndUp","cargo"],["B_Soldier_F_25395582","B_Soldier_F",[2513.03,5591.09,0.00120544],[[-0.0220995,0.999755,0],[0,0,1]],[[],[],[],[[[],[]],[[],[]],[[],[]]]]],""],["#CBA_HASH#",["id","type","position","vectorDirAndUp","cargo","container"],["Box_IND_Support_F_25375583","Box_IND_Support_F",[2509.87,5593.56,0.00128937],[[-0.983095,0.181101,-0.0269479],[-0.0374948,-0.0550684,0.997778]],[[],[],[],[[["Binocular","Rangefinder","Laserdesignator"],[1,1,1]],[["Laserbatteries"],[5]],[["FirstAidKit","Medikit","ToolKit","MineDetector","ItemGPS","acc_flashlight","acc_pointer_IR","muzzle_snds_acp","muzzle_snds_L","muzzle_snds_M","muzzle_snds_H_MG","muzzle_snds_B","ALIVE_Tablet"],[10,1,1,1,5,5,5,5,5,5,1,5,4]]]],"C_Van_01_transport_F_25075594"],""],["#CBA_HASH#",["id","type","position","vectorDirAndUp","cargo"],["C_Van_01_transport_F_25075594","C_Van_01_transport_F",[2548.58,5596.96,0.032753],[[0.995035,0.0947354,0.0305003],[-0.0444098,0.148383,0.987932]],[["Box_IND_Support_F_25375583"],[],[],[[[],[]],[[],[]],[["FirstAidKit"],[2]]]]],""],["#CBA_HASH#",["id","type","position","vectorDirAndUp","cargo","container"],["Box_NATO_AmmoVeh_F_25405588","Box_NATO_AmmoVeh_F",[2513.15,5593.95,0.0366364],[[-0.0243607,0.999243,0.0303292],[-0.0846194,-0.0322904,0.99589]],[[],[],[],[[[],[]],[[],[]],[[],[]]]],"B_Truck_01_transport_F_25155594"],""],["#CBA_HASH#",["id","type","position","vectorDirAndUp","cargo"],["B_Truck_01_transport_F_25155594","B_Truck_01_transport_F",[2519.42,5672.47,0.00487518],[[-0.0269835,0.996654,-0.0771549],[-0.0441564,0.0759193,0.996136]],[["Box_NATO_AmmoVeh_F_25405588"],[],[],[[[],[]],[[],[]],[["FirstAidKit"],[4]]]]],""]],""];
                
                // Reset states with provided data;
                //_state = GVAR(STORE);
                
                [_logic,"state",_state] call ALiVE_fnc_logistics;

                // Push to clients
                publicVariable QMOD(SYS_LOGISTICS);
			};

            /*
            CONTROLLER  - coordination
            - check if an object is currently moved (= nearObjects attached to player)
            */
            
            TRACE_1("Spawning Server processes",isServer);
            
            if (isServer) then {
                // Set eventhandlers for logistics objects
                [_logic,"setEH",[_logic,"allObjects"] call ALiVE_fnc_logistics] call ALiVE_fnc_logistics;
            };

			TRACE_1("Spawning clientside processes",hasInterface);

            if (hasInterface) then {
                // Add actions
                call GVAR(ACTIONS);
                
                // Set eventhandlers for player
                [_logic,"setEH",[player]] call ALiVE_fnc_logistics;
            };
            
            /*
            VIEW - purely visual
            - initialise menu
            - frequent check to modify menu and display status (ALIVE_fnc_logisticsmenuDef)
            */

			TRACE_1("Adding menu on clients",hasInterface);

			// The machine has an interface? Must be a MP client, SP client or a client that acts as host!
            if (hasInterface) then {
                
                // Wait until server init is finished
            	waitUntil {!isNil QMOD(SYS_LOGISTICS)};
            
                // Initialise interaction key if undefined
                if (isNil "SELF_INTERACTION_KEY") then {SELF_INTERACTION_KEY = [221,[false,false,false]];};

                TRACE_2("Menu pre-req",SELF_INTERACTION_KEY,ALIVE_fnc_logisticsMenuDef);

                // Initialise main menu
                [
                        "player",
                        [SELF_INTERACTION_KEY],
                        -9500,
                        [
                                "call ALIVE_fnc_logisticsMenuDef",
                                "main"
                        ]
                ] call ALiVE_fnc_flexiMenu_Add;
            };

            TRACE_1("After module init",_logic);
            
            // Indicate Init is finished on server
            if (isServer) then {
            	MOD(SYS_LOGISTICS) setVariable ["init", true, true];
            };
            
            ["%1 - Initialisation Completed...",MOD(SYS_LOGISTICS)] call ALiVE_fnc_Dump;
            
            _result = MOD(SYS_LOGISTICS);
        };
        
        case "destroy": {
            [[_logic, "destroyGlobal",_args],"ALIVE_fnc_logistics",true, false] call BIS_fnc_MP;
        };

        case "destroyGlobal": {

                [_logic, "debug", false] call MAINCLASS;

                if (isServer) then {
                		// if server
                        MOD(SYS_LOGISTICS) = _logic;

                        MOD(SYS_LOGISTICS) setVariable ["super", nil];
                        MOD(SYS_LOGISTICS) setVariable ["class", nil];
                        MOD(SYS_LOGISTICS) setVariable ["init", nil];
                                
                        // and publicVariable to clients
                        
                        publicVariable QMOD(SYS_LOGISTICS);
                        [_logic, "destroy"] call SUPERCLASS;
                };

                if (hasInterface) then {
                    	{[MOD(SYS_LOGISTICS),"removeAction",[player,_x]] call ALiVE_fnc_logistics} foreach ["carryObject","dropObject","stowObjects","unloadObjects","towObject","untowObject","liftObject","releaseObject"];
                    
                        // remove main menu
                        [
                                "player",
                                [SELF_INTERACTION_KEY],
                                -9500,
                                [
                                        "call ALIVE_fnc_logisticsMenuDef",
                                        "main"
                                ]
                        ] call ALiVE_fnc_flexiMenu_Remove;
                };
        };
        
        case "state" : {
            if ((isnil "_args") || {!isServer}) exitwith {_result = GVAR(STORE)};
            
            // Check if provided data is valid
            if (count (_args select 1) == 0) exitwith {};
            
            private ["_collection"];
            
            //Reset store with provided data
            GVAR(STORE) set [1,_args select 1];
            GVAR(STORE) set [2,_args select 2];
            
            // Set defaults
            _createdObjects = [];
            _existing = [];
            _blacklist = ["Man"];
            
            // Get all logistics objects
			_startObjects = [_logic,"allObjects"] call ALiVE_fnc_logistics;
            {[_logic,"id",[_x]] call ALiVE_fnc_logistics} foreach _startObjects;
            
            // Set EHs
            [_logic,"setEH",_startObjects] call ALiVE_fnc_logistics;
            
            //Match exisiting ones against store
            {
                private ["_id","_args"];

                _id = [MOD(SYS_LOGISTICS),"id",_x] call ALiVE_fnc_logistics;
                _args = [GVAR(STORE),_id] call ALiVE_fnc_HashGet;

                if !(isnil "_args") then {
                    private ["_pos","_vDirUp","_container","_cargo"];
					_existing set [count _existing,_id];
                };
            } foreach _startObjects;

            // Create non existing vehicles
            {
                private ["_args","_object"];

                _args = [GVAR(STORE),_x] call ALiVE_fnc_HashGet;
                _type = ([_args,"type"] call ALiVE_fnc_hashGet);
                
                if (({_type iskindOf _x} count _blacklist) == 0) then {
					_object = _type createVehicle ([_args,"position"] call ALiVE_fnc_hashGet);
	                _object setvariable [QGVAR(ID),_x,true];
	                
	                _createdObjects set [count _createdObjects,_object];
                } else {
                    TRACE_1("ALiVE SYS LOGISTICS Removing non-existing unit from store!",_x);
                    
                    [_logic,"removeObject",_x] call ALiVE_fnc_logistics;
                };
             } foreach ((GVAR(STORE) select 1) - _existing);
          
             // Reset state
             {
             	_args = [GVAR(STORE),_x getvariable QGVAR(ID)] call ALiVE_fnc_HashGet;
             	if !(isnil "_args") then {[_x,_args] call ALiVE_fnc_setObjectState};
             } foreach (_startObjects + _createdObjects);

            _result = GVAR(STORE);
        };

        case "setEH" : {
            if (isnil "_args") exitwith {};
            
            private ["_objects"];

			switch (typeName _args) do {
                case ("OBJECT") : {_objects = [_args]};
                case ("ARRAY") : {_objects = _args};
                default {_objects = _args};
            };
       
            {
                private ["_object"];
                
                _object = _x;
                
	            //Clientside only section below
	            if (hasInterface) then {
	            	//apply these EHs on players
	                _object setvariable [QGVAR(EH_RESPAWN), _object getvariable [QGVAR(EH_RESPAWN), _object addEventhandler ["Respawn", GVAR(ACTIONS)]]];
	            };
	            
	            //Serverside only section below
	            if (isServer) then {
		            //apply these EHs on all objects
		            _object setvariable [QGVAR(EH_KILLED), _object getvariable [QGVAR(EH_KILLED), _object addEventHandler ["Killed", {[ALiVE_SYS_LOGISTICS,"removeObject",_this select 0] call ALIVE_fnc_logistics}]]];
		            
		            //apply these EHs on vehicles
		            if (_object isKindOf "LandVehicle" || {_object isKindOf "Air"}) then {
		            	_object setvariable [QGVAR(EH_GETOUT), _object getvariable [QGVAR(EH_GETOUT), _object addEventHandler ["GetOut", {if ((_this select 1) == "driver") then {[ALiVE_SYS_LOGISTICS,"updateObject",_this select 0] call ALIVE_fnc_logistics}}]]];
		            };
	            };
            } foreach _objects;
            
            _result = _objects;
        };
                        
        case "id" : {
            if (isnil "_args") exitwith {};
            
            private ["_object","_id"];
            
            _object = [_args, 0, objNull, [objNull,""]] call BIS_fnc_param;
			_id = _object getvariable QGVAR(ID);
            
            if (isnil "_id") then {
				_id = format["%1_%2%3",typeof _object, floor(getposATL _object select 0),floor(getposATL _object select 1)];
				_object setvariable [QGVAR(ID),_id,true];
            };

            _result = _id;
        };

        case "updateObject": {
            if (isnil "_args") exitwith {};
            
            private ["_objects"];

            switch (typeName _args) do {
                case ("ARRAY") : {_objects = _args};
                case ("OBJECT") : {_objects = [_args]};
                default {_objects = []};
            };
            
            {
            	private ["_args","_id","_cont"];
                
                //Ensure object is existing
                if (!(isnil "_x") && {!(isNull _x)}) then {
	                _id = [_logic,"id",_x] call ALiVE_fnc_logistics;
					_args = [GVAR(STORE),_id] call ALiVE_fnc_HashGet;
		            
                    //Create objecthash and add to store if not existing yet
		            if (isnil "_args") then {
		                _args = [] call ALIVE_fnc_hashCreate;
		                [GVAR(STORE),_id,_args] call ALiVE_fnc_HashSet;
		            };
	                
                    //Set static data
	                [_args,"id",_id] call ALiVE_fnc_HashSet;
		            [_args,"type",typeof _x] call ALiVE_fnc_HashSet;
		            [_args,"position",getposATL _x] call ALiVE_fnc_HashSet;
		            [_args,"vectorDirAndUp",[vectorDir _x,vectorUp _x]] call ALiVE_fnc_HashSet;
                    [_args,"cargo",[_x] call ALiVE_fnc_getObjectCargo] call ALiVE_fnc_HashSet;
					
                    //Set dynamic data (to fight errors on loading back existing data from DB)
                    if (!isnil {_x getvariable QGVAR(CONTAINER)} && {!isnull (_x getvariable QGVAR(CONTAINER))}) then {
                        [_args,"container",(_x getvariable QGVAR(CONTAINER)) getvariable QGVAR(ID)] call ALiVE_fnc_HashSet;
                    };
                    
		            //_args call ALiVE_fnc_InspectHash;
                };
            } foreach _objects;
            
            _result = _args;
        };
        
        case "allObjects" : {
			if (isnil "_args" || {isnull _args}) then {_args = []};
            
            private ["_position","_radius","_list","_objects"];

            _position = [_args, 0, getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition")] call BIS_fnc_param;
            _radius = [_args, 1, 30000] call BIS_fnc_param;
            _list = [_args, 2, ["Reammobox_F","Static","ThingX","Truck_F","Car","Helicopter"]] call BIS_fnc_param;
            
            _objects = [];
            {
            	private ["_object"];
                
	            _object = _x;
	            if ((_x distance _position <= _radius) && {({_object iskindOf _x} count _list) > 0}) then {
	                _objects set [count _objects,_object];
	            };
            } foreach (allMissionObjects "");
            
            _result = _objects;
        };
        
        case "removeObject": {
			if (isnil "_args") exitwith {};
            
            private ["_object","_id"];
            
            _object = [_args, 0, objNull, [objNull,""]] call BIS_fnc_param;

            switch (typeName _object) do {
                case ("OBJECT") : {_id = _object getvariable QGVAR(ID)};
                case ("STRING") : {[GVAR(STORE),_object] call ALiVE_fnc_HashRem};
            };
            
            if (isnil "_id") exitwith {_result = _object};

			[GVAR(STORE),_id] call ALiVE_fnc_HashRem;
            _object setvariable [QGVAR(ID),nil,true];
            
            //GVAR(STORE) call ALiVE_fnc_InspectHash;
            
            _result = GVAR(STORE) select 1;
        };
                        
        case "addAction": {
	        private ["_object","_operation","_id","_condition","_text","_input","_container","_die"];
	
			_object = [_args, 0, objNull, [objNull,[]]] call BIS_fnc_param;
			_operation = [_args, 1, "", [""]] call BIS_fnc_param;
			
			switch (typename _object) do {
			    case ("ARRAY") : {_object = _object select 0};
			    default {};
			};
            
            _id = (_object getvariable [format["ALiVE_SYS_LOGISTICS_%1",_operation],-1]); if (_id > -1) exitwith {_result = _id};
			
			switch (_operation) do {
				case ("carryObject") : {
                    _text = "Carry object";
                	_input = "cursortarget";
                    _container = "_this select 1";
                    _condition = "isnil {cursortarget getvariable 'ALiVE_SYS_LOGISTICS_CONTAINER'} && {cursortarget distance _target < 5} && {[cursortarget,_target] call ALiVE_fnc_canCarry}";
				};
			    case ("dropObject") : {
                    _text = "Drop object";
                    _input = "(attachedObjects (_this select 1)) select 0";
                    _container = "_this select 1";
                    _condition = "(count (attachedObjects player)) > 0";
                };
                case ("unloadObjects") : {
                    _text = "Load out cargo"; 
                    _input = "cursortarget"; 
                    _container = "((nearestObjects [_this select 1, ALiVE_SYS_LOGISTICS_STOWABLE select 0, 8]) select 0)"; 
                    _condition = "count (cursortarget getvariable ['ALiVE_SYS_LOGISTICS_CARGO',[]]) > 0";
                };
                case ("stowObjects") : {
                    _text  = "Stow in cargo"; 
                    _input = "objNull"; 
                    _container = "cursortarget"; 
                    _condition = "cursortarget distance _target < 5 && {[((nearestObjects [cursortarget, ALiVE_SYS_LOGISTICS_STOWABLE select 1, 8]) select 0),cursortarget] call ALiVE_fnc_canStow}";
                };
                case ("towObject") : {
                    _text  = "Tow object";
                    _input = "cursortarget";
                    _container = "((nearestObjects [_this select 1, ALiVE_SYS_LOGISTICS_TOWABLE select 0, 8]) select 0)";
                    _condition = "cursortarget distance player < 5 && {[cursortarget,(nearestObjects [cursortarget, ALiVE_SYS_LOGISTICS_TOWABLE select 0, 8]) select 0] call ALiVE_fnc_canTow}";
                };
                case ("untowObject") : {
                    _text  = "Untow object";
                    _input = "cursortarget";
                    _container = "attachedTo cursortarget";
                    _condition = "cursortarget distance _target < 5 && {{_x == cursortarget} count ((attachedTo cursortarget) getvariable ['ALiVE_SYS_LOGISTICS_CARGO_TOW',[]]) > 0}";
                };
                case ("liftObject") : {
                    _text  = "Lift object";
                    _input = "((nearestObjects [vehicle (_this select 1), ALiVE_SYS_LOGISTICS_LIFTABLE select 1, 15]) select 0)";
                    _container = "vehicle (_this select 1)";
                    _condition = "(getposATL (vehicle _target) select 2) > 5 && {(getposATL (vehicle _target) select 2) < 15} && {[(nearestObjects [vehicle (_target), ALiVE_SYS_LOGISTICS_LIFTABLE select 1, 15]) select 0, vehicle _target] call ALiVE_fnc_canLift}";
                };
                case ("releaseObject") : {
                    _text  = "Release object";
                    _input = "attachedObjects (vehicle (_this select 1)) select 0";
                    _container = "vehicle (_this select 1)";
                    _condition = "(getposATL (vehicle _target) select 2) > 5 && {(getposATL (vehicle _target) select 2) < 15} && {count ((vehicle _target) getvariable ['ALiVE_SYS_LOGISTICS_CARGO_LIFT',[]]) > 0}";
            	};
                default {_die = true};
			};
            
            if !(isnil "_die") exitwith {_result = -1};
			
			_id = _object addAction [
				_text,
				{[MOD(SYS_LOGISTICS),(_this select 3 select 0),[call compile (_this select 3 select 1), call compile (_this select 3 select 2)]] call ALiVE_fnc_logistics},
				[_operation,_input,_container],
				1,
				false,
				true,
				"",
				_condition
			];
            
            _object setvariable [format["ALiVE_SYS_LOGISTICS_%1",_operation],_id];
			
			_result = _id;
        };

        case "removeAction": {
            if (isnil "_args") exitwith {};
            
	        private ["_object","_action","_id"];
	
			_object = [_args, 0, objNull, [objNull,[]]] call BIS_fnc_param;
			_action = [_args, 1, "", [""]] call BIS_fnc_param;

			_id = _object getvariable [format["ALiVE_SYS_LOGISTICS_%1",_action],-1];
            _object setvariable [format["ALiVE_SYS_LOGISTICS_%1",_operation],nil];
            _object removeAction _id;
            
			_result = _id;
        };
        
        case "carryObject": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container","_objectID","_containerID"];

            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            _objectID = [_logic,"id",_object] call ALiVE_fnc_logistics;
            _containerID = [_logic,"id",_container] call ALiVE_fnc_logistics;
            
            if !([_object,_container] call ALiVE_fnc_canCarry) exitwith {};
			
            _object attachTo [_container];
            
            [[_logic,"updateObject",[_container,_object]],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;
           
            _result =_container; 
        };
        
        case "dropObject": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container","_objectID","_containerID"];
            
            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            _objectID = [_logic,"id",_object] call ALiVE_fnc_logistics;
            _containerID = [_logic,"id",_container] call ALiVE_fnc_logistics;
            
            if ([_object,_container] call ALiVE_fnc_canCarry) exitwith {};
            
            // Detach and reposition for a save placement
            detach _object;
            _object setposATL [getposATL _object select 0, getposATL _object select 1,0];
            _object setvelocity [0,0,-1];
            
            [[_logic,"updateObject",[_container,_object]],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;         
            
            _result = _object;
        };
        
		case "stowObject": {
            if (isnil "_args") exitwith {};
            
            //Do it globally so all clients are updated correctly all the time
            if !(isServer) exitwith {
                [[_logic, _operation, _args],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;
            };
            
            private ["_object","_container","_objectID","_containerID"];
            
            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            _objectID = [_logic,"id",_object] call ALiVE_fnc_logistics;
            _containerID = [_logic,"id",_container] call ALiVE_fnc_logistics;
            
            if !([_object,_container] call ALiVE_fnc_canStow) exitwith {};
            
            [_logic,"dropObject",[_object,player]] call ALiVE_fnc_logistics;

            _object setvariable [QGVAR(CONTAINER),_container,true];
            _container setvariable [QGVAR(CARGO),(_container getvariable [QGVAR(CARGO),[]]) + [_object],true];

			if (isMultiplayer && isServer) then {_object hideObjectGlobal true; _object enableSimulationGlobal false} else {_object hideObject true; _object enableSimulation false};

			[_logic,"updateObject",[_container,_object]] call ALIVE_fnc_logistics;
            
            _result = _container;
        };
        
        case "stowObjects": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container","_objectID","_containerID"];
            
            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            _objectID = [_logic,"id",_object] call ALiVE_fnc_logistics;
            _containerID = [_logic,"id",_container] call ALiVE_fnc_logistics;
 
            {[_logic,"stowObject",[_x,_container]] call ALiVE_fnc_logistics} foreach (nearestObjects [_container, GVAR(STOWABLE) select 1, 15]);
            
            _result = _container;
        };
        
        case "unloadObject": {
            if (isnil "_args") exitwith {};
            
            //Do it globally so all clients are updated correctly all the time
            if !(isServer) exitwith {
                [[_logic, _operation, _args],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;
            };

            private ["_object","_container","_objectID","_containerID"];
            
            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            _objectID = [_logic,"id",_object] call ALiVE_fnc_logistics;
            _containerID = [_logic,"id",_container] call ALiVE_fnc_logistics;
            
			if ([_object,_container] call ALiVE_fnc_canStow) exitwith {};

            _object setvariable [QGVAR(CONTAINER),nil,true];
            _container setvariable [QGVAR(CARGO),(_container getvariable [QGVAR(CARGO),[]]) - [_object],true];
            
			_object setpos ([getpos _container, 0, 15, 2, 0, 20, 0, [],[[getpos _container,20] call CBA_fnc_Randpos]] call BIS_fnc_findSafePos);
			if (isMultiplayer && isServer) then {_object hideObjectGlobal false; _object enableSimulationGlobal true} else {_object hideObject false; _object enableSimulation true};

			[_logic,"updateObject",[_container,_object]] call ALIVE_fnc_logistics;
            
            _result = _container;
        };
        
        case "unloadObjects": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container","_objectID","_containerID"];
            
            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            _objectID = [_logic,"id",_object] call ALiVE_fnc_logistics;
            _containerID = [_logic,"id",_container] call ALiVE_fnc_logistics;
            
            {[_logic,"unloadObject",[_x,_container]] call ALiVE_fnc_logistics} foreach (_container getvariable [QGVAR(CARGO),[]]);
            
            _result = _container;
        };
        
        case "towObject": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container","_objectID","_containerID"];
            
            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            _objectID = [_logic,"id",_object] call ALiVE_fnc_logistics;
            _containerID = [_logic,"id",_container] call ALiVE_fnc_logistics;
            
            if !([_object,_container] call ALiVE_fnc_canTow) exitwith {};
            
            _object attachTo [_container, [
				0,
				(boundingBox _container select 0 select 1) + (boundingBox _container select 0 select 1) + 2,
				(boundingBox _container select 0 select 2) - (boundingBox _container select 0 select 2) + 0.4
			]];
            
            _object setvariable [QGVAR(CONTAINER),_container,true];
            _container setvariable [QGVAR(CARGO_TOW),(_container getvariable [QGVAR(CARGO_TOW),[]]) + [_object],true];

			[[_logic,"updateObject",[_container,_object]],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;

            _result = _container;
        };
        
        case "untowObject": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container","_objectID","_containerID"];
            
            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            _objectID = [_logic,"id",_object] call ALiVE_fnc_logistics;
            _containerID = [_logic,"id",_container] call ALiVE_fnc_logistics;
            
            if ([_object,_container] call ALiVE_fnc_canTow) exitwith {};

            _object setvariable [QGVAR(CONTAINER),nil,true];
            _container setvariable [QGVAR(CARGO_TOW),(_container getvariable [QGVAR(CARGO_TOW),[]]) - [_object],true];
                        
            detach _object;
            _object setposATL [getposATL _object select 0, getposATL _object select 1,0];
            
            [[_logic,"updateObject",[_container,_object]],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;
            
            _result = _container;
        };
        
        case "liftObject": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container","_objectID","_containerID"];
            
            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            _objectID = [_logic,"id",_object] call ALiVE_fnc_logistics;
            _containerID = [_logic,"id",_container] call ALiVE_fnc_logistics;
            
            if !([_object,_container] call ALiVE_fnc_canLift) exitwith {};
            
			_object attachTo [
            	_container,
            	[0,0,(boundingBox _container select 0 select 2) - (boundingBox _object select 0 select 2) - (getPos _container select 2) + 0.5]
			];
            
            _object setvariable [QGVAR(CONTAINER),_container,true];
            _container setvariable [QGVAR(CARGO_LIFT),(_container getvariable [QGVAR(CARGO_LIFT),[]]) + [_object],true];
            
            [[_logic,"updateObject",[_container,_object]],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;
            
            _result = _container;
        };
        
        case "releaseObject": {
            if (isnil "_args") exitwith {};
            
            private ["_object","_container","_objectID","_containerID"];
            
            _object = [_args, 0, objNull, [objNull]] call BIS_fnc_param;
			_container = [_args, 1, objNull, [objNull]] call BIS_fnc_param;
            
            _objectID = [_logic,"id",_object] call ALiVE_fnc_logistics;
            _containerID = [_logic,"id",_container] call ALiVE_fnc_logistics;
            
            if ([_object,_container] call ALiVE_fnc_canLift) exitwith {};
            
            _object setvariable [QGVAR(CONTAINER),nil,true];
            _container setvariable [QGVAR(CARGO_LIFT),(_container getvariable [QGVAR(CARGO_LIFT),[]]) - [_object],true];
                        
            detach _object;
            _object setposATL [getposATL _object select 0, getposATL _object select 1,0];
            
            [[_logic,"updateObject",[_container,_object]],"ALIVE_fnc_logistics", false, false] call BIS_fnc_MP;
            
            _result = _container;
        };

        default {
            _result = [_logic, _operation, _args] call SUPERCLASS;
        };
};

TRACE_1("ALiVE SYS LOGISTICS - output",_result);

if !(isnil "_result") then {
    _result;
};
