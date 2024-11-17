package com.monsters.utils
{
   import flash.geom.Point;
   
   public class MathUtils
   {
      public static const DEGREES_TO_RADIANS:Number = Math.PI / 180;
      
      public static const RADIANS_TO_DEGREES:Number = 180 / Math.PI;
      
      public function MathUtils()
      {
         super();
      }
      
      public static function getDistanceBetweenTwoPoints(param1:Point, param2:Point) : Number
      {
         return GLOBAL.QuickDistance(param1,param2);
      }
   }
}

