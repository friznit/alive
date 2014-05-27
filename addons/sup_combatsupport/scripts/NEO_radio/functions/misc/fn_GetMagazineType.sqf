private["_battery","_ordnanceType","_weaponType","_howitzer","_mortar","_mlrs","_ord"];

 _battery = _this select 0;
_ordnanceType = _this select 1;


 _weaponType = typeof(vehicle _battery);


_howitzer = ["B_MBT_01_arty_F","O_MBT_02_arty_F"];
_mortar = ["I_Mortar_01_F","O_Mortar_01_F","B_G_Mortar_01_F","B_Mortar_01_F"];
_mlrs = ["B_MBT_01_mlrs_F"];
_ord ="";

if (_weaponType in _mortar) then {
    if (_ordnanceType == "HE") then {_ord = "8Rnd_82mm_Mo_shells"};
    if (_ordnanceType == "SMOKE") then {_ord = "8Rnd_82mm_Mo_Smoke_white"};
    if (_ordnanceType == "ILLUM") then {_ord = "8Rnd_82mm_Mo_Flare_white"};

};

if (_weaponType in _howitzer) then {
    if (_ordnanceType == "HE") then {_ord = "32Rnd_155mm_Mo_shells"};
    if (_ordnanceType == "SMOKE") then {_ord = "6Rnd_155mm_Mo_smoke"};
    if (_ordnanceType == "SADARM") then {_ord = "2Rnd_155mm_Mo_guided"};
    if (_ordnanceType == "CLUSTER") then {_ord = "2Rnd_155mm_Mo_Cluster"};
    if (_ordnanceType == "LASER") then {_ord = "2Rnd_155mm_Mo_LG"};
    if (_ordnanceType == "MINE") then {_ord = "6Rnd_155mm_Mo_mine"};
    if (_ordnanceType == "AT MINE") then {_ord = "6Rnd_155mm_Mo_AT_mine"};
        diag_log format["_ord Type: %1",_ord];
};

if (_weaponType in _mlrs) then {
    if (_ordnanceType == "ROCKETS") then {_ord = "12Rnd_230mm_rockets"};
};
   _ord
