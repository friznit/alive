class cfgFunctions {
        class PREFIX {
                class COMPONENT {
                        class playertags {
                                description = "The main class";
                                file = "\x\alive\addons\sys_playertags\fnc_playertags.sqf";
																recompile = 1;
                        };
                        class playertagsInit {
                                description = "The module initialisation function";
                                file = "\x\alive\addons\sys_playertags\fnc_playertagsInit.sqf";
																recompile = 1;
                        };
                        class playertagsMenuDef {
                                description = "The module menu definition";
                                file = "\x\alive\addons\sys_playertags\fnc_playertagsMenuDef.sqf";
																recompile = 1;
                        };
 												class playertagsScript {
                                description = "The module script";
                                file = "\x\alive\addons\sys_playertags\playertags_setupRecognise.sqf";
																recompile = 1;
                        };
                        
                };
        };
};
