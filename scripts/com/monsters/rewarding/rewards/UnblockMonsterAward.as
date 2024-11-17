package com.monsters.rewarding.rewards
{
   import com.monsters.rewarding.Reward;
   
   public class UnblockMonsterAward extends Reward
   {
      protected var _monsterID:String;
      
      public function UnblockMonsterAward(param1:String)
      {
         super();
         this._monsterID = param1;
      }
      
      override protected function onApplication() : void
      {
         CREATURELOCKER._creatures[this._monsterID].blocked = false;
      }
   }
}

