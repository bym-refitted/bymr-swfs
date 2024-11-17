package com.monsters.subscriptions.rewards
{
   import com.monsters.baseplanner.BasePlanner;
   import com.monsters.rewarding.Reward;
   
   public class YardPlannerExtraSlotsReward extends Reward
   {
      public static const ID:String = "yardPlannerExtraSlots";
      
      public function YardPlannerExtraSlotsReward()
      {
         super();
      }
      
      override protected function onApplication() : void
      {
         BasePlanner.maxNumberOfSlots = 10;
      }
      
      override public function removed() : void
      {
         BasePlanner.maxNumberOfSlots = BasePlanner.DEFAULT_NUMBER_OF_SLOTS;
      }
   }
}

