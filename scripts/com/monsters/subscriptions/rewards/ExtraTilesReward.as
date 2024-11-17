package com.monsters.subscriptions.rewards
{
   import com.monsters.rewarding.Reward;
   
   public class ExtraTilesReward extends Reward
   {
      public static const ID:String = "extraTiles";
      
      public function ExtraTilesReward()
      {
         super();
      }
      
      override protected function onApplication() : void
      {
         MAP.swapBG(this.value);
      }
      
      override public function removed() : void
      {
         MAP.swapBG(0);
      }
   }
}

