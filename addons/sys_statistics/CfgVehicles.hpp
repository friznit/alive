class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_DISABLE_STATISTICS";
                function = "ALIVE_fnc_statisticsDisable";
                isGlobal = 1;
				isPersistent = 1;
				icon = "x\alive\addons\sys_statistics\icon_sys_statistics.paa";
				picture = "x\alive\addons\sys_statistics\icon_sys_statistics.paa";
                class Arguments
                {
                        class Condition
                        {
                                displayName = "Condition:";
                                description = "";
                                defaultValue = "true";
                        };                        
                };
                
        };
};
