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
                                                default = true;
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
                        class friendlyIntel
                        {
                                displayName = "$STR_ALIVE_MI_FRIENDLY_INTEL";
                                description = "$STR_ALIVE_MI_FRIENDLY_INTEL_COMMENT";
                                class Values
                                {
                                        class NONE
                                        {
                                                name = "$STR_ALIVE_MI_FRIENDLY_INTEL_NONE";
                                                value = "NONE";
                                        };
                                        class CONFLICT
                                        {
                                                name = "$STR_ALIVE_MI_FRIENDLY_INTEL_CONFLICT";
                                                value = "CONFLICT";
                                                default = true;
                                        };
                                        class TOTAL
                                        {
                                                name = "$STR_ALIVE_MI_FRIENDLY_INTEL_TOTAL";
                                                value = "TOTAL";
                                        };
                                };
                        };
                };
                
        };
        class ADDON2 : ModuleAliveMilitaryBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_SD";
                function = "ALIVE_fnc_SDInit";
                functionPriority = 5;
                isGlobal = 1;
                isPersistent = 1;
                icon = "x\alive\addons\mil_intelligence\icon_mil_SD.paa";
                picture = "x\alive\addons\mil_intelligence\icon_mil_SD.paa";
        };
        class ADDON3 : ModuleAliveMilitaryBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_PSD";
                function = "ALIVE_fnc_PSDInit";
                functionPriority = 5;
                isGlobal = 1;
                isPersistent = 1;
                icon = "x\alive\addons\mil_intelligence\icon_mil_SD.paa";
                picture = "x\alive\addons\mil_intelligence\icon_mil_SD.paa";
        };
};
