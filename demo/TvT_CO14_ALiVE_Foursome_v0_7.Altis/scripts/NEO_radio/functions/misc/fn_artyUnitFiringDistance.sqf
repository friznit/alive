private ["_min", "_max", "_result"];
_min = 0;
_max = 0;
_result = 0;

switch (true) do
{
	case (_this in 
	[
		"M119", "M119_US_EP1",
		"D30", "D30_TK_EP1", "D30_CDF", "D30_Ins", "D30_RU", "D30_TK_EP1", "D30_TK_GUE_EP1", "D30_TK_INS_EP1"
	]) :
	{
		_min = 2375;
		_max = 5800;
	};
	
	case (_this in 
	[
		"M252", "M252_US_EP1", 
		"2b14_82mm", "2b14_82mm_INS", "2b14_82mm_CDF", "2b14_82mm_GUE", "2b14_82mm_CZ_EP1", "2b14_82mm_TK_EP1", "2b14_82mm_TK_GUE_EP1", "2b14_82mm_TK_INS_EP1"
	]) :
	{
		_min = 100;
		_max = 3700;
	};
	
	case (_this in 
	[
		"MLRS", "MLRS_DES_EP1"
	]) :
	{
		_min = 4900;
		_max = 15550;
	};
	
	case (_this in 
	[
		"GRAD_CDF", "GRAD_INS", "GRAD_RU", "GRAD_TK_EP1"
	]) :
	{
		_min = 3300;
		_max = 10100;
	};
	
	case DEFAULT {};
};

_result = [_min, _max];

_result;
