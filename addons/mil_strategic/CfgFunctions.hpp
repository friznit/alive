class cfgFunctions {
        class PREFIX {
                class COMPONENT {
                        class MO {
                                description = "The main class";
                                file = "\x\alive\addons\mil_strategic\fnc_MO.sqf";
                                recompile = 1;
                        };
                        class MOInit {
                                description = "The module initialisation function";
                                file = "\x\alive\addons\mil_strategic\fnc_MOInit.sqf";
                                recompile = 1;
                        };
                        class findTargets {
                                description = "Identify targets within the TAOR";
                                file = "\x\alive\addons\mil_strategic\fnc_findTargets.sqf";
                                recompile = 1;
                        };
						class setTargets {
                                description = "Set basic params on clusters";
                                file = "\x\alive\addons\mil_strategic\fnc_setTargets.sqf";
                                recompile = 1;
                        };
						class clustersInsideMarker {
                                description = "Return list of clusters inside a marker";
                                file = "\x\alive\addons\mil_strategic\fnc_clustersInsideMarker.sqf";
                                recompile = 1;
                        };
						class clustersOutsideMarker {
                                description = "Return list of clusters outside a marker";
                                file = "\x\alive\addons\mil_strategic\fnc_clustersOutsideMarker.sqf";
                                recompile = 1;
                        };
						class staticClusterOutput {
                                description = "Returns clusters in string format for static file storage";
                                file = "\x\alive\addons\mil_strategic\fnc_staticClusterOutput.sqf";
                                recompile = 1;
                        };
						class copyClusters {
                                description = "Duplicate an array of clusters";
                                file = "\x\alive\addons\mil_strategic\fnc_copyClusters.sqf";
                                recompile = 1;
                        };
                };
        };
};
