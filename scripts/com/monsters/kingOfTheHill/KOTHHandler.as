package com.monsters.kingOfTheHill
{
   import com.monsters.interfaces.IHandler;
   import com.monsters.kingOfTheHill.graphics.KOTHHUDGraphic;
   import com.monsters.kingOfTheHill.rewards.KrallenBuffReward;
   import com.monsters.kingOfTheHill.rewards.KrallenReward;
   import com.monsters.rewarding.Reward;
   import com.monsters.rewarding.RewardHandler;
   import com.monsters.rewarding.RewardLibrary;
   import flash.events.MouseEvent;
   
   public class KOTHHandler implements IHandler
   {
      private const _RANK_THRESHOLDS:Vector.<uint> = Vector.<uint>([5 * 60,200,100,0]);
      
      private var _consecutiveWins:uint;
      
      private var _rank:uint;
      
      private var _progression:uint;
      
      private var _hudGraphic:KOTHHUDGraphic;
      
      public function KOTHHandler()
      {
         super();
      }
      
      public function initialize(param1:Object = null) : void
      {
      }
      
      private function applyRewards() : void
      {
         this.updateReward(KrallenReward.ID,this._progression);
         this.updateReward(KrallenBuffReward.ID,this._consecutiveWins);
      }
      
      private function updateReward(param1:String, param2:Number) : void
      {
         var _loc3_:Reward = RewardHandler.instance.getRewardByID(param1);
         if(_loc3_)
         {
            if(!param2)
            {
               RewardHandler.instance.removeReward(_loc3_);
               _loc3_ = null;
            }
         }
         else if(param2)
         {
            _loc3_ = RewardLibrary.getRewardByID(param1);
         }
         if(_loc3_)
         {
            _loc3_.value = param2;
            RewardHandler.instance.addReward(_loc3_);
         }
      }
      
      private function addHUDGraphic() : void
      {
         this._hudGraphic = new KOTHHUDGraphic(this._consecutiveWins);
         this._hudGraphic.addEventListener(MouseEvent.CLICK,this.clickedHUDGraphic);
      }
      
      protected function clickedHUDGraphic(param1:MouseEvent) : void
      {
         CHAMPIONCAGE.Show();
         CHAMPIONCAGE._popup.Setup(2);
      }
      
      public function get name() : String
      {
         return "koth";
      }
      
      public function importData(param1:Object) : void
      {
         this._consecutiveWins = param1.consecutivewins;
         this.rank = param1.rank;
      }
      
      public function exportData() : Object
      {
         return null;
      }
      
      public function get rank() : uint
      {
         return this._rank;
      }
      
      public function set rank(param1:uint) : void
      {
         this._rank = param1;
         this._progression = this.getProgressionFromRank(this._rank);
      }
      
      private function getProgressionFromRank(param1:uint) : uint
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._RANK_THRESHOLDS.length)
         {
            if(this._RANK_THRESHOLDS[_loc2_] >= param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return 0;
      }
   }
}

