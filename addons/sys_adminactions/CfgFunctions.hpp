class cfgFunctions {
        class PREFIX {
                class COMPONENT {
                        class adminActions {
                                description = "The main class";
                                file = "\x\alive\addons\sys_adminactions\fnc_adminActions.sqf";
				                recompile = RECOMPILE;
                        };
                        class adminActionsInit {
                                description = "The module initialisation function";
                                file = "\x\alive\addons\sys_adminactions\fnc_adminActionsInit.sqf";
				                recompile = RECOMPILE;
                        };
                        class adminActionsMenuDef {
                                description = "The module menu definition";
                                file = "\x\alive\addons\sys_adminactions\fnc_adminActionsMenuDef.sqf";
				                recompile = RECOMPILE;
                        };
                        class markUnits {
                                description = "Mark units active and profiled";
                                file = "\x\alive\addons\sys_adminactions\fnc_markUnits.sqf";
                                recompile = RECOMPILE;
                        };
                };
        };
};
