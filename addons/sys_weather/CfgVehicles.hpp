class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_WEATHER";
                function = "ALIVE_fnc_weatherInit";
                isGlobal = 1;
                isPersistent = 1;
                icon = "\x\alive\addons\sys_weather\icon_sys_weather.paa";
                picture = "\x\alive\addons\sys_weather\icon_sys_weather.paa";
                
			         	class Arguments
			          {
			                        class weather_debug_setting
			                        {
			                                displayName = "$STR_ALIVE_WEATHER_DEBUG";
			                                description = "$STR_ALIVE_WEATHER_DEBUG_COMMENT";
			                                class Values
			                                {
			                                	
			                                        class No
			                                        {
			                                                name = "No";
			                                                value = false;
			                                                default = false;
			                                        };
			                                        class Yes
			                                        {
			                                                name = "Yes";
			                                                value = true;
			                                               
			                                        };
			                                };
			                        };
			                        
 															class weather_initial_setting
			                        {
			                                displayName = "$STR_ALIVE_WEATHER_INITIAL";
			                                description = "$STR_ALIVE_WEATHER_INITIAL_COMMENT";
			                                class Values
			                                {
			                                	
			                                	
																							class initialRandom
			                                        {
			                                                name = "Random";
			                                                value = 1;
			                                                default = 1;
			                                        };
			                                        class initialClear
			                                        {
			                                                name = "Clear";
			                                                value = 2;
			                                        };
			                                        class initialOvercast
			                                        {
			                                                name = "Overcast";
			                                                value = 3;
			                                               
			                                        };
 																							class initialStormy
			                                        {
			                                                name = "Stormy";
			                                                value = 4;
			                                               
			                                        };
			                                };
			                        };
			          };
			                
			  };
};
