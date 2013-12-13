private ["_min", "_max", "_result"];
_min = 0;
_max = 0;
_result = 0;

switch (true) do
{
	case (_this in 
	[
		"B_MBT_01_arty_F","O_MBT_02_arty_F"
	]) :
	{
		_min = 750;
		_max = 15000;
	};
	
	case (_this in 
	[
		"O_Mortar_01_F", "B_Mortar_01_F", 
		"B_G_Mortar_01_F", "I_Mortar_01_F"
	]) :
	{
		_min = 500;
		_max = 3800;
	};
	
	case (_this in 
	[
		"B_MBT_01_mlrs_F"
	]) :
	{
		_min = 500;
		_max = 18000;
	};
	
	case DEFAULT {};
};

_result = [_min, _max];

_result;
