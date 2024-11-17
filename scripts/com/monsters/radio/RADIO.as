package com.monsters.radio
{
   import com.adobe.serialization.json.JSON;
   import flash.display.StageDisplayState;
   
   public class RADIO
   {
      public static var _twitterAccount:String;
      
      private static var _mc:RADIOSETTINGSPOPUP;
      
      public static var _settings:Object;
      
      public static var _init:Boolean = false;
      
      public static var _open:Boolean = false;
      
      private static var _requestedName:Boolean = false;
      
      public static var _proxymode:Boolean = false;
      
      public static var _isSaving:Boolean = false;
      
      public static const ATTACK_KEY:String = "att";
      
      public static const NEWS_KEY:String = "news";
      
      public static const ADDRESS_KEY:String = "address";
      
      public static const PROXY_KEY:String = "proxy";
      
      public function RADIO()
      {
         super();
      }
      
      public static function Setup(param1:Object = null) : *
      {
         if(param1)
         {
            _settings = param1;
         }
         else if(LOGIN._settings)
         {
            _settings = LOGIN._settings;
         }
         else
         {
            _settings = {};
         }
      }
      
      public static function SubmitEmail() : void
      {
      }
      
      public static function getProp(param1:String) : *
      {
         if(Boolean(_settings) && Boolean(_settings.hasOwnProperty(param1)))
         {
            return _settings[param1];
         }
         return null;
      }
      
      public static function setProp(param1:String, param2:*) : void
      {
         _settings[param1] = param2;
         var _loc3_:String = com.adobe.serialization.json.JSON.encode(_settings);
         new URLLoaderApi().load(GLOBAL._apiURL + "player/updateemail",[["settings",_loc3_]],handleSettingsSaveSucc,handleSettingsSaveFail);
         _isSaving = true;
         _mc.bSaveToggle();
      }
      
      private static function handleSettingsSaveSucc(param1:Object) : void
      {
         _isSaving = false;
         _mc.bSaveToggle();
         if(param1.error == 0)
         {
            GLOBAL.Message(KEYS.Get("radio_saveSucc"),null,null,null);
            Hide();
         }
         else
         {
            LOGGER.Log("err","|RADIO| - handleSettingsSaveSucc - Fail",com.adobe.serialization.json.JSON.encode(param1));
            GLOBAL.Message(KEYS.Get("radio_saveFail"),null,null,null);
         }
      }
      
      private static function handleSettingsSaveFail(param1:Object) : void
      {
         _isSaving = false;
         GLOBAL.Message(KEYS.Get("radio_saveFail"),null,null,null);
      }
      
      public static function TwitterCallback(param1:String) : *
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
      
      public static function TwitterSetName(param1:String) : *
      {
         GLOBAL.CallJS("twitterInterface.setName",["" + param1,"twitteraccount"],false);
         _twitterAccount = param1;
      }
      
      public static function TwitterRemoveName() : *
      {
         GLOBAL.CallJS("twitterInterface.deleteName",["twitteraccount"],false);
      }
      
      public static function RemoveName() : *
      {
         var handleRemoveSucc:Function = null;
         var handleRemoveFail:Function = null;
         var removeEmail:Function = function(param1:String, param2:*):void
         {
            _settings[param1] = param2;
            var _loc3_:String = com.adobe.serialization.json.JSON.encode(_settings);
            new URLLoaderApi().load(GLOBAL._apiURL + "player/updateemail",[["settings",_loc3_]],handleRemoveSucc,handleRemoveFail);
            _isSaving = true;
         };
         handleRemoveSucc = function(param1:Object):void
         {
            _isSaving = false;
            if(param1.error == 0)
            {
               GLOBAL.Message(KEYS.Get("radio_recycleConfirm"),null,null,null);
               Hide();
            }
            else
            {
               LOGGER.Log("err","|RADIO| - handleSettingsSaveSucc - Fail",com.adobe.serialization.json.JSON.encode(param1));
               GLOBAL.Message(KEYS.Get("radio_recycleConfirm"),null,null,null);
            }
         };
         handleRemoveFail = function(param1:Object):void
         {
            _isSaving = false;
            GLOBAL.Message(KEYS.Get("radio_saveFail"),null,null,null);
         };
         var obj:Object = {};
         obj[RADIO.ATTACK_KEY] = 0;
         if(obj[RADIO.ATTACK_KEY] == 1)
         {
            QUESTS._global.email_att = 1;
         }
         obj[RADIO.NEWS_KEY] = 0;
         if(obj[RADIO.NEWS_KEY] == 1)
         {
            QUESTS._global.email_news = 1;
         }
         obj[RADIO.ADDRESS_KEY] = LOGIN._email;
         removeEmail("o1",obj);
      }
      
      public static function TwitterFollow() : *
      {
         GLOBAL.CallJS("openUrl",["http://twitter.com/#!/BackyardMonster"],true);
      }
      
      public static function TwitterBrag() : *
      {
         GLOBAL.CallJS("sendFeed",["build-radio","#fname#\'s Radio Tower is complete.","#fname# is following @BackyardMonster and is now receiving Attack Alerts.","build-radio.v2.png"]);
      }
      
      public static function Export() : Object
      {
         return _settings;
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
            _mc = new RADIOSETTINGSPOPUP();
            _mc.x = GLOBAL._SCREENCENTER.x;
            _mc.y = GLOBAL._SCREENCENTER.y;
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

