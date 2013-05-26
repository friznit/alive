class cfgFunctions {
        class PREFIX {
                class COMPONENT {
                        class newsFeed {
                                description = "The main class";
                                file = "\x\alive\addons\sys_newsfeed\fnc_newsFeed.sqf";
				recompile = 1;
                        };
                        class newsFeedInit {
                                description = "The module initialisation function";
                                file = "\x\alive\addons\sys_newsfeed\fnc_newsFeedInit.sqf";
				recompile = 1;
                        };
                        class newsFeedMenuDef {
                                description = "The module menu definition";
                                file = "\x\alive\addons\sys_newsfeed\fnc_newsFeedMenuDef.sqf";
				recompile = 1;
                        };
                };
        };
};

