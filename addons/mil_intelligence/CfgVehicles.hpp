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
						class intelChance
                        {
                                displayName = "$STR_ALIVE_MI_INTEL_CHANCE";
                                description = "$STR_ALIVE_MI_INTEL_CHANCE_COMMENT";
                                class Values
                                {
                                        class LOW
                                        {
                                                name = "$STR_ALIVE_MI_INTEL_CHANCE_LOW";
                                                value = "0.1";
                                        };
										class MEDIUM
                                        {
                                                name = "$STR_ALIVE_MI_INTEL_CHANCE_MEDIUM";
                                                value = "0.2";
                                        };
										class HIGH
                                        {
                                                name = "$STR_ALIVE_MI_INTEL_CHANCE_HIGH";
                                                value = "0.4";
                                        };
										class TOTAL
                                        {
                                                name = "$STR_ALIVE_MI_INTEL_CHANCE_TOTAL";
                                                value = "1";
                                        };
                                };
                        };
                };
                
        };
};
