class CfgVehicles {
        class ModuleAliveSupportBase;
        class ADDON : ModuleAliveSupportBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_TRANSPORT";
                function = "ALIVE_fnc_TRANSPORTInit";
                isGlobal = 1;
                isPersistent = 1;
				icon = "x\alive\addons\sup_transport\icon_sup_transport.paa";
				picture = "x\alive\addons\sup_transport\icon_sup_transport.paa";
                class Arguments
                {
                        class transport_callsign
                        {
                                displayName = "$STR_ALIVE_TRANSPORT_CALLSIGN";
                                description = "$STR_ALIVE_TRANSPORT_CALLSIGN_DESC";
                                defaultValue ="RODEO TWO";
                        };
                        class trasnport_type
                                {
                                displayName = "$STR_ALIVE_TRANSPORT_TYPE";
                                description = "$STR_ALIVE_TRANSPORT_TYPE_DESC";
                                defaultValue="B_Heli_Transport_01_camo_F";
                                };
                        };
                };
                
        };