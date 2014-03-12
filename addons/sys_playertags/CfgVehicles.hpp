class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_PLAYERTAGS";
                function = "ALIVE_fnc_playertagsInit";
                functionPriority = 24;
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
			                        
                       				 class playertags_invehicle_setting
			                        {
			                                displayName = "$STR_ALIVE_PLAYERTAGS_INVEHICLE";
			                                description = "$STR_ALIVE_PLAYERTAGS_INVEHICLE_COMMENT";
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
			                        
			                        class playertags_targets_setting
			                        {
			                                displayName = "$STR_ALIVE_PLAYERTAGS_TARGETS";
			                                description = "$STR_ALIVE_PLAYERTAGS_TARGETS_COMMENT";
                               			  defaultValue = "[""CAManBase"", ""Car"", ""Tank"", ""StaticWeapon"", ""Helicopter"", ""Plane""]";
                                      typeName = "ARRAY";
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
			                        
			                        
			                        class playertags_height_setting
			                        {
			                                displayName = "$STR_ALIVE_PLAYERTAGS_HEIGHT";
			                                description = "$STR_ALIVE_PLAYERTAGS_HEIGHT_COMMENT";
                               			  defaultValue = 1.1;
                                      typeName = "NUMBER";
			                        };
			                        
			                        
			                        class playertags_namecolour_setting
			                        {
			                                displayName = "$STR_ALIVE_PLAYERTAGS_NAMECOLOUR";
			                                description = "$STR_ALIVE_PLAYERTAGS_NAMECOLOUR_COMMENT";
                               			  defaultValue = "#FFFFFF"; // white
                                      typeName = "STRING";
			                        };
			                        
			                        class playertags_groupcolour_setting
			                        {
			                                displayName = "$STR_ALIVE_PLAYERTAGS_GROUPCOLOUR";
			                                description = "$STR_ALIVE_PLAYERTAGS_GROUPCOLOUR_COMMENT";
                               			  defaultValue = "#A8F000"; // green
                                      typeName = "STRING";
			                        };
			                        
			                        class playertags_thisgroupleadernamecolour_setting
			                        {
			                                displayName = "$STR_ALIVE_PLAYERTAGS_THISGROUPLEADERNAMECOLOUR";
			                                description = "$STR_ALIVE_PLAYERTAGS_THISGROUPLEADERNAMECOLOUR_COMMENT";
                               			  defaultValue = "#FFB300"; // yellow
                                      typeName = "STRING";
			                        };
			                        
			                        class playertags_thisgroupcolour_setting
			                        {
			                                displayName = "$STR_ALIVE_PLAYERTAGS_THISGROUPCOLOUR";
			                                description = "$STR_ALIVE_PLAYERTAGS_THISGROUPCOLOUR_COMMENT";
                               			  defaultValue = "#009D91"; // cyan
                                      typeName = "STRING";
			                        };

			          };
        };
};


