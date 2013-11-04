class cfgFunctions {
        class PREFIX {
                class COMPONENT {
                        class weather {
                                description = "The main class";
                                file = "\x\alive\addons\sys_weather\fnc_weather.sqf";
																recompile = 1;
                        };
                        class weatherInit {
                                description = "The module initialisation function";
                                file = "\x\alive\addons\sys_weather\fnc_weatherInit.sqf";
																recompile = 1;
                        }; 
                        class weatherFX {
                                description = "The module FX function";
                                file = "\x\alive\addons\sys_weather\fnc_weatherFX.sqf";
																recompile = 1;
                        }; 
                };
        };
};