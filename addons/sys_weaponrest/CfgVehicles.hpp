class CfgVehicles {
		class Land_HelipadEmpty_F;
		class ALIVE_LogicDummy: Land_HelipadEmpty_F
		{
			scope = 1;
			slx_xeh_disabled = 1;
			class EventHandlers {
				init = "(_this select 0) enableSimulation false";
			};
		};
};
