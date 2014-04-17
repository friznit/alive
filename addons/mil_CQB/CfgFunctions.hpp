class cfgFunctions {
        class PREFIX {
                class COMPONENT {
                        class CQB {
                                description = "The main class";
                                file = "\x\alive\addons\mil_cqb\fnc_CQB.sqf";
								recompile = RECOMPILE;
                        };
                        class CQBInit {
                                description = "The module initialisation function";
                                file = "\x\alive\addons\mil_cqb\fnc_CQBInit.sqf";
								recompile = RECOMPILE;
                        };
                        class CQBsortStrategicHouses {
                                description = "The CQB blacklist function";
                                file = "\x\alive\addons\mil_cqb\fnc_CQBsortStrategicHouses.sqf";
								recompile = RECOMPILE;
                        };
                        class CQBSaveData {
                                description = "CQB save data to DB";
                                file = "\x\alive\addons\mil_cqb\fnc_CQBSaveData.sqf";
								recompile = RECOMPILE;
                        };
                        class CQBLoadData {
                                description = "CQB load data to DB";
                                file = "\x\alive\addons\mil_cqb\fnc_CQBLoadData.sqf";
								recompile = RECOMPILE;
                        };
                };
        };
};
