class cfgFunctions {
        class PREFIX {
                class COMPONENT {
                        class vDist {
                                description = "The main class";
                                file = "\x\alive\addons\sys_viewdistance\fnc_vDist.sqf";
				recompile = 1;
                        };
                        class vDistInit {
                                description = "The module initialisation function";
                                file = "\x\alive\addons\sys_viewdistance\fnc_vDistInit.sqf";
				recompile = 1;
                        };
                        class vDistMenuDef {
                                description = "The module menu definition";
                                file = "\x\alive\addons\sys_viewdistance\fnc_vDistMenuDef.sqf";
				recompile = 1;
                        };
                        class vDistGuiInit {
                                description = "The Gui";
                                file = "\x\alive\addons\sys_viewdistance\vdist\fnc_vdist_init.sqf";
                                recompile = 1;
                        };
                };
        };
};

