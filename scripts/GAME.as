package
{
   import com.adobe.serialization.json.JSON;
   import com.monsters.alliances.ALLIANCES;
   import com.monsters.radio.RADIO;
   import flash.display.*;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.system.Security;
   
   public class GAME extends Sprite
   {
      public static var _instance:GAME;
      
      public static var _contained:Boolean;
      
      public function GAME()
      {
         var _loc1_:Object = null;
         super();
         _instance = this;
         if(this.parent)
         {
            _loc1_ = {};
            if(GLOBAL._testKongregate)
            {
               _loc1_._baseURL = "http://bm-kg-web2.dev.casualcollective.com/base/";
               _loc1_._apiURL = "http://bm-kg-web2.dev.casualcollective.com/api/";
               _loc1_._gameURL = "";
               _loc1_._statsURL = "http://bm-kg-web2.dev.casualcollective.com/recordstats.php";
               _loc1_._storageURL = "assets/";
               _loc1_._soundPathURL = "assets/sounds/";
               _loc1_._mapURL = "http://bm-kg-web2.dev.casualcollective.com/worldmapv2/";
               _loc1_._allianceURL = "http://bmstage.fb.casualcollective.com/alliance/";
               _loc1_.fb_kongregate_api_path = "http://chat.kongregate.com/flash/API_AS3_46ebaf5ef297ce57605ca0a769f70b7d.swf";
               _loc1_._appid = "";
               _loc1_._tpid = "";
               _loc1_._countryCode = "us";
            }
            else
            {
               _loc1_._baseURL = "http://bmdev.fb.casualcollective.com/base/";
               _loc1_._apiURL = "http://bmdev.fb.casualcollective.com/api/";
               _loc1_._gameURL = "";
               _loc1_._statsURL = "http://bmdev.fb.casualcollective.com/recordstats.php";
               _loc1_._storageURL = "assets/";
               _loc1_._soundPathURL = "assets/sounds/";
               _loc1_._mapURL = "http://bmdev.fb.casualcollective.com/worldmapv2/";
               _loc1_._allianceURL = "http://bmdev.fb.casualcollective.com/alliance/";
               _loc1_._appid = "";
               _loc1_._tpid = "";
               _loc1_._countryCode = "us";
            }
            this.Data(_loc1_,false);
         }
      }
      
      public function Data(param1:Object, param2:Boolean = false) : void
      {
         var u:String;
         var obj:Object = param1;
         var contained:Boolean = param2;
         _contained = contained;
         GLOBAL._baseURL = obj._baseURL;
         GLOBAL._apiURL = obj._apiURL;
         GLOBAL._gameURL = obj._gameURL;
         GLOBAL._storageURL = obj._storageURL;
         GLOBAL._allianceURL = obj._allianceURL;
         GLOBAL._soundPathURL = obj._soundPathURL;
         GLOBAL._statsURL = obj._statsURL;
         GLOBAL._mapURL = obj._mapURL;
         GLOBAL._appid = obj.app_id;
         GLOBAL._tpid = obj.tpid;
         GLOBAL._countryCode = obj._countryCode;
         GLOBAL._softversion = obj.softversion;
         GLOBAL._fbdata = obj;
         GLOBAL._monetized = obj.monetized;
         GLOBAL._ROOT = new MovieClip();
         addChild(GLOBAL._ROOT);
         GLOBAL._layerMap = GLOBAL._ROOT.addChild(new MovieClip());
         GLOBAL._layerUI = GLOBAL._ROOT.addChild(new MovieClip());
         GLOBAL._layerWindows = GLOBAL._ROOT.addChild(new MovieClip());
         GLOBAL._layerMessages = GLOBAL._ROOT.addChild(new MovieClip());
         GLOBAL._layerTop = GLOBAL._ROOT.addChild(new MovieClip());
         if(obj.openbase)
         {
            GLOBAL._openBase = com.adobe.serialization.json.JSON.decode(obj.openbase);
         }
         else
         {
            GLOBAL._openBase = null;
         }
         addEventListener(Event.ENTER_FRAME,GLOBAL.TickFast);
         LOGIN.Login();
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.addEventListener(Event.RESIZE,UI2.ResizeHandler);
         stage.showDefaultContextMenu = false;
         u = GLOBAL._baseURL.split("/")[2];
         Security.allowDomain(u);
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("openbase",function(param1:String):*
            {
               var _loc2_:Object = null;
               if(BASE._saveCounterA == BASE._saveCounterB && !BASE._saving)
               {
                  BASE._isOutpost = 0;
                  GLOBAL._currentCell = null;
                  _loc2_ = com.adobe.serialization.json.JSON.decode(param1);
                  if(_loc2_.viewleader)
                  {
                     BASE.LoadBase(_loc2_.url,_loc2_.userid,_loc2_.baseid,"view",true);
                  }
                  else
                  {
                     BASE.LoadBase(_loc2_.url,_loc2_.userid,_loc2_.baseid,"help",true);
                  }
               }
            });
            ExternalInterface.addCallback("fbcBuyItem",function(param1:String):*
            {
               STORE.FacebookCreditPurchaseB(param1);
            });
            ExternalInterface.addCallback("callbackgift",function(param1:String):*
            {
               POPUPS.CallbackGift(param1);
            });
            ExternalInterface.addCallback("callbackshiny",function(param1:String):*
            {
               POPUPS.CallbackShiny(param1);
            });
            ExternalInterface.addCallback("twitteraccount",function(param1:String):*
            {
               RADIO.Callback(param1);
            });
            ExternalInterface.addCallback("updateCredits",function(param1:String):*
            {
               STORE.updateCredits(param1);
            });
            ExternalInterface.addCallback("fbcAdd",function(param1:String):*
            {
               BUY.FBCAdd(param1);
            });
            ExternalInterface.addCallback("fbcOfferDaily",function(param1:String):*
            {
               BUY.FBCOfferDaily(param1);
            });
            ExternalInterface.addCallback("fbcOfferEarn",function(param1:String):*
            {
               BUY.FBCOfferEarn(param1);
            });
            ExternalInterface.addCallback("purchaseReceive",function(param1:String):*
            {
               BUY.purchaseReceive(param1);
            });
            ExternalInterface.addCallback("purchaseComplete",function(param1:String):*
            {
               BUY.purchaseComplete(param1);
            });
            ExternalInterface.addCallback("receivePurchase",function(param1:String):*
            {
               BUY.purchaseReceive(param1);
            });
            ExternalInterface.addCallback("startPromoTimer",function(param1:String):*
            {
               BUY.startPromo(param1);
            });
            ExternalInterface.addCallback("alliancesShow",function(param1:String):*
            {
               ALLIANCES.AlliancesCallback(param1);
            });
            ExternalInterface.addCallback("alliancesUpdate",function(param1:String):*
            {
               ALLIANCES.AlliancesServerUpdate(param1);
            });
            ExternalInterface.addCallback("alliancesViewLeader",function(param1:String):*
            {
               ALLIANCES.AlliancesViewLeader(param1);
            });
            ExternalInterface.addCallback("openmap",function(param1:String):*
            {
               GLOBAL.ShowMap();
            });
         }
      }
   }
}

