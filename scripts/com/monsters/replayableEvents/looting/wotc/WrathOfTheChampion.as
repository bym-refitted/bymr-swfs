package com.monsters.replayableEvents.looting.wotc
{
   import com.monsters.frontPage.messages.Message;
   import com.monsters.replayableEvents.*;
   import com.monsters.replayableEvents.looting.wotc.messages.*;
   import com.monsters.replayableEvents.monsterMadness.MonsterMadness;
   
   public class WrathOfTheChampion extends ReplayableEvent
   {
      public static const EVENT_PAGE_URL:String = "http://camelot.allakhazam.com/ability.html?cabil=109";
      
      protected var m_lastKnownScore:Number;
      
      public function WrathOfTheChampion()
      {
         _name = "Wrath of the Champion";
         _progress = -1;
         _priority = 400;
         _id = 6;
         _buttonCopy = KEYS.Get("btn_openmap");
         _titleImage = "events/wotc/wotc_title.png";
         _imageURL = "events/wotc/wotc_reward.png";
         _messages = Vector.<Message>([new WOTCPromoMessage1(),new WOTCPromoMessage2(),new WOTCPromoMessage3(),new WOTCStartMessage(),new WOTCEndMessage()]);
         _maxScore = MonsterMadness.POINTS_GOAL3;
         super();
         var _loc1_:* = BASE.loadObject[MonsterMadness.SAVE_ID];
         this.score = !!BASE.loadObject[MonsterMadness.SAVE_ID] ? Number(BASE.loadObject[MonsterMadness.SAVE_ID]) : 0;
         _quotas.push(new ReplayableEventQuota(MonsterMadness.POINTS_GOAL1,null,null,new WOTCRewardMessage1()));
         _quotas.push(new ReplayableEventQuota(MonsterMadness.POINTS_GOAL2,null,null,new WOTCRewardMessage2()));
         _quotas.push(new ReplayableEventQuota(MonsterMadness.POINTS_GOAL3,null,null,new WOTCRewardMessage3()));
      }
      
      override public function createNewUI() : IReplayableEventUI
      {
         if(hasEventStarted)
         {
            return new MultiRewardReplayableEventUI();
         }
         return new ReplayableEventUI();
      }
      
      override public function getCurrentMessage() : Message
      {
         var _loc1_:ReplayableEventQuota = getCurrentQuota();
         if(Boolean(_loc1_) && Boolean(_loc1_.message))
         {
            return _loc1_.message;
         }
         return super.getCurrentMessage();
      }
      
      override public function get hasCompletedEvent() : Boolean
      {
         return this.m_lastKnownScore >= MonsterMadness.POINTS_GOAL3;
      }
      
      override public function pressedActionButton() : void
      {
         GLOBAL.ShowMap();
      }
      
      override public function set score(param1:Number) : void
      {
         super.score = param1;
         this.m_lastKnownScore = _score;
         progress = this.m_lastKnownScore / MonsterMadness.POINTS_GOAL3;
      }
      
      override public function doesQualify() : Boolean
      {
         return false;
      }
   }
}

