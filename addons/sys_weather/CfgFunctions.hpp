class cfgFunctions {
        class PREFIX {
                class COMPONENT {
                        class weather {
                                description = "The main class";
                                file = "\x\alive\addons\sys_weather\fnc_weather.sqf";
																recompile = RECOMPILE;
                        };
                        class weatherInit {
                                description = "The module initialisation function";
                                file = "\x\alive\addons\sys_weather\fnc_weatherInit.sqf";
																recompile = RECOMPILE;
                        }; 
                        class weatherFX {
                                description = "The module FX function";
                                file = "\x\alive\addons\sys_weather\fnc_weatherFX.sqf";
																recompile = RECOMPILE;
                        }; 
                };
        };
};