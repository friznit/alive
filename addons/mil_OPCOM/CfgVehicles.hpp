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
                        class faction1
                        {
                                displayName = "$STR_ALIVE_OPCOM_FACTION";
                                description = "$STR_ALIVE_OPCOM_FACTION_COMMENT";
                                class Values
                                {
                                        class NATO
                                        {
                                                name = "NATO";
                                                value = "BLU_F";
                                                default = "BLU_F";
                                                defaultValue = "BLU_F";
                                        };
                                        class IRAN
                                        {
                                                name = "IRAN";
                                                value = "OPF_F";
                                        };
                                        class GREEKARMY
                                        {
                                                name = "AAF";
                                                value = "IND_F";
                                        };
                                        class REBELS
                                        {
                                                name = "REBELS";
                                                value = "BLU_G_F";
                                        };
                                        class NONE
                                        {
                                                name = "NONE";
                                                value = "NONE";
                                        };
                                };
                        };
                        class faction2
                        {
                                displayName = "$STR_ALIVE_OPCOM_FACTION";
                                description = "$STR_ALIVE_OPCOM_FACTION_COMMENT";
                                class Values
                                {
                                		class NONE
                                        {
                                                name = "NONE";
                                                value = "NONE";
                                                default = "NONE";
                                                defaultValue = "NONE";
                                        };
                                        class NATO
                                        {
                                                name = "NATO";
                                                value = "BLU_F";
                                        };
                                        class IRAN
                                        {
                                                name = "IRAN";
                                                value = "OPF_F";
                                        };
                                        class GREEKARMY
                                        {
                                                name = "AAF";
                                                value = "IND_F";
                                        };
                                        class REBELS
                                        {
                                                name = "REBELS";
                                                value = "BLU_G_F";
                                        };
                                };
                        };
                        class faction3
                        {
                                displayName = "$STR_ALIVE_OPCOM_FACTION";
                                description = "$STR_ALIVE_OPCOM_FACTION_COMMENT";
                                class Values
                                {
                                		class NONE
                                        {
                                                name = "NONE";
                                                value = "NONE";
                                                default = "NONE";
                                                defaultValue = "NONE";
                                        };
                                        class NATO
                                        {
                                                name = "NATO";
                                                value = "BLU_F";
                                        };
                                        class IRAN
                                        {
                                                name = "IRAN";
                                                value = "OPF_F";
                                        };
                                        class GREEKARMY
                                        {
                                                name = "AAF";
                                                value = "IND_F";
                                        };
                                        class REBELS
                                        {
                                                name = "REBELS";
                                                value = "BLU_G_F";
                                        };
                                };
                        };
                        class faction4
                        {
                                displayName = "$STR_ALIVE_OPCOM_FACTION";
                                description = "$STR_ALIVE_OPCOM_FACTION_COMMENT";
                                class Values
                                {
                                		class NONE
                                        {
                                                name = "NONE";
                                                value = "NONE";
                                                default = "NONE";
                                                defaultValue = "NONE";
                                        };
                                        class NATO
                                        {
                                                name = "NATO";
                                                value = "BLU_F";
                                        };
                                        class IRAN
                                        {
                                                name = "IRAN";
                                                value = "OPF_F";
                                        };
                                        class GREEKARMY
                                        {
                                                name = "AAF";
                                                value = "IND_F";
                                        };
                                        class REBELS
                                        {
                                                name = "REBELS";
                                                value = "BLU_G_F";
                                        };
                                };
                        };
                        class factions
                        {
                                displayName = "$STR_ALIVE_OPCOM_FACTIONS";
                                description = "$STR_ALIVE_OPCOM_FACTIONS_COMMENT";
                                defaultValue = [];
                        };
                };
                
        };
};
