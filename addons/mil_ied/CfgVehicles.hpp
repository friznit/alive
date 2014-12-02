class CfgVehicles {
        class ModuleAliveBase;
        class ADDON : ModuleAliveBase
        {
                scope = 2;
                displayName = "$STR_ALIVE_ied";
                function = "ALIVE_fnc_iedInit";
                isGlobal = 2;
                isPersistent = 0;
                author = MODULE_AUTHOR;
                functionPriority = 110;
				icon = "x\alive\addons\mil_ied\icon_mil_ied.paa";
				picture = "x\alive\addons\mil_ied\icon_mil_ied.paa";
                class Arguments
                {
                        class debug
                        {
                                displayName = "$STR_ALIVE_IED_DEBUG";
                                description = "$STR_ALIVE_IED_DEBUG_COMMENT";
                                typeName = "BOOL";
                                class Values
                                {
                                        class Yes
                                        {
                                                name = "Yes";
                                                value = 1;
                                        };
                                        class No
                                        {
                                                name = "No";
                                                value = 0;
                                                default = 1;
                                        };
                                };
                        };
                        class taor
                        {
                                displayName = "$STR_ALIVE_IED_TAOR";
                                description = "$STR_ALIVE_IED_TAOR_COMMENT";
                                defaultValue = "";
                        };
                        class blacklist
                        {
                                displayName = "$STR_ALIVE_IED_BLACKLIST";
                                description = "$STR_ALIVE_IED_BLACKLIST_COMMENT";
                                defaultValue = "";
                        };
                        class IED_Threat
                        {
                                displayName = "$STR_ALIVE_ied_IED_Threat";
                                description = "$STR_ALIVE_ied_IED_Threat_COMMENT";
                                typeName = "NUMBER";
                                class Values
                                {
                                        class None
                                        {
                                                name = "None";
                                                value = 0;
                                                default = 1;
                                        };
                                        class Low
                                        {
                                                name = "Low";
                                                value = 50;
                                        };
                                        class Med
                                        {
                                                name = "Medium";
                                                value = 100;
                                        };
                                        class High
                                        {
                                                name = "High";
                                                value = 200;
                                        };
                                        class Extreme
                                        {
                                                name = "Exteme";
                                                value = 350;
                                        };
                                };
                        };
/*                      class Bomber_Threat
                        {
                                displayName = "$STR_ALIVE_ied_Bomber_Threat";
                                description = "$STR_ALIVE_ied_Bomber_Threat_COMMENT";
                                typeName = "NUMBER";
                                class Values
                                {
                                        class None
                                        {
                                                name = "None";
                                                value = 0;
                                                default = 1;
                                        };
                                        class Low
                                        {
                                                name = "Low";
                                                value = 10;
                                        };
                                        class Med
                                        {
                                                name = "Medium";
                                                value = 20;
                                        };
                                        class High
                                        {
                                                name = "High";
                                                value = 30;
                                        };
                                        class Extreme
                                        {
                                                name = "Exteme";
                                                value = 50;
                                        };
                                };
                        }; */
                        class VB_IED_Threat
                        {
                                displayName = "$STR_ALIVE_ied_VB_IED_Threat";
                                description = "$STR_ALIVE_ied_VB_IED_Threat_COMMENT";
                                typeName = "NUMBER";
                                class Values
                                {
                                        class None
                                        {
                                                name = "None";
                                                value = 0;
                                                default = 1;
                                        };
                                        class Low
                                        {
                                                name = "Low";
                                                value = 5;
                                        };
                                        class Med
                                        {
                                                name = "Medium";
                                                value = 10;
                                        };
                                        class High
                                        {
                                                name = "High";
                                                value = 30;
                                        };
                                        class Extreme
                                        {
                                                name = "Exteme";
                                                value = 60;
                                        };
                                };
                        };
                        class VB_IED_Side
                        {
                                displayName = "$STR_ALIVE_ied_VB_IED_Side";
                                description = "$STR_ALIVE_ied_VB_IED_Side_COMMENT";
                                typeName = "STRING";
                                class Values
                                {
                                        class Civ
                                        {
                                                name = "CIV";
                                                value = "CIV";
                                                default = 1;
                                        };
                                        class East
                                        {
                                                name = "EAST";
                                                value = "EAST";
                                        };
                                        class West
                                        {
                                                name = "WEST";
                                                value = "WEST";
                                        };
                                        class Ind
                                        {
                                                name = "IND";
                                                value = "GUER";
                                        };
                                };
                        };
                        class Locs_IED
                        {
                                displayName = "$STR_ALIVE_ied_Locs_IED";
                                description = "$STR_ALIVE_ied_Locs_IED_COMMENT";
                                typeName = "NUMBER";
                                class Values
                                {
                                        class Random
                                        {
                                                name = "Random";
                                                value = 0;
                                                default = 1;
                                        };
                                        class Occupied
                                        {
                                                name = "Enemy Occupied";
                                                value = 1;
                                        };
                                        class Unoccupied
                                        {
                                                name = "Unoccupied";
                                                value = 2;
                                        };
                                };
                        };
                };
        };

        class ThingX;
        class Land_Sack_F;
        class ALiVE_IED : ThingX {
            author = "ALiVE Mod Team";
            _generalMacro = "ALiVE_IED";
            model = "\A3\Weapons_F\empty.p3d";
            icon = "iconObject";
            vehicleClass = "Objects";
            destrType = "DestructTent";
            cost = 250;
        };

        class ALIVE_IEDUrbanSmall_Remote_Ammo : ALiVE_IED {
            scope = 2;
            scopeCurator = 2;
            displayName = "";
            model = "\A3\Weapons_F\Explosives\IED_urban_small";
        };

        class ALIVE_IEDLandSmall_Remote_Ammo : ALIVE_IEDUrbanSmall_Remote_Ammo {
            model = "\A3\Weapons_F\Explosives\IED_land_small";
        };

        class ALIVE_IEDUrbanBig_Remote_Ammo : ALIVE_IEDUrbanSmall_Remote_Ammo {
            model = "\A3\Weapons_F\Explosives\IED_urban_big";
        };

        class ALIVE_IEDLandBig_Remote_Ammo : ALIVE_IEDUrbanSmall_Remote_Ammo {
            model = "\A3\Weapons_F\Explosives\IED_land_big";
        };

        class ALIVE_DemoCharge_Remote_Ammo : ALIVE_IEDUrbanSmall_Remote_Ammo {
            model = "\A3\Weapons_F\explosives\c4_charge_small";
        };

        class ALIVE_SatchelCharge_Remote_Ammo : ALIVE_IEDUrbanSmall_Remote_Ammo {
            model = "\A3\Weapons_F\Explosives\satchel";
        };

};
