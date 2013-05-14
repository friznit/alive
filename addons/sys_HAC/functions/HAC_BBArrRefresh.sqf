	_HAC_BB_arrA_tmp = [
		_logic getvariable "HAC_HQ_Friends",
		_logic getvariable "HAC_HQ_NCrewInfG",
		_logic getvariable "HAC_HQ_CarsG",
		(_logic getvariable "HAC_HQ_HArmorG") + (_logic getvariable "HAC_HQ_LArmorG"),
		_logic getvariable "HAC_HQ_AirG",
		(_logic getvariable "HAC_HQ_NCAirG") + ((_logic getvariable "HAC_HQ_NCCargoG") - (_logic getvariable "HAC_HQ_NCAirG")) + ((_logic getvariable "HAC_HQ_SupportG") - ((_logic getvariable "HAC_HQ_NCAirG") + ((_logic getvariable "HAC_HQ_NCCargoG") - (_logic getvariable "HAC_HQ_NCAirG")))),
		_logic getvariable "HAC_HQ_CCurrent",
		_logic getvariable "HAC_HQ_CInitial",
		_logic getvariable "HAC_HQ_FValue",
		_logic getvariable "HAC_HQ_Morale",
		_logic getvariable "HAC_HQ_KnEnemiesG",
		_logic getvariable "HAC_HQ_EnInfG",
		_logic getvariable "HAC_HQ_EnCarsG",
		((_logic getvariable "HAC_HQ_EnHArmorG") + (_logic getvariable "HAC_HQ_EnLArmorG")),
		_logic getvariable "HAC_HQ_EnAirG",
		(_logic getvariable "HAC_HQ_EnNCAirG") + ((_logic getvariable "HAC_HQ_EnNCCargoG") - (_logic getvariable "HAC_HQ_EnNCAirG")) + ((_logic getvariable "HAC_HQ_EnSupportG") - ((_logic getvariable "HAC_HQ_EnNCAirG") + ((_logic getvariable "HAC_HQ_EnNCCargoG") - (_logic getvariable "HAC_HQ_EnNCAirG")))),
		_logic getvariable "HAC_HQ_EValue"
		];

	_logic setvariable ["HAC_BB_arrA",_HAC_BB_arrA_tmp];