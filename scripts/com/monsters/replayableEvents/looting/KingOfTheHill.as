package com.monsters.replayableEvents.looting
{
   import com.monsters.frontPage.messages.Message;
   import com.monsters.frontPage.messages.events.kingOfTheHill.*;
   import com.monsters.replayableEvents.ReplayableEvent;
   
   public class KingOfTheHill extends ReplayableEvent
   {
      public function KingOfTheHill()
      {
         _name = "Champion King of the Hill";
         _progress = -1;
         _priority = 0;
         _id = 4;
         _titleImage = "events/koth/koth_title.png";
         _imageURL = "events/koth/koth_reward.png";
         _messages = Vector.<Message>([new KOTHPromoMessage1(),new KOTHPromoMessage2(),new KOTHPromoMessage3(),new KOTHStartMessage(),new KOTHEndMessage()]);
         _rewardMessage = new KOTHRewardMessage();
         super();
         _originalStartDate = 1339441200;
         _duration = 7 * 24 * 60 * 60;
      }
      
      override public function doesQualify() : Boolean
      {
         return true;
      }
   }
}

