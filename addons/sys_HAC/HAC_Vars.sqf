_logic = _this select ((count _this)-1);

Boss = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\Boss.sqf";

A_EnemyScan = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\EnemyScan.sqf";
A_Flanking = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\Flanking.sqf";
A_Garrison = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\Garrison.sqf";
A_GoAmmoSupp = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\GoAmmoSupp.sqf";
A_GoAttAir = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\GoAttAir.sqf";
A_GoAttArmor = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\GoAttArmor.sqf";
A_GoAttInf = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\GoAttInf.sqf";
A_GoAttSniper = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\GoAttSniper.sqf";
A_GoCapture = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\GoCapture.sqf";
A_GoDef = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\GoDef.sqf";
A_GoDefAir = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\GoDefAir.sqf";
A_GoDefRecon = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\GoDefRecon.sqf";
A_GoDefRes = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\GoDefRes.sqf";
A_GoFlank = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\GoFlank.sqf";
A_GoFuelSupp = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\GoFuelSupp.sqf";
A_GoIdle = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\GoIdle.sqf";
A_GoMedSupp = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\GoMedSupp.sqf";
A_GoRecon = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\GoRecon.sqf";
A_GoRepSupp = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\GoRepSupp.sqf";
A_GoRest = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\GoRest.sqf";
A_GoSFAttack = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\GoSFAttack.sqf";
A_HQOrders = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\HQOrders.sqf";
A_HQOrdersDef = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\HQOrdersDef.sqf";
A_HQReset = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\HQReset.sqf";
A_HQSitRep = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\HQSitRep.sqf";
A_LHQ = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\LHQ.sqf";
A_LPos = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\LPos.sqf";
A_Personality = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\Personality.sqf";
A_Reloc = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\Reloc.sqf";
A_Rev = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\Rev.sqf";
A_SCargo = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\SCargo.sqf";
A_SFIdleOrd = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\SFIdleOrd.sqf";
A_Spotscan = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\SpotScan.sqf";
A_SuppAmmo = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\SuppAmmo.sqf";
A_SuppFuel = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\SuppFuel.sqf";
A_SuppMed = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\SuppMed.sqf";
A_SuppRep = compile preprocessfileLineNumbers "\x\alive\addons\sys_HAC\A\SuppRep.sqf";

if (isNil {_logic getvariable ["HAC_HQ_Obj1",nil]}) then {_logic setvariable ["HAC_HQ_Obj1", vehicle _logic]};
if (isNil {_logic getvariable ["HAC_HQ_Obj2",nil]}) then {_logic setvariable ["HAC_HQ_Obj2", (_logic getvariable "HAC_HQ_Obj1")]};
if (isNil {_logic getvariable ["HAC_HQ_Obj3",nil]}) then {_logic setvariable ["HAC_HQ_Obj3", (_logic getvariable "HAC_HQ_Obj2")]};
if (isNil {_logic getvariable ["HAC_HQ_Obj4",nil]}) then {_logic setvariable ["HAC_HQ_Obj4", (_logic getvariable "HAC_HQ_Obj3")]};

_logic setvariable ["HAC_xHQ_Done", true];
