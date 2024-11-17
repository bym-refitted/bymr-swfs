package com.monsters.rewarding.rewards
{
   public class UnblockUnlockMonsterAward extends UnblockMonsterAward
   {
      public function UnblockUnlockMonsterAward(param1:String)
      {
         super(param1);
      }
      
      override public function canBeApplied() : Boolean
      {
         return GLOBAL.isAtHome();
      }
      
      override protected function onApplication() : void
      {
         CREATURELOCKER._lockerData[_monsterID] = {"t":2};
      }
      
      override public function reset() : void
      {
         delete CREATURELOCKER._lockerData[_monsterID];
      }
   }
}

