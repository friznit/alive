class CfgVehicles {
        class ModuleAliveSystemBase;
        class ADDON : ModuleAliveSystemBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_HAC";
                function = "ALIVE_fnc_HAC_Init";
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\sys_HAC\icon_sys_HAC.paa";
				picture = "x\alive\addons\sys_HAC\icon_sys_HAC.paa";
                class Arguments
                {
                        class HAC_HQ_Debug
                        {
                                displayName = "$STR_ALIVE_HAC_DEBUG";
                                description = "$STR_ALIVE_HAC_DEBUG_COMMENT";
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
                        class HAC_HQ_Personality
                        {
                                displayName = "$STR_ALIVE_HAC_PERS";
                                description = "$STR_ALIVE_HAC_PERS_COMMENT";
                                class Values
                                {
                                        class GENIUS
                                        {
                                                name = "Genius";
                                                value = GENIUS;
                                                default = true;
                                        };
                                        class IDIOT
                                        {
                                                name = "Idiot";
                                                value = IDIOT;
                                        };
                                        class CHAOTIC
                                        {
                                                name = "Chaotic";
                                                value = CHAOTIC;
                                        };
                                        class EAGER
                                        {
                                                name = "Eager";
                                                value = EAGER;
                                        };
                                };
                        };
                };
                
        };
};
