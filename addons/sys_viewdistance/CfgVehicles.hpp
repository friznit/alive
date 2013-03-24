class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_VDIST";
                function = "ALIVE_fnc_vDistInit";
                isGlobal = 1;
                isPersistent = 1;
                icon = "x\alive\addons\sys_viewdistance\icon_sys_viewdistance.paa";
                picture = "x\alive\addons\sys_viewdistance\icon_sys_viewdistance.paa";
                class Arguments
                {
                        class vdist
                        {
                                displayName = "$STR_ALIVE_VDIST_ENABLED";
                                description = "$STR_ALIVE_VDIST_ENABLED_COMMENT";
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
