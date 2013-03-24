class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_TEMPLATE";
                function = "ALIVE_fnc_TEMPLATEInit";
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\sys_TEMPLATE\icon_sys_TEMPLATE.paa";
				picture = "x\alive\addons\sys_TEMPLATE\icon_sys_TEMPLATE.paa";
                class Arguments
                {
                        class Enabled
                        {
                                displayName = "$STR_ALIVE_TEMPLATE_ALLOW";
                                description = "$STR_ALIVE_TEMPLATE_ALLOW_COMMENT";
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
                };
                
        };
};
