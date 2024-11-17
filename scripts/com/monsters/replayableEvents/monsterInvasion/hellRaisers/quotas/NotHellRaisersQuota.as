package com.monsters.replayableEvents.monsterInvasion.hellRaisers.quotas
{
   import com.monsters.frontPage.messages.Message;
   import com.monsters.replayableEvents.ReplayableEventQuota;
   import com.monsters.replayableEvents.monsterInvasion.hellRaisers.rewards.UnlockMagmaTowerInOutposts;
   import com.monsters.rewarding.RewardHandler;
   
   public class NotHellRaisersQuota extends ReplayableEventQuota
   {
      private var _rewardValue:int;
      
      public function NotHellRaisersQuota(param1:Number, param2:String, param3:Message, param4:int)
      {
         super(param1,param2,UnlockMagmaTowerInOutposts.ID,param3);
         this._rewardValue = param4;
      }
      
      override public function metQuota() : void
      {
         super.metQuota();
         RewardHandler.instance.getRewardByID(UnlockMagmaTowerInOutposts.ID).value = this._rewardValue;
      }
   }
}

