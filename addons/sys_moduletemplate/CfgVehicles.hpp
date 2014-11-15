class CfgVehicles {
        class ModuleAliveBase;

        class ADDON : ModuleAliveBase
        {
        		scope = 1;
				displayName = "$STR_ALIVE_MODULETEMPLATE";
				function = "ALIVE_fnc_emptyInit";
				functionPriority = 0;
				isGlobal = 2;
				icon = "x\alive\addons\sys_moduletemplate\icon_sys_moduletemplate.paa";
				picture = "x\alive\addons\sys_moduletemplate\icon_sys_moduletemplate.paa";
				author = MODULE_AUTHOR;
        };

        class ALiVE_SYS_MODULETEMPLATEPARAMS : ModuleAliveBase
        {
				scope = 1;
				displayName = "$STR_ALIVE_MODULETEMPLATEPARAMS";
				function = "ALIVE_fnc_moduleTemplateParams";
				functionPriority = 0;
				isGlobal = 2;
				icon = "x\alive\addons\sys_moduletemplate\icon_sys_moduletemplate.paa";
				picture = "x\alive\addons\sys_moduletemplate\icon_sys_moduletemplate.paa";
				author = MODULE_AUTHOR;

                class ModuleDescription
				{
					description[] = {
							"$STR_ALIVE_MODULETEMPLATEPARAMS_COMMENT",
							"",
							"$STR_ALIVE_MODULETEMPLATEPARAMS_USAGE"
					};
				};

                class Arguments
                {

                        class DEBUG
                        {
                                displayName = "$STR_ALIVE_MODULETEMPLATE_DEBUG";
                                description = "$STR_ALIVE_MODULETEMPLATE_DEBUG_COMMENT";
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
                                                default = 1;
                                        };
                                };
                        };
                };
        };
};