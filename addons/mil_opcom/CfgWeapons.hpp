class cfgWeapons
{
        class ItemCore;
        class InventoryItem_Base_F;
        class HeadgearItem;
        class Uniform_Base;
        class UniformItem;
        class Vest_NoCamo_Base;
        class VestItem;

        class V_ALiVE_Suicide_Vest: Vest_NoCamo_Base
        {
                scope = 2;
                displayName = "Suicide Vest";
                picture = "\x\alive\addons\mil_opcom\data\ui\icon_V_ALiVE_Suicide_Vest.paa"; //
                class ItemInfo: VestItem
                {
                        uniformModel = "-";
                        containerClass = "Supply50"; // or what ever space it got
                        mass = 25;
                        armor = "5*0.5"; // if body armor various values can be used
                        passThrough = 0.7; // how much the vest stops a bullet going through
                };
        };
};