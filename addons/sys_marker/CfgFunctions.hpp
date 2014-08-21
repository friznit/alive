class cfgFunctions {
        class PREFIX {
                class COMPONENT {
                        class marker {
                                description = "The main class";
                                file = "\x\alive\addons\sys_marker\fnc_marker.sqf";
								recompile = RECOMPILE;
                        };
                        class markerInit {
                                description = "The module initialisation function";
                                file = "\x\alive\addons\sys_marker\fnc_markerInit.sqf";
								recompile = RECOMPILE;
                        };
                        class markerParams {
                                description = "Marker parameters";
                                file = "\x\alive\addons\sys_marker\fnc_markerParams.sqf";
								recompile = RECOMPILE;
                        };
                        class markerSaveData {
                                description = "marker save data to DB";
                                file = "\x\alive\addons\sys_marker\fnc_markerSaveData.sqf";
                                                                recompile = RECOMPILE;
                        };
                        class markerLoadData {
                                description = "marker load data to DB";
                                file = "\x\alive\addons\sys_marker\fnc_markerLoadData.sqf";
                                                                recompile = RECOMPILE;
                        };
                        class markerOnLoad{
                                description = "Onload for Dialog";
                                file = "\x\alive\addons\sys_marker\fnc_markerOnLoad.sqf";
                                                                recompile = RECOMPILE;
                        };
                        class markerLBSelChanged{
                                description = "LBSelChanged for Dialog";
                                file = "\x\alive\addons\sys_marker\fnc_markerLBSelChanged.sqf";
                                                                recompile = RECOMPILE;
                        };
                };
        };
};