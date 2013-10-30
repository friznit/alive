class CfgVehicles {
        class ModuleAliveMilitaryBase;
        class ADDON : ModuleAliveMilitaryBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_ML";
                function = "ALIVE_fnc_MLInit";
				functionPriority = 5;
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\mil_logistics\icon_mil_ML.paa";
				picture = "x\alive\addons\mil_logistics\icon_mil_ML.paa";
                class Arguments
                {
                        class debug
                        {
                                displayName = "$STR_ALIVE_ML_DEBUG";
                                description = "$STR_ALIVE_ML_DEBUG_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "Yes";
                                                value = true;
                                                default = true;
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = false;
                                        };
                                };
                        };
                };
                
        };
};
