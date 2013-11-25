#include <script_component.hpp>
#include <\x\alive\addons\main\CfgMods.hpp>
#include <CfgPatches.hpp>
#include <CfgVehicles.hpp>
#include <CfgFunctions.hpp>

class CfgMissions
{
        class Challenges{};
        class Missions
        {
                displayName = "$STR_A3_CFGMISSIONS_MISSIONS0";
                overview = "";
        };
        class Showcases
        {
                displayName = "$STR_A3_CFGMISSIONS_SHOWCASES0";
                briefingName = "$STR_A3_CFGMISSIONS_SHOWCASES0";
                author = MODULE_AUTHOR;
                overviewPicture = "a3\Missions_F_Beta\data\img\Campaign_overview_CA.paa";
                overviewText = "$STR_A3_CFGMISSIONS_SHOWCASES0";
                
					class showcase_mil_opcom_stratis
					{
						briefingName = "ALiVE OPCOM Spleen - Stratis";
						directory = "x\alive\addons\mil_opcom\showcases\opcom_spleen.stratis";
						overviewPicture = "x\alive\addons\mil_opcom\showcases\opcom_spleen.stratis\rsc\logo_alive.paa";
					};
					class showcase_mil_opcom_altis
					{
						briefingName = "ALiVE | OPCOM Spleen - Altis";
						directory = "x\alive\addons\mil_opcom\showcases\opcom_spleen.altis";
						overviewPicture = "x\alive\addons\mil_opcom\showcases\opcom_spleen.altis\rsc\logo_alive.paa";
					};
					class showcase_mil_opcom_foursome
					{
						briefingName = "ALiVE | Foursome";
						directory = "x\alive\addons\mil_opcom\showcases\foursome.altis";
						overviewPicture = "x\alive\addons\mil_opcom\showcases\foursome.altis\rsc\logo_alive.paa";
					};
        };
};


