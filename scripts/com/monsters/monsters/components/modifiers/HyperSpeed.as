package com.monsters.monsters.components.modifiers
{
   import com.monsters.interfaces.IPropertyModifier;
   
   public class HyperSpeed
   {
      public static const k_color:uint = 0xff0000;
      
      public static const k_value:Number = 1.5;
      
      public static const k_attackSpeedModifier:IPropertyModifier = new DivisionModifier(k_value);
      
      public static const k_moveSpeedModifier:IPropertyModifier = new MultiplicationPropertyModifier(k_value);
      
      public function HyperSpeed()
      {
         super();
      }
   }
}

