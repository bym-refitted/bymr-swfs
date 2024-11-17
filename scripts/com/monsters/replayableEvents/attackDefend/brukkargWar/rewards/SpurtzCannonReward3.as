package com.monsters.replayableEvents.attackDefend.brukkargWar.rewards
{
   import com.monsters.rewarding.Reward;
   import flash.geom.Point;
   
   public class SpurtzCannonReward3 extends Reward
   {
      public static const ID:String = "spurtzCannonReward3";
      
      public function SpurtzCannonReward3()
      {
         super();
      }
      
      override protected function onApplication() : void
      {
         var _loc1_:BFOUNDATION = null;
         for each(_loc1_ in BASE._buildingsTowers)
         {
            if(_loc1_._type == SpurtzCannon.TYPE)
            {
               this.swapBuildings(_loc1_,BASE.addBuildingC(BlackSpurtzCannon.TYPE));
            }
         }
         GLOBAL._buildingProps[BlackSpurtzCannon.TYPE - 1].block = false;
         GLOBAL._buildingProps[BlackSpurtzCannon.TYPE - 1].quantity = [2];
         GLOBAL._buildingProps[SpurtzCannon.TYPE - 1].block = true;
      }
      
      override public function removed() : void
      {
         GLOBAL._buildingProps[BlackSpurtzCannon.TYPE - 1].block = true;
      }
      
      override public function reset() : void
      {
         if(this.canBeApplied())
         {
            this.removed();
         }
      }
      
      private function swapBuildings(param1:BFOUNDATION, param2:BFOUNDATION) : void
      {
         var _loc3_:Point = GRID.FromISO(param1.x,param1.y);
         var _loc4_:Object = {
            "X":_loc3_.x,
            "Y":_loc3_.y,
            "t":param2._type,
            "id":param1._id,
            "l":param1._lvl.Get()
         };
         param1.RecycleC();
         param2.Setup(_loc4_);
      }
      
      override public function canBeApplied() : Boolean
      {
         return GLOBAL.isAtHome();
      }
   }
}

