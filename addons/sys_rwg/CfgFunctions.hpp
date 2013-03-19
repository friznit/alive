class cfgFunctions {
        class PREFIX {
                class COMPONENT {
                        class RWG {
                                description = "The main class";
                                file = "\x\alive\addons\sys_rwg\fnc_RWG.sqf";
                        };
                        class RWGInit {
                                description = "The module initialisation function";
                                file = "\x\alive\addons\sys_rwg\fnc_RWGInit.sqf";
                        };
			class RWGsavegear {
				description = "The gear saving function";
                                file = "\x\alive\addons\sys_rwg\fnc_RWGsavegear.sqf";
			};
			class RWGloadgear {
				description = "The the gear loading function";
                                file = "\x\alive\addons\sys_rwg\fnc_RWGloadgear.sqf";
			};
                        class RWGExec {
                                description = "The player init function";
                                file = "\x\alive\addons\sys_rwg\fnc_RWGexec.sqf";
                        };
                };
        };
};
