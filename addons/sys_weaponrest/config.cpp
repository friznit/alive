#include <script_component.hpp>
#include <\x\alive\addons\main\CfgMods.hpp>
#include <CfgPatches.hpp>
#include <CfgVehicles.hpp>

#include <EventHandlers.hpp>

class CfgWeapons
{
	class Rifle;
	class Rifle_Base_F;
	class Rifle_Long_Base_F: Rifle_Base_F
	{
		alive_bipod = 1;
	};
	class EBR_base_F;
	class srifle_EBR_F: EBR_base_F
	{
		alive_bipod = 0;
	};
	class arifle_MX_SW_F: Rifle_Base_F
	{
		alive_bipod = 1;
	};
};


class CfgMovesBasic
{
	class Actions
	{
		class RifleStandActions;
		class RifleStandActions_Steady: RifleStandActions
		{
			stop = "AmovPercMstpSrasWrflDnon_Steady";
			default = "AmovPercMstpSrasWrflDnon_Steady";
			limitFast = 1;
			turnSpeed = 0.3;
		};
		class RifleAdjustBStandActions;
		class RifleAdjustBStandActions_Steady: RifleAdjustBStandActions
		{
			stop = "AadjPercMstpSrasWrflDdown_Steady";
			default = "AadjPercMstpSrasWrflDdown_Steady";
			limitFast = 1;
			turnSpeed = 0.3;
		};
		class RifleAdjustFStandActions;
		class RifleAdjustFStandActions_Steady: RifleAdjustFStandActions
		{
			stop = "AadjPercMstpSrasWrflDup_Steady";
			default = "AadjPercMstpSrasWrflDup_Steady";
			limitFast = 1;
			turnSpeed = 0.3;
		};
		
