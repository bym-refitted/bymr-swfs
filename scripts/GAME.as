package
{
   import com.adobe.serialization.json.JSON;
   import com.monsters.alliances.ALLIANCES;
   import com.monsters.radio.RADIO;
   import flash.display.*;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.geom.Rectangle;
   import flash.system.Security;
   
   public class GAME extends Sprite
   {
      public static var _instance:GAME;
      
      public static var _contained:Boolean;
      
      public static var _isSmallSize:Boolean = true;
      
      private var _checkScreenSize:Boolean = true;
      
      public function GAME()
      {
         var _loc1_:Object = null;
         super();
         _instance = this;
         if(this.parent)
         {
            _loc1_ = {};
            switch(GLOBAL._localMode)
            {
               case 1:
                  _loc1_._baseURL = "http://bym-fb-trunk.dev.kixeye.com/base/";
                  _loc1_._apiURL = "http://bym-fb-trunk.dev.kixeye.com/api/";
                  _loc1_.infbaseurl = _loc1_._apiURL + "bm/base/";
                  _loc1_._statsURL = "http://bym-fb-trunk.dev.kixeye.com/recordstats.php";
                  _loc1_._mapURL = "http://bym-fb-trunk.dev.kixeye.com/worldmapv2/";
                  _loc1_._allianceURL = "http://bym-fb-trunk.dev.kixeye.com/alliance/";
                  break;
               case 2:
                  _loc1_._baseURL = "http://bm-kg-web2.dev.casualcollective.com/base/";
                  _loc1_._apiURL = "http://bm-kg-web2.dev.casualcollective.com/api/";
                  _loc1_.infbaseurl = _loc1_._apiURL + "bm/base/";
                  _loc1_._statsURL = "http://bm-kg-web2.dev.casualcollective.com/recordstats.php";
                  _loc1_._mapURL = "http://bm-kg-web2.dev.casualcollective.com/worldmapv2/";
                  _loc1_._allianceURL = "http://bmstage.fb.casualcollective.com/alliance/";
                  _loc1_.fb_kongregate_api_path = "http://chat.kongregate.com/flash/API_AS3_46ebaf5ef297ce57605ca0a769f70b7d.swf";
                  break;
               case 3:
                  _loc1_._baseURL = "http://bmdev.vx.casualcollective.com/base/";
                  _loc1_._apiURL = "http://bmdev.vx.casualcollective.com/api/";
                  _loc1_.infbaseurl = _loc1_._apiURL + "bm/base/";
                  _loc1_._statsURL = "http://bmdev.vx.casualcollective.com/recordstats.php";
                  _loc1_._mapURL = "http://bmdev.vx.casualcollective.com/worldmapv2/";
                  _loc1_._allianceURL = "http://bmdev.vx.casualcollective.com/alliance/";
                  break;
               case 7:
                  _loc1_._baseURL = "http://bym-vx-web.stage.kixeye.com/base/";
                  _loc1_._apiURL = "http://bym-vx-web.stage.kixeye.com/api/";
                  _loc1_.infbaseurl = _loc1_._apiURL + "bm/base/";
                  _loc1_._statsURL = "http://bym-vx-web.stage.kixeye.com/recordstats.php";
                  _loc1_._mapURL = "http://bym-vx-web.stage.kixeye.com/worldmapv2/";
                  _loc1_._allianceURL = "http://bym-vx-web.stage.kixeye.com/alliance/";
                  break;
               case 4:
                  _loc1_._baseURL = "http://bym-vx2-vip.sjc.kixeye.com/base/";
                  _loc1_._apiURL = "http://bym-vx2-vip.sjc.kixeye.com/api/";
                  _loc1_.infbaseurl = _loc1_._apiURL + "bm/base/";
                  _loc1_._statsURL = "http://bym-vx2-vip.sjc.kixeye.com/recordstats.php";
                  _loc1_._mapURL = "http://bym-vx2-vip.sjc.kixeye.com/worldmapv2/";
                  _loc1_._allianceURL = "http://bym-vx2-vip.sjc.kixeye.com/alliance/";
                  break;
               case 5:
                  _loc1_._baseURL = "http://bym-fb-inferno.dev.kixeye.com/base/";
                  _loc1_._apiURL = "http://bym-fb-inferno.dev.kixeye.com/api/";
                  _loc1_.infbaseurl = null;
                  _loc1_._statsURL = "http://bym-fb-inferno.dev.kixeye.com/recordstats.php";
                  _loc1_._mapURL = "http://bym-fb-inferno.dev.kixeye.com/worldmapv2/";
                  _loc1_._allianceURL = "http://bym-fb-inferno.dev.kixeye.com/alliance/";
                  break;
               case 6:
                  _loc1_._baseURL = "https://bym-fb-lbns.dc.kixeye.com/base/";
                  _loc1_._apiURL = "https://bym-fb-lbns.dc.kixeye.com/api/";
                  _loc1_.infbaseurl = _loc1_._apiURL + "bm/base/";
                  _loc1_._statsURL = "https://bym-fb-lbns.dc.kixeye.com/recordstats.php";
                  _loc1_._mapURL = "https://bym-fb-lbns.dc.kixeye.com/worldmapv2/";
                  _loc1_._allianceURL = "https://bym-fb-lbns.dc.kixeye.com/alliance/";
                  break;
               case 8:
                  _loc1_._baseURL = "http://bym-fb-alex.dev.kixeye.com/base/";
                  _loc1_._apiURL = "http://bym-fb-alex.dev.kixeye.com/api/";
                  _loc1_.infbaseurl = _loc1_._apiURL + "bm/base/";
                  _loc1_._statsURL = "http://bym-fb-alex.dev.kixeye.com/recordstats.php";
                  _loc1_._mapURL = "http://bym-fb-alex.dev.kixeye.com/worldmapv2/";
                  _loc1_._allianceURL = "http://bym-fb-alex.dev.kixeye.com/alliance/";
                  break;
               case 9:
                  _loc1_._baseURL = "http://bym-fb-nmoore.dev.kixeye.com/base/";
                  _loc1_._apiURL = "http://bym-fb-nmoore.dev.kixeye.com/api/";
                  _loc1_.infbaseurl = _loc1_._apiURL + "bm/base/";
                  _loc1_._statsURL = "http://bym-fb-nmoore.dev.kixeye.com/recordstats.php";
                  _loc1_._mapURL = "http://bym-fb-nmoore.dev.kixeye.com/worldmapv2/";
                  _loc1_._allianceURL = "http://bym-fb-nmoore.dev.kixeye.com/alliance/";
                  break;
               default:
                  _loc1_._baseURL = "http://bym-fb-web1.stage.kixeye.com/base/";
                  _loc1_._apiURL = "http://bym-fb-web1.stage.kixeye.com/api/";
                  _loc1_.infbaseurl = _loc1_._apiURL + "bm/base/";
                  _loc1_._statsURL = "http://bym-fb-web1.stage.kixeye.com/recordstats.php";
                  _loc1_._mapURL = "http://bym-fb-web1.stage.kixeye.com/worldmapv2/";
                  _loc1_._allianceURL = "http://bym-fb-web1.stage.kixeye.com/alliance/";
            }
            _loc1_._gameURL = "";
            _loc1_._storageURL = "assets/";
            _loc1_._soundPathURL = "assets/sounds/";
            _loc1_._appid = "";
            _loc1_._tpid = "";
            _loc1_._countryCode = "us";
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
         GLOBAL._infBaseURL = obj.infbaseurl;
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
         GLOBAL.RefreshScreen();
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
         stage.addEventListener(Event.RESIZE,GLOBAL.ResizeGame);
         stage.showDefaultContextMenu = false;
         u = GLOBAL._baseURL.split("/")[2];
         Security.allowDomain(u);
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("openbase",function(param1:String):*
            {
               var _loc2_:Object = null;
               if(BASE._saveCounterA == BASE._saveCounterB && !BASE._saving && !BASE._loading)
               {
                  BASE._yardType = BASE.MAIN_YARD;
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
               RADIO.TwitterCallback(param1);
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
            ExternalInterface.addCallback("alliancesupdate",function(param1:String):*
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
         if(this._checkScreenSize)
         {
            GLOBAL._SCREENINIT = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
            if(_isSmallSize)
            {
               GLOBAL._SCREENINIT = new Rectangle(0,0,760,670);
            }
            else
            {
               GLOBAL._SCREENINIT = new Rectangle(0,0,760,750);
            }
         }
      }
   }
}

