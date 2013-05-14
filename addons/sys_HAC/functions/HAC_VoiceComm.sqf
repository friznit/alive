_UL = _this select 0;
_HQ = _this select 1;
_logic = _this select ((count _this)-1);

if not (isMultiplayer) then
	{
	if (not (_UL kbHasTopic "orders")) then 
		{
		_UL kbAddTopic ["orders","\x\alive\addons\sys_HAC\topics.bikb",""];
		waituntil {(_UL kbHasTopic "orders")};
		};

	_UL kbTell [_HQ, "orders", "First", true];
	waituntil {(_UL kbWasSaid [_HQ, "orders", "First", 5])};
	sleep 1;

	if ((isPlayer _UL) and (_logic getvariable "HAC_HQ_VoiceComm")) then
		{
		_HQ kbTell [_UL, "orders", "NewMessage", true];
		waituntil {(_HQ kbWasSaid [_UL, "orders", "NewMessage", 5])};
		sleep (0.2 + (random 0.8));

		_OK = "OK" + str (floor (random 5));

		_UL kbTell [_HQ, "orders", _OK, true];
		waituntil {(_UL kbWasSaid [_HQ, "orders", _OK, 5])};
		sleep (0.2 + (random 0.8));
		}
	}
else
	{
	if (not (_UL kbHasTopic "orders")) then 
		{
		[objNull,_UL,"loc",rKBADDTOPIC,"orders","\x\alive\addons\sys_HAC\topics.bikb",""] call RE;
		waituntil {[nil,_UL,"loc",rKBHASTOPIC,"orders"] call RE};
		sleep 0.5;
		};

	[objNull,_UL,"loc",rKBTELL,_HQ,"orders","First",true] call RE;
	sleep (2 + (random 1));
	waituntil {[nil,_UL,"loc",rKBWASSAID,_HQ,"orders","First",5] call RE};
	sleep 1;

	if ((isPlayer _UL) and (_logic getvariable "HAC_HQ_VoiceComm")) then
		{
		[objNull,_HQ,"loc",rKBTELL,_UL,"orders","NewMessage",true] call RE;
		waituntil {[nil,_HQ,"loc",rKBWASSAID,_UL,"orders","NewMessage",5] call RE};
		sleep (2 + (random 1));
		sleep (0.2 + (random 0.8));

		_OK = "OK" + str (floor (random 5));

		[objNull,_UL,"loc",rKBTELL,_HQ,"orders",_OK,true] call RE;
		waituntil {[nil,_UL,"loc",rKBWASSAID,_HQ,"orders",_OK,5] call RE};
		sleep (2 + (random 1));
		sleep (0.2 + (random 0.8))
		}
	};

_logic setvariable ["HAC_HQ_VCDone", true];
