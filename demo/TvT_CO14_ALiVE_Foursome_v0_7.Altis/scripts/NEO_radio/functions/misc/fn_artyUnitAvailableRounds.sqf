private ["_result"];
_result = switch (true) do
{
	case (_this in 
	[
		"M119", "M119_US_EP1",
		"D30", "D30_TK_EP1", "D30_CDF", "D30_Ins", "D30_RU", "D30_TK_EP1", "D30_TK_GUE_EP1", "D30_TK_INS_EP1"
	]) :
	{
		["HE", "WP", "ILLUM", "SADARM", "LASER", "SMOKE"]
	};
	
	case (_this in 
	[
		"M252", "M252_US_EP1", 
		"2b14_82mm", "2b14_82mm_INS", "2b14_82mm_CDF", "2b14_82mm_GUE", "2b14_82mm_CZ_EP1", "2b14_82mm_TK_EP1", "2b14_82mm_TK_GUE_EP1", "2b14_82mm_TK_INS_EP1"
	]) :
	{
		["HE", "WP", "ILLUM"]
	};
	
	case (_this in 
	[
		"MLRS", "MLRS_DES_EP1", 
		"GRAD_CDF", "GRAD_INS", "GRAD_RU", "GRAD_TK_EP1"
	]) :
	{
		["HE"]
	};
	
	case DEFAULT { [] };
};

_result;
