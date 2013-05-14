_logic = _this select ((count _this)-1);
if (isNil {_logic getvariable "HAC_HQ_MAtt"}) then {_logic setvariable ["HAC_HQ_MAtt", false]};
if ((isNil {_logic getvariable "HAC_HQ_Personality"}) or not ((_logic getvariable "HAC_HQ_MAtt"))) then {_logic setvariable ["HAC_HQ_Personality", "OTHER"]};

_rnd = random 100;

switch (true) do
	{
	case ((not (_logic getvariable "HAC_HQ_MAtt") and (_rnd < 10)) or ((_logic getvariable "HAC_HQ_MAtt") and ((_logic getvariable "HAC_HQ_Personality") == "GENIUS"))) : {_logic setvariable ["HAC_HQ_Personality", "GENIUS"];_logic setvariable ["HAC_HQ_Recklessness", 0.5];_logic setvariable ["HAC_HQ_Consistency", 1];_logic setvariable ["HAC_HQ_Activity", 1];_logic setvariable ["HAC_HQ_Reflex", 1];_logic setvariable ["HAC_HQ_Circumspection",1];_logic setvariable ["HAC_HQ_Fineness",1]};
	case ((not (_logic getvariable "HAC_HQ_MAtt") and ((_rnd >= 10) and (_rnd < 20))) or ((HAC_HQ_MAtt) and ((_logic getvariable "HAC_HQ_Personality") == "IDIOT"))) : {_logic setvariable ["HAC_HQ_Personality", "IDIOT"];_logic setvariable ["HAC_HQ_Recklessness", 1];_logic setvariable ["HAC_HQ_Consistency", 0];_logic setvariable ["HAC_HQ_Activity", 0];_logic setvariable ["HAC_HQ_Reflex", 0];_logic setvariable ["HAC_HQ_Circumspection",0];_logic setvariable ["HAC_HQ_Fineness",0]};
	case ((not (_logic getvariable "HAC_HQ_MAtt") and ((_rnd >= 20) and (_rnd < 30))) or ((HAC_HQ_MAtt) and ((_logic getvariable "HAC_HQ_Personality") == "COMPETENT"))) : {_logic setvariable ["HAC_HQ_Personality", "COMPETENT"];_logic setvariable ["HAC_HQ_Recklessness", 0.5];_logic setvariable ["HAC_HQ_Consistency", 0.5];_logic setvariable ["HAC_HQ_Activity", 0.5];_logic setvariable ["HAC_HQ_Reflex", 0.5];_logic setvariable ["HAC_HQ_Circumspection",0.5];_logic setvariable ["HAC_HQ_Fineness",0.5]};
	case ((not (_logic getvariable "HAC_HQ_MAtt") and ((_rnd >= 30) and (_rnd < 40))) or ((HAC_HQ_MAtt) and ((_logic getvariable "HAC_HQ_Personality") == "EAGER"))) : {_logic setvariable ["HAC_HQ_Personality", "EAGER"];_logic setvariable ["HAC_HQ_Recklessness", 1];_logic setvariable ["HAC_HQ_Consistency", 0];_logic setvariable ["HAC_HQ_Activity", 1];_logic setvariable ["HAC_HQ_Reflex", 1];_logic setvariable ["HAC_HQ_Circumspection",0];_logic setvariable ["HAC_HQ_Fineness",0]};
	case ((not (_logic getvariable "HAC_HQ_MAtt") and ((_rnd >= 40) and (_rnd < 50))) or ((HAC_HQ_MAtt) and ((_logic getvariable "HAC_HQ_Personality") == "DILATORY"))) : {_logic setvariable ["HAC_HQ_Personality", "DILATORY"];_logic setvariable ["HAC_HQ_Recklessness", 0];_logic setvariable ["HAC_HQ_Consistency", 1];_logic setvariable ["HAC_HQ_Activity", 0];_logic setvariable ["HAC_HQ_Reflex", 0];_logic setvariable ["HAC_HQ_Circumspection",0.5];_logic setvariable ["HAC_HQ_Fineness",0.5]};
	case ((not (_logic getvariable "HAC_HQ_MAtt") and ((_rnd >= 50) and (_rnd < 60))) or ((HAC_HQ_MAtt) and ((_logic getvariable "HAC_HQ_Personality") == "SCHEMER"))) : {_logic setvariable ["HAC_HQ_Personality", "SCHEMER"];_logic setvariable ["HAC_HQ_Recklessness", 0.5];_logic setvariable ["HAC_HQ_Consistency", 1];_logic setvariable ["HAC_HQ_Activity", 0];_logic setvariable ["HAC_HQ_Reflex", 0];_logic setvariable ["HAC_HQ_Circumspection",1];_logic setvariable ["HAC_HQ_Fineness",1]};
	case ((not (_logic getvariable "HAC_HQ_MAtt") and ((_rnd >= 60) and (_rnd < 70))) or ((HAC_HQ_MAtt) and ((_logic getvariable "HAC_HQ_Personality") == "BRUTE"))) : {_logic setvariable ["HAC_HQ_Personality", "BRUTE"];_logic setvariable ["HAC_HQ_Recklessness", 0.5];_logic setvariable ["HAC_HQ_Consistency", 1];_logic setvariable ["HAC_HQ_Activity", 1];_logic setvariable ["HAC_HQ_Reflex", 0.5];_logic setvariable ["HAC_HQ_Circumspection",0];_logic setvariable ["HAC_HQ_Fineness",0]};
	case ((not (_logic getvariable "HAC_HQ_MAtt") and ((_rnd >= 70) and (_rnd < 80))) or ((HAC_HQ_MAtt) and ((_logic getvariable "HAC_HQ_Personality") == "CHAOTIC"))) : {_logic setvariable ["HAC_HQ_Personality", "CHAOTIC"];_logic setvariable ["HAC_HQ_Recklessness", 0.5];_logic setvariable ["HAC_HQ_Consistency", 0];_logic setvariable ["HAC_HQ_Activity", 1];_logic setvariable ["HAC_HQ_Reflex", 1];_logic setvariable ["HAC_HQ_Circumspection",0.5];_logic setvariable ["HAC_HQ_Fineness",0.5]};
	default
		{
		_gauss1 = (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1);
		if (isNil {_logic getvariable "HAC_HQ_Recklessness"}) then {_logic setvariable ["HAC_HQ_Recklessness", _gauss1]};

		_gauss1 = (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1);
		if (isNil {_logic getvariable "HAC_HQ_Consistency"}) then {_logic setvariable ["HAC_HQ_Consistency", _gauss1]};

		_gauss1 = (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1);
		if (isNil {_logic getvariable "HAC_HQ_Activity"}) then {_logic setvariable ["HAC_HQ_Activity", _gauss1]};

		_gauss1 = (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1);
		if (isNil {_logic getvariable "HAC_HQ_Reflex"}) then {_logic setvariable ["HAC_HQ_Reflex", _gauss1]};

		_gauss1 = (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1);
		if (isNil {_logic getvariable "HAC_HQ_Circumspection"}) then {_logic setvariable ["HAC_HQ_Circumspection",_gauss1]};

		_gauss1 = (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1);
		if (isNil {_logic getvariable "HAC_HQ_Fineness"}) then {_logic setvariable ["HAC_HQ_Fineness",_gauss1]};
		};
	};

if (_logic getvariable "HAC_HQ_Debug") then {diag_log format ["Commander A (%7) - Recklessness: %1 Consistency: %2 Activity: %3 Reflex: %4 Circumspection: %5 Fineness: %6",(_logic getvariable "HAC_HQ_Recklessness"),(_logic getvariable "HAC_HQ_Consistency"),(_logic getvariable "HAC_HQ_Activity"),(_logic getvariable "HAC_HQ_Reflex"),(_logic getvariable "HAC_HQ_Circumspection"),(_logic getvariable "HAC_HQ_Fineness"),(_logic getvariable "HAC_HQ_Personality")]};

_logic setvariable ["HAC_HQ_PersDone", true];