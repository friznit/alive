class cfgFunctions {
        class PREFIX {
                class COMPONENT {
                        class statisticsMenuDef {
                                description = "The module menu definition";
                                file = "\x\alive\addons\sys_statistics\fnc_statisticsMenuDef.sqf";
								recompile = RECOMPILE;
                        };
						class statisticsDisable {
								description = "The module disable function";
								file = "\x\alive\addons\sys_statistics\fnc_statisticsDisable.sqf";
								recompile = RECOMPILE;
						};
						class statisticsModuleFunction {
								description = "The module function definition";
								file = "\x\alive\addons\sys_statistics\fnc_statisticsModuleFunction.sqf";
								recompile = RECOMPILE;
						};
						class stats_OnPlayerDisconnected {
								description = "The module onPlayerDisconnected handler";
								file = "\x\alive\addons\sys_statistics\fnc_stats_onPlayerDisconnected.sqf";
								recompile = RECOMPILE;
						};
						class stats_OnPlayerConnected {
								description = "The module onPlayerConnected handler";
								file = "\x\alive\addons\sys_statistics\fnc_stats_onPlayerConnected.sqf";
								recompile = RECOMPILE;
						};
						class stats_createPlayerProfile {
								description = "The module onPlayerConnected handler";
								file = "\x\alive\addons\sys_statistics\fnc_stats_createPlayerProfile.sqf";
								recompile = RECOMPILE;
						};
				};
        };
};
