package com.monsters.monsters.creeps
{
   import com.monsters.monsters.MonsterBase;
   import flash.geom.Point;
   
   public class Eyera extends CreepBase
   {
      public function Eyera(param1:String, param2:String, param3:Point, param4:Number, param5:int = 0, param6:int = 2147483647, param7:Point = null, param8:Boolean = false, param9:BFOUNDATION = null, param10:Number = 1, param11:Boolean = false, param12:MonsterBase = null)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
         if(poweredUp())
         {
            targetMode = 1;
         }
      }
   }
}

