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
                        class logisticsActions {
                                description = "Adds the logistics actions";
                                file = "\x\alive\addons\sys_logistics\fnc_logisticsActions.sqf";
								recompile = RECOMPILE;
                        };
				};
        };
};
