package com.monsters.subscriptions.rewards
{
   import com.monsters.display.CreepSkinManager;
   import com.monsters.rewarding.Reward;
   
   public class GoldenDAVEReward extends Reward
   {
      public static const ID:String = "goldenDAVE";
      
      private static const DAVE_CREEP_ID:String = "C12";
      
      private static const GOLD_SKIN_ID:String = "C12Gold";
      
      public function GoldenDAVEReward()
      {
         super();
      }
      
      override protected function onApplication() : void
      {
         var _loc1_:String = !!_value ? GOLD_SKIN_ID : null;
         CreepSkinManager.instance.SetSkin(DAVE_CREEP_ID,_loc1_);
      }
      
      override public function removed() : void
      {
         CreepSkinManager.instance.SetSkin(DAVE_CREEP_ID,null);
      }
   }
}

