class CfgVehicles {
        class ModuleAliveMilitaryBase;
        class ADDON : ModuleAliveMilitaryBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_OPCOM";
                function = "ALIVE_fnc_OPCOMInit";
                author = MODULE_AUTHOR;
				functionPriority = 4;
                isGlobal = 0;
                isPersistent = 0;
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
                        class PLAYERTASKINGS
                        {
                                displayName = "$STR_ALIVE_OPCOM_PLAYERTASKINGS";
                                description = "$STR_ALIVE_OPCOM_PLAYERTASKINGS_COMMENT";
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
            	class ModuleDescription
				{
					//description = "$STR_ALIVE_OPCOM_COMMENT"; // Short description, will be formatted as structured text
					description[] = {
							"$STR_ALIVE_OPCOM_COMMENT",
							"",
							"$STR_ALIVE_OPCOM_USAGE"
					};
					sync[] = {"ALiVE_civ_placement","ALiVE_mil_placement","ALiVE_mil_intelligence","ALiVE_mil_logistics"}; // Array of synced entities (can contain base classes)
		 
					class ALiVE_civ_placement
					{
						description[] = { // Multi-line descriptions are supported
							"$STR_ALIVE_CP_COMMENT",
							"",
							"$STR_ALIVE_CP_USAGE"
						};
						position = 0; // Position is taken into effect
						direction = 0; // Direction is taken into effect
						optional = 1; // Synced entity is optional
						duplicate = 1; // Multiple entities of this type can be synced
					};
					class ALiVE_mil_placement
					{
						description[] = { // Multi-line descriptions are supported
							"$STR_ALIVE_MP_COMMENT",
							"",
							"$STR_ALIVE_MP_USAGE"
						};
						position = 0; // Position is taken into effect
						direction = 0; // Direction is taken into effect
						optional = 1; // Synced entity is optional
						duplicate = 1; // Multiple entities of this type can be synced
					};
					class ALiVE_mil_intelligence
					{
						description[] = { // Multi-line descriptions are supported
							"$STR_ALIVE_MI_COMMENT",
							"",
							"$STR_ALIVE_MI_USAGE"
						};
						position = 0; // Position is taken into effect
						direction = 0; // Direction is taken into effect
						optional = 1; // Synced entity is optional
						duplicate = 1; // Multiple entities of this type can be synced
					};
					class ALiVE_mil_logistics
                    {
                        description[] = { // Multi-line descriptions are supported
                            "$STR_ALIVE_ML_COMMENT",
                            "",
                            "$STR_ALIVE_ML_USAGE"
                        };
                        position = 0; // Position is taken into effect
                        direction = 0; // Direction is taken into effect
                        optional = 1; // Synced entity is optional
                        duplicate = 1; // Multiple entities of this type can be synced
                    };
				};
        };
};
