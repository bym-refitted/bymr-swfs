package com.monsters.rewarding.rewards
{
   import com.monsters.rewarding.Reward;
   
   public class EarlyBuildingAccess extends Reward
   {
      protected var _buildingID:int;
      
      public function EarlyBuildingAccess(param1:String, param2:int)
      {
         super(param1);
         this._buildingID = param2;
      }
      
      override public function applyReward() : void
      {
         YARD_PROPS._yardProps[this._buildingID - 1].rewarded = true;
         YARD_PROPS._yardProps[this._buildingID - 1].block = false;
      }
   }
}

