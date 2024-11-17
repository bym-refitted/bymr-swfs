package com.monsters.replayableEvents.monsterInvasion.hellRaisers
{
   import com.monsters.frontPage.messages.Message;
   import com.monsters.frontPage.messages.events.hellRaisers.*;
   import com.monsters.replayableEvents.monsterInvasion.MonsterInvasion;
   import com.monsters.rewarding.RewardHandler;
   import com.monsters.rewarding.RewardLibrary;
   import com.monsters.rewarding.rewards.magmaTowers.UnlockMagmaTowers;
   
   public class HellRaisers extends MonsterInvasion
   {
      private static const WAVES:Array = [[{
         "type":CREEP,
         "wave":[["IC1","bounce",25,250,DIR.N,0,1]],
         "powerup":1,
         "level":1
      }],[{
         "type":CREEP,
         "wave":[["IC1","bounce",15,250,DIR.N,0,1]],
         "powerup":0,
         "level":1
      },1,{
         "type":CREEP,
         "wave":[["IC2","bounce",15,250,DIR.N,0,0]],
         "powerup":0,
         "level":1
      }],[{
         "type":CREEP,
         "wave":[["IC1","bounce",15,250,DIR.N,0,1]],
         "powerup":0,
         "level":1
      },1,{
         "type":CREEP,
         "wave":[["IC3","bounce",15,250,DIR.N,0,0]],
         "powerup":0,
         "level":1
      }],[{
         "type":CREEP,
         "wave":[["IC1","bounce",5,250,DIR.N,0,1]],
         "powerup":0,
         "level":1
      },1,{
         "type":CREEP,
         "wave":[["IC2","bounce",5,250,DIR.N,0,0]],
         "powerup":0,
         "level":1
      },1,{
         "type":CREEP,
         "wave":[["IC3","bounce",5,250,DIR.N,0,0]],
         "powerup":0,
         "level":1
      },1,{
         "type":CREEP,
         "wave":[["IC4","bounce",5,250,DIR.N,0,0]],
         "powerup":0,
         "level":1
      }],[{
         "type":CREEP,
         "wave":[["IC6","bounce",7,250,DIR.N,0,1]],
         "powerup":0,
         "level":1
      }],[{
         "type":CREEP,
         "wave":[["IC5","bounce",4,250,DIR.N,0,1]],
         "powerup":0,
         "level":1
      },2,{
         "type":CREEP,
         "wave":[["IC2","bounce",5,250,DIR.N,0,0]],
         "powerup":0,
         "level":1
      }],[{
         "type":CREEP,
         "wave":[["IC2","bounce",10,250,DIR.N,0,1]],
         "powerup":0,
         "level":1
      },5,{
         "type":CREEP,
         "wave":[["IC4","bounce",10,250,DIR.N,0,0]],
         "powerup":0,
         "level":1
      }],[{
         "type":CREEP,
         "wave":[["IC1","bounce",12,250,DIR.N,0,1]],
         "powerup":0,
         "level":1
      },2,{
         "type":CREEP,
         "wave":[["IC1","bounce",13,250,DIR.S,0,1]],
         "powerup":0,
         "level":1
      },1,{
         "type":CREEP,
         "wave":[["IC1","bounce",13,250,DIR.E,0,1]],
         "powerup":0,
         "level":1
      },1,{
         "type":CREEP,
         "wave":[["IC1","bounce",12,250,DIR.W,0,1]],
         "powerup":0,
         "level":1
      }],[{
         "type":CREEP,
         "wave":[["IC7","bounce",6,250,DIR.N,0,1]],
         "powerup":0,
         "level":1
      }],[{
         "type":CREEP,
         "wave":[["IC7","bounce",4,250,DIR.N,0,1]],
         "powerup":0,
         "level":1
      },1,{
         "type":CREEP,
         "wave":[["IC5","bounce",5,250,DIR.N,0,1]],
         "powerup":0,
         "level":1
      },1,{
         "type":CREEP,
         "wave":[["IC2","bounce",5,250,DIR.N,0,1]],
         "powerup":0,
         "level":1
      }]];
      
      private const _WAVES_TOTAL:uint = 10;
      
      public function HellRaisers()
      {
         _name = "Hell-Raisers";
         _originalStartDate = 0;
         _progress = -1;
         _priority = 5 * 60;
         _id = 3;
         _titleImage = "events/hellraisers/hellraisers_logo.png";
         _imageURL = "events/hellraisers/hellraisers_event.png";
         _messages = Vector.<Message>([new HellRaisersPromoMessage1(),new HellRaisersPromoMessage2(),new HellRaisersPromoMessage3(),new HellRaisersStartMessage(),new HellRaisersEndMessage()]);
         _wavesTotal = this._WAVES_TOTAL;
         _rewardMessage = new HellRaisersRewardMessage();
         super(this._WAVES_TOTAL);
      }
      
      override protected function getWaveArray() : Array
      {
         return WAVES;
      }
      
      override public function doesQualify() : Boolean
      {
         var _loc1_:uint = GLOBAL._bTownhall._lvl.Get();
         return _loc1_ >= 3 && _loc1_ <= 4;
      }
      
      override protected function onEventComplete() : void
      {
         RewardHandler.instance.addReward(RewardLibrary.getRewardByID(UnlockMagmaTowers.ID));
      }
      
      public function doesAutomaticalyGetReward() : Boolean
      {
         return false;
      }
      
      override protected function onImport() : void
      {
         if(this.doesAutomaticalyGetReward())
         {
            RewardHandler.instance.addReward(RewardLibrary.getRewardByID(UnlockMagmaTowers.ID));
         }
      }
   }
}

