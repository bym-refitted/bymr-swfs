package com.monsters.replayableEvents.looting.wotc.messages
{
   import com.monsters.frontPage.messages.KeywordMessage;
   
   public class WOTCStartMessage extends KeywordMessage
   {
      public function WOTCStartMessage()
      {
         super("wotcstart","btn_openmap");
      }
      
      override protected function onButtonClick() : void
      {
         GLOBAL.ShowMap();
      }
   }
}

