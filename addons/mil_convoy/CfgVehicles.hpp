class CfgVehicles {
        class ModuleAliveMilitaryBase;
        class ADDON : ModuleAliveMilitaryBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_CONVOY";
                function = "ALIVE_fnc_convoyInit";
                author = MODULE_AUTHOR;
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\sup_transport\icon_sup_transport.paa";
				picture = "x\alive\addons\sup_transport\icon_sup_transport.paa";
                class Arguments
                {
                class conv_debug_setting
                        {
                                displayName = "$STR_ALIVE_CONVOY_DEBUG";
                                description = "$STR_ALIVE_CONVOY_DEBUG_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "Yes";
                                                value = true;
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = false;
                                                default = false;
                                        };
                                };
                        };
                class conv_intensity_setting
                        {
                                displayName = "$STR_ALIVE_CONVOY_INTENSITY";
                                description = "$STR_ALIVE_CONVOY_INTENSITY_DESC";
                                class Values
                                {
                                        class conv_intesity_low
                                        {
                                                name = "Low";
                                                value = 1;
                                                default = 1;
                                                conv_intesnsity = 1;
                                        };
                                         class conv_intesity_med
                                        {
                                                name = "Medium";
                                                value = 2;
                                                conv_intesnsity = 2;
                                        };
                                         class conv_intesity_high
                                        {
                                                name = "High";
                                                value = 3;
                                                conv_intesnsity = 3;
                                        };

                                };
                        };
                class CONV_FACTIONS
                        {
                                displayName = "$STR_ALIVE_CONVOY_FACTIONS";
                                description = "$STR_ALIVE_CONVOY_FACTIONS_COMMENT";
                                defaultValue = "OPF_F";
                        };
                };
                
        };
};