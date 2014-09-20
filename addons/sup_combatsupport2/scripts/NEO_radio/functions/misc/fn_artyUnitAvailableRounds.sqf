private ["_result"];
_result = switch (true) do
{
	case (_this in
	[
		"B_MBT_01_arty_F","O_MBT_02_arty_F"
	]) :
	{
		["HE", "SADARM", "LASER", "SMOKE","CLUSTER","MINE","AT MINE"]
	};

	case (_this in
	[
		"O_Mortar_01_F", "B_Mortar_01_F",
		"B_G_Mortar_01_F", "I_Mortar_01_F"
	]) :
	{
		["HE", "WP", "ILLUM", "SMOKE"]
	};

	case (_this in
	[
		"B_MBT_01_mlrs_F"
	]) :
	{
		["ROCKETS"]
	};

	case DEFAULT { [] };
};

_result;
