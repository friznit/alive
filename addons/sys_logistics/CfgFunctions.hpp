class cfgFunctions {
        class PREFIX {
                class COMPONENT {
                        class logistics {
                                description = "The main class";
                                file = "\x\alive\addons\sys_logistics\fnc_logistics.sqf";
								recompile = RECOMPILE;
                        };
                        class logisticsInit {
                                description = "The module initialisation function";
                                file = "\x\alive\addons\sys_logistics\fnc_logisticsInit.sqf";
								recompile = RECOMPILE;
                        };
                        class logisticsMenuDef {
                                description = "The module menu definition";
                                file = "\x\alive\addons\sys_logistics\fnc_logisticsMenuDef.sqf";
								recompile = RECOMPILE;
                        };
                        class getObjectWeight {
                                description = "Gets the approximate weight (sum) of the given objects";
                                file = "\x\alive\addons\sys_logistics\fnc_getObjectWeight.sqf";
								recompile = RECOMPILE;
                        };
                        class getObjectSize {
                                description = "Gets the approximate volume (sum) of the given objects";
                                file = "\x\alive\addons\sys_logistics\fnc_getObjectSize.sqf";
								recompile = RECOMPILE;
                        };
                        class availableWeight {
                                description = "Gets the available weight capacity (sum) of the given objects in kg";
                                file = "\x\alive\addons\sys_logistics\fnc_availableWeight.sqf";
								recompile = RECOMPILE;
                        };
                        class availableCargo {
                                description = "Gets the available cargo volume (sum) of the given objects in m^3";
                                file = "\x\alive\addons\sys_logistics\fnc_availableCargo.sqf";
								recompile = RECOMPILE;
                        };
                        class canCarry {
                                description = "Checks if an object can be carried by another given object";
                                file = "\x\alive\addons\sys_logistics\fnc_canCarry.sqf";
								recompile = RECOMPILE;
                        };
                        class canStow {
                                description = "Checks if an object can be stowed the given container";
                                file = "\x\alive\addons\sys_logistics\fnc_canStow.sqf";
								recompile = RECOMPILE;
                        };
                        class canTow {
                                description = "Checks if an object can be towed by the given vehicle";
                                file = "\x\alive\addons\sys_logistics\fnc_canTow.sqf";
								recompile = RECOMPILE;
                        };
                        class canLift {
                                description = "Checks if an object can be lifted by given vehicle";
                                file = "\x\alive\addons\sys_logistics\fnc_canLift.sqf";
								recompile = RECOMPILE;
                        };
                        class getObjectCargo {
                                description = "Gets the cargo list of an object";
                                file = "\x\alive\addons\sys_logistics\fnc_getObjectCargo.sqf";
								recompile = RECOMPILE;
                        };
                        class setObjectCargo {
                                description = "Sets the cargo back on an object";
                                file = "\x\alive\addons\sys_logistics\fnc_setObjectCargo.sqf";
								recompile = RECOMPILE;
                        };
				};
        };
};
