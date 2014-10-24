
class CfgPatches
{
	class ALiVE_Missions
	{
		units[] = {""};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"Alive_main"};
	};
};

class CfgMissions
{
	class Showcases
	{

		class Showcase_Getting_Started
		{
			briefingName = "ALiVE | Quick Start";
			directory = "x\alive\addons\missions\showcases\basic.stratis";
            overviewPicture = "x\alive\addons\missions\showcases\foursome.altis\rsc\logo_alive.paa";
			author = "ALiVE Mod Team";            		
		};

		class Showcase_Foursome
		{
			briefingName = "ALiVE | Foursome";
			directory = "x\alive\addons\missions\showcases\foursome.altis";
            overviewPicture = "x\alive\addons\missions\showcases\foursome.altis\rsc\logo_alive.paa";	
			author = "ALiVE Mod Team";               		
		};

        class Showcase_Tour
        {
            briefingName = "ALiVE | Tour";
            directory = "x\alive\addons\missions\showcases\tour.stratis";
            overviewPicture = "x\alive\addons\missions\showcases\foursome.altis\rsc\logo_alive.paa";
			author = "ALiVE Mod Team";   
        };		
	};
	class MPMissions
	{
		class MP_COOP_Air_Assault
		{
			briefingName = "ALiVE | Air Assault (COOP)";
			directory = "x\alive\missions\mpscenarios\ALiVE_Air_Assault.Altis";
            overviewPicture = "x\alive\addons\missions\showcases\foursome.altis\rsc\logo_alive.paa";			
			author = "ALiVE Mod Team";   
		};
		class MP_COOP_Sabotage
		{
			briefingName = "ALiVE | Sabotage (COOP)";
			directory = "x\alive\missions\mpscenarios\ALiVE_Sabotage.Altis";
            overviewPicture = "x\alive\addons\missions\showcases\foursome.altis\rsc\logo_alive.paa";			
			author = "ALiVE Mod Team";   
		};
	};
};

