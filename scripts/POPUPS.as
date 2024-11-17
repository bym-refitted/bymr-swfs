package
{
   import com.adobe.serialization.json.JSON;
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.StageDisplayState;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Timer;
   import gs.TweenLite;
   import gs.easing.Quad;
   
   public class POPUPS
   {
      private static var _popups:Object;
      
      private static var _mc:MovieClip;
      
      private static var _mcBG:MovieClip;
      
      private static var _lastGroup:String = "alerts";
      
      public static var _open:Boolean = false;
      
      public function POPUPS()
      {
         super();
      }
      
      public static function Setup() : *
      {
         _popups = {
            "now":[],
            "alerts":[],
            "gifts":[],
            "wait":[]
         };
         _open = false;
      }
      
      public static function Push(param1:*, param2:Function = null, param3:Array = null, param4:String = "", param5:String = "", param6:Boolean = false, param7:String = "now") : *
      {
         if(param5)
         {
            ImageCache.GetImageWithCallBack("popups/" + param5,null,true,0);
         }
         if(GLOBAL._catchup && param7 == "now" && !param6)
         {
            param7 = "alerts";
         }
         _popups[param7].push([param1,param2,param3,param4,param5]);
         if(param6)
         {
            Next();
         }
         else if(!_open)
         {
            Show();
         }
      }
      
      public static function Next(param1:MouseEvent = null) : *
      {
         if(GLOBAL._halt)
         {
            GLOBAL.CallJS("reloadPage");
         }
         if(!GLOBAL._catchup)
         {
            Hide();
         }
      }
      
      private static function Hide() : *
      {
         if(_mc)
         {
            HideB();
         }
         else
         {
            Show("now");
         }
      }
      
      private static function HideB() : *
      {
         _open = false;
         RemoveBG();
         if(Boolean(_mc) && Boolean(_mc.parent))
         {
            _mc.parent.removeChild(_mc);
         }
         _mc = null;
         if(_lastGroup == "alerts" || _lastGroup == "wait")
         {
            NextDelayed();
         }
         else
         {
            Show(_lastGroup);
         }
      }
      
      private static function NextDelayed(param1:int = 200) : *
      {
         var timer:Timer = null;
         var TimerDone:Function = null;
         var delay:int = param1;
         TimerDone = function(param1:TimerEvent):*
         {
            timer.stop();
            timer = null;
            Show(_lastGroup);
         };
         timer = new Timer(delay,1);
         timer.addEventListener(TimerEvent.TIMER,TimerDone);
         timer.start();
      }
      
      public static function Show(param1:String = "now") : *
      {
         var ImageLoaded:Function;
         var message:* = undefined;
         var group:String = param1;
         if(!GLOBAL._catchup)
         {
            _lastGroup = group;
            message = _popups[group].shift();
            if(message)
            {
               _open = true;
               AddBG();
               _mc = GLOBAL._layerTop.addChild(message[0]) as MovieClip;
               _mc.x = 380;
               _mc.y = 250;
               _mc.scaleX = _mc.scaleY = 0.9;
               TweenLite.to(_mc,0.2,{
                  "scaleX":1,
                  "scaleY":1,
                  "ease":Quad.easeOut
               });
               try
               {
                  if(_mc.bMessage)
                  {
                     _mc.bMessage.selectable = true;
                     _mc.bMessage.stage.focus = _mc.bMessage;
                     _mc.bMessage.setSelection(0,_mc.bMessage.text.length);
                  }
               }
               catch(e:Error)
               {
               }
               if(message[3])
               {
                  SOUNDS.Play(message[3]);
               }
               if(message[1])
               {
                  if(message[2])
                  {
                     if(message[2].length == 1)
                     {
                        message[1](message[2][0]);
                     }
                     if(message[2].length == 2)
                     {
                        message[1](message[2][0],message[2][1]);
                     }
                     if(message[2].length == 3)
                     {
                        message[1](message[2][0],message[2][1],message[2][2]);
                     }
                     if(message[2].length == 4)
                     {
                        message[1](message[2][0],message[2][1],message[2][2],message[2][3]);
                     }
                  }
                  else
                  {
                     message[1]();
                  }
               }
               if(message[4])
               {
                  ImageLoaded = function(param1:String, param2:BitmapData):*
                  {
                     var key:String = param1;
                     var bmd:BitmapData = param2;
                     try
                     {
                        if(Boolean(_mc) && Boolean(_mc.mcImage))
                        {
                           _mc.mcImage.addChild(new Bitmap(bmd));
                           _mc.mcImage.mouseEnabled = false;
                           _mc.mcImage.mouseChildren = false;
                           if(_mc.mcImageFrame)
                           {
                              _mc.mcImage.x = _mc.mcImageFrame.x + (_mc.mcImageFrame.width - _mc.mcImage.width) * 0.5;
                              _mc.mcImage.y = _mc.mcImageFrame.y + (_mc.mcImageFrame.height - _mc.mcImage.height) * 0.5;
                           }
                        }
                     }
                     catch(e:Error)
                     {
                     }
                  };
                  ImageCache.GetImageWithCallBack("popups/" + message[4],ImageLoaded,true,0);
               }
            }
            else if(_lastGroup == "now" && QueueCount("now") == 0 && QueueCount("wait") > 0)
            {
               _lastGroup = "wait";
               NextDelayed(50 * 60);
            }
         }
      }
      
      public static function QueueCount(param1:String = "now") : int
      {
         return _popups[param1].length;
      }
      
      public static function AddBG() : *
      {
         RemoveBG();
         _mcBG = GLOBAL._layerTop.addChild(new popup_bg());
         _mcBG.width = GLOBAL._ROOT.stage.stageWidth;
         _mcBG.height = GLOBAL._ROOT.stage.stageHeight;
         _mcBG.x = (760 - GLOBAL._ROOT.stage.stageWidth) / 2;
         _mcBG.y = (520 - GLOBAL._ROOT.stage.stageHeight) / 2;
      }
      
      public static function RemoveBG(param1:MovieClip = null) : *
      {
         if(Boolean(_mcBG) && Boolean(_mcBG.parent))
         {
            _mcBG.parent.removeChild(_mcBG);
         }
         _mcBG = null;
      }
      
      public static function Timeout() : *
      {
         var _loc1_:MovieClip = null;
         if(GLOBAL._ROOT.stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            GLOBAL._ROOT.stage.displayState = StageDisplayState.NORMAL;
         }
         _mcBG = GLOBAL._layerTop.addChild(new popup_bg2());
         _mcBG.width = GLOBAL._ROOT.stage.stageWidth;
         _mcBG.height = GLOBAL._ROOT.stage.stageHeight;
         _mcBG.x = (760 - GLOBAL._ROOT.stage.stageWidth) / 2;
         _mcBG.y = (520 - GLOBAL._ROOT.stage.stageHeight) / 2;
         _mcBG.cacheAsBitmap = true;
         _loc1_ = new popup_timeout();
         _loc1_.tA.htmlText = "<b>" + KEYS.Get("pop_timeout_title") + "</b>";
         _loc1_.tB.htmlText = KEYS.Get("pop_timeout_body");
         if(!GLOBAL._flags.kongregate)
         {
            if(GLOBAL._canGift)
            {
               _loc1_.bGift.SetupKey("btn_sendfreegifts");
               _loc1_.bGift.addEventListener(MouseEvent.CLICK,DisplayGiftSelect);
            }
            else
            {
               _loc1_.bGift.SetupKey("btn_invitefriendstoplay");
               _loc1_.bGift.addEventListener(MouseEvent.CLICK,DisplayInviteSelect);
            }
            _loc1_.bGift.Highlight = true;
         }
         else
         {
            _loc1_.bGift.visible = false;
         }
         _loc1_.x = 380;
         _loc1_.y = 250;
         GLOBAL._layerTop.addChild(_loc1_);
         GLOBAL._halt = true;
      }
      
      public static function AFK() : *
      {
         if(!GLOBAL._promptedAFK && TUTORIAL._stage > 200)
         {
            if(GLOBAL._canGift || Boolean(GLOBAL._flags.kongregate))
            {
               Gift(true);
            }
            else
            {
               Invite(true);
            }
         }
         GLOBAL._promptedAFK = true;
      }
      
      public static function Gift(param1:Boolean = false) : *
      {
         var SendGift:Function;
         var GetFriends:Function;
         var popupMC:* = undefined;
         var showingamepopup:Boolean = param1;
         if(GLOBAL._canGift || Boolean(GLOBAL._flags.kongregate))
         {
            if(showingamepopup)
            {
               SendGift = function(param1:MouseEvent):*
               {
                  POPUPS.Next(param1);
                  DisplayGiftSelect();
               };
               popupMC = new popup_afk_gift();
               popupMC.tA.htmlText = "<b>" + KEYS.Get("pop_afk_title") + "</b>";
               popupMC.tB.htmlText = KEYS.Get("pop_afk_body");
               if(GLOBAL._canGift)
               {
                  popupMC.bAction.SetupKey("btn_sendfreegifts");
                  popupMC.bAction.addEventListener(MouseEvent.CLICK,SendGift);
                  popupMC.bAction.Highlight = true;
               }
               else
               {
                  popupMC.bAction.visible = false;
               }
               POPUPS.Push(popupMC,null,null,"","resourcetwigs.png");
            }
            else
            {
               DisplayGiftSelect();
            }
         }
         else
         {
            GetFriends = function(param1:MouseEvent):*
            {
               POPUPS.Next(param1);
               Invite();
            };
            popupMC = new popup_invite_friends();
            if(GLOBAL._friendCount > 0)
            {
               popupMC.tA.htmlText = "<b>" + KEYS.Get("pop_invitefriends_title") + "</b>";
               popupMC.tB.htmlText = KEYS.Get("pop_invitefriends_body");
            }
            else
            {
               popupMC.tA.htmlText = "<b>" + KEYS.Get("pop_invitenofriends_title") + "</b>";
               popupMC.tB.htmlText = KEYS.Get("pop_invitenofriends_body");
            }
            popupMC.bAction.SetupKey("btn_invitefriends");
            popupMC.bAction.addEventListener(MouseEvent.CLICK,GetFriends);
            popupMC.bAction.Highlight = true;
            POPUPS.Push(popupMC);
         }
         GLOBAL.StatSet("pg",GLOBAL.Timestamp());
      }
      
      public static function Invite(param1:Boolean = false) : *
      {
         var GetFriends:Function;
         var popupMC:* = undefined;
         var showingamepopup:Boolean = param1;
         if(showingamepopup)
         {
            GetFriends = function(param1:MouseEvent):*
            {
               POPUPS.Next(param1);
               DisplayInviteSelect();
            };
            popupMC = new popup_invite_friends();
            popupMC.tA.htmlText = KEYS.Get("pop_invitefriends_title");
            popupMC.tB.htmlText = KEYS.Get("pop_invitefriends_body");
            popupMC.bAction.SetupKey("btn_invitefriends");
            popupMC.bAction.addEventListener(MouseEvent.CLICK,GetFriends);
            popupMC.bAction.Highlight = true;
            POPUPS.Push(popupMC);
         }
         else
         {
            DisplayInviteSelect();
         }
         GLOBAL.StatSet("pi",GLOBAL.Timestamp());
      }
      
      public static function Done() : Boolean
      {
         return _open == false;
      }
      
      public static function DisplaySR(param1:MouseEvent = null) : *
      {
         AddBG();
         GLOBAL.CallJS("cc.showSrOverlay",["callbackshiny"]);
         LOGGER.Stat([20,1]);
      }
      
      public static function DisplayGiftSelect(param1:MouseEvent = null) : *
      {
         AddBG();
         GLOBAL.CallJS("cc.showFeedDialog",["gift","callbackgift"]);
         LOGGER.Stat([20,1]);
      }
      
      public static function DisplayInviteSelect(param1:MouseEvent = null) : *
      {
         AddBG();
         GLOBAL.CallJS("cc.showFeedDialog",["invite","callbackgift"]);
         LOGGER.Stat([21,1]);
      }
      
      public static function DisplayWelcome(param1:MouseEvent = null) : *
      {
         var Share:Function;
         var popupMC:MovieClip = null;
         var e:MouseEvent = param1;
         if(GLOBAL._flags.fanfriendbookmarkquests)
         {
            Share = function():*
            {
               LOGGER.Stat([23,1]);
               GLOBAL.CallJS("sendFeed",["started-aggressive",KEYS.Get("pop_displaywelcome_streamtitle"),KEYS.Get("pop_displaywelcome_streambody"),"aggressive.png",0,null,"aggressive.v3.swf"]);
               Next();
            };
            LOGGER.Stat([23]);
            popupMC = new popup_welcome();
            popupMC.bAction.SetupKey("btn_share");
            popupMC.tA.htmlText = KEYS.Get("pop_displaywelcome_title");
            popupMC.tB.htmlText = KEYS.Get("pop_displaywelcome_body");
            popupMC.bAction.addEventListener(MouseEvent.CLICK,Share);
            popupMC.bAction.Highlight = true;
            POPUPS.Push(popupMC);
         }
      }
      
      public static function DisplayGetShiny(param1:MouseEvent = null) : *
      {
         var _loc2_:MovieClip = new popup_noshiny();
         _loc2_.tA.htmlText = "<b>" + KEYS.Get("pop_noshiny_title") + "</b>";
         _loc2_.tB.htmlText = KEYS.Get("pop_noshiny_body");
         _loc2_.bGet.SetupKey("str_getmore_btn");
         _loc2_.bGet.addEventListener(MouseEvent.CLICK,BUY.Show);
         _loc2_.bGet.Highlight = true;
         POPUPS.Push(_loc2_,null,null,"error1","aintgotnoshiny.png");
      }
      
      public static function DisplayWorker(param1:int, param2:*) : *
      {
         var getWorker:Function = null;
         var n:int = param1;
         var b:* = param2;
         getWorker = function(param1:MouseEvent):void
         {
            STORE.ShowB(1,0,["BEW"]);
            POPUPS.Next();
         };
         var DisplayWorkerNext:Function = function(param1:int, param2:*):*
         {
            var _loc4_:BFOUNDATION = null;
            var _loc3_:int = QUEUE.GetFinishCost();
            GLOBAL._selectedBuilding = QUEUE.GetBuilding();
            if(_loc3_ > BASE._credits.Get())
            {
               POPUPS.Next();
               POPUPS.DisplayGetShiny();
               return;
            }
            if(GLOBAL._selectedBuilding)
            {
               STORE._storeItems.SP4.c = [_loc3_];
               STORE.BuyB("SP4");
               POPUPS.Next();
            }
            if(param1 == 0)
            {
               BUILDINGS.Hide();
               BASE.addBuildingB(param2 as int);
            }
            else
            {
               _loc4_ = param2 as BFOUNDATION;
               if(param1 == 1 && Boolean(_loc4_))
               {
                  if(int(_loc4_._buildingProps.costs[_loc4_._lvl.Get()].time * GLOBAL._buildTime) > 60 * 60)
                  {
                     UPDATES.Create(["BU",_loc4_._id]);
                  }
                  BUILDINGOPTIONS.Hide();
                  _loc4_.UpgradeB();
                  BASE.Save();
               }
               else if(param1 == 2 && Boolean(_loc4_))
               {
                  BUILDINGINFO.Hide();
                  MUSHROOMS.PickWorker(_loc4_);
               }
            }
            POPUPS.Next();
         };
         var mc:MovieClip = new popup_noworker();
         if(BASE._isOutpost)
         {
            mc.tA.htmlText = "<b>Your Worker Is Busy</b>";
            mc.tB.htmlText = "Speed-up the worker\'s task for " + QUEUE.GetFinishCost() + " Shiny.";
            mc.bGet.SetupKey("btn_speedup");
            mc.bGet.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
            {
               DisplayWorkerNext(n,b);
            });
            mc.bGet.Highlight = true;
         }
         else
         {
            mc.tA.htmlText = "<b>" + KEYS.Get("pop_hireanother_title") + "</b>";
            if(QUEUE.GetBuilding())
            {
               mc.tB.htmlText = "Speed-up a worker\'s task for " + QUEUE.GetFinishCost() + " Shiny.";
               mc.bGet.SetupKey("btn_speedup");
               mc.bGet.addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):*
               {
                  DisplayWorkerNext(n,b);
               });
            }
            else
            {
               mc.bGet.SetupKey("btn_hireanother");
               mc.tB.htmlText = KEYS.Get("pop_hireanother_body");
               mc.bGet.addEventListener(MouseEvent.CLICK,getWorker);
            }
            mc.bGet.Highlight = true;
         }
         POPUPS.Push(mc,null,null,null,"helpinghand.png");
      }
      
      public static function DisplayPleaseBuy(param1:String) : *
      {
         var popupMC:popup_pleasebuy = null;
         var Action:Function = null;
         var key:String = param1;
         Action = function():*
         {
            popupMC.bAction.Enabled = false;
            popupMC.bAction.removeEventListener(MouseEvent.CLICK,Action);
            BUY.Show();
         };
         popupMC = new popup_pleasebuy();
         popupMC.bAction.SetupKey("str_getmore_btn");
         popupMC.bAction.addEventListener(MouseEvent.CLICK,Action);
         popupMC.tMessage.htmlText = KEYS.Get("pop_marketing_getshiny");
         POPUPS.Push(popupMC,null,null,null,"purchased.png");
      }
      
      public static function DisplayGeneric(param1:String, param2:String, param3:String, param4:String, param5:Function) : *
      {
         var _loc6_:popup_generic = new popup_generic();
         _loc6_.tA.autoSize = TextFieldAutoSize.LEFT;
         _loc6_.tB.autoSize = TextFieldAutoSize.LEFT;
         _loc6_.tA.htmlText = "<b>" + param1 + "</b>";
         _loc6_.tB.htmlText = param2;
         _loc6_.bAction.Setup(param3);
         _loc6_.bAction.addEventListener(MouseEvent.CLICK,param5);
         _loc6_.bAction.Highlight = true;
         _loc6_.tB.y = _loc6_.tA.y + _loc6_.tA.height + 5;
         _loc6_.mcBG.height = 0 - _loc6_.mcBG.y + _loc6_.tB.y + _loc6_.tB.height + 50;
         if(_loc6_.mcBG.height < 190)
         {
            _loc6_.mcBG.height = 190;
         }
         _loc6_.bAction.y = _loc6_.mcBG.y + _loc6_.mcBG.height - 45;
         (_loc6_.mcBG as frame2).Setup();
         POPUPS.Push(_loc6_,null,null,"",param4);
      }
      
      public static function DisplayRate() : *
      {
         var popupMCrate:popup_pleaserate = null;
         var ActionB:Function = null;
         var ActionC:Function = null;
         ActionB = function():*
         {
            popupMCrate.bAction.Enabled = false;
            popupMCrate.bAction.removeEventListener(MouseEvent.CLICK,ActionB);
            TweenLite.to(popupMCrate,1,{"onComplete":ActionC});
         };
         ActionC = function():*
         {
            GLOBAL.CallJS("cc.showRating");
         };
         popupMCrate = new popup_pleaserate();
         popupMCrate.tA.htmlText = KEYS.Get("pop_pleaserate");
         popupMCrate.bAction.SetupKey("pop_rategame_btn");
         popupMCrate.bAction.addEventListener(MouseEvent.CLICK,ActionB);
         POPUPS.Push(popupMCrate,null,null,null,"fivestarbob.png");
      }
      
      public static function CallbackGift(param1:String) : *
      {
         RemoveBG();
         if(GLOBAL._halt)
         {
            GLOBAL.CallJS("reloadPage");
         }
      }
      
      public static function CallbackShiny(param1:String) : *
      {
         var obj:Object = null;
         var o:String = param1;
         RemoveBG();
         Next();
         try
         {
            if(o)
            {
               obj = com.adobe.serialization.json.JSON.decode(o);
               BASE._credits.Set(int(obj.credits));
               BASE._hpCredits = int(obj.credits);
               GLOBAL._credits.Set(int(obj.credits));
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","POPUPS.CallbackShiny " + o + " | " + e.message);
         }
         if(GLOBAL._halt)
         {
            GLOBAL.CallJS("reloadPage");
         }
      }
   }
}
