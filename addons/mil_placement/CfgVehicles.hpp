class CfgVehicles {
        class ModuleAliveMilitaryBase;
        class ADDON : ModuleAliveMilitaryBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_MP";
                function = "ALIVE_fnc_MPInit";
                author = MODULE_AUTHOR;
				functionPriority = 4;
                isGlobal = 1;
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
						class taor
                        {
                                displayName = "$STR_ALIVE_MP_TAOR";
                                description = "$STR_ALIVE_MP_TAOR_COMMENT";
                                defaultValue = "";
                        };
                        class blacklist
                        {
                                displayName = "$STR_ALIVE_MP_BLACKLIST";
                                description = "$STR_ALIVE_MP_BLACKLIST_COMMENT";
                                defaultValue = "";
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
						class withPlacement
                        {
                                displayName = "$STR_ALIVE_MP_PLACEMENT";
                                description = "$STR_ALIVE_MP_PLACEMENT_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "$STR_ALIVE_MP_PLACEMENT_YES";
                                                value = true;
                                                default = true;
                                        };
                                        class No
                                        {
                                                name = "$STR_ALIVE_MP_PLACEMENT_NO";
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
										class BNx3
                                        {
                                                name = "$STR_ALIVE_MP_SIZE_BNx3";
                                                value = 1200;
                                        };
										class BNx2
                                        {
                                                name = "$STR_ALIVE_MP_SIZE_BNx2";
                                                value = 800;
                                        };
                                        class BN
                                        {
                                                name = "$STR_ALIVE_MP_SIZE_BN";
                                                value = 400;
                                        };
										class CYx2
                                        {
                                                name = "$STR_ALIVE_MP_SIZE_CYx2";
                                                value = 200;
												default = 1;
                                        };
                                        class CY
                                        {
                                                name = "$STR_ALIVE_MP_SIZE_CY";
                                                value = 100;
                                        };
										class PLx2
                                        {
                                                name = "$STR_ALIVE_MP_SIZE_PLx2";
                                                value = 60;
                                        };
                                        class PL
                                        {
                                                name = "$STR_ALIVE_MP_SIZE_PL";
                                                value = 30;
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
                                        class SPECOPS
                                        {
                                                name = "$STR_ALIVE_MP_TYPE_SPECOPS";
                                                value = "Specops";
                                        };
                                };
                        };
                        class faction
                        {
                                displayName = "$STR_ALIVE_MP_FACTION";
                                description = "$STR_ALIVE_MP_FACTION_COMMENT";
                                defaultValue = "OPF_F";
                        };
                        class createHQ
                        {
                                displayName = "$STR_ALIVE_MP_CREATE_HQ";
                                description = "$STR_ALIVE_MP_CREATE_HQ_COMMENT";
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
						class placeHelis
                        {
                                displayName = "$STR_ALIVE_MP_PLACE_HELI";
                                description = "$STR_ALIVE_MP_PLACE_HELI_COMMENT";
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
						class placeSupplies
                        {
                                displayName = "$STR_ALIVE_MP_PLACE_SUPPLIES";
                                description = "$STR_ALIVE_MP_PLACE_SUPPLIES_COMMENT";
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
                class ModuleDescription
                {
                    //description = "$STR_ALIVE_OPCOM_COMMENT"; // Short description, will be formatted as structured text
                    description[] = {
                            "$STR_ALIVE_MP_COMMENT",
                            "",
                            "$STR_ALIVE_MP_USAGE"
                    };
                    sync[] = {"ALiVE_mil_OPCOM","ALiVE_mil_CQB"}; // Array of synced entities (can contain base classes)

                    class ALiVE_mil_OPCOM
                    {
                        description[] = { // Multi-line descriptions are supported
                            "$STR_ALIVE_OPCOM_COMMENT",
                            "",
                            "$STR_ALIVE_OPCOM_USAGE"
                        };
                        position = 0; // Position is taken into effect
                        direction = 0; // Direction is taken into effect
                        optional = 1; // Synced entity is optional
                        duplicate = 1; // Multiple entities of this type can be synced
                    };
                    class ALiVE_mil_CQB
                    {
                        description[] = { // Multi-line descriptions are supported
                            "$STR_ALIVE_CQB_COMMENT",
                            "",
                            "$STR_ALIVE_CQB_USAGE"
                        };
                        position = 0; // Position is taken into effect
                        direction = 0; // Direction is taken into effect
                        optional = 1; // Synced entity is optional
                        duplicate = 1; // Multiple entities of this type can be synced
                    };
                };
        };
};
