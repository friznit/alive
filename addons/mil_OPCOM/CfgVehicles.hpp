class CfgVehicles {
        class ModuleAliveMilitaryBase;
        class ADDON : ModuleAliveMilitaryBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_OPCOM";
                function = "ALIVE_fnc_OPCOMInit";
				functionPriority = 4;
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\mil_opcom\icon_mil_opcom.paa";
				picture = "x\alive\addons\mil_opcom\icon_mil_opcom.paa";
                class Arguments
                {
                        class debug
                        {
                                displayName = "$STR_ALIVE_OPCOM_DEBUG";
                                description = "$STR_ALIVE_OPCOM_DEBUG_COMMENT";
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
                        class controltype
                        {
                                displayName = "$STR_ALIVE_OPCOM_CONTROLTYPE";
                                description = "$STR_ALIVE_OPCOM_CONTROLTYPE_COMMENT";
                                class Values
                                {
                                        class invasion
                                        {
                                                name = "Invasion";
                                                value = "invasion";
                                                default = "invasion";
                                        };
                                        class occupation
                                        {
                                                name = "Occupation";
                                                value = "occupation";
                                        };
                                };
                        };
                        class factions
                        {
                                displayName = "$STR_ALIVE_OPCOM_FACTIONS";
                                description = "$STR_ALIVE_OPCOM_FACTIONS_COMMENT";
                                defaultValue = ["OPF_F"];
                        };
                };
                
        };
};
