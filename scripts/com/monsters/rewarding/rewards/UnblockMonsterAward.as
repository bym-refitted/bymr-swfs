package com.monsters.rewarding.rewards
{
   import com.monsters.rewarding.Reward;
   
   public class UnblockMonsterAward extends Reward
   {
      protected var _monsterID:String;
      
      public function UnblockMonsterAward(param1:String, param2:String)
      {
         super(param1);
         this._monsterID = param2;
      }
      
      override public function applyReward() : void
      {
         CREATURELOCKER._creatures[this._monsterID].blocked = false;
      }
   }
}

