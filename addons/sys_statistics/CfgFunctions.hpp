class cfgFunctions {
        class PREFIX {
                class COMPONENT {
                        class statisticsMenuDef {
                                description = "The module menu definition";
                                file = "\x\alive\addons\sys_statistics\fnc_statisticsMenuDef.sqf";
								recompile = 1;
                        };
						class statisticsDisable {
								description = "The module disable function";
								file = "\x\alive\addons\sys_statistics\fnc_statisticsDisable.sqf";
								recompile = 1;
						};
						class statisticsModuleFunction {
								description = "The module function definition";
								file = "\x\alive\addons\sys_statistics\fnc_statisticsModuleFunction.sqf";
								recompile = 1;
						};
						class stats_OnPlayerDisconnected {
								description = "The module onPlayerDisconnected handler";
								file = "\x\alive\addons\sys_statistics\fnc_stats_onPlayerDisconnected.sqf";
								recompile = 1;
						};
				};
        };
};
