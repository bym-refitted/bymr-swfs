package com.monsters.kingOfTheHill.messages
{
   import com.monsters.frontPage.messages.KeywordMessage;
   import com.monsters.kingOfTheHill.KOTHHandler;
   
   public class KOTHRewardMessage extends KeywordMessage
   {
      public function KOTHRewardMessage(param1:Boolean)
      {
         super(param1 ? "kothendkeep" : "kothendwin","btn_brag");
         this.body = KEYS.Get(PREFIX + _keyword,{"v1":KOTHHandler.instance.wins + 1});
         imageURL = getImageURLFromKeyword("event_kothwin");
      }
      
      override protected function onButtonClick() : void
      {
         GLOBAL.CallJS("sendFeed",["event4-reward",KEYS.Get("fb_kothstream_title"),KEYS.Get("fb_kothstream_desc"),"fb_kothstream.png"]);
         POPUPS.Next();
      }
   }
}

