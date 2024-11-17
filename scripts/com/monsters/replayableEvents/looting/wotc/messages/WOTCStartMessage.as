package com.monsters.replayableEvents.looting.wotc.messages
{
   import com.monsters.frontPage.FrontPageHandler;
   import com.monsters.frontPage.messages.KeywordMessage;
   
   public class WOTCStartMessage extends KeywordMessage
   {
      public function WOTCStartMessage()
      {
         var _loc2_:String = null;
         var _loc1_:BFOUNDATION = BASE.maproom;
         if(!_loc1_)
         {
            _loc2_ = "";
         }
         else if(!GLOBAL._advancedMap)
         {
            _loc2_ = "btn_upgradenow";
         }
         else
         {
            _loc2_ = "btn_openmap";
         }
         super("wotcstart",_loc2_);
      }
      
      override protected function onButtonClick() : void
      {
         var _loc1_:BFOUNDATION = BASE.maproom;
         if(!GLOBAL._advancedMap && Boolean(_loc1_))
         {
            FrontPageHandler.closeAll();
            BUILDINGOPTIONS.Show(BASE.maproom,"upgrade");
         }
         else if(GLOBAL._advancedMap)
         {
            GLOBAL.ShowMap();
         }
      }
      
      override public function refresh() : void
      {
         var _loc2_:String = null;
         var _loc1_:BFOUNDATION = BASE.maproom;
         if(!_loc1_)
         {
            _loc2_ = "";
         }
         else if(!GLOBAL._advancedMap)
         {
            _loc2_ = "btn_upgradenow";
         }
         else
         {
            _loc2_ = "btn_openmap";
         }
         _buttonCopy = !!_loc2_ ? KEYS.Get(_loc2_) : null;
      }
   }
}

