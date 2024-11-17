package com.monsters.replayableEvents.monsterInvasion.hellRaisers.messages
{
   import com.monsters.frontPage.messages.KeywordMessage;
   
   public class HellRaisersEndMessage extends KeywordMessage
   {
      public function HellRaisersEndMessage()
      {
         super("event3end");
         this.imageURL = _IMAGE_DIRECTORY + "fp_event3start.v2.jpg";
      }
   }
}

