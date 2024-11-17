package com.monsters.kingOfTheHill.rewards
{
   import com.monsters.debug.Console;
   import com.monsters.rewarding.Reward;
   
   public class KrallenBuffReward extends Reward
   {
      public static const ID:String = "krallenBuffReward";
      
      public function KrallenBuffReward()
      {
         super();
      }
      
      override public function set value(param1:Number) : void
      {
         super.value = param1;
         this.updateChampionBuff(_value);
      }
      
      override protected function onApplication() : void
      {
         this.updateChampionBuff(_value);
      }
      
      override public function removed() : void
      {
         this.updateChampionBuff(0);
      }
      
      private function updateChampionBuff(param1:uint) : void
      {
         var _loc2_:Object = CHAMPIONCAGE.GetGuardianData(5);
         if(_loc2_)
         {
            _loc2_.buff = param1;
         }
         else
         {
            Console.warning("You are trying to setup the Krallen buff but you dont own a Krallen");
         }
      }
   }
}

