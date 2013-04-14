class CfgVehicles {
        class ModuleAliveSupportBase;
        class ADDON : ModuleAliveSupportBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_multispawn";
                function = "ALIVE_fnc_multispawnInit";
                isGlobal = 1;
				icon = "x\alive\addons\sup_multispawn\icon_sup_multispawn.paa";
				picture = "x\alive\addons\sup_multispawn\icon_sup_multispawn.paa";
                class Arguments
                {
                        class Enabled
                        {
                                displayName = "$STR_ALIVE_multispawn_ENABLED";
                                description = "$STR_ALIVE_multispawn_ENABLED_COMMENT";
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
