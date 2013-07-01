HAC_LEADERS = [TEST1,TEST2,TEST3,TEST4,TEST5,TEST6,TEST7,TEST8,TEST9];
call compile preprocessFileLinenumbers "convertToProfiles.sqf";
//[] execvm "SEP.sqf";

//waituntil {!isnil "SEP_INIT_FINISHED"};

[] spawn {
    sleep 5;
OPCOM = execFSM "opcom.fsm";
TACOM = execFSM "tacom.fsm";
};