private ["_display", "_slider", "_pos", "_casFlyHeightSliderText"];
_display = findDisplay 655555;
_slider = _this select 0;
_pos = round (_this select 1);
_artyRateDelayText = _display displayCtrl 655611;

_slider sliderSetPosition _pos;
_artyRateDelayText ctrlSetStructuredText parseText format ["<t color='#FFFF00' size='0.5' font='Zeppelin33Italic'>DELAY - %1/30s</t>", _pos];
