class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_PLAYERTAGS";
                function = "ALIVE_fnc_playertagsInit";
                isGlobal = 1;
                isPersistent = 1;
								icon = "x\alive\addons\sys_playertags\icon_sys_playertags.paa";
								picture = "x\alive\addons\sys_playertags\icon_sys_playertags.paa";
								
								class Arguments
			          {
			                        class playertags_debug_setting
			                        {
			                                displayName = "$STR_ALIVE_PLAYERTAGS_DEBUG";
			                                description = "$STR_ALIVE_PLAYERTAGS_DEBUG_COMMENT";
			                                class Values
			                                {
			                                	
			                                        class No
			                                        {
			                                                name = "No";
			                                                value = false;
			                                                default = false;
			                                        };
			                                        class Yes
			                                        {
			                                                name = "Yes";
			                                                value = true;
			                                               
			                                        };
			                                };
			                        };
			                        
			                        class playertags_displayrank_setting
			                        {
			                                displayName = "$STR_ALIVE_PLAYERTAGS_RANK";
			                                description = "$STR_ALIVE_PLAYERTAGS_RANK_COMMENT";
			                                class Values
			                                {
			                                	
			                                        class No
			                                        {
			                                                name = "No";
			                                                value = false;
			                                        };
			                                        class Yes
			                                        {
			                                                name = "Yes";
			                                                value = true;
			                                                default = true;
			                                               
			                                        };
			                                };
			                        };
			                        
			                        
			                        class playertags_displaygroup_setting
			                        {
			                                displayName = "$STR_ALIVE_PLAYERTAGS_GROUP";
			                                description = "$STR_ALIVE_PLAYERTAGS_GROUP_COMMENT";
			                                class Values
			                                {
			                                	
			                                        class No
			                                        {
			                                                name = "No";
			                                                value = false;
			                                        };
			                                        class Yes
			                                        {
			                                                name = "Yes";
			                                                value = true;
			                                                default = true;
			                                               
			                                        };
			                                };
			                        };
			                        
			                        
			                        class playertags_distance_setting
			                        {
			                                displayName = "$STR_ALIVE_PLAYERTAGS_DISTANCE";
			                                description = "$STR_ALIVE_PLAYERTAGS_DISTANCE_COMMENT";
                               			  defaultValue = 20;
                                      typeName = "NUMBER";
			                        };
			                        
			                        class playertags_tolerance_setting
			                        {
			                                displayName = "$STR_ALIVE_PLAYERTAGS_TOLERANCE";
			                                description = "$STR_ALIVE_PLAYERTAGS_TOLERANCE_COMMENT";
                               			  defaultValue = 0.75;
                                      typeName = "NUMBER";
			                        };
			                        
			                        class playertags_scale_setting
			                        {
			                                displayName = "$STR_ALIVE_PLAYERTAGS_SCALE";
			                                description = "$STR_ALIVE_PLAYERTAGS_SCALE_COMMENT";
                               			  defaultValue = 0.65;
                                      typeName = "NUMBER";
			                        };
			          };
        };
};