		class RifleKneelActions;
		class RifleKneelActions_Steady: RifleKneelActions
		{
			stop = "AmovPknlMstpSrasWrflDnon_Steady";
			default = "AmovPknlMstpSrasWrflDnon_Steady";
			weaponOff = "AmovPknlMstpSrasWrflDnon_Steady";
			Stand = "AmovPknlMstpSrasWrflDnon_Steady";
			Crouch = "AmovPknlMstpSrasWrflDnon_Steady";
			CanNotMove = "AmovPknlMstpSrasWrflDnon_Steady";
			FireNotPossible = "AmovPknlMstpSrasWrflDnon_Steady";
			strokeGun = "AmovPknlMstpSrasWrflDnon_Steady";
			limitFast = 1;
			turnSpeed = 0.3;
		};
		class RifleAdjustFKneelActions;
		class RifleAdjustFKneelActions_Steady: RifleAdjustFKneelActions
		{
			stop = "AadjPknlMstpSrasWrflDup_Steady";
			default = "AadjPknlMstpSrasWrflDup_Steady";
			weaponOff = "AadjPknlMstpSrasWrflDup_Steady";
			Stand = "AadjPknlMstpSrasWrflDup_Steady";
			Crouch = "AadjPknlMstpSrasWrflDup_Steady";
			CanNotMove = "AadjPknlMstpSrasWrflDup_Steady";
			FireNotPossible = "AadjPknlMstpSrasWrflDup_Steady";
			strokeGun = "AadjPknlMstpSrasWrflDup_Steady";
			limitFast = 1;
			turnSpeed = 0.3;
		};
		class RifleAdjustBKneelActions;
		class RifleAdjustBKneelActions_Steady: RifleAdjustBKneelActions
		{
			stop = "AadjPknlMstpSrasWrflDdown_Steady";
			default = "AadjPknlMstpSrasWrflDdown_Steady";
			weaponOff = "AadjPknlMstpSrasWrflDdown_Steady";
			Stand = "AadjPknlMstpSrasWrflDdown_Steady";
			Crouch = "AadjPknlMstpSrasWrflDdown_Steady";
			CanNotMove = "AadjPknlMstpSrasWrflDdown_Steady";
			FireNotPossible = "AadjPknlMstpSrasWrflDdown_Steady";
			strokeGun = "AadjPknlMstpSrasWrflDdown_Steady";
			limitFast = 1;
			turnSpeed = 0.3;
		};
		
		
		class RifleProneActions;
		class RifleProneActions_Bipod: RifleProneActions
		{
			stop = "AmovPpneMstpSrasWrflDnon_Bipod";
			default = "AmovPpneMstpSrasWrflDnon_Bipod";
			weaponOff = "AmovPpneMstpSrasWrflDnon_Bipod";
			limitfast = 1;
			turnSpeed = 0.05;
		};
		class RifleAdjustBProneActions;
		class RifleAdjustBProneActions_Steady: RifleAdjustBProneActions
		{
			stop = "AadjPpneMstpSrasWrflDdown_Steady";
			default = "AadjPpneMstpSrasWrflDdown_Steady";
			weaponOff = "AadjPpneMstpSrasWrflDdown_Steady";
			limitfast = 1;
			turnSpeed = 0.05;
		};
		class RifleAdjustFProneActions;
		class RifleAdjustFProneActions_Steady: RifleAdjustFProneActions
		{
			stop = "AadjPpneMstpSrasWrflDup_Steady";
			default = "AadjPpneMstpSrasWrflDup_Steady";
			weaponOff = "AadjPpneMstpSrasWrflDup_Steady";
			limitfast = 1;
			turnSpeed = 0.05;
		};
	};
};
class CfgMovesMaleSdr: CfgMovesBasic
{
	class States
	{
		class AmovPercMstpSrasWrflDnon;
		class AmovPercMstpSrasWrflDnon_Steady: AmovPercMstpSrasWrflDnon
		{
			actions = "RifleStandActions_Steady";
			aimPrecision = 0.39;
			aiming = "aimingLying";
			camshakefire = 0.4;
			speed = 0.01;
			onLandEnd = 1;
			onLandBeg = 1;
			connectTo[] = {"AmovPercMstpSrasWrflDnon_Steady",0.02};
			connectFrom[] = {"AmovPercMstpSrasWrflDnon_Steady",0.02};
			interpolateFrom[] = {"AmovPercMstpSrasWrflDnon",0.02};
			interpolateTo[] = {"AmovPercMstpSrasWrflDnon",0.02};
		};
		class AadjPercMstpSrasWrflDdown;
		class AadjPercMstpSrasWrflDdown_Steady: AadjPercMstpSrasWrflDdown
		{
			actions = "RifleAdjustBStandActions_Steady";
			aimPrecision = 0.39;
			aiming = "aimingLying";
			camshakefire = 0.4;
			speed = 0.01;
			onLandEnd = 1;
			onLandBeg = 1;
			connectTo[] = {"AadjPercMstpSrasWrflDdown_Steady",0.02};
			connectFrom[] = {"AadjPercMstpSrasWrflDdown_Steady",0.02};
			interpolateFrom[] = {"AadjPercMstpSrasWrflDdown",0.02};
			interpolateTo[] = {"AadjPercMstpSrasWrflDdown",0.02};
		};
		class AadjPercMstpSrasWrflDup;
		class AadjPercMstpSrasWrflDup_Steady: AadjPercMstpSrasWrflDup
		{
			actions = "RifleAdjustFStandActions_Steady";
			aimPrecision = 0.39;
			aiming = "aimingLying";
			camshakefire = 0.4;
			speed = 0.01;
			onLandEnd = 1;
			onLandBeg = 1;
			connectTo[] = {"AadjPercMstpSrasWrflDup_Steady",0.02};
			connectFrom[] = {"AadjPercMstpSrasWrflDup_Steady",0.02};
			interpolateFrom[] = {"AadjPercMstpSrasWrflDup",0.02};
			interpolateTo[] = {"AadjPercMstpSrasWrflDup",0.02};
		};
		
		
		class AmovPknlMstpSrasWrflDnon;
		class AmovPknlMstpSrasWrflDnon_Steady: AmovPknlMstpSrasWrflDnon
		{
			actions = "RifleKneelActions_Steady";
			aimPrecision = 0.195;
			aiming = "aimingLying";
			camshakefire = 0.35;
			speed = 0.01;
			onLandEnd = 1;
			onLandBeg = 1;
			connectTo[] = {"AmovPknlMstpSrasWrflDnon_Steady",0.02};
			connectFrom[] = {"AmovPknlMstpSrasWrflDnon_Steady",0.02};
			interpolateFrom[] = {"AmovPknlMstpSrasWrflDnon",0.02};
			interpolateTo[] = {"AmovPknlMstpSrasWrflDnon",0.02};
		};
		class AadjPknlMstpSrasWrflDdown;
		class AadjPknlMstpSrasWrflDdown_Steady: AadjPknlMstpSrasWrflDdown
		{
			actions = "RifleAdjustBKneelActions_Steady";
			aimPrecision = 0.195;
			aiming = "aimingLying";
			camshakefire = 0.35;
			speed = 0.01;
			onLandEnd = 1;
			onLandBeg = 1;
			connectTo[] = {"AadjPknlMstpSrasWrflDdown_Steady",0.02};
			connectFrom[] = {"AadjPknlMstpSrasWrflDdown_Steady",0.02};
			interpolateFrom[] = {"AadjPknlMstpSrasWrflDdown",0.02};
			interpolateTo[] = {"AadjPknlMstpSrasWrflDdown",0.02};
		};
		class AadjPknlMstpSrasWrflDup;
		class AadjPknlMstpSrasWrflDup_Steady: AadjPknlMstpSrasWrflDup
		{
			actions = "RifleAdjustFKneelActions_Steady";
			aimPrecision = 0.195;
			aiming = "aimingLying";
			camshakefire = 0.35;
			speed = 0.01;
			onLandEnd = 1;
			onLandBeg = 1;
			connectTo[] = {"AadjPknlMstpSrasWrflDup_Steady",0.02};
			connectFrom[] = {"AadjPknlMstpSrasWrflDup_Steady",0.02};
			interpolateFrom[] = {"AadjPknlMstpSrasWrflDup",0.02};
			interpolateTo[] = {"AadjPknlMstpSrasWrflDup",0.02};
		};

		
		class AmovPpneMstpSrasWrflDnon: AmovPercMstpSrasWrflDnon
		{
			variantsAI[] = {"Alive_AmovPpneMstpSrasWrflDnon_Supported",1};
			variantAfter[] = {1,2,3};
		};
		class AmovPpneMrunSlowWrflDf: AmovPpneMstpSrasWrflDnon
		{
			variantsAI[] = {};
		};
		class AmovPpneMstpSrasWrflDnon_turnL: AmovPpneMstpSrasWrflDnon
		{
			variantsAI[] = {};
		};
		class AmovPpneMstpSrasWrflDnon_turnR: AmovPpneMstpSrasWrflDnon
		{
			variantsAI[] = {};
		};
		class AmovPpneMstpSrasWrflDnon_healed: AmovPpneMstpSrasWrflDnon
		{
			variantsAI[] = {};
		};
		class AmovPpneMstpSrasWrflDnon_Bipod: AmovPpneMstpSrasWrflDnon
		{
			actions = "RifleProneActions_Bipod";
			aimPrecision = 0.07;
			aiming = "aimingLying";
			camshakefire = 0.3;
			onLandEnd = 1;
			onLandBeg = 1;
			connectTo[] = {"AmovPpneMstpSrasWrflDnon_Bipod",0.02};
			connectFrom[] = {"AmovPpneMstpSrasWrflDnon_Bipod",0.02};
			interpolateFrom[] = {"AmovPpneMstpSrasWrflDnon",0.02};
			interpolateTo[] = {"AmovPpneMstpSrasWrflDnon",0.02};
		};
		class Alive_AmovPpneMstpSrasWrflDnon_Supported: AmovPpneMstpSrasWrflDnon_Bipod
		{
			equivalentTo = "AmovPpneMstpSrasWrflDnon";
			aimPrecision = 0.09;
		};
		
