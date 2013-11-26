class CfgVehicles {
        class ModuleAliveMilitaryBase;
        class ADDON : ModuleAliveMilitaryBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_ML";
                function = "ALIVE_fnc_MLInit";
				functionPriority = 5;
                isGlobal = 0;
                isPersistent = 0;
				icon = "x\alive\addons\mil_logistics\icon_mil_ML.paa";
				picture = "x\alive\addons\mil_logistics\icon_mil_ML.paa";
                class Arguments
                {
                        class debug
                        {
                                displayName = "$STR_ALIVE_ML_DEBUG";
                                description = "$STR_ALIVE_ML_DEBUG_COMMENT";
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
                };
                class ModuleDescription
                {
                    //description = "$STR_ALIVE_OPCOM_COMMENT"; // Short description, will be formatted as structured text
                    description[] = {
                            "$STR_ALIVE_ML_COMMENT",
                            "",
                            "$STR_ALIVE_ML_USAGE"
                    };
                    sync[] = {"ALiVE_mil_OPCOM"}; // Array of synced entities (can contain base classes)

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

                };
                
        };
};
