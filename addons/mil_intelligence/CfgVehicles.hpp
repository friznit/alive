class CfgVehicles {
        class ModuleAliveMilitaryBase;
        class ADDON : ModuleAliveMilitaryBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_MI";
                function = "ALIVE_fnc_MIInit";
				functionPriority = 5;
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\mil_intelligence\icon_mil_MI.paa";
				picture = "x\alive\addons\mil_intelligence\icon_mil_MI.paa";
                class Arguments
                {
                        class debug
                        {
                                displayName = "$STR_ALIVE_MI_DEBUG";
                                description = "$STR_ALIVE_MI_DEBUG_COMMENT";
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
