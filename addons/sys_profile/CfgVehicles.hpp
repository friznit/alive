class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_PROFILE_SYSTEM";
                function = "ALIVE_fnc_profileSystemInit";
                isGlobal = 1;
				icon = "x\alive\addons\sys_profile\icon_sys_profile.paa";
				picture = "x\alive\addons\sys_profile\icon_sys_profile.paa";
                class Arguments
                {
                        class Enabled
                        {
                                displayName = "$STR_ALIVE_PROFILE_SYSTEM_ENABLED";
                                description = "$STR_ALIVE_PROFILE_SYSTEM_ENABLED_COMMENT";
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