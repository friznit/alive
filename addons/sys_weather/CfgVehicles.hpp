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
			          };
			                
			  };
};
