class cfgFunctions {
        class PREFIX {
                class COMPONENT {
                        class adminActions {
                                description = "The main class";
                                file = "\x\alive\addons\sys_adminactions\fnc_adminActions.sqf";
				recompile = 1;
                        };
                        class adminActionsInit {
                                description = "The module initialisation function";
                                file = "\x\alive\addons\sys_adminactions\fnc_adminActionsInit.sqf";
				recompile = 1;
                        };
                        class adminActionsMenuDef {
                                description = "The module menu definition";
                                file = "\x\alive\addons\sys_adminactions\fnc_adminActionsMenuDef.sqf";
				recompile = 1;
                        };
                };
        };
};