		class AadjPpneMstpSrasWrflDdown;
		class AadjPpneMstpSrasWrflDdown_Steady: AadjPpneMstpSrasWrflDdown
		{
			actions = "RifleAdjustBProneActions_Steady";
			aimPrecision = 0.09;
			aiming = "aimingLying";
			camshakefire = 0.3;
			speed = 0.01;
			onLandEnd = 1;
			onLandBeg = 1;
			connectTo[] = {"AadjPpneMstpSrasWrflDdown_Steady",0.02};
			connectFrom[] = {"AadjPpneMstpSrasWrflDdown_Steady",0.02};
			interpolateFrom[] = {"AadjPpneMstpSrasWrflDdown",0.02};
			interpolateTo[] = {"AadjPpneMstpSrasWrflDdown",0.02};
		};
		class AadjPpneMstpSrasWrflDup;
		class AadjPpneMstpSrasWrflDup_Steady: AadjPpneMstpSrasWrflDup
		{
			actions = "RifleAdjustFProneActions_Steady";
			aimPrecision = 0.09;
			aiming = "aimingLying";
			camshakefire = 0.3;
			speed = 0.01;
			onLandEnd = 1;
			onLandBeg = 1;
			connectTo[] = {"AadjPpneMstpSrasWrflDup_Steady",0.02};
			connectFrom[] = {"AadjPpneMstpSrasWrflDup_Steady",0.02};
			interpolateFrom[] = {"AadjPpneMstpSrasWrflDup",0.02};
			interpolateTo[] = {"AadjPpneMstpSrasWrflDup",0.02};
		};
	};
};
class CfgSounds
{
	class alive_deployweapon_1
	{
		name = "alive_deployweapon_1";
		sound[] = {"\x\alive\addons\sys_weaponrest\sound\depl1.ogg",5,1};
		titles[] = {};
	};
	class alive_deployweapon_2
	{
		name = "alive_deployweapon_2";
		sound[] = {"\x\alive\addons\sys_weaponrest\sound\depl2.ogg",5,1};
		titles[] = {};
	};
	class alive_deployweapon_3
	{
		name = "alive_deployweapon_3";
		sound[] = {"\x\alive\addons\sys_weaponrest\sound\depl3.ogg",5,1};
		titles[] = {};
	};
};

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
		author = "$STR_A3_Bohemia_Interactive";
		overviewPicture = "a3\Missions_F_Beta\data\img\Campaign_overview_CA.paa";
		overviewText = "$STR_A3_CFGMISSIONS_SHOWCASES0";
		class Showcase_ALiVE_WeaponRest
		{
			briefingName = "ALiVE Weapon Resting and Bipods";
			directory = "sys_weaponrest\missions\showcases\showcase_weaponrest.stratis";
		};
	};
};