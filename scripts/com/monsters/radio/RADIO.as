package com.monsters.radio
{
   import com.adobe.serialization.json.JSON;
   import flash.display.MovieClip;
   import flash.display.StageDisplayState;
   
   public class RADIO
   {
      public static var _mc:MovieClip;
      
      public static var _twitterAccount:String;
      
      public static var _open:Boolean = false;
      
      private static var _requestedName:Boolean = false;
      
      public function RADIO()
      {
         super();
      }
      
      public static function Setup() : *
      {
         if(!GLOBAL._bRadio)
         {
            return;
         }
         if(_requestedName)
         {
            return;
         }
         GLOBAL.CallJS("twitterInterface.getName",["twitteraccount"],false);
         _requestedName = true;
      }
      
      public static function Callback(param1:String) : *
      {
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(param1);
         if(_loc2_.error)
         {
            if(_loc2_.error != "noname")
            {
               LOGGER.Log("err","radio: " + _loc2_.error);
               GLOBAL.Message("There was a problem with the Radio Tower: " + _loc2_.error + "<br><br>Please try again.");
            }
         }
         else if(_loc2_.name)
         {
            _twitterAccount = _loc2_.name;
         }
      }
      
      public static function SetName(param1:String) : *
      {
         GLOBAL.CallJS("twitterInterface.setName",["" + param1,"twitteraccount"],false);
         _twitterAccount = param1;
      }
      
      public static function RemoveName() : *
      {
         GLOBAL.CallJS("twitterInterface.deleteName",["twitteraccount"],false);
      }
      
      public static function Follow() : *
      {
         GLOBAL.CallJS("openUrl",["http://twitter.com/#!/BackyardMonster"],true);
      }
      
      public static function Brag() : *
      {
         GLOBAL.CallJS("sendFeed",["build-radio","#fname#\'s Radio Tower is complete.","#fname# is following @BackyardMonster and is now receiving Attack Alerts.","build-radio.v2.png"]);
      }
      
      public static function Show() : *
      {
         if(!_open)
         {
            if(GLOBAL._ROOT.stage.displayState == StageDisplayState.FULL_SCREEN)
            {
               UI2._top.mcZoom.gotoAndStop(1);
               GLOBAL._ROOT.stage.displayState = StageDisplayState.NORMAL;
               GLOBAL._zoomed = false;
               MAP._GROUND.scaleY = 1;
               MAP._GROUND.scaleX = 1;
               MAP.Focus(0,0);
            }
            GLOBAL.BlockerAdd();
            _mc = new popup_radio();
            _mc.x = 380;
            _mc.y = 260;
            GLOBAL._layerWindows.addChild(_mc);
            _open = true;
         }
      }
      
      public static function Hide() : *
      {
         if(_open)
         {
            GLOBAL.BlockerRemove();
            if(Boolean(_mc) && Boolean(_mc.parent))
            {
               _mc.parent.removeChild(_mc);
            }
            _open = false;
         }
      }
   }
}

