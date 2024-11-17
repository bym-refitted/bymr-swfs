package com.monsters.replayableEvents.monsterInvasion.hellRaisers.messages
{
   import com.monsters.frontPage.messages.KeywordMessage;
   
   public class HellRaisersRewardMessage extends KeywordMessage
   {
      public function HellRaisersRewardMessage()
      {
         super("event3reward","btn_brag");
         this.imageURL = _IMAGE_DIRECTORY + "fp_event3start.v2.jpg";
      }
      
      override public function get areRequirementsMet() : Boolean
      {
         return false;
      }
      
      override protected function onButtonClick() : void
      {
         GLOBAL.CallJS("sendFeed",["event3-reward",KEYS.Get("event3reward_streamtitle"),KEYS.Get("event3reward_streambody"),"event3reward_stream.v2.png"]);
         POPUPS.Next();
      }
   }
}

