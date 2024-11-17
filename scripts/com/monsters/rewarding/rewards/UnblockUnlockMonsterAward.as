package com.monsters.rewarding.rewards
{
   public class UnblockUnlockMonsterAward extends UnblockMonsterAward
   {
      public function UnblockUnlockMonsterAward(param1:String, param2:String)
      {
         super(param1,param2);
      }
      
      override public function applyReward() : void
      {
         super.applyReward();
         CREATURELOCKER._lockerData[_monsterID] = {"t":2};
      }
   }
}

