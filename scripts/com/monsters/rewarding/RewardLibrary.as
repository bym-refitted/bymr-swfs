package com.monsters.rewarding
{
   import com.monsters.debug.Console;
   import com.monsters.rewarding.rewards.magmaTowers.UnlockMagmaTowers;
   import com.monsters.rewarding.rewards.slimeattikus.UnblockSlimeattikusReward;
   import com.monsters.rewarding.rewards.slimeattikus.UnlockSlimeattikusReward;
   import com.monsters.rewarding.rewards.vorg.UnblockVorgReward;
   import com.monsters.rewarding.rewards.vorg.UnlockVorgReward;
   
   public class RewardLibrary
   {
      public static var rewardTypes:Object = {};
      
      public function RewardLibrary()
      {
         super();
      }
      
      public static function initialize() : void
      {
         addRewardType(UnlockVorgReward.ID,UnlockVorgReward);
         addRewardType(UnlockSlimeattikusReward.ID,UnlockSlimeattikusReward);
         addRewardType(UnblockSlimeattikusReward.ID,UnblockSlimeattikusReward);
         addRewardType(UnblockVorgReward.ID,UnblockVorgReward);
         addRewardType(UnlockMagmaTowers.ID,UnlockMagmaTowers);
      }
      
      public static function addRewardType(param1:String, param2:Class) : void
      {
         if(rewardTypes[param1])
         {
            Console.warning("You tried to add the reward(" + param1 + ") that already exists");
         }
         rewardTypes[param1] = param2;
      }
      
      public static function getRewardByID(param1:String) : Reward
      {
         var _loc2_:Class = rewardTypes[param1];
         if(_loc2_)
         {
            return new _loc2_() as Reward;
         }
         return null;
      }
   }
}

