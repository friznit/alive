class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_RWG";
                function = "ALIVE_fnc_RWGInit";
                isGlobal = 1;
				icon = "x\alive\addons\sys_RWG\icon_sys_RWG.paa";
				picture = "x\alive\addons\sys_RWG\icon_sys_RWG.paa";
                class Arguments
                {
                        class Enabled
                        {
                                displayName = "$STR_ALIVE_RWG_ENABLED";
                                description = "$STR_ALIVE_RWG_ENABLED_COMMENT";
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
