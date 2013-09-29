class CfgVehicles {
        class ModuleAliveCivilianBase;
        class ADDON : ModuleAliveCivilianBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_CO";
                function = "ALIVE_fnc_COInit";
				functionPriority = 1;
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\civ_strategic\icon_civ_CO.paa";
				picture = "x\alive\addons\civ_strategic\icon_civ_CO.paa";
                class Arguments
                {
                        class debug
                        {
                                displayName = "$STR_ALIVE_CO_DEBUG";
                                description = "$STR_ALIVE_CO_DEBUG_COMMENT";
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
                        class taor
                        {
                                displayName = "$STR_ALIVE_CO_TAOR";
                                description = "$STR_ALIVE_CO_TAOR_COMMENT";
                                defaultValue = [];
                        };
                        class blacklist
                        {
                                displayName = "$STR_ALIVE_CO_BLACKLIST";
                                description = "$STR_ALIVE_CO_BLACKLIST_COMMENT";
                                defaultValue = [];
                        };
						class sizeFilter
                        {
                                displayName = "$STR_ALIVE_CO_SIZE_FILTER";
                                description = "$STR_ALIVE_CO_SIZE_FILTER_COMMENT";
                                 class Values
                                {
                                        class NONE
                                        {
                                                name = "$STR_ALIVE_CO_SIZE_FILTER_NONE";
                                                value = "0";
                                        };
                                        class SMALL
                                        {
                                                name = "$STR_ALIVE_CO_SIZE_FILTER_SMALL";
                                                value = "100";
                                        };
										class MEDIUM
                                        {
                                                name = "$STR_ALIVE_CO_SIZE_FILTER_MEDIUM";
                                                value = "200";
                                        };
										class LARGE
                                        {
                                                name = "$STR_ALIVE_CO_SIZE_FILTER_LARGE";
                                                value = "300";
                                        };
                                };
                        };
						class priorityFilter
                        {
                                displayName = "$STR_ALIVE_CO_PRIORITY_FILTER";
                                description = "$STR_ALIVE_CO_PRIORITY_FILTER_COMMENT";
                                 class Values
                                {
                                        class NONE
                                        {
                                                name = "$STR_ALIVE_CO_PRIORITY_FILTER_NONE";
                                                value = "0";
                                        };
                                        class LOW
                                        {
                                                name = "$STR_ALIVE_CO_PRIORITY_FILTER_LOW";
                                                value = "10";
                                        };
										class MEDIUM
                                        {
                                                name = "$STR_ALIVE_CO_PRIORITY_FILTER_MEDIUM";
                                                value = "30";
                                        };
										class HIGH
                                        {
                                                name = "$STR_ALIVE_CO_PRIORITY_FILTER_HIGH";
                                                value = "40";
                                        };
                                };
                        };
						class initType
                        {
                                displayName = "$STR_ALIVE_CO_INIT_TYPE";
                                description = "$STR_ALIVE_CO_INIT_TYPE_COMMENT";
                                 class Values
                                {
                                        class STATIC
                                        {
                                                name = "$STR_ALIVE_CO_INIT_TYPE_STATIC";
                                                value = "STATIC";
                                        };
                                        class DYNAMIC
                                        {
                                                name = "$STR_ALIVE_CO_INIT_TYPE_DYNAMIC";
                                                value = "DYNAMIC";
                                        };
										class GENERATE
                                        {
                                                name = "$STR_ALIVE_CO_INIT_TYPE_GENERATE";
                                                value = "GENERATE";
                                        };
                                };
                        };
                };
                
        };
};
