class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_DISABLE_PERF";
				function = "ALIVE_fnc_perfModuleFunction";
				author = MODULE_AUTHOR;
                isGlobal = 1;
				isPersistent = 1;
				icon = "x\alive\addons\sys_perf\icon_sys_perf.paa";
				picture = "x\alive\addons\sys_perf\icon_sys_perf.paa";
                class Arguments
                {
                        class Condition
                        {
                                displayName = "Condition:";
                                description = "";
                                defaultValue = "true";
                        };                        
                };
				
		class Eventhandlers
		{
			init = "call ALIVE_fnc_perfDisable;";
		};
                
        };
};
