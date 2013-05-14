_cycle = 0;
_logic = _this select ((count _this)-1);
waitUntil {sleep 1; not (isNil {_logic getvariable "HAC_HQ"})};

_logic setvariable ["HAC_HQ_LHQInit", true];
while {not (isNull (_logic getvariable "HAC_HQ"))} do
	{
	_last = _logic;
	if (isNil ("_last")) then {_last = ObjNull};
	sleep 0.2;
	if not (_last == _logic) then
		{
		if not (isNull _logic) then
			{
			if (alive _logic) then
				{
				if not (isNull (_logic getvariable "HAC_HQ")) then
					{
					if not (_cycle == (_logic getvariable "HAC_HQ_Cyclecount")) then
						{
						if not ((_logic getvariable "HAC_HQ_Cyclecount") < 2) then 
							{
							_logic setvariable ["HAC_xHQ_AllLeaders", (_logic getvariable "HAC_xHQ_AllLeaders") - [_last]];_logic setvariable ["HAC_xHQ_AllLeaders",(_logic getvariable "HAC_xHQ_AllLeaders") + [_logic]];_cycle = (_logic getvariable "HAC_HQ_Cyclecount");
							_logic setvariable ["HAC_HQ_Personality", (_logic getvariable "HAC_HQ_Personality") + "-"];
							_logic setvariable ["HAC_HQ_Recklessness", (_logic getvariable "HAC_HQ_Recklessness") + (random 0.2)];
							_logic setvariable ["HAC_HQ_Consistency", (_logic getvariable "HAC_HQ_Consistency") - (random 0.2)];
							_logic setvariable ["HAC_HQ_Activity", (_logic getvariable "HAC_HQ_Activity") - (random 0.2)];
							_logic setvariable ["HAC_HQ_Reflex", (_logic getvariable "HAC_HQ_Reflex") - (random 0.2)];
							_logic setvariable ["HAC_HQ_Circumspection", (_logic getvariable "HAC_HQ_Circumspection") - (random 0.2)];
							_logic setvariable ["HAC_HQ_Fineness", (_logic getvariable "HAC_HQ_Fineness") - (random 0.2)];

								{
								if (_x > 1) then {_x = 1};
								if (_x < 0) then {_x = 0};
								}
							foreach [(_logic getvariable "HAC_HQ_Recklessness"),(_logic getvariable "HAC_HQ_Consistency"),(_logic getvariable "HAC_HQ_Activity"),(_logic getvariable "HAC_HQ_Reflex"),(_logic getvariable "HAC_HQ_Circumspection"),(_logic getvariable "HAC_HQ_Fineness")];

							[_logic] spawn
								{
                               	_logic = _this select 0;
								sleep (60 + (random 120));
								_logic setvariable ["HAC_HQ_Morale",(_logic getvariable "HAC_HQ_Morale") - (10 + round (random 10))];
								}
							}
						}
					}
				}
			}
		};

        if (({alive _x} count (units (_logic getvariable "HAC_HQ"))) == 0) then {_logic setvariable ["HAC_HQ", GrpNull]};
	};

if (_logic getvariable "HAC_HQ_Debug") then {hintSilent "HQ of A forces has been destroyed!"};

_logic setvariable ["HAC_HQ_Done", true];