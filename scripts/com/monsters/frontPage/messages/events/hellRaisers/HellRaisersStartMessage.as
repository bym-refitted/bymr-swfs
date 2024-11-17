package com.monsters.frontPage.messages.events.hellRaisers
{
   import com.monsters.frontPage.messages.KeywordMessage;
   import com.monsters.replayableEvents.ReplayableEventHandler;
   
   public class HellRaisersStartMessage extends KeywordMessage
   {
      public function HellRaisersStartMessage()
      {
         super("event3start","btn_nextwave");
         this.imageURL = _IMAGE_DIRECTORY + "fp_event3start.v2.jpg";
      }
      
      override protected function onButtonClick() : void
      {
         ReplayableEventHandler.activeEvent.pressedActionButton();
         POPUPS.Next();
      }
   }
}
