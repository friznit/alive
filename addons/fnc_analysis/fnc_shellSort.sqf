#include <\x\alive\addons\fnc_analysis\script_component.hpp>
SCRIPT(shellSort);

/* ----------------------------------------------------------------------------
Function: ALIVE_fnc_shellSort

 Description:
    generic shell sort implementation. The original list does 
    NOT get altered.
    
    Shellsort is not sensitive to the initial ordering of the
    given list. Hard to compare to other sorting methods but
    shellsort is often the method of choice for many sorting
    applications:
    
     - acceptable runtime even for moderately large lists,
       (Sedgewick says up to "five thousand elements")
     - yet very easy algorithm.
    
   Parameter(s):
    _this select 0: the list to be sorted (array of any)
    _this select 1: sort value selector/calculator (string or code; optional)
                    - gets passed a list item, must return scalar
                    - if a string gets passed, we compile it first
                    
                    -> if the list does not consist of numbers but a complex 
                       data structure (like arrays), you may pass a simple
                       function, that accesses (or calculate) the "value" 
                       in this structure the list will be sorted on.
                       
                    -> to simply invert the sort order, pass {_this * -1} as
                       second parameter (for numbers).
                       
                       default sorting order is ASCENDING

   Returns:
    sorted list


Author:
rübe
---------------------------------------------------------------------------- */

private ["_list", "_selectSortValue", "_n", "_cols", "_j", "_k", "_h", "_t", "_i"];

_list = +(_this select 0);
_selectSortValue = { _this };

if ((count _this) > 1) then
{
   if ((typeName (_this select 1)) == "CODE") then
   {
      _selectSortValue = _this select 1;
   } else {
      _selectSortValue = compile (_this select 1);
   };
};

// shell sort
_n = count _list;
// we take the increment sequence (3 * h + 1), which has been shown
// empirically to do well... 
_cols = [3501671, 1355339, 543749, 213331, 84801, 27901, 11969, 4711, 1968, 815, 271, 111, 41, 13, 4, 1];

for "_k" from 0 to ((count _cols) - 1) do
{
   _h = _cols select _k;
   for [{_i = _h}, {_i < _n}, {_i = _i + 1}] do
   {
      _t = _list select _i;
      _j = _i;

      while {(_j >= _h)} do
      {
         if (!(((_list select (_j - _h)) call _selectSortValue) > 
               (_t call _selectSortValue))) exitWith {};
         _list set [_j, (_list select (_j - _h))];
         _j = _j - _h;
      };
      
      
      _list set [_j, _t];
   };
};

_list