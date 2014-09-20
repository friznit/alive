class CfgVehicles {
        class ModuleAliveSupportBase;
        class ADDON : ModuleAliveSupportBase
        {
        	scope = 2;
        	displayName = "$STR_ALIVE_COMBATSUPPORT2";
        	function = "ALIVE_fnc_combatsupport2Init";
        	functionPriority = 0;
        	isGlobal = 2;
        	icon = "x\alive\addons\sup_combatsupport2\icon_sup_combatsupport.paa";
        	picture = "x\alive\addons\sup_combatsupport2\icon_sup_combatsupport.paa";
        	author = MODULE_AUTHOR;
				
                class ModuleDescription
		{
        		description[] = {
				"$STR_ALIVE_CS2_COMMENT",
				"",
				"$STR_ALIVE_CS2_USAGE"
        		};
		};
				
                class Arguments
                {

                        class DEBUG
                        {
                                displayName = "$STR_ALIVE_CS2_DEBUG";
                                description = "";
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