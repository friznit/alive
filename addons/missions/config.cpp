
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
			overviewText = This is the basic quick start mission featured in the ALiVE documentation and Wiki (alivemod.com);            
			author = "ALiVE Mod Team";            		
		};

		class Showcase_Foursome
		{
			briefingName = "ALiVE | Foursome";
			directory = "x\alive\addons\missions\showcases\foursome.altis";
            overviewPicture = "x\alive\addons\missions\showcases\foursome.altis\rsc\logo_alive.paa";	
			overviewText = Four factions battle it out for control of Altis!;            
			author = "ALiVE Mod Team";               		
		};

		class Showcase_Divide_And_Rule
		{
			briefingName = "ALiVE | Divide and Rule";
			directory = "x\alive\addons\missions\showcases\alive_divide_and_rule.altis";
            overviewPicture = "x\alive\addons\missions\showcases\alive_divide_and_rule.altis\rsc\logo_alive.paa";	
			overviewText = ADD TEXT HERE;            
			author = "ALiVE Mod Team";               		
		};		

        class Showcase_Tour
        {
            briefingName = "ALiVE | Tour";
            directory = "x\alive\addons\missions\showcases\tour.stratis";
            overviewPicture = "x\alive\addons\missions\showcases\foursome.altis\rsc\logo_alive.paa";
			overviewText = ALiVE Tour will take you through the different modules, technology and gameplay offered by ALiVE.;            
			author = "ALiVE Mod Team";   
        };		
	};
	class MPMissions
	{
		class MP_COOP_Getting_Started
		{
			briefingName = "ALiVE | Quick Start (COOP 9) ";
			directory = "x\alive\addons\missions\showcases\basic.stratis";
            overviewPicture = "x\alive\addons\missions\showcases\foursome.altis\rsc\logo_alive.paa";
			overviewText = This is the basic quick start mission featured in the ALiVE documentation and Wiki (alivemod.com);            
			author = "ALiVE Mod Team";            		
		};		
		class MP_COOP_Air_Assault
		{
			briefingName = "ALiVE | Air Assault (COOP 8)";
			directory = "x\alive\addons\missions\mpscenarios\ALiVE_Air_Assault.Altis";
            overviewPicture = "x\alive\addons\missions\showcases\foursome.altis\rsc\logo_alive.paa";	
            overviewText = "Steal the prototype MI-48 from the airbase at Salakano and bring it to your Command base in the north! Try to survive!";		
			author = "ALiVE Mod Team";   
		};
		class MP_COOP_Sabotage
		{
			briefingName = "ALiVE | Sabotage (COOP 12)";
			directory = "x\alive\addons\missions\mpscenarios\ALiVE_Sabotage.Altis";
            overviewPicture = "x\alive\addons\missions\showcases\foursome.altis\rsc\logo_alive.paa";	
            overviewText = "Lead an insurgency on Altis, use sabotage and subterfuge to capture weapons and establish safe houses across the island. ";            		
			author = "ALiVE Mod Team";   
		};
		class MP_COOP_Foursome
		{
			briefingName = "ALiVE | Foursome (COOP/TVT 19)";
			directory = "x\alive\addons\missions\showcases\foursome.altis";
            overviewPicture = "x\alive\addons\missions\showcases\foursome.altis\rsc\logo_alive.paa";	
			overviewText = Four factions battle it out for control of Altis!;            
			author = "ALiVE Mod Team";               		
		};		
	};
};

