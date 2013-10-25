class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_CREWINFO";
                function = "ALIVE_fnc_crewinfoInit";
                isGlobal = 1;
                isPersistent = 1;
                icon = "sys_crewinfo\icon_sys_crewinfo.paa";
                picture = "sys_crewinfo\icon_sys_crewinfo.paa";
                
			         	class Arguments
			          {
			                        class crewinfo_debug_setting
			                        {
			                                displayName = "$STR_ALIVE_CREWINFO_DEBUG";
			                                description = "$STR_ALIVE_CREWINFO_DEBUG_COMMENT";
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
			                        class crewinfo_ui_setting
			                        {
			                                displayName = "$STR_ALIVE_CREWINFO_UI";
			                                description = "$STR_ALIVE_CREWINFO_UI_COMMENT";
			                                class Values
			                                {
			                                        class uiRight
			                                        {
			                                                name = "Right";
			                                                value = 1;
																											default = 1;
			                                        };
			                                        class uiLeft
			                                        {
			                                                name = "Left";
			                                                value = 2;
			                                        };

			                                };
			                        };
			          };
			                
			  };
};
