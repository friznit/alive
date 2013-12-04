	private ["_unit", "_text", "_radio"];
	_unit = _this select 0;
	_text = _this select 1;
	_radio = _this select 2;

	//enableRadio true;
	//enableSentences true;
	//sleep 1;
	
	switch (_radio) do
	{
		case "global" : { _unit globalChat _text };
		case "side" : { _unit sideChat _text };
		case "group" : { _unit groupChat _text };
		case "vehicle" : { _unit vehicleChat _text };
		case "sideRadio" : { _unit sideRadio _text };
	};
	
	//sleep 1;
	//enableSentences false;
	//enableRadio false;


true;
