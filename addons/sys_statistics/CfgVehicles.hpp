class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_STATISTICS";
                function = "ALIVE_fnc_statisticsInit";
                isGlobal = 1;
				icon = "x\alive\addons\sys_statistics\icon_sys_statistics.paa";
				picture = "x\alive\addons\sys_statistics\icon_sys_statistics.paa";
                class Arguments
                {
                        class Enabled
                        {
                                displayName = "$STR_ALIVE_STATISTICS_ENABLED";
                                description = "$STR_ALIVE_STATISTICS_ENABLED_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "Yes";
                                                value = 1;
												default = 1;
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = 0;
                                        };
                                };
                        };
                          class Condition
                        {
                                displayName = "Condition:";
                                description = "";
                                defaultValue = "true";
                        };                        
                };
                
        };
};
