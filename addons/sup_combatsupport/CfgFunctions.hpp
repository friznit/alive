class cfgFunctions {
        class PREFIX {
                class COMPONENT {
                        class combatSupportFncInit {
                                description = "The main class";
                                file = "\x\alive\addons\sup_combatsupport\fnc_combatSupportFncInit.sqf";
				                recompile = RECOMPILE;
                        };
                        class combatSupport {
                                description = "The main class";
                                file = "\x\alive\addons\sup_combatsupport\fnc_combatSupport.sqf";
				                recompile = RECOMPILE;
                        };
                        class combatSupportInit {
                                description = "The module initialisation function";
                                file = "\x\alive\addons\sup_combatsupport\fnc_combatSupportInit.sqf";
				                recompile = RECOMPILE;
                        };
                          class radioAction {
                                description = "The module Radio Action function";
                                file = "\x\alive\addons\sup_combatsupport\fnc_radioAction.sqf";
                                recompile = RECOMPILE;
                        };
                        class combatSupportMenuDef {
                                description = "The module menu definition";
                                file = "\x\alive\addons\sup_combatsupport\fnc_combatSupportMenuDef.sqf";
                				recompile = RECOMPILE;
                        };
                };
        };
};

