class CfgVehicles {
        class ModuleAliveSupportBase;
        class ADDON : ModuleAliveSupportBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_COMBATSUPPORT";
                function = "ALIVE_fnc_CombatSupportInit";
                author = MODULE_AUTHOR;
                isGlobal = 1;
                isPersistent = 1;
                icon = "x\alive\addons\sup_combatsupport\icon_sup_combatsupport.paa";
                picture = "x\alive\addons\sup_combatsupport\icon_sup_combatsupport.paa";
                class Arguments
                {
                        class combatsupport_item
                        {
                                displayName = "$STR_ALIVE_CS_ALLOW";
                                description = "$STR_ALIVE_CS_ALLOW_COMMENT";
                                defaultValue = "LaserDesignator";
                        };
                };
                class ModuleDescription
				{
					//description = "$STR_ALIVE_CS_COMMENT"; // Short description, will be formatted as structured text
					description[] = {
							"$STR_ALIVE_CS_COMMENT",
							"",
							"$STR_ALIVE_CS_USAGE"
					};
					sync[] = {"ALiVE_SUP_TRANSPORT","ALiVE_SUP_CAS"}; // Array of synced entities (can contain base classes)
		 
					class ALiVE_SUP_TRANSPORT
					{
						description[] = { // Multi-line descriptions are supported
							"$STR_ALIVE_TRANSPORT_COMMENT",
							"",
							"$STR_ALIVE_TRANSPORT_USAGE"
						};
						position = 1; // Position is taken into effect
						direction = 1; // Direction is taken into effect
						optional = 1; // Synced entity is optional
						duplicate = 1; // Multiple entities of this type can be synced
					};
					class ALiVE_SUP_CAS
					{
						description[] = { // Multi-line descriptions are supported
							"$STR_ALIVE_CAS_COMMENT",
							"",
							"$STR_ALIVE_CAS_USAGE"
						};
						position = 1; // Position is taken into effect
						direction = 1; // Direction is taken into effect
						optional = 1; // Synced entity is optional
						duplicate = 1; // Multiple entities of this type can be synced
					};
				};
        };
};
