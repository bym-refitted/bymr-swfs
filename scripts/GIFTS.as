package
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   
   public class GIFTS
   {
      public static var _mc:MovieClip;
      
      public static var _giftsAccepted:Array = [];
      
      public static var _sentGiftsAccepted:Array = [];
      
      public static var _sentInvitesAccepted:Array = [];
      
      public static var _maxXPReward:uint = 100000;
      
      public function GIFTS()
      {
         super();
      }
      
      public static function Process(param1:*) : *
      {
         var _loc2_:Array = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(TUTORIAL._stage >= 69)
         {
            for each(_loc2_ in param1)
            {
               if(Math.random() * 100 > 75)
               {
                  _loc3_ = 0.07 + Math.random() * 0.05;
               }
               else
               {
                  _loc3_ = 0.02 + Math.random() * 0.02;
               }
               _loc4_ = 1 + Math.random() * 4;
               _loc5_ = BASE._resources["r" + _loc4_ + "max"] * _loc3_;
               Show(_loc4_,_loc2_[0],_loc2_[1],_loc2_[2],_loc2_[3],_loc5_);
            }
         }
      }
      
      public static function ProcessAcceptedGifts(param1:*) : *
      {
         var _loc2_:Array = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(TUTORIAL._stage >= 69)
         {
            for each(_loc2_ in param1)
            {
               if(Math.random() * 100 > 75)
               {
                  _loc3_ = 0.07 + Math.random() * 0.05;
               }
               else
               {
                  _loc3_ = 0.02 + Math.random() * 0.02;
               }
               _loc4_ = 1 + Math.random() * 4;
               _loc5_ = BASE._resources["r" + _loc4_ + "max"] * _loc3_;
               ShowSentGift(_loc4_,_loc2_[0],_loc2_[1],_loc2_[2],_loc2_[3],_loc5_);
            }
         }
      }
      
      public static function ProcessAcceptedInvites(param1:Array) : *
      {
         var _loc2_:Array = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(TUTORIAL._stage >= 69)
         {
            for each(_loc2_ in param1)
            {
               if(Math.random() * 100 > 75)
               {
                  _loc3_ = 0.07 + Math.random() * 0.05;
               }
               else
               {
                  _loc3_ = 0.02 + Math.random() * 0.02;
               }
               _loc4_ = 1 + Math.random() * 4;
               _loc5_ = BASE._resources["r" + _loc4_ + "max"] * _loc3_;
               ShowSentInvite(_loc4_,_loc2_[0],_loc2_[1],_loc2_[2],_loc2_[3],_loc5_);
            }
         }
      }
      
      public static function Show(param1:int, param2:String, param3:String, param4:String, param5:String, param6:int) : *
      {
         var img:String;
         var LoadImageError:Function;
         var onImageLoaded:Function;
         var loader:Loader = null;
         var resourceID:int = param1;
         var giftID:String = param2;
         var giftFromName:String = param3;
         var giftFromID:String = param4;
         var profilePic:String = param5;
         var giftValue:int = param6;
         _mc = new popup_gift();
         _mc.gotoAndStop(resourceID);
         _mc.tA.htmlText = KEYS.Get("pop_gift_title",{"v1":giftFromName});
         _mc.tB.htmlText = "<b>" + GLOBAL.FormatNumber(giftValue) + " " + KEYS.Get(GLOBAL._resourceNames[resourceID - 1]) + "</b>";
         _mc.bReturn.SetupKey("pop_giftback_btn");
         _mc.bReturn.Highlight = true;
         _mc.bReturn.addEventListener(MouseEvent.CLICK,GIFTS.SendGift);
         _mc.bReturn.visible = true;
         _mc.bReturn.mouseEnabled = true;
         _mc.bThanks.SetupKey("pop_saythanks_btn");
         _mc.bThanks.Highlight = true;
         _mc.bThanks.addEventListener(MouseEvent.CLICK,GiveThanks(resourceID,giftFromID,giftValue));
         if(profilePic)
         {
            try
            {
               LoadImageError = function(param1:IOErrorEvent):*
               {
               };
               onImageLoaded = function(param1:Event):void
               {
                  loader.height = 50;
                  loader.width = 50;
               };
               loader = new Loader();
               loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,LoadImageError,false,0,true);
               loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onImageLoaded);
               _mc.mcPic.mcBG.addChild(loader);
               loader.load(new URLRequest(profilePic));
            }
            catch(e:Error)
            {
            }
         }
         img = "resourcetwigs.png";
         if(resourceID == 2)
         {
            img = "resourcepebbles.png";
         }
         if(resourceID == 3)
         {
            img = "resourceputty.png";
         }
         if(resourceID == 4)
         {
            img = "resourcegoo.png";
         }
         POPUPS.Push(_mc,GIFTS.Fund,[giftID,resourceID,giftValue],"",img,false,"gifts");
      }
      
      public static function ShowSentGift(param1:int, param2:String, param3:String, param4:String, param5:String, param6:int) : *
      {
         var img:String;
         var LoadImageError:Function;
         var onImageLoaded:Function;
         var loader:Loader = null;
         var resourceID:int = param1;
         var giftID:String = param2;
         var giftFromName:String = param3;
         var giftFromID:String = param4;
         var profilePic:String = param5;
         var giftValue:int = param6;
         var onePctNextLevelXP:int = 0;
         var lvlInfo:Object = BASE.BaseLevel();
         onePctNextLevelXP = lvlInfo.upper * 0.01;
         onePctNextLevelXP = onePctNextLevelXP > _maxXPReward ? int(_maxXPReward) : onePctNextLevelXP;
         _mc = new popup_gift();
         _mc.tA.htmlText = KEYS.Get("pop_sentgift_title",{"v1":giftFromName});
         _mc.tB.htmlText = "<b>" + GLOBAL.FormatNumber(onePctNextLevelXP) + " " + KEYS.Get("#r_points#") + "</b>";
         _mc.bReturn.SetupKey("btn_close");
         _mc.bReturn.Highlight = true;
         _mc.bReturn.visible = false;
         _mc.bReturn.mouseEnabled = false;
         _mc.bThanks.SetupKey("btn_close");
         _mc.bThanks.Highlight = true;
         _mc.bThanks.addEventListener(MouseEvent.CLICK,ClosePopup);
         if(profilePic)
         {
            try
            {
               LoadImageError = function(param1:IOErrorEvent):*
               {
               };
               onImageLoaded = function(param1:Event):void
               {
                  loader.height = 50;
                  loader.width = 50;
               };
               loader = new Loader();
               loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,LoadImageError,false,0,true);
               loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onImageLoaded);
               _mc.mcPic.mcBG.addChild(loader);
               loader.load(new URLRequest(profilePic));
            }
            catch(e:Error)
            {
            }
         }
         img = "fantastic.png";
         POPUPS.Push(_mc,GIFTS.AddXP,[giftID,giftValue],"",img,false,"gifts");
      }
      
      public static function ShowSentInvite(param1:int, param2:String, param3:String, param4:String, param5:String, param6:int) : *
      {
         var img:String;
         var LoadImageError:Function;
         var onImageLoaded:Function;
         var loader:Loader = null;
         var resourceID:int = param1;
         var giftID:String = param2;
         var giftFromName:String = param3;
         var giftFromID:String = param4;
         var profilePic:String = param5;
         var giftValue:int = param6;
         var onePctNextLevelXP:int = 0;
         var lvlInfo:Object = BASE.BaseLevel();
         onePctNextLevelXP = lvlInfo.upper * 0.01;
         onePctNextLevelXP = onePctNextLevelXP > _maxXPReward ? int(_maxXPReward) : onePctNextLevelXP;
         _mc = new popup_gift();
         _mc.tA.htmlText = KEYS.Get("pop_sentinvite_title",{"v1":giftFromName});
         _mc.tB.htmlText = "<b>" + GLOBAL.FormatNumber(onePctNextLevelXP) + " " + KEYS.Get("#r_points#") + "</b>";
         _mc.bReturn.SetupKey("pop_sentinvite_gift");
         _mc.bReturn.Highlight = true;
         _mc.bReturn.addEventListener(MouseEvent.CLICK,GIFTS.SendGift);
         _mc.bReturn.visible = true;
         _mc.bReturn.mouseEnabled = true;
         _mc.bThanks.SetupKey("pop_sentinvite_visit");
         _mc.bThanks.Highlight = true;
         _mc.bThanks.addEventListener(MouseEvent.CLICK,HelpFriend(giftFromID));
         if(profilePic)
         {
            try
            {
               LoadImageError = function(param1:IOErrorEvent):*
               {
               };
               onImageLoaded = function(param1:Event):void
               {
                  loader.height = 50;
                  loader.width = 50;
               };
               loader = new Loader();
               loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,LoadImageError,false,0,true);
               loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onImageLoaded);
               _mc.mcPic.mcBG.addChild(loader);
               loader.load(new URLRequest(profilePic));
            }
            catch(e:Error)
            {
            }
         }
         img = "fantastic.png";
         POPUPS.Push(_mc,GIFTS.AddXP,[giftID,giftValue],"",img,false,"gifts");
      }
      
      public static function Fund(param1:String, param2:int, param3:int) : *
      {
         _giftsAccepted.push(param1);
         BASE.Fund(param2,param3);
         BASE.Save();
         LOGGER.Stat([19,param2,param3,int(100 / BASE._resources["r" + param2 + "max"] * param3)]);
      }
      
      public static function AddXP(param1:String, param2:uint) : void
      {
         _sentGiftsAccepted.push(param1);
         ++QUESTS._global.gift_accept;
         QUESTS.Check();
         BASE.PointsAdd(param2);
         BASE.Save();
      }
      
      public static function HelpFriend(param1:String) : *
      {
         var giftFromID:String = param1;
         return function(param1:MouseEvent = null):*
         {
            POPUPS.Next();
            BASE.LoadBase(null,int(giftFromID),null,"help",false,BASE.MAIN_YARD);
         };
      }
      
      public static function GiveThanks(param1:int, param2:String, param3:int) : *
      {
         var resourceID:int = param1;
         var giftFromID:String = param2;
         var giftValue:int = param3;
         return function(param1:MouseEvent = null):*
         {
            GLOBAL.CallJS("sendFeed",["thanks",KEYS.Get("pop_givethanks_streamtitle"),KEYS.Get("pop_givethanks_streambody",{
               "v1":GLOBAL.FormatNumber(giftValue),
               "v2":KEYS.Get(GLOBAL._resourceNames[resourceID - 1])
            }),"gift" + resourceID + ".png",giftFromID]);
            POPUPS.Next();
         };
      }
      
      public static function SendGift(param1:MouseEvent) : *
      {
         GLOBAL.CallJS("cc.showFeedDialog",["gift","callbackgift"]);
         POPUPS.Next();
      }
      
      public static function ClosePopup(param1:MouseEvent) : *
      {
         POPUPS.Next(param1);
      }
   }
}

