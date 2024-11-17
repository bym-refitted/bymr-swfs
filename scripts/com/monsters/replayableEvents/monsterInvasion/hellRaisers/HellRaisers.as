package com.monsters.replayableEvents.monsterInvasion.hellRaisers
{
   import com.monsters.frontPage.messages.Message;
   import com.monsters.replayableEvents.monsterInvasion.MonsterInvasion;
   import com.monsters.replayableEvents.monsterInvasion.WaveObj;
   import com.monsters.replayableEvents.monsterInvasion.hellRaisers.messages.*;
   import com.monsters.replayableEvents.monsterInvasion.hellRaisers.quotas.HellRaisersQuota;
   
   public class HellRaisers extends MonsterInvasion
   {
      private static const WAVES:Array = [[new WaveObj("IC1","bounce",25,WaveObj.DIR.N,1,1,true)],[new WaveObj("IC1","bounce",15,WaveObj.DIR.N,0,0,true),1,new WaveObj("IC2","bounce",15,WaveObj.DIR.N)],[new WaveObj("IC1","bounce",15,WaveObj.DIR.N,0,0,true),1,new WaveObj("IC3","bounce",15,WaveObj.DIR.N)],[new WaveObj("IC1","bounce",5,WaveObj.DIR.N,0,0,true),1,new WaveObj("IC2","bounce",5,WaveObj.DIR.N),1,new WaveObj("IC3","bounce",5,WaveObj.DIR.N),1,new WaveObj("IC4","bounce",5,WaveObj.DIR.N)],[new WaveObj("IC6","bounce",7,WaveObj.DIR.N,0,0,true)],[new WaveObj("IC5","bounce",4,WaveObj.DIR.N,0,0,true),2,new WaveObj("IC2","bounce",5,WaveObj.DIR.N,0,0)],[new WaveObj("IC2","bounce",10,WaveObj.DIR.N,0,0,true),5,new WaveObj("IC4","bounce",10,WaveObj.DIR.N,0,0)],[new WaveObj("IC1","bounce",12,WaveObj.DIR.N,0,0,true),2,new WaveObj("IC1","bounce",13,WaveObj.DIR.S,0,0),1,new WaveObj("IC1","bounce",13,WaveObj.DIR.E,0,0),1,new WaveObj("IC1","bounce",12,WaveObj.DIR.W,0,0)],[new WaveObj("IC7","bounce",6,WaveObj
      .DIR.N,0,0,true)],[new WaveObj("IC7","bounce",4,WaveObj.DIR.N,0,0,true),1,new WaveObj("IC5","bounce",5,WaveObj.DIR.N,0,0),1,new WaveObj("IC2","bounce",5,WaveObj.DIR.N,0,0)]];
      
      private const _WAVES_TOTAL:uint = 20;
      
      public function HellRaisers()
      {
         _name = "Hell-Raisers";
         _progress = -1;
         _priority = 450;
         _id = 3;
         _titleImage = "events/hellraisers/hellraisers_logo.png";
         _imageURL = "events/hellraisers/hellraisers_event.png";
         _messages = Vector.<Message>([new HellRaisersPromoMessage1(),new HellRaisersPromoMessage2(),new HellRaisersPromoMessage3(),new HellRaisersStartMessage(),new HellRaisersEndMessage()]);
         _wavesTotal = this._WAVES_TOTAL;
         _rewardMessage = new HellRaisersRewardMessage();
         super(this._WAVES_TOTAL);
         _quotas.push(new HellRaisersQuota(15,"events/hellraisers/hellraisers_reward_1.png",null,1));
         _quotas.push(new HellRaisersQuota(this._WAVES_TOTAL,"events/hellraisers/hellraisers_reward_2.png",null,2));
      }
      
      override protected function getWaveArray() : Array
      {
         return WAVES;
      }
      
      override public function doesQualify() : Boolean
      {
         return false;
      }
   }
}

