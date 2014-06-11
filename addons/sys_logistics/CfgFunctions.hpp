class cfgFunctions {
        class PREFIX {
                class COMPONENT {
                        class logistics {
                                description = "The main class";
                                file = "\x\alive\addons\sys_logistics\fnc_logistics.sqf";
								recompile = RECOMPILE;
                        };
                        class logisticsInit {
                                description = "The module initialisation function";
                                file = "\x\alive\addons\sys_logistics\fnc_logisticsInit.sqf";
								recompile = RECOMPILE;
                        };
                        class logisticsMenuDef {
                                description = "The module menu definition";
                                file = "\x\alive\addons\sys_logistics\fnc_logisticsMenuDef.sqf";
								recompile = RECOMPILE;
                        };
                        class getObjectWeight {
                                description = "Gets the approximate weight (sum) of the given objects";
                                file = "\x\alive\addons\sys_logistics\fnc_getObjectWeight.sqf";
								recompile = RECOMPILE;
                        };
                        class getObjectSize {
                                description = "Gets the approximate volume (sum) of the given objects";
                                file = "\x\alive\addons\sys_logistics\fnc_getObjectSize.sqf";
								recompile = RECOMPILE;
                        };
				};
        };
};
