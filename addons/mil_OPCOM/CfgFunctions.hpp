class cfgFunctions {
        class PREFIX {
                class COMPONENT {
                        class OPCOM {
                                description = "The main class";
                                file = "\x\alive\addons\mil_opcom\fnc_OPCOM.sqf";
                                recompile = RECOMPILE;
                        };
                        class OPCOMInit {
                                description = "The module initialisation function";
                                file = "\x\alive\addons\mil_opcom\fnc_OPCOMInit.sqf";
                                recompile = RECOMPILE;
                        };
                        class OPCOMpositions {
                                description = "Selects OPCOM objective positions of given state";
                                file = "\x\alive\addons\mil_opcom\fnc_OPCOMpositions.sqf";
                                recompile = RECOMPILE;
                        };
						class OPCOMLoadData {
                                description = "Loads OPCOM state from DB";
                                file = "\x\alive\addons\mil_opcom\fnc_OPCOMLoadData.sqf";
                                recompile = RECOMPILE;
                        };
						class OPCOMSaveData {
                                description = "Saves OPCOM state from DB";
                                file = "\x\alive\addons\mil_opcom\fnc_OPCOMSaveData.sqf";
                                recompile = RECOMPILE;
                        };
                };
        };
};
