package com.monsters.rewarding
{
   import com.monsters.interfaces.IHandler;
   
   public class RewardHandler implements IHandler
   {
      private static var _instance:RewardHandler;
      
      public var rewards:Vector.<Reward> = new Vector.<Reward>();
      
      public function RewardHandler()
      {
         super();
      }
      
      public static function get instance() : RewardHandler
      {
         if(!_instance)
         {
            _instance = new RewardHandler();
         }
         return _instance;
      }
      
      public function get name() : String
      {
         return "rewards";
      }
      
      public function addReward(param1:Reward) : void
      {
         if(this.getRewardByID(param1.id))
         {
            return;
         }
         this.rewards.push(param1);
         param1.applyReward();
      }
      
      private function applyRewards() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.rewards.length)
         {
            this.rewards[_loc1_].applyReward();
            _loc1_++;
         }
      }
      
      private function getRewardByID(param1:String) : Reward
      {
         var _loc3_:Reward = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.rewards.length)
         {
            _loc3_ = this.rewards[_loc2_];
            if(_loc3_.id == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function initialize(param1:Object = null) : void
      {
         if(GLOBAL._mode != "build")
         {
            return;
         }
         RewardLibrary.initialize();
         if(param1)
         {
            this.importData(param1);
         }
         this.applyRewards();
      }
      
      public function exportData() : Object
      {
         return null;
      }
      
      public function importData(param1:Object) : void
      {
      }
   }
}

