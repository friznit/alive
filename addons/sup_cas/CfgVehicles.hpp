class CfgVehicles {
        class ModuleAliveSupportBase;
        class ADDON : ModuleAliveSupportBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_CAS";
                function = "ALIVE_fnc_CASInit";
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\mil_cqb\icon_mil_cqb.paa";
				picture = "x\alive\addons\mil_cqb\icon_mil_cqb.paa";
                class Arguments
                {
                        class cas_callsign
                        {
                                displayName = "$STR_ALIVE_CAS_CALLSIGN";
                                description = "$STR_ALIVE_CAS_CALLSIGN_DESC";
                                defaultValue ="EAGLE ONE";
                        };

                        class cas_type
                                {
                                displayName = "$STR_ALIVE_CAS_TYPE";
                                description = "$STR_ALIVE_CAS_TYPE_DESC";
                                defaultValue ="B_Heli_Attack_01_F";
                                };  
                        };
                };       
        };