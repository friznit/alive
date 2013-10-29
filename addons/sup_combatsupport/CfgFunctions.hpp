class cfgFunctions {
        class PREFIX {
                class COMPONENT {
                        class combatSupportFncInit {
                                description = "The main class";
                                file = "\x\alive\addons\sup_combatsupport\fnc_combatSupportFncInit.sqf";
				                recompile = 1;
                        };
                        class combatSupport {
                                description = "The main class";
                                file = "\x\alive\addons\sup_combatsupport\fnc_combatSupport.sqf";
				                recompile = 1;
                        };
                        class combatSupportInit {
                                description = "The module initialisation function";
                                file = "\x\alive\addons\sup_combatsupport\fnc_combatSupportInit.sqf";
				                recompile = 1;
                        };
                          class radioAction {
                                description = "The module Radio Action function";
                                file = "\x\alive\addons\sup_combatsupport\fnc_radioAction.sqf";
                                recompile = 1;
                        };
                        class combatSupportMenuDef {
                                description = "The module menu definition";
                                file = "\x\alive\addons\sup_combatsupport\fnc_combatSupportMenuDef.sqf";
                				recompile = 1;
                        };
                        class getUserMenuButton {
                            description = "Get's the user defined menu button";
                             file = "\x\alive\addons\sup_combatsupport\fnc_getUserMenuButton.sqf";
                             recompile = 1;
                        };
                };
        };
};

