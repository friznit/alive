class CfgVehicles {
        class ModuleAliveMilitaryBase;
        class ADDON : ModuleAliveMilitaryBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_MO";
                function = "ALIVE_fnc_MOInit";
				functionPriority = 2;
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\mil_strategic\icon_mil_MO.paa";
				picture = "x\alive\addons\mil_strategic\icon_mil_MO.paa";
                class Arguments
                {
                        class debug
                        {
                                displayName = "$STR_ALIVE_MO_DEBUG";
                                description = "$STR_ALIVE_MO_DEBUG_COMMENT";
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
                                displayName = "$STR_ALIVE_MO_TAOR";
                                description = "$STR_ALIVE_MO_TAOR_COMMENT";
                                defaultValue = [];
                        };
                        class blacklist
                        {
                                displayName = "$STR_ALIVE_MO_BLACKLIST";
                                description = "$STR_ALIVE_MO_BLACKLIST_COMMENT";
                                defaultValue = [];
                        };
						class sizeFilter
                        {
                                displayName = "$STR_ALIVE_MO_SIZE_FILTER";
                                description = "$STR_ALIVE_MO_SIZE_FILTER_COMMENT";
                                class Values
                                {
                                        class NONE
                                        {
                                                name = "$STR_ALIVE_MO_SIZE_FILTER_NONE";
                                                value = "0";
                                        };
                                        class SMALL
                                        {
                                                name = "$STR_ALIVE_MO_SIZE_FILTER_SMALL";
                                                value = "100";
                                        };
										class MEDIUM
                                        {
                                                name = "$STR_ALIVE_MO_SIZE_FILTER_MEDIUM";
                                                value = "200";
                                        };
										class LARGE
                                        {
                                                name = "$STR_ALIVE_MO_SIZE_FILTER_LARGE";
                                                value = "300";
                                        };
                                };
                        };
						class priorityFilter
                        {
                                displayName = "$STR_ALIVE_MO_PRIORITY_FILTER";
                                description = "$STR_ALIVE_MO_PRIORITY_FILTER_COMMENT";
                                class Values
                                {
                                        class NONE
                                        {
                                                name = "$STR_ALIVE_MO_PRIORITY_FILTER_NONE";
                                                value = "0";
                                        };
                                        class LOW
                                        {
                                                name = "$STR_ALIVE_MO_PRIORITY_FILTER_LOW";
                                                value = "10";
                                        };
										class MEDIUM
                                        {
                                                name = "$STR_ALIVE_MO_PRIORITY_FILTER_MEDIUM";
                                                value = "30";
                                        };
										class HIGH
                                        {
                                                name = "$STR_ALIVE_MO_PRIORITY_FILTER_HIGH";
                                                value = "40";
                                        };
                                };
                        };
						class initType
                        {
                                displayName = "$STR_ALIVE_MO_INIT_TYPE";
                                description = "$STR_ALIVE_MO_INIT_TYPE_COMMENT";
                                class Values
                                {
                                        class STATIC
                                        {
                                                name = "$STR_ALIVE_MO_INIT_TYPE_STATIC";
                                                value = "STATIC";
                                        };
                                        class DYNAMIC
                                        {
                                                name = "$STR_ALIVE_MO_INIT_TYPE_DYNAMIC";
                                                value = "DYNAMIC";
                                        };
										class GENERATE
                                        {
                                                name = "$STR_ALIVE_MO_INIT_TYPE_GENERATE";
                                                value = "GENERATE";
                                        };
                                };
                        };
                };
                
        };
};
