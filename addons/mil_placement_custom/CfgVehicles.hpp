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

                                        class smallHQOutpost1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_smallHQOutpost1";
                                        value = "smallHQOutpost1";
                                        };
                                        class largeMedicalHQ1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_largeMedicalHQ1";
                                        value = "largeMedicalHQ1";
                                        };
                                        class smallConvoyCamp1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_smallConvoyCamp1";
                                        value = "smallConvoyCamp1";
                                        };
                                        class smallMilitaryCamp1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_smallMilitaryCamp1";
                                        value = "smallMilitaryCamp1";
                                        };
                                        class smallMortarCamp1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_smallMortarCamp1";
                                        value = "smallMortarCamp1";
                                        };
                                        class mediumMilitaryCamp1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_mediumMilitaryCamp1";
                                        value = "mediumMilitaryCamp1";
                                        };
                                        class mediumMGCamp1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_mediumMGCamp1";
                                        value = "mediumMGCamp1";
                                        };
                                        class mediumMGCamp2
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_mediumMGCamp2";
                                        value = "mediumMGCamp2";
                                        };
                                        class mediumMGCamp3
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_mediumMGCamp3";
                                        value = "mediumMGCamp3";
                                        };
                                        class communicationCamp1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_communicationCamp1";
                                        value = "communicationCamp1";
                                        };
                                        class smallOspreyCrashsite1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_smallOspreyCrashsite1";
                                        value = "smallOspreyCrashsite1";
                                        };
                                        class smallAH99Crashsite1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_smallAH99Crashsite1";
                                        value = "smallAH99Crashsite1";
                                        };
                                        class mediumc192Crash1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_mediumc192Crash1";
                                        value = "mediumc192Crash1";
                                        };
                                        class largeMilitaryOutpost1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_largeMilitaryOutpost1";
                                        value = "largeMilitaryOutpost1";
                                        };
                                        class mediumMilitaryOutpost1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_mediumMilitaryOutpost1";
                                        value = "mediumMilitaryOutpost1";
                                        };
                                        class smallATNest1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_smallATNest1";
                                        value = "smallATNest1";
                                        };
                                        class smallMGNest1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_smallMGNest1";
                                        value = "smallMGNest1";
                                        };
                                        class smallCheckpoint1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_smallCheckpoint1";
                                        value = "smallCheckpoint1";
                                        };
                                        class smallRoadblock1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_smallRoadblock1";
                                        value = "smallRoadblock1";
                                        };
                                        class mediumCheckpoint1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_mediumCheckpoint1";
                                        value = "mediumCheckpoint1";
                                        };
                                        class largeGarbageCamp1
                                        {
                                        name = "$STR_ALIVE_COMPOSITION_largeGarbageCamp1";
                                        value = "largeGarbageCamp1";
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
