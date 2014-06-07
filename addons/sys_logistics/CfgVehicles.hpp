class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
				scope = 2;
				displayName = "$STR_ALIVE_LOGISTICS";
				function = "ALIVE_fnc_logisticsInit";
				functionPriority = 200;
				isGlobal = 2;
				icon = "x\alive\addons\sys_logistics\icon_sys_logistics.paa";
				picture = "x\alive\addons\sys_logistics\icon_sys_logistics.paa";
				author = MODULE_AUTHOR;
				
                class ModuleDescription
				{
					description[] = {
							"$STR_ALIVE_LOGISTICS_COMMENT",
							"",
							"$STR_ALIVE_LOGISTICS_USAGE"
					};
					sync[] = {"ALiVE_sys_data"}; // Array of synced entities (can contain base classes)
		 
					class ALiVE_sys_data
					{
						description[] = { // Multi-line descriptions are supported
							"$STR_ALIVE_Data_COMMENT",
							"",
							"$STR_ALIVE_Data_COMMENT"
						};
						position = 0; // Position is taken into effect
						direction = 0; // Direction is taken into effect
						optional = 1; // Synced entity is optional
						duplicate = 1; // Multiple entities of this type can be synced
					};
				};

                class Arguments
                {

                        class DEBUG
                        {
                                displayName = "$STR_ALIVE_LOGISTICS_DEBUG";
                                description = "$STR_ALIVE_LOGISTICS_DEBUG_COMMENT";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "Yes";
                                                value = true;
                                                default = 1;
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = false;
                                        };
                                };
                        };
                };
        };
};
