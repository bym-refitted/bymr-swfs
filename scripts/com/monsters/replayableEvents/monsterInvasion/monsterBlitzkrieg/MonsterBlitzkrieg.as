package com.monsters.replayableEvents.monsterInvasion.monsterBlitzkrieg
{
   import com.monsters.frontPage.messages.Message;
   import com.monsters.frontPage.messages.events.battletoads.*;
   import com.monsters.frontPage.messages.events.monsterBlitzkrieg.*;
   import com.monsters.replayableEvents.monsterInvasion.MonsterInvasion;
   import com.monsters.rewarding.RewardHandler;
   import com.monsters.rewarding.RewardLibrary;
   import com.monsters.rewarding.rewards.slimeattikus.UnblockSlimeattikusReward;
   import com.monsters.rewarding.rewards.slimeattikus.UnlockSlimeattikusReward;
   
   public class MonsterBlitzkrieg extends MonsterInvasion
   {
      private static const WAVES:Array = [[{
         "type":CREEP,
         "wave":[["C2","bounce",8,250,DIR.N,0,1]],
         "powerup":1,
         "level":1
      }],[{
         "type":CREEP,
         "wave":[["C2","bounce",10,250,DIR.N,0,1]],
         "powerup":0,
         "level":1
      },1,{
         "type":CREEP,
         "wave":[["C3","bounce",5,250,DIR.N,0,0]],
         "powerup":0,
         "level":1
      }],[{
         "type":CREEP,
         "wave":[["C2","bounce",5,250,DIR.N,0,1]],
         "powerup":0,
         "level":1
      },1,{
         "type":CREEP,
         "wave":[["C1","bounce",10,250,DIR.N,0,0]],
         "powerup":0,
         "level":1
      }],[{
         "type":CREEP,
         "wave":[["C1","bounce",20,250,DIR.N,0,1]],
         "powerup":0,
         "level":1
      },1,{
         "type":CREEP,
         "wave":[["C3","bounce",15,250,DIR.N,0,0]],
         "powerup":0,
         "level":1
      }],[{
         "type":CREEP,
         "wave":[["C17","bounce",3,250,DIR.N,0,1]],
         "powerup":0,
         "level":1
      },{
         "type":CREEP,
         "wave":[["C4","bounce",5,250,DIR.N,0,0]],
         "powerup":0,
         "level":1
      }],[{
         "type":CREEP,
         "wave":[["C2","bounce",6,250,DIR.N,0,1]],
         "powerup":0,
         "level":1
      },2,{
         "type":CREEP,
         "wave":[["C4","bounce",8,250,DIR.N,0,0]],
         "powerup":0,
         "level":1
      }],[{
         "type":CREEP,
         "wave":[["C6","bounce",10,250,DIR.N,0,1]],
         "powerup":0,
         "level":1
      },5,{
         "type":CREEP,
         "wave":[["C3","bounce",50,250,DIR.N,0,0]],
         "powerup":0,
         "level":1
      }],[{
         "type":CREEP,
         "wave":[["C1","bounce",40,250,DIR.N,0,1]],
         "powerup":0,
         "level":1
      },2,{
         "type":CREEP,
         "wave":[["C4","bounce",8,250,DIR.N,0,0]],
         "powerup":0,
         "level":1
      }],[{
         "type":CREEP,
         "wave":[["C2","bounce",10,250,DIR.N,0,1]],
         "powerup":0,
         "level":1
      },1,{
         "type":CREEP,
         "wave":[["C1","bounce",10,250,DIR.N,0,0]],
         "powerup":0,
         "level":1
      },{
         "type":CREEP,
         "wave":[["C4","bounce",10,250,DIR.N,0,0]],
         "powerup":0,
         "level":1
      },5,{
         "type":CREEP,
         "wave":[["C3","bounce",10,250,DIR.N,0,0]],
         "powerup":0,
         "level":1
      }],[{
         "type":CREEP,
         "wave":[["C17","bounce",8,250,DIR.N,0,1]],
         "powerup":0,
         "level":1
      }]];
      
      private const _WAVES_TOTAL:uint = 10;
      
      private const _CREATURE_REWARD_ID:String = "C17";
      
      public function MonsterBlitzkrieg()
      {
         _name = "Monster Blitzkrieg";
         _originalStartDate = 0;
         _progress = -1;
         _priority = 200;
         _id = 2;
         _titleImage = "events/monblitz/monblitz_logo.v3.png";
         _imageURL = "events/monblitz/monblitz_event.png";
         _messages = Vector.<Message>([new MonsterBlitzkriegPromoMessage1(),new MonsterBlitzkriegPromoMessage2(),new MonsterBlitzkriegPromoMessage3(),new MonsterBlitzkriegStartMessage(),new MonsterBlitzkriegEndMessage()]);
         _wavesTotal = this._WAVES_TOTAL;
         _rewardMessage = new MonsterBlitzkriegRewardMessage();
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
         RewardHandler.instance.addReward(RewardLibrary.getRewardByID(UnlockSlimeattikusReward.ID));
      }
      
      public function doesAutomaticalyGetReward() : Boolean
      {
         return GLOBAL._bTownhall._lvl.Get() >= 5 && !startDate;
      }
      
      override protected function onImport() : void
      {
         if(this.doesAutomaticalyGetReward())
         {
            RewardHandler.instance.addReward(RewardLibrary.getRewardByID(UnblockSlimeattikusReward.ID));
         }
      }
   }
}

