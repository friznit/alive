	private ["_logic","_arty","_ModSideHQ","_so","_gp","_artymod","_magAdded","_vh","_SMOKEM119","_SMOKED30","_ILLUMM252","_ILLUMM119","_ILLUMD30","_ILLUMPODNOS","_amount",
	"_BL","_mdls","_isSync","_magAdded","_SADARMM119","_SADARMD30","_HEM119","_HED30","_HEPODNOS","_HEMLRS","_HEGRAD","_WPM252","_hAmmo","_typeVh","_WPM119",
	"_WPD30","_WPPODNOS","_HEM252","_WPM119","_WPD30","_WPPODNOS"];	

	_arty = _this select 0;
	_amount = _this select 1;
    _logic = _this select ((count _this)-1);

	_ModSideHQ = createCenter sideLogic;

		{
		_BL = leader _x;	

		_so = synchronizedObjects _BL;
		_mdls = [10,10,0] nearEntities [["BIS_ARTY_Logic"], 10];
		_isSync = false;

			{
			if (_BL in (synchronizedObjects _x)) exitWith {_isSync = true};
			}
		foreach _mdls;

		if ((({(typeOf _x) in ["BIS_ARTY_Logic"]} count _so) == 0) and not (_isSync)) then 
			{
			_gp = creategroup sideLogic;
			_artymod = _gp createUnit ["BIS_ARTY_Logic", [10,10], [], 0, "NONE"];
			_artymod synchronizeObjectsAdd [(leader _x)];
			};

		_hAmmo = _x getVariable "HEAmmo";

		if (isNil "_hAmmo") then 
			{
			_vh = assignedvehicle (leader _x);
			_typeVh = typeOf _vh;

			_x setVariable ["HEAmmo",_amount];
			if (_typeVh in ((_logic getvariable "HAC_HQ_Howitzer") + (_logic getvariable "HAC_HQ_Mortar"))) then {_x setVariable ["IllumAmmo",_amount]};
			if (_typeVh in ((_logic getvariable "HAC_HQ_Howitzer") + (_logic getvariable "HAC_HQ_Mortar"))) then {_x setVariable ["WPAmmo",_amount]};
			if (_typeVh in (_logic getvariable "HAC_HQ_Howitzer")) then {_x setVariable ["SmokeAmmo",_amount]};
			if (_typeVh in (_logic getvariable "HAC_HQ_Howitzer")) then {_x setVariable ["SADARMAmmo",ceil (_amount/10)]};

			_magAdded = [];

				{
				_vh = vehicle _x;
				if not (_vh in _magAdded) then
					{
					_magAdded set [(count _magAdded),_vh];
					//{_vh removemagazine _x} foreach (magazines _vh);
					_SMOKEM119 = "ARTY_30Rnd_105mmSMOKE_M119";
					_SMOKED30 = "ARTY_30Rnd_122mmSMOKE_D30";

					_SADARMM119 = "ARTY_30Rnd_105mmSADARM_M119";
					_SADARMD30 = "ARTY_30Rnd_122mmSADARM_D30";

					_ILLUMM252 = "ARTY_8Rnd_81mmILLUM_M252";
					_ILLUMM119 = "ARTY_30Rnd_105mmILLUM_M119";
					_ILLUMD30 = "ARTY_30Rnd_122mmILLUM_D30";
					_ILLUMPODNOS = "ARTY_8Rnd_82mmILLUM_2B14";

					_HEM252 = "ARTY_8Rnd_81mmHE_M252";
					_HEM119 = "ARTY_30Rnd_105mmHE_M119";
					_HED30 = "ARTY_30Rnd_122mmHE_D30";
					_HEPODNOS = "ARTY_8Rnd_82mmHE_2B14";
					_HEMLRS = "ARTY_12Rnd_227mmHE_M270";
					_HEGRAD = "ARTY_40Rnd_120mmHE_BM21";

					_WPM252 = "ARTY_8Rnd_81mmWP_M252";
					_WPM119 = "ARTY_30Rnd_105mmWP_M119";
					_WPD30 = "ARTY_30Rnd_122mmWP_D30";
					_WPPODNOS = "ARTY_8Rnd_82mmWP_2B14";

					switch (typeOf _vh) do
						{
						case	"M119" : {for "_i" from 1 to (ceil (_amount/30)) do 
							{
							_vh addMagazine _SMOKEM119;
							_vh addMagazine _ILLUMM119;
							_vh addMagazine _HEM119;
							_vh addMagazine _WPM119;
							_vh addMagazine _SADARMM119;
							}};

						case	"M119_US_EP1" : {for "_i" from 1 to (ceil (_amount/30)) do 
							{
							_vh addMagazine _SMOKEM119;
							_vh addMagazine _ILLUMM119;
							_vh addMagazine _HEM119;
							_vh addMagazine _WPM119;
							_vh addMagazine _SADARMM119;
							}};

						case	"D30_RU" : {for "_i" from 1 to (ceil (_amount/30)) do 
							{
							_vh addMagazine _SMOKED30;
							_vh addMagazine _ILLUMD30;
							_vh addMagazine _HED30;
							_vh addMagazine _WPD30;
							_vh addMagazine _SADARMD30;
							}};

						case	"D30_INS" : {for "_i" from 1 to (ceil (_amount/30)) do 
							{
							_vh addMagazine _SMOKED30;
							_vh addMagazine _ILLUMD30;
							_vh addMagazine _HED30;
							_vh addMagazine _WPD30;
							_vh addMagazine _SADARMD30;
							}};

						case	"D30_CDF" : {for "_i" from 1 to (ceil (_amount/30)) do 
							{
							_vh addMagazine _SMOKED30;
							_vh addMagazine _ILLUMD30;
							_vh addMagazine _HED30;
							_vh addMagazine _WPD30;
							_vh addMagazine _SADARMD30;
							}};

						case	"D30_TK_EP1" : {for "_i" from 1 to (ceil (_amount/30)) do 
							{
							_vh addMagazine _SMOKED30;
							_vh addMagazine _ILLUMD30;
							_vh addMagazine _HED30;
							_vh addMagazine _WPD30;
							_vh addMagazine _SADARMD30;
							}};

						case	"D30_TK_GUE_EP1" : {for "_i" from 1 to (ceil (_amount/30)) do 
							{
							_vh addMagazine _SMOKED30;
							_vh addMagazine _ILLUMD30;
							_vh addMagazine _HED30;
							_vh addMagazine _WPD30;
							_vh addMagazine _SADARMD30;
							}};

						case	"D30_TK_INS_EP1" : {for "_i" from 1 to (ceil (_amount/30)) do 
							{
							_vh addMagazine _SMOKED30;
							_vh addMagazine _ILLUMD30;
							_vh addMagazine _HED30;
							_vh addMagazine _WPD30;
							_vh addMagazine _SADARMD30;
							}};

						case	"MLRS" : {for "_i" from 1 to (ceil (_amount/12)) do 
							{
							_vh addMagazine _HEMLRS;
							}};

						case	"MLRS_DES_EP1" : {for "_i" from 1 to (ceil (_amount/12)) do 
							{
							_vh addMagazine _HEMLRS;
							}};

						case	"GRAD_CDF" : {for "_i" from 1 to (ceil (_amount/40)) do 
							{
							_vh addMagazine _HEGRAD;
							}};

						case	"GRAD_INS" : {for "_i" from 1 to (ceil (_amount/40)) do 
							{
							_vh addMagazine _HEGRAD;
							}};

						case	"GRAD_RU" : {for "_i" from 1 to (ceil (_amount/40)) do 
							{
							_vh addMagazine _HEGRAD;
							}};

						case	"GRAD_TK_EP1" : {for "_i" from 1 to (ceil (_amount/40)) do 
							{
							_vh addMagazine _HEGRAD;
							}};

						case	"M252" : {for "_i" from 1 to (ceil (_amount/8)) do 
							{
							_vh addMagazine _ILLUMM252;
							_vh addMagazine _HEM252;
							_vh addMagazine _WPM252;
							}};

						case	"M252_US_EP1" : {for "_i" from 1 to (ceil (_amount/8)) do 
							{
							_vh addMagazine _ILLUMM252;
							_vh addMagazine _HEM252;
							_vh addMagazine _WPM252;
							}};

						default {for "_i" from 1 to (ceil (_amount/8)) do 
							{
							_vh addMagazine _ILLUMPODNOS;
							_vh addMagazine _HEPODNOS;
							_vh addMagazine _WPPODNOS;
							}};
						}
					}
				}
			foreach (units _x)
			}
		}
	foreach _arty; 