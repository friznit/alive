private ["_display", "_slider", "_pos", "_casFlyHeightSliderText"];
_display = findDisplay 655555;
_slider = _this select 0;
_pos = round (_this select 1);
_artyDispersionText = _display displayCtrl 655608;

_slider sliderSetPosition _pos;
_artyDispersionText ctrlSetStructuredText parseText format ["<t color='#FFFF00' size='0.5' font='Zeppelin33Italic'>DISPERSION - %1/500m</t>", _pos];
