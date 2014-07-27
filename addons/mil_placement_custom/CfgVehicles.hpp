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

                                        // autogen start

                                        class AAF_Communication_Camp_1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_AAF_Communication_Camp_1";
                                        value = "AAF_Communication_Camp_1";
                                        };
                                        class AAF_Bunker_Light_1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_AAF_Bunker_Light_1";
                                        value = "AAF_Bunker_Light_1";
                                        };
                                        class AAF_Bunker_Light_2
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_AAF_Bunker_Light_2";
                                        value = "AAF_Bunker_Light_2";
                                        };
                                        class AAF_AntiTank_Nest_1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_AAF_AntiTank_Nest_1";
                                        value = "AAF_AntiTank_Nest_1";
                                        };
                                        class AAF_Convoy_Camp_1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_AAF_Convoy_Camp_1";
                                        value = "AAF_Convoy_Camp_1";
                                        };
                                        class NATO_Supply_Bunker_1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_NATO_Supply_Bunker_1";
                                        value = "NATO_Supply_Bunker_1";
                                        };
                                        class NATO_HQ_Medical_1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_NATO_HQ_Medical_1";
                                        value = "NATO_HQ_Medical_1";
                                        };
                                        class NATO_Crashsite_1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_NATO_Crashsite_1";
                                        value = "NATO_Crashsite_1";
                                        };
                                        class NATO_Medium_Checkpoint_1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_NATO_Medium_Checkpoint_1";
                                        value = "NATO_Medium_Checkpoint_1";
                                        };
                                        class NATO_Light_Camp_1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_NATO_Light_Camp_1";
                                        value = "NATO_Light_Camp_1";
                                        };
                                        class CSAT_Light_Camp_1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_CSAT_Light_Camp_1";
                                        value = "CSAT_Light_Camp_1";
                                        };
                                        class CSAT_Checkpoint_1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_CSAT_Checkpoint_1";
                                        value = "CSAT_Checkpoint_1";
                                        };
                                        class CSAT_Heavy_Camp_1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_CSAT_Heavy_Camp_1";
                                        value = "CSAT_Heavy_Camp_1";
                                        };
                                        class CSAT_Mortar_Camp_1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_CSAT_Mortar_Camp_1";
                                        value = "CSAT_Mortar_Camp_1";
                                        };
                                        class CSAT_Medium_Camp_1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_CSAT_Medium_Camp_1";
                                        value = "CSAT_Medium_Camp_1";
                                        };
                                        class GENERIC_Garbage_Camp
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_GENERIC_Garbage_Camp";
                                        value = "GENERIC_Garbage_Camp";
                                        };
                                        class GENEROC_Medium_Camp_1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_GENEROC_Medium_Camp_1";
                                        value = "GENEROC_Medium_Camp_1";
                                        };
                                        class GENERIC_Osprey_Crash
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_GENERIC_Osprey_Crash";
                                        value = "GENERIC_Osprey_Crash";
                                        };
                                        class GENERIC_Medium_Crashsite_1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_GENERIC_Medium_Crashsite_1";
                                        value = "GENERIC_Medium_Crashsite_1";
                                        };
                                        class GENERIC_Roadblock_1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_GENERIC_Roadblock_1";
                                        value = "GENERIC_Roadblock_1";
                                        };
                                        class GENERIC_Roadblock_2
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_GENERIC_Roadblock_2";
                                        value = "GENERIC_Roadblock_2";
                                        };


                                        // autogen end

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
