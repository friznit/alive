// Add a game logic which does nothing except requires the addon in the mission.

class CfgFactionClasses {
	class Alive {
		displayName = "$STR_ALIVE_MODULE";
		priority = 0;
		side = 7;
	};
};
class CfgVehicles {
	class Logic;
	class Module_F: Logic {
		class ArgumentsBaseUnits {
			class Units;
		};
		class ModuleDescription
		{
			class AnyBrain;
		};
	};
	class ModuleAliveBase: Module_F {
		scope = 1;
		displayName = "EditorAliveBase";
		category = "Alive";
	};

	class ALiVE_require: ModuleAliveBase
	{
		scope = 2;
		displayName = "$STR_ALIVE_REQUIRES_ALIVE";
		icon = "x\alive\addons\main\icon_requires_alive.paa";
		picture = "x\alive\addons\main\icon_requires_alive.paa";
		functionPriority = 40;
        isGlobal = 2;
		function = "ALiVE_fnc_aliveInit";
        author = MODULE_AUTHOR;

		class Arguments
		{
			class debug
            {
                    displayName = "$STR_ALIVE_DEBUG";
                    description = "$STR_ALIVE_DEBUG_COMMENT";
                    class Values
                    {
                            class Yes
                            {
                                    name = "Yes";
                                    value = true;
                                    default = false;
                            };
                            class No
                            {
                                    name = "No";
                                    value = false;
                            };
                    };
            };
	        class ALiVE_Versioning
	        {
	                displayName = "$STR_ALIVE_REQUIRES_ALIVE_VERSIONING";
	                description = "$STR_ALIVE_REQUIRES_ALIVE_VERSIONING_COMMENT";
	                class Values
	                {
	                        class warning
	                        {
	                                name = "Warn players";
	                                value = warning;
	                                default = 1;
	                        };
	                        class kick
	                        {
	                                name = "Kick players";
	                                value = kick;
	                        };
	                };
	        };

	        class ALiVE_DISABLESAVE
	        {
	                displayName = "$STR_ALIVE_DISABLESAVE";
	                description = "$STR_ALIVE_DISABLESAVE_COMMENT";
	                class Values
	                {
	                        class warning
	                        {
	                                name = "Yes";
	                                value = true;
	                                default = 1;
	                        };
	                        class kick
	                        {
	                                name = "No";
	                                value = false;
	                        };
	                };
	        };
			class ALiVE_GC_INTERVAL
            {
                    displayName = "$STR_ALIVE_GC_INTERVAL";
                    description = "$STR_ALIVE_GC_INTERVAL_COMMENT";
                    defaultValue = 300;
            };
            class ALiVE_GC_THRESHHOLD
            {
                    displayName = "$STR_ALIVE_GC_THRESHHOLD";
                    description = "$STR_ALIVE_GC_THRESHHOLD_COMMENT";
                    defaultValue = 100;
            };
            class ALiVE_GC_INDIVIDUALTYPES
            {
                    displayName = "$STR_ALIVE_GC_INDIVIDUALTYPES";
                    description = "$STR_ALIVE_GC_INDIVIDUALTYPES_COMMENT";
                    defaultValue = "";
            };
		};
	};
};
