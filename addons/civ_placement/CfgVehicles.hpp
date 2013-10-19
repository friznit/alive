class CfgVehicles {
        class ModuleAliveMilitaryBase;
        class ADDON : ModuleAliveMilitaryBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_CP";
                function = "ALIVE_fnc_CPInit";
				functionPriority = 1;
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\civ_placement\icon_civ_CP.paa";
				picture = "x\alive\addons\civ_placement\icon_civ_CP.paa";
                class Arguments
                {
                        class debug
                        {
                                displayName = "$STR_ALIVE_CP_DEBUG";
                                description = "$STR_ALIVE_CP_DEBUG_COMMENT";
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
                                displayName = "$STR_ALIVE_CP_TAOR";
                                description = "$STR_ALIVE_CP_TAOR_COMMENT";
                                defaultValue = "";
                        };
                        class blacklist
                        {
                                displayName = "$STR_ALIVE_CP_BLACKLIST";
                                description = "$STR_ALIVE_CP_BLACKLIST_COMMENT";
                                defaultValue = "";
                        };
						class sizeFilter
                        {
                                displayName = "$STR_ALIVE_CP_SIZE_FILTER";
                                description = "$STR_ALIVE_CP_SIZE_FILTER_COMMENT";
                                class Values
                                {
                                        class NONE
                                        {
                                                name = "$STR_ALIVE_CP_SIZE_FILTER_NONE";
                                                value = "0";
                                        };
                                        class SMALL
                                        {
                                                name = "$STR_ALIVE_CP_SIZE_FILTER_SMALL";
                                                value = "100";
                                        };
										class MEDIUM
                                        {
                                                name = "$STR_ALIVE_CP_SIZE_FILTER_MEDIUM";
                                                value = "200";
                                        };
										class LARGE
                                        {
                                                name = "$STR_ALIVE_CP_SIZE_FILTER_LARGE";
                                                value = "300";
                                        };
                                };
                        };
						class priorityFilter
                        {
                                displayName = "$STR_ALIVE_CP_PRIORITY_FILTER";
                                description = "$STR_ALIVE_CP_PRIORITY_FILTER_COMMENT";
                                class Values
                                {
                                        class NONE
                                        {
                                                name = "$STR_ALIVE_CP_PRIORITY_FILTER_NONE";
                                                value = "0";
                                        };
                                        class LOW
                                        {
                                                name = "$STR_ALIVE_CP_PRIORITY_FILTER_LOW";
                                                value = "10";
                                        };
										class MEDIUM
                                        {
                                                name = "$STR_ALIVE_CP_PRIORITY_FILTER_MEDIUM";
                                                value = "30";
                                        };
										class HIGH
                                        {
                                                name = "$STR_ALIVE_CP_PRIORITY_FILTER_HIGH";
                                                value = "40";
                                        };
                                };
                        };
						class withPlacement
                        {
                                displayName = "$STR_ALIVE_CP_PLACEMENT";
                                description = "$STR_ALIVE_CP_PLACEMENT_COMMENT";
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
						class size
                        {
                                displayName = "$STR_ALIVE_CP_SIZE";
                                description = "$STR_ALIVE_CP_SIZE_COMMENT";
                                class Values
                                {
										class BNx3
                                        {
                                                name = "$STR_ALIVE_CP_SIZE_BNx3";
                                                value = 1200;
                                        };
										class BNx2
                                        {
                                                name = "$STR_ALIVE_CP_SIZE_BNx2";
                                                value = 800;
                                        };
                                        class BN
                                        {
                                                name = "$STR_ALIVE_CP_SIZE_BN";
                                                value = 400;
                                        };
										class CYx2
                                        {
                                                name = "$STR_ALIVE_CP_SIZE_CYx2";
                                                value = 200;
												default = 1;
                                        };
                                        class CY
                                        {
                                                name = "$STR_ALIVE_CP_SIZE_CY";
                                                value = 100;
                                        };
										class PLx2
                                        {
                                                name = "$STR_ALIVE_CP_SIZE_PLx2";
                                                value = 60;
                                        };
                                        class PL
                                        {
                                                name = "$STR_ALIVE_CP_SIZE_PL";
                                                value = 30;
                                        };
                                };
                        };
                        class type
                        {
                                displayName = "$STR_ALIVE_CP_TYPE";
                                description = "$STR_ALIVE_CP_TYPE_COMMENT";
                                class Values
                                {
                                        class RANDOM
                                        {
                                                name = "$STR_ALIVE_CP_TYPE_RANDOM";
                                                value = "Random";
												default = 1;
                                        };
                                        class ARMOR
                                        {
                                                name = "$STR_ALIVE_CP_TYPE_ARMOR";
                                                value = "Armored";
                                        };
                                        class MECH
                                        {
                                                name = "$STR_ALIVE_CP_TYPE_MECH";
                                                value = "Mechanized";
                                        };
                                        class MOTOR
                                        {
                                                name = "$STR_ALIVE_CP_TYPE_MOTOR";
                                                value = "Motorized";
                                        };
                                        class LIGHT
                                        {
                                                name = "$STR_ALIVE_CP_TYPE_LIGHT";
                                                value = "Infantry";
                                        };
                                        class AIRBORNE
                                        {
                                                name = "$STR_ALIVE_CP_TYPE_AIRBORNE";
                                                value = "Air";
                                        };
                                };
                        };
                        class faction
                        {
                                displayName = "$STR_ALIVE_CP_FACTION";
                                description = "$STR_ALIVE_CP_FACTION_COMMENT";
                                defaultValue = "OPF_F";
                        };
                };
                
        };
};
