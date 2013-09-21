class CfgVehicles {
        class ModuleAliveMilitaryBase;
        class ADDON : ModuleAliveMilitaryBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_MP";
                function = "ALIVE_fnc_MPInit";
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\mil_placement\icon_mil_MP.paa";
				picture = "x\alive\addons\mil_placement\icon_mil_MP.paa";
                class Arguments
                {
                        class debug
                        {
                                displayName = "$STR_ALIVE_MP_DEBUG";
                                description = "$STR_ALIVE_MP_DEBUG_COMMENT";
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
                                displayName = "$STR_ALIVE_MP_SIZE";
                                description = "$STR_ALIVE_MP_SIZE_COMMENT";
                                class Values
                                {
                                        class BN
                                        {
                                                name = "$STR_ALIVE_MP_SIZE_BN";
                                                value = "BN";
                                        };
                                        class CY
                                        {
                                                name = "$STR_ALIVE_MP_SIZE_CY";
                                                value = "CY";
												default = 1;
                                        };
                                        class PL
                                        {
                                                name = "$STR_ALIVE_MP_SIZE_PL";
                                                value = "PL";
                                        };
                                };
                        };
                        class type
                        {
                                displayName = "$STR_ALIVE_MP_TYPE";
                                description = "$STR_ALIVE_MP_TYPE_COMMENT";
                                class Values
                                {
                                        class RANDOM
                                        {
                                                name = "$STR_ALIVE_MP_TYPE_RANDOM";
                                                value = "Random";
												default = 1;
                                        };
                                        class ARMOR
                                        {
                                                name = "$STR_ALIVE_MP_TYPE_ARMOR";
                                                value = "Armored";
                                        };
                                        class MECH
                                        {
                                                name = "$STR_ALIVE_MP_TYPE_MECH";
                                                value = "Mechanized";
                                        };
                                        class MOTOR
                                        {
                                                name = "$STR_ALIVE_MP_TYPE_MOTOR";
                                                value = "Motorized";
                                        };
                                        class LIGHT
                                        {
                                                name = "$STR_ALIVE_MP_TYPE_LIGHT";
                                                value = "Infantry";
                                        };
                                        class AIRBORNE
                                        {
                                                name = "$STR_ALIVE_MP_TYPE_AIRBORNE";
                                                value = "Air";
                                        };
                                };
                        };
                        class faction
                        {
                                displayName = "$STR_ALIVE_MP_FACTION";
                                description = "$STR_ALIVE_MP_FACTION_COMMENT";
                                defaultValue = "OPF_F";
                        };
						class sizeFilter
                        {
                                displayName = "$STR_ALIVE_MP_SIZE_FILTER";
                                description = "$STR_ALIVE_MP_SIZE_FILTER_COMMENT";
                                class Values
                                {
                                        class NONE
                                        {
                                                name = "$STR_ALIVE_MP_SIZE_FILTER_NONE";
                                                value = "0";
                                        };
                                        class SMALL
                                        {
                                                name = "$STR_ALIVE_MP_SIZE_FILTER_SMALL";
                                                value = "100";
                                        };
										class MEDIUM
                                        {
                                                name = "$STR_ALIVE_MP_SIZE_FILTER_MEDIUM";
                                                value = "200";
                                        };
										class LARGE
                                        {
                                                name = "$STR_ALIVE_MP_SIZE_FILTER_LARGE";
                                                value = "300";
                                        };
                                };
                        };
						class priorityFilter
                        {
                                displayName = "$STR_ALIVE_MP_PRIORITY_FILTER";
                                description = "$STR_ALIVE_MP_PRIORITY_FILTER_COMMENT";
                                class Values
                                {
                                        class NONE
                                        {
                                                name = "$STR_ALIVE_MP_PRIORITY_FILTER_NONE";
                                                value = "0";
                                        };
                                        class LOW
                                        {
                                                name = "$STR_ALIVE_MP_PRIORITY_FILTER_LOW";
                                                value = "10";
                                        };
										class MEDIUM
                                        {
                                                name = "$STR_ALIVE_MP_PRIORITY_FILTER_MEDIUM";
                                                value = "30";
                                        };
										class HIGH
                                        {
                                                name = "$STR_ALIVE_MP_PRIORITY_FILTER_HIGH";
                                                value = "40";
                                        };
                                };
                        };
                        class taor
                        {
                                displayName = "$STR_ALIVE_MP_TAOR";
                                description = "$STR_ALIVE_MP_TAOR_COMMENT";
                                defaultValue = [];
                        };
                        class blacklist
                        {
                                displayName = "$STR_ALIVE_MP_BLACKLIST";
                                description = "$STR_ALIVE_MP_BLACKLIST_COMMENT";
                                defaultValue = [];
                        };
						class ambientVehicleAmount
                        {
                                displayName = "$STR_ALIVE_MP_AMBIENT_VEHICLE_AMOUNT";
                                description = "$STR_ALIVE_MP_AMBIENT_VEHICLE_AMOUNT_COMMENT";
                                class Values
                                {
                                        class NONE
                                        {
                                                name = "$STR_ALIVE_MP_AMBIENT_VEHICLE_AMOUNT_NONE";
                                                value = "0";
                                        };
                                        class LOW
                                        {
                                                name = "$STR_ALIVE_MP_AMBIENT_VEHICLE_AMOUNT_LOW";
                                                value = "0.2";
                                        };
										class MEDIUM
                                        {
                                                name = "$STR_ALIVE_MP_AMBIENT_VEHICLE_AMOUNT_MEDIUM";
                                                value = "0.6";
                                        };
										class HIGH
                                        {
                                                name = "$STR_ALIVE_MP_AMBIENT_VEHICLE_AMOUNT_HIGH";
                                                value = "1";
                                        };
                                };
                        };
                };
                
        };
};
