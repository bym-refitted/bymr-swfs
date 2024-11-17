package com.monsters.kingOfTheHill.rewards
{
   import com.monsters.rewarding.Reward;
   
   public class KrallenReward extends Reward
   {
      public static const ID:String = "krallenReward";
      
      public function KrallenReward()
      {
         super();
      }
      
      override public function set value(param1:Number) : void
      {
         super.value = param1;
         this.updateKrallenStatus(_value);
      }
      
      override protected function onApplication() : void
      {
         this.updateKrallenStatus(_value);
      }
      
      override public function removed() : void
      {
         this.updateKrallenStatus(0);
      }
      
      private function updateKrallenStatus(param1:uint) : void
      {
      }
   }
}

