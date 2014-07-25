class CfgVehicles {
        class ModuleAliveMilitaryBase;
        class ADDON : ModuleAliveMilitaryBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_CMP";
                function = "ALIVE_fnc_CMPInit";
                author = MODULE_AUTHOR;
                functionPriority = 5;
                isGlobal = 1;
                icon = "x\alive\addons\mil_placement_custom\icon_mil_CMP.paa";
                picture = "x\alive\addons\mil_placement_custom\icon_mil_CMP.paa";
                class Arguments
                {
                        class debug
                        {
                                displayName = "$STR_ALIVE_CMP_DEBUG";
                                description = "$STR_ALIVE_CMP_DEBUG_COMMENT";
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
                        class faction
                        {
                                displayName = "$STR_ALIVE_CMP_FACTION";
                                description = "$STR_ALIVE_CMP_FACTION_COMMENT";
                                defaultValue = "OPF_F";
                        };
                        class priority
                        {
                                displayName = "$STR_ALIVE_CMP_PRIORITY";
                                description = "$STR_ALIVE_CMP_PRIORITY_COMMENT";
                                defaultValue = "50";
                        };
                        class size
                        {
                                displayName = "$STR_ALIVE_CMP_SIZE";
                                description = "$STR_ALIVE_CMP_SIZE_COMMENT";
                                defaultValue = "50";
                        };
                        class customInfantryCount
                        {
                                displayName = "$STR_ALIVE_CMP_CUSTOM_INFANTRY_COUNT";
                                description = "$STR_ALIVE_CMP_CUSTOM_INFANTRY_COUNT_COMMENT";
                                defaultValue = "0";
                        };
                        class customMotorisedCount
                        {
                                displayName = "$STR_ALIVE_CMP_CUSTOM_MOTORISED_COUNT";
                                description = "$STR_ALIVE_CMP_CUSTOM_MOTORISED_COUNT_COMMENT";
                                defaultValue = "0";
                        };
                        class customMechanisedCount
                        {
                                displayName = "$STR_ALIVE_CMP_CUSTOM_MECHANISED_COUNT";
                                description = "$STR_ALIVE_CMP_CUSTOM_MECHANISED_COUNT_COMMENT";
                                defaultValue = "0";
                        };
                        class customArmourCount
                        {
                                displayName = "$STR_ALIVE_CMP_CUSTOM_ARMOUR_COUNT";
                                description = "$STR_ALIVE_CMP_CUSTOM_ARMOUR_COUNT_COMMENT";
                                defaultValue = "0";
                        };
                        class customSpecOpsCount
                        {
                                displayName = "$STR_ALIVE_CMP_CUSTOM_SPECOPS_COUNT";
                                description = "$STR_ALIVE_CMP_CUSTOM_SPECOPS_COUNT_COMMENT";
                                defaultValue = "0";
                        };
                        class composition
                        {
                                displayName = "$STR_ALIVE_CMP_COMPOSITION";
                                description = "$STR_ALIVE_CMP_COMPOSITION_COMMENT";
                                class Values
                                {
                                        class CompNo
                                        {
                                                name = "No";
                                                value = false;
                                                default = true;
                                        };
                                        class CompA
                                        {
                                                name = "$STR_ALIVE_CMP_COMPOSITION_BIS_A";
                                                value = "OutpostA";
                                        };
                                        class CompB
                                        {
                                                name = "$STR_ALIVE_CMP_COMPOSITION_BIS_B";
                                                value = "OutpostB";
                                        };
                                        class CompC
                                        {
                                                name = "$STR_ALIVE_CMP_COMPOSITION_BIS_C";
                                                value = "OutpostC";
                                        };
                                        class CompD
                                        {
                                                name = "$STR_ALIVE_CMP_COMPOSITION_BIS_D";
                                                value = "OutpostD";
                                        };
                                        class CompE
                                        {
                                                name = "$STR_ALIVE_CMP_COMPOSITION_BIS_E";
                                                value = "OutpostE";
                                        };
                                        class CompF
                                        {
                                                name = "$STR_ALIVE_CMP_COMPOSITION_BIS_F";
                                                value = "OutpostF";
                                        };
                                };
                        };
                };
                class ModuleDescription
                {
                    //description = "$STR_ALIVE_OPCOM_COMMENT"; // Short description, will be formatted as structured text
                    description[] = {
                            "$STR_ALIVE_CMP_COMMENT",
                            "",
                            "$STR_ALIVE_CMP_USAGE"
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
