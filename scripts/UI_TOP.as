package
{
   import com.monsters.dealspot.DealSpot;
   import com.monsters.kingOfTheHill.graphics.KOTHHUDGraphic;
   import com.monsters.maproom_inferno.views.DescentDebuffPopup;
   import com.monsters.siege.SiegeWeapons;
   import com.monsters.siege.weapons.SiegeWeapon;
   import com.monsters.subscriptions.SubscriptionHandler;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.text.TextFieldAutoSize;
   import gs.*;
   import gs.easing.*;
   
   public class UI_TOP extends UI_TOP_CLIP
   {
      public var _popup:*;
      
      public var _popupWarning:*;
      
      public var _popupBuff:*;
      
      public var _creatureButtons:Array;
      
      public var _creatureButtonsMC:*;
      
      public var _bubbleDo:DisplayObject;
      
      public var _catapult:CATAPULTPOPUP;
      
      public var _siegeweapon:SIEGEWEAPONPOPUP;
      
      public var _buttonIcons:Array;
      
      public var _descentDebuff:DescentDebuffPopup;
      
      public var extraResourceRows:int = 0;
      
      public var _dealspot:DealSpot;
      
      public var _resourceUI:Object;
      
      public var _resourceR1:int;
      
      public var _resourceR2:int;
      
      public var _resourceR3:int;
      
      public var _resourceR4:int;
      
      public var _kothIcon:DisplayObject;
      
      public var _daveClub:DisplayObject;
      
      private const _RESOURCEBAR_HEIGHT:int = 37;
      
      public function UI_TOP()
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:SiegeWeapon = null;
         var _loc7_:MovieClip = null;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:MovieClip = null;
         super();
         var _loc2_:String = GLOBAL._mode;
         switch(GLOBAL._mode)
         {
            case "build":
            case "ibuild":
               _loc2_ = "build";
               break;
            case "attack":
            case "iattack":
               _loc2_ = "attack";
               break;
            case "wmattack":
            case "iwmattack":
               _loc2_ = "wmattack";
               break;
            case "view":
            case "iview":
               _loc2_ = "view";
               break;
            case "help":
            case "ihelp":
               _loc2_ = "help";
               break;
            case "wmview":
            case "iwmview":
               _loc2_ = "wmview";
         }
         gotoAndStop(GLOBAL._loadmode);
         if(GLOBAL._loadmode == "build" || GLOBAL._loadmode == "ibuild")
         {
            mc.mcPoints.addEventListener(MouseEvent.MOUSE_OVER,this.InfoShow);
            mc.mcPoints.addEventListener(MouseEvent.MOUSE_OUT,this.InfoHide);
            _loc1_ = 1;
            while(_loc1_ < 5)
            {
               mc["mcR" + _loc1_].mcHit.addEventListener(MouseEvent.MOUSE_OVER,this.StatsShow(_loc1_,false));
               mc["mcR" + _loc1_].mcHit.addEventListener(MouseEvent.MOUSE_OUT,this.StatsHide);
               mc["mcR" + _loc1_].bAdd.addEventListener(MouseEvent.CLICK,this.Topup(_loc1_));
               mc["mcR" + _loc1_].bAdd.buttonMode = true;
               mc["mcR" + _loc1_].bAdd.mouseEnabled = true;
               mc["mcR" + _loc1_].bAdd.mouseChildren = false;
               _loc1_++;
            }
            this._resourceUI = {};
            this._resourceUI.r1 = BASE._resources["r1"].Get();
            this._resourceUI.r2 = BASE._resources["r2"].Get();
            this._resourceUI.r3 = BASE._resources["r3"].Get();
            this._resourceUI.r4 = BASE._resources["r4"].Get();
            mc["mcR1"]._resource = BASE._resources["r1"].Get();
            mc["mcR2"]._resource = BASE._resources["r2"].Get();
            mc["mcR3"]._resource = BASE._resources["r3"].Get();
            mc["mcR4"]._resource = BASE._resources["r4"].Get();
            mc.mcR5.bAdd.txtAdd.autoSize = TextFieldAutoSize.LEFT;
            mc.mcR5.bAdd.txtAdd.htmlText = KEYS.Get("ui_topaddshiny");
            mc.mcR5.bAdd.mcBG.width = mc.mcR5.bAdd.txtAdd.width + 11;
            mc.mcR5.mcBG.width = 82 + mc.mcR5.bAdd.width;
            mc.mcR5.bAdd.addEventListener(MouseEvent.CLICK,BUY.Show);
            mc.mcR5.bAdd.buttonMode = true;
            mc.mcR5.bAdd.mouseChildren = false;
            mc.mcOutposts.mcHit.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfoShow);
            mc.mcOutposts.mcHit.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonInfoHide);
            mc.mcOutposts.bNext.addEventListener(MouseEvent.CLICK,BASE.LoadNext);
            mc.mcOutposts.bNext.buttonMode = true;
            mc.mcOutposts.bNext.mouseEnabled = true;
            mc.mcOutposts.bNext.mouseChildren = false;
            mc.bInvite.buttonMode = true;
            mc.bInvite.mouseChildren = false;
            mc.bInvite.addEventListener(MouseEvent.CLICK,this.ButtonClick("invite"));
            mc.bInvite.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfoShow);
            mc.bInvite.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonInfoHide);
            mc.bGift.buttonMode = true;
            mc.bGift.mouseChildren = false;
            mc.bGift.addEventListener(MouseEvent.CLICK,this.ButtonClick("gift"));
            mc.bGift.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfoShow);
            mc.bGift.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonInfoHide);
            mc.bInbox.buttonMode = true;
            mc.bInbox.mouseChildren = false;
            mc.bInbox.addEventListener(MouseEvent.CLICK,this.ButtonClick("inbox"));
            mc.bInbox.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfoShow);
            mc.bInbox.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonInfoHide);
            mc.bAlert.buttonMode = true;
            mc.bAlert.mouseChildren = false;
            mc.bAlert.addEventListener(MouseEvent.CLICK,this.ButtonClick("alert"));
            mc.bAlert.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfoShow);
            mc.bAlert.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonInfoHide);
            this._buttonIcons = [];
            this._buttonIcons = [mc.bInvite,mc.bGift,mc.bInbox,mc.bAlert];
            mc.bEarn.bAction.tLabel.htmlText = KEYS.Get("btn_earn");
            if(GLOBAL._flags.showFBCEarn == 1)
            {
               mc.bEarn.buttonMode = true;
               mc.bEarn.mouseChildren = false;
               mc.bEarn.addEventListener(MouseEvent.CLICK,this.ButtonClick("earn"));
               mc.bEarn.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfoShow);
               mc.bEarn.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonInfoHide);
            }
            else
            {
               mc.bEarn.mouseChildren = false;
               mc.bEarn.mouseEnabled = false;
               mc.bEarn.visible = false;
            }
            mc.bDailyDeal.tLabel.htmlText = KEYS.Get("btn_dailydeal");
            if(GLOBAL._flags.showFBCDaily == 1)
            {
               mc.bDailyDeal.buttonMode = true;
               mc.bDailyDeal.mouseChildren = false;
               mc.bDailyDeal.addEventListener(MouseEvent.CLICK,this.ButtonClick("daily"));
               mc.bDailyDeal.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfoShow);
               mc.bDailyDeal.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonInfoHide);
               if(GLOBAL._flags.showFBCEarn == 0)
               {
                  mc.bDailyDeal.x = mc.bEarn.x;
               }
            }
            else
            {
               mc.bDailyDeal.mouseChildren = false;
               mc.bDailyDeal.mouseEnabled = false;
               mc.bDailyDeal.visible = false;
            }
         }
         else if(GLOBAL._loadmode == "attack" || GLOBAL._loadmode == "wmattack" || GLOBAL._loadmode == "iattack" || GLOBAL._loadmode == "iwmattack")
         {
            this._creatureButtonsMC = mc.addChild(new flingerLevel());
            this._creatureButtonsMC.tA.htmlText = BASE.isInferno() ? KEYS.Get("monster_limit") : KEYS.Get("attack_flingerbar");
            this._creatureButtonsMC.y = 84;
            _loc3_ = 0;
            this._creatureButtons = [];
            _loc4_ = 0;
            while(_loc4_ < GLOBAL._playerGuardianData.length)
            {
               if(Boolean(GLOBAL._playerGuardianData[_loc4_]) && GLOBAL._playerGuardianData[_loc4_].hp.Get() > 0)
               {
                  if(GLOBAL._loadmode == GLOBAL._mode || GLOBAL._loadmode != GLOBAL._mode && !MAPROOM_DESCENT.DescentPassed)
                  {
                     _loc7_ = this._creatureButtonsMC.addChild(new CHAMPIONBUTTON("G" + GLOBAL._playerGuardianData[_loc4_].t,GLOBAL._playerGuardianData[_loc4_].l.Get(),_loc4_));
                     _loc7_.y = 25 + 60 * _loc3_;
                     this._creatureButtons.push(_loc7_);
                     _loc3_++;
                  }
               }
               _loc4_++;
            }
            for(_loc5_ in CREATURELOCKER._creatures)
            {
               _loc8_ = int(_loc5_.substr(_loc5_.length - 1));
               if(GLOBAL._advancedMap && GLOBAL._attackerMapCreatures[_loc5_] || !GLOBAL._advancedMap && GLOBAL._attackerCreatures[_loc5_])
               {
                  _loc9_ = _loc5_;
                  if(GLOBAL._advancedMap)
                  {
                     if(GLOBAL._attackerMapCreatures[_loc9_].Get() > 0)
                     {
                        _loc10_ = this._creatureButtonsMC.addChild(new CREATUREBUTTON(_loc9_));
                        _loc10_.y = 25 + _loc3_ * 60;
                        if(_loc3_ > 5)
                        {
                           if(this.HasChampionButton())
                           {
                              _loc10_.y -= 300;
                           }
                           else
                           {
                              _loc10_.y -= 360;
                           }
                           _loc10_.x += 136;
                        }
                        this._creatureButtons.push(_loc10_);
                        _loc3_++;
                     }
                  }
                  else if(GLOBAL._attackerCreatures[_loc9_].Get() > 0)
                  {
                     _loc10_ = this._creatureButtonsMC.addChild(new CREATUREBUTTON(_loc9_));
                     _loc10_.y = 25 + _loc3_ * 60;
                     if(_loc3_ > 5)
                     {
                        if(this.HasChampionButton())
                        {
                           _loc10_.y -= 300;
                        }
                        else
                        {
                           _loc10_.y -= 360;
                        }
                        _loc10_.x += 136;
                     }
                     this._creatureButtons.push(_loc10_);
                     _loc3_++;
                  }
               }
            }
            if(GLOBAL._attackersCatapult > 0 && !BASE.isInferno())
            {
               this._catapult = new CATAPULTPOPUP();
               mc.addChild(this._catapult);
               this._catapult.x = 448;
               this._catapult.y = 4;
               this._catapult.Setup();
            }
            _loc6_ = SiegeWeapons.availableWeapon;
            if(_loc6_ != null && !BASE.isInferno())
            {
               this._siegeweapon = new SIEGEWEAPONPOPUP();
               mc.addChild(this._siegeweapon);
               this._siegeweapon.x = 632;
               this._siegeweapon.y = 4;
               this._siegeweapon.Setup();
            }
         }
         else
         {
            this.DescentDebuffHide();
         }
         this.Update();
      }
      
      private function InfoShow(param1:MouseEvent) : *
      {
         mc.mcPoints.gotoAndStop(2);
         var _loc2_:Object = BASE.BaseLevel();
         mc.mcPoints.tInfo.htmlText = KEYS.Get("pop_experiencebar",{
            "v1":GLOBAL.FormatNumber(_loc2_.points),
            "v2":GLOBAL.FormatNumber(_loc2_.needed),
            "v3":_loc2_.level + 1
         });
      }
      
      private function InfoHide(param1:MouseEvent) : *
      {
         mc.mcPoints.gotoAndStop(1);
      }
      
      private function HasChampionButton() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._creatureButtons.length)
         {
            if(this._creatureButtons[_loc1_] is CHAMPIONBUTTON)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         if(GLOBAL._mode == "build")
         {
            if(mc.mcPoints)
            {
               mc.mcPoints.removeEventListener(MouseEvent.MOUSE_OVER,this.InfoShow);
               mc.mcPoints.removeEventListener(MouseEvent.MOUSE_OUT,this.InfoHide);
            }
            _loc1_ = 1;
            while(_loc1_ < 5)
            {
               if(mc["mcR" + _loc1_])
               {
                  if(mc["mcR" + _loc1_].mcHit)
                  {
                     mc["mcR" + _loc1_].mcHit.removeEventListener(MouseEvent.MOUSE_OVER,this.StatsShow(_loc1_,false));
                     mc["mcR" + _loc1_].mcHit.removeEventListener(MouseEvent.MOUSE_OUT,this.StatsHide);
                  }
                  if(mc["mcR" + _loc1_].bAdd)
                  {
                     mc["mcR" + _loc1_].bAdd.removeEventListener(MouseEvent.CLICK,this.Topup(_loc1_));
                  }
               }
               _loc1_++;
            }
            if(Boolean(mc.mcR5) && Boolean(mc.mcR5.bAdd))
            {
               mc.mcR5.bAdd.removeEventListener(MouseEvent.CLICK,BUY.Show);
            }
            if(Boolean(mc.mcOutposts) && Boolean(mc.mcOutposts.mcHit) && Boolean(mc.mcOutposts.bNext))
            {
               mc.mcOutposts.mcHit.removeEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfoShow);
               mc.mcOutposts.mcHit.removeEventListener(MouseEvent.MOUSE_OUT,this.ButtonInfoHide);
               mc.mcOutposts.bNext.removeEventListener(MouseEvent.CLICK,BASE.LoadNext);
            }
            if(mc.bInvite)
            {
               mc.bInvite.removeEventListener(MouseEvent.CLICK,this.ButtonClick("invite"));
               mc.bInvite.removeEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfoShow);
               mc.bInvite.removeEventListener(MouseEvent.MOUSE_OUT,this.ButtonInfoHide);
            }
            if(mc.bGift)
            {
               mc.bGift.removeEventListener(MouseEvent.CLICK,this.ButtonClick("gift"));
               mc.bGift.removeEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfoShow);
               mc.bGift.removeEventListener(MouseEvent.MOUSE_OUT,this.ButtonInfoHide);
            }
            if(mc.bInbox)
            {
               mc.bInbox.removeEventListener(MouseEvent.CLICK,this.ButtonClick("inbox"));
               mc.bInbox.removeEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfoShow);
               mc.bInbox.removeEventListener(MouseEvent.MOUSE_OUT,this.ButtonInfoHide);
            }
            if(mc.bAlert)
            {
               mc.bAlert.removeEventListener(MouseEvent.CLICK,this.ButtonClick("alert"));
               mc.bAlert.removeEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfoShow);
               mc.bAlert.removeEventListener(MouseEvent.MOUSE_OUT,this.ButtonInfoHide);
            }
            if(mc.bEarn)
            {
               mc.bEarn.removeEventListener(MouseEvent.CLICK,this.ButtonClick("earn"));
               mc.bEarn.removeEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfoShow);
               mc.bEarn.removeEventListener(MouseEvent.MOUSE_OUT,this.ButtonInfoHide);
            }
            if(Boolean(mc.bDailyDeal) && GLOBAL._flags.showFBCDaily == 1)
            {
               mc.bDailyDeal.removeEventListener(MouseEvent.CLICK,this.ButtonClick("daily"));
               mc.bDailyDeal.removeEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfoShow);
               mc.bDailyDeal.removeEventListener(MouseEvent.MOUSE_OUT,this.ButtonInfoHide);
            }
         }
      }
      
      public function ClearSiegeWeapon() : void
      {
         if(Boolean(this._siegeweapon) && Boolean(this._siegeweapon.parent))
         {
            this._siegeweapon.parent.removeChild(this._siegeweapon);
            this._siegeweapon = null;
         }
      }
      
      public function Topup(param1:int) : *
      {
         var n:int = param1;
         return function(param1:MouseEvent = null):*
         {
            var _loc2_:* = Math.min((n - 1) * 0.4,1);
            if(BASE.isInferno())
            {
               STORE.ShowB(2,_loc2_,["BR" + n + "1I","BR" + n + "2I","BR" + n + "3I"]);
            }
            else
            {
               STORE.ShowB(2,_loc2_,["BR" + n + "1","BR" + n + "2","BR" + n + "3"]);
            }
         };
      }
      
      public function Setup() : *
      {
         var onImageLoad:Function;
         var LoadImageError:Function;
         var loader:Loader = null;
         if(GLOBAL._mode != "build" && GLOBAL._mode != "ibuild")
         {
            if(BASE._ownerName)
            {
               if(BASE._ownerName.toLowerCase().charAt(BASE._ownerName.length - 1) == "s")
               {
                  mc.mcPoints.tName.htmlText = KEYS.Get("uitop_yardownershort",{"v1":BASE._ownerName.toUpperCase()});
               }
               else
               {
                  mc.mcPoints.tName.htmlText = KEYS.Get("uitop_yardownerlong",{"v1":BASE._ownerName.toUpperCase()});
               }
            }
            else if(GLOBAL._mode == GLOBAL._loadmode)
            {
               mc.mcPoints.tName.htmlText = KEYS.Get("uitop_backyardmonsters");
            }
            else
            {
               mc.mcPoints.tName.htmlText = KEYS.Get("uitop_backyardmonstersinferno");
            }
            try
            {
               onImageLoad = function(param1:Event):void
               {
                  mc.mcPic.mcBG.addChild(loader);
                  if(Boolean(GLOBAL._flags.viximo) || Boolean(GLOBAL._flags.kongregate))
                  {
                     loader.height = 50;
                     loader.width = 50;
                  }
               };
               LoadImageError = function(param1:IOErrorEvent):*
               {
               };
               loader = new Loader();
               loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,LoadImageError,false,0,true);
               loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onImageLoad);
               if(GLOBAL._loadmode == "wmattack" || GLOBAL._loadmode == "wmview" || GLOBAL._loadmode == "iwmattack" || GLOBAL._loadmode == "iwmview")
               {
                  loader.load(new URLRequest(GLOBAL._storageURL + BASE._ownerPic));
               }
               else if(Boolean(GLOBAL._flags.viximo) || Boolean(GLOBAL._flags.kongregate))
               {
                  loader.load(new URLRequest(BASE._ownerPic));
               }
               else
               {
                  loader.load(new URLRequest("http://graph.facebook.com/" + BASE._loadedFBID + "/picture"));
               }
            }
            catch(e:Error)
            {
            }
         }
         else if(GLOBAL._mode == GLOBAL._loadmode)
         {
            mc.mcPoints.tName.htmlText = KEYS.Get("uitop_backyardmonsters");
         }
         else
         {
            mc.mcPoints.tName.htmlText = KEYS.Get("uitop_backyardmonstersinferno");
         }
         if((GLOBAL._loadmode == "iwmattack" || GLOBAL._loadmode == "iattack") && !MAPROOM_DESCENT.DescentPassed)
         {
            if(BASE.isInferno() && !MAPROOM_DESCENT.DescentPassed)
            {
               this.DescentDebuffShow();
            }
            else
            {
               this.DescentDebuffHide();
            }
         }
      }
      
      public function addIcon(param1:DisplayObject) : void
      {
         if(Boolean(mc) && GLOBAL._mode == "build")
         {
            param1.x = 222;
            param1.y = 0;
            this._kothIcon = mc.addChild(param1);
            mc.mcR5.x = 284;
            mc.bEarn.x = 415;
            mc.bDealSpot.x = 502;
            mc.bDailyDeal.x = 493;
         }
      }
      
      public function removeIcon(param1:DisplayObject) : void
      {
         if(Boolean(mc) && mc.contains(param1))
         {
            mc.removeChild(param1);
            if(GLOBAL._mode == "build")
            {
               mc.mcR5.x = 227;
               mc.bEarn.x = 358;
               mc.bDailyDeal = 436;
               mc.bDealSpot = 445;
            }
         }
         if(this._kothIcon)
         {
            if(this._kothIcon.parent)
            {
               this._kothIcon.parent.removeChild(this._kothIcon);
            }
            this._kothIcon = null;
         }
      }
      
      public function addResourceBar(param1:DisplayObject) : void
      {
         var _loc2_:MovieClip = null;
         if(Boolean(mc) && GLOBAL._mode == "build")
         {
            if(GLOBAL._advancedMap)
            {
               _loc2_ = mc.mcOutposts;
            }
            else
            {
               _loc2_ = mc.mcR4;
            }
            param1.x = -4;
            param1.y = _loc2_.y + 37;
            this._daveClub = mc.addChild(param1);
            ++this.extraResourceRows;
            this.Update();
         }
      }
      
      public function removeResourceBar(param1:DisplayObject) : void
      {
         if(Boolean(mc) && mc.contains(param1))
         {
            mc.removeChild(param1);
            if(this.extraResourceRows > 0)
            {
               --this.extraResourceRows;
            }
         }
         if(this._daveClub)
         {
            if(this._daveClub.parent)
            {
               this._daveClub.parent.removeChild(this._daveClub);
            }
            this._daveClub = null;
         }
         this.Update();
      }
      
      public function BombSelect(param1:int) : *
      {
         var n:int = param1;
         return function(param1:MouseEvent = null):*
         {
            MonsterDeselect();
            BombDeselect();
         };
      }
      
      public function BombDeselect() : *
      {
      }
      
      public function MonsterDeselect() : *
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         for(_loc1_ in ATTACK._flingerBucket)
         {
            if(Boolean(ATTACK._flingerBucket[_loc1_]) && ATTACK._flingerBucket[_loc1_].Get() > 0)
            {
               if(GLOBAL._advancedMap)
               {
                  GLOBAL._attackerMapCreatures[_loc1_].Add(ATTACK._flingerBucket[_loc1_].Get());
               }
               else
               {
                  GLOBAL._attackerCreatures[_loc1_].Add(ATTACK._flingerBucket[_loc1_].Get());
               }
               ATTACK._flingerBucket[_loc1_].Set(0);
            }
         }
         ATTACK.BucketUpdate();
         _loc2_ = 0;
         while(_loc2_ < this._creatureButtons.length)
         {
            this._creatureButtons[_loc2_].Update();
            _loc2_++;
         }
      }
      
      public function StatsShow(param1:int, param2:Boolean) : *
      {
         var n:int = param1;
         var topup:Boolean = param2;
         return function(param1:MouseEvent):*
         {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if(n < 5)
            {
               if(topup)
               {
                  _loc2_ = "<b><font size=\"12\">" + KEYS.Get(GLOBAL._resourceNames[n - 1]) + "</font></b><br><b>" + KEYS.Get("bubble_topup") + "</b>";
                  _loc3_ = 2;
               }
               else if(GLOBAL._advancedMap)
               {
                  _loc2_ = KEYS.Get("pop_resource2",{
                     "v1":KEYS.Get(GLOBAL._resourceNames[n - 1]),
                     "v2":GLOBAL.FormatNumber(BASE._resources["r" + n + "max"]),
                     "v3":GLOBAL.FormatNumber(BASE._resources["r" + n + "Rate"]),
                     "v4":GLOBAL.FormatNumber(BASE.getEmpireResources(n))
                  });
                  _loc3_ = 4;
               }
               else
               {
                  _loc2_ = "<b><font size=\"12\">" + KEYS.Get(GLOBAL._resourceNames[n - 1]) + "</font></b><br>" + KEYS.Get("pop_resource",{
                     "v1":GLOBAL.FormatNumber(BASE._resources["r" + n + "max"]),
                     "v2":GLOBAL.FormatNumber(BASE._resources["r" + n + "Rate"])
                  });
                  _loc3_ = 3;
               }
            }
            else
            {
               _loc2_ = "<b>" + KEYS.Get("bubble_getshiny") + "</b>";
               _loc3_ = 2;
            }
            var _loc4_:* = mc["mcR" + n];
            BubbleShow(_loc4_.x + 135,_loc4_.y + int(_loc4_.height * 0.5),_loc2_,_loc3_);
         };
      }
      
      public function StatsHide(param1:MouseEvent) : *
      {
         this.BubbleHide();
      }
      
      public function OverchargeShow(param1:int) : void
      {
         if(!this._popupWarning)
         {
            this._popupWarning = addChild(new bubblepopup4());
         }
         this._popupWarning.tA.htmlText = BASE.isInferno() ? KEYS.Get("inf_ui_needmoreroom") : KEYS.Get("ui_needmoreroom");
         this._popupWarning.x = 150;
         this._popupWarning.y = 20 + 41 * param1;
         this._popupWarning.Wobble();
      }
      
      public function OverchargeHide() : *
      {
         if(this._popupWarning)
         {
            removeChild(this._popupWarning);
            this._popupWarning = null;
         }
      }
      
      public function UpdateTweenResourceText(param1:Number) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc2_:int = param1;
         _loc4_ = mc["mcR" + _loc2_];
         _loc5_ = Number(_loc4_._resource);
         _loc4_.tR.htmlText = "<b>" + GLOBAL.FormatNumber(_loc5_) + "</b>";
         _loc3_ = 90 / BASE._resources["r" + _loc2_ + "max"] * _loc5_;
         if(_loc3_ > 90)
         {
            _loc3_ = 90;
         }
         _loc4_.mcBar.width = _loc3_;
      }
      
      public function Update() : *
      {
         var _loc1_:int = 0;
         var _loc2_:* = undefined;
         var _loc3_:Object = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Boolean = false;
         var _loc11_:int = 0;
         var _loc12_:Boolean = false;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:String = null;
         if(!GLOBAL._catchup)
         {
            if(GLOBAL._loadmode == "build" || GLOBAL._loadmode == "ibuild")
            {
               _loc4_ = Number(BASE._resources["r1"].Get());
               _loc5_ = Number(BASE._resources["r2"].Get());
               _loc6_ = Number(BASE._resources["r3"].Get());
               _loc7_ = Number(BASE._resources["r4"].Get());
               TweenLite.to(mc.mcR1,0.5,{
                  "_resource":_loc4_,
                  "onUpdate":this.UpdateTweenResourceText,
                  "onUpdateParams":[1],
                  "ease":Linear.easeNone,
                  "overwrite":1
               });
               TweenLite.to(mc.mcR2,0.5,{
                  "_resource":_loc5_,
                  "onUpdate":this.UpdateTweenResourceText,
                  "onUpdateParams":[2],
                  "ease":Linear.easeNone,
                  "overwrite":1
               });
               TweenLite.to(mc.mcR3,0.5,{
                  "_resource":_loc6_,
                  "onUpdate":this.UpdateTweenResourceText,
                  "onUpdateParams":[3],
                  "ease":Linear.easeNone,
                  "overwrite":1
               });
               TweenLite.to(mc.mcR4,0.5,{
                  "_resource":_loc7_,
                  "onUpdate":this.UpdateTweenResourceText,
                  "onUpdateParams":[4],
                  "ease":Linear.easeNone,
                  "overwrite":1
               });
               mc["mcR5"].tR.htmlText = "<b>" + GLOBAL.FormatNumber(BASE._credits.Get()) + "</b>";
               if(GLOBAL._advancedMap)
               {
                  mc.mcOutposts.visible = true;
                  mc.mcOutposts.tR.htmlText = GLOBAL._mapOutpost.length;
               }
               else
               {
                  mc.mcOutposts.visible = false;
               }
               if(TUTORIAL._stage < 200)
               {
                  mc.bInvite.visible = false;
                  mc.bGift.visible = false;
                  mc.bInbox.visible = false;
                  mc.bAlert.visible = false;
                  mc.mcR5.bAdd.visible = false;
                  mc.bEarn.visible = false;
                  mc.bDailyDeal.visible = false;
                  _loc1_ = 1;
                  while(_loc1_ < 6)
                  {
                     mc["mcR" + _loc1_].bAdd.visible = false;
                     _loc1_++;
                  }
                  this.SortButtonIcons();
               }
               else
               {
                  if(GLOBAL._flags.sroverlay)
                  {
                     mc.mcR5.bAdd.visible = true;
                  }
                  else
                  {
                     mc.mcR5.bAdd.visible = true;
                  }
                  mc.bEarn.visible = GLOBAL._flags.showFBCEarn == 1;
                  mc.bDailyDeal.visible = GLOBAL._flags.showFBCDaily == 1;
                  _loc1_ = 1;
                  while(_loc1_ < 6)
                  {
                     if(!mc["mcR" + _loc1_].bAdd.visible)
                     {
                        mc["mcR" + _loc1_].bAdd.visible = true;
                     }
                     _loc1_++;
                  }
                  _loc8_ = 0;
                  if(GLOBAL._canInvite && !GLOBAL._flags.kongregate)
                  {
                     if(GLOBAL._sessionCount >= 2 && !GLOBAL._canGift && GLOBAL.Timestamp() - GLOBAL.StatGet("pi") > 129600)
                     {
                        mc.bInvite.mcSpinner.visible = true;
                     }
                     else
                     {
                        mc.bInvite.mcSpinner.visible = false;
                     }
                     mc.bInvite.visible = true;
                  }
                  else
                  {
                     mc.bInvite.visible = false;
                  }
                  _loc9_ = this.extraResourceRows * this._RESOURCEBAR_HEIGHT;
                  this.SortButtonIcons(2,4,_loc9_);
                  mc.bGift.visible = true;
                  _loc8_ = POPUPS.QueueCount("gifts");
                  if(_loc8_ > 0)
                  {
                     mc.bGift.mcSpinner.visible = true;
                     mc.bGift.mcCounter.visible = true;
                     if(_loc8_ < 10)
                     {
                        mc.bGift.mcCounter.t.htmlText = "<b>" + _loc8_ + "</b>";
                     }
                     else
                     {
                        mc.bGift.mcCounter.t.htmlText = "<b>+</b>";
                     }
                  }
                  else
                  {
                     mc.bGift.mcSpinner.visible = false;
                     mc.bGift.mcCounter.visible = false;
                  }
                  mc.bInbox.visible = true;
                  if(GLOBAL._unreadMessages > 0)
                  {
                     mc.bInbox.mcCounter.t.htmlText = "<b>" + GLOBAL._unreadMessages + "</b>";
                     mc.bInbox.mcCounter.visible = true;
                     mc.bInbox.mcSpinner.visible = true;
                  }
                  else
                  {
                     mc.bInbox.mcCounter.visible = false;
                     mc.bInbox.mcSpinner.visible = false;
                  }
                  _loc8_ = POPUPS.QueueCount("alerts");
                  if(_loc8_ > 0)
                  {
                     mc.bAlert.visible = true;
                     mc.bAlert.mcSpinner.visible = true;
                     mc.bAlert.mcCounter.visible = true;
                     if(_loc8_ < 10)
                     {
                        mc.bAlert.mcCounter.t.htmlText = "<b>" + _loc8_ + "</b>";
                     }
                     else
                     {
                        mc.bAlert.mcCounter.t.htmlText = "<b>+</b>";
                     }
                  }
                  else
                  {
                     mc.bAlert.visible = false;
                  }
                  this.DisplayBuffs();
                  if(this._kothIcon)
                  {
                     _loc10_ = Boolean(CREATURES._krallen);
                     _loc11_ = 0;
                     if(_loc10_)
                     {
                        _loc11_ = CREATURES._krallen._level.Get();
                     }
                     (this._kothIcon as KOTHHUDGraphic).update(_loc10_,_loc11_);
                  }
                  if(this._daveClub)
                  {
                     _loc12_ = SubscriptionHandler.instance.isSubscriptionActive;
                     (this._daveClub as MovieClip).gotoAndStop(_loc12_ ? "on" : "off");
                  }
               }
            }
            else if(GLOBAL._loadmode == "attack" || GLOBAL._loadmode == "wmattack" || GLOBAL._loadmode == "iattack" || GLOBAL._loadmode == "iwmattack")
            {
               _loc1_ = 1;
               while(_loc1_ < 5)
               {
                  _loc2_ = mc["mcR" + _loc1_];
                  _loc2_.tR.htmlText = "<b>" + GLOBAL.FormatNumber(ATTACK._loot["r" + _loc1_].Get()) + "</b>";
                  _loc2_.mcBar.visible = false;
                  _loc1_++;
               }
               _loc1_ = 0;
               while(_loc1_ < this._creatureButtons.length)
               {
                  this._creatureButtons[_loc1_].Update();
                  _loc1_++;
               }
               _loc13_ = int(GLOBAL._buildingProps[4].capacity[GLOBAL._attackersFlinger - 1]);
               if(MAPROOM_DESCENT.InDescent)
               {
                  _loc13_ = int(YARD_PROPS._yardProps[4].capacity[GLOBAL._attackersFlinger - 1]);
               }
               if(POWERUPS.CheckPowers(POWERUPS.ALLIANCE_DECLAREWAR,"OFFENSE"))
               {
                  _loc13_ += _loc13_ * 0.25;
               }
               _loc14_ = _loc13_;
               for(_loc15_ in ATTACK._flingerBucket)
               {
                  if(_loc15_.substr(0,1) == "G")
                  {
                     _loc14_ -= CHAMPIONCAGE.GetGuardianProperty(_loc15_.substr(0,2),1,"bucket");
                  }
                  else
                  {
                     _loc14_ -= CREATURES.GetProperty(_loc15_,"bucket") * ATTACK._flingerBucket[_loc15_].Get();
                  }
               }
               this._creatureButtonsMC.mcBar.width = 115 - 115 / _loc13_ * _loc14_;
               if(GLOBAL._mode != GLOBAL._loadmode)
               {
                  if(ATTACK._countdown > 0)
                  {
                     mc.tMessage.htmlText = KEYS.Get("attack_ui_attacklock");
                  }
                  else
                  {
                     mc.tMessage.htmlText = KEYS.Get("attack_ui_attackends");
                  }
               }
               else if(ATTACK._countdown > 0)
               {
                  mc.tMessage.htmlText = KEYS.Get("attack_ui_flingerlock");
               }
               else
               {
                  mc.tMessage.htmlText = KEYS.Get("attack_ui_attackends");
               }
               if(ATTACK._countdown > 30)
               {
                  mc.tTime.htmlText = GLOBAL.ToTime(ATTACK._countdown,true);
               }
               else if(ATTACK._countdown > 0)
               {
                  mc.tTime.htmlText = "<font color=\"#FF0000\">" + GLOBAL.ToTime(ATTACK._countdown,true) + "</font>";
               }
               else if(ATTACK._countdown > -120)
               {
                  mc.tTime.htmlText = "<font color=\"#FFFFFF\">" + GLOBAL.ToTime(2 * 60 + ATTACK._countdown,true) + "</font>";
               }
               else
               {
                  mc.tTime.htmlText = "<font color=\"#FFFFFF\">" + KEYS.Get("attack_ui_over") + "</font>";
               }
            }
            _loc3_ = BASE.BaseLevel();
            this.SetPoints(_loc3_.lower,_loc3_.upper,_loc3_.needed,_loc3_.points,_loc3_.level,false);
         }
      }
      
      public function SortButtonIcons(param1:int = 2, param2:int = 4, param3:int = 0) : void
      {
         var _loc6_:* = param1;
         var _loc7_:* = param2;
         var _loc10_:int = param3;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         if(GLOBAL._advancedMap)
         {
            _loc10_ += 35;
         }
         var _loc14_:int = 0;
         while(_loc14_ < this._buttonIcons.length)
         {
            if(this._buttonIcons[_loc14_].visible)
            {
               this._buttonIcons[_loc14_].x = 9 + _loc11_;
               this._buttonIcons[_loc14_].y = 195 + _loc10_;
               _loc13_++;
               _loc10_ += 55;
               if(_loc13_ >= _loc7_)
               {
                  _loc13_ = 0;
                  _loc12_++;
                  _loc10_ = 0;
                  _loc11_ += 67;
               }
            }
            _loc14_++;
         }
      }
      
      public function InitDealspot() : *
      {
         if(mc.bDealSpot)
         {
            mc.bDealSpot.visible = true;
            mc.bDealSpot.buttonMode = true;
            mc.bDealSpot.mouseChildren = true;
            while(mc.bDealSpot.numChildren)
            {
               mc.bDealSpot.removeChildAt(0);
            }
            this._dealspot = new DealSpot(this);
            this._dealspot.x = -5;
            this._dealspot.y = -5;
            mc.bDealSpot.addChild(this._dealspot);
         }
         else if(mc.bDealSpot)
         {
            mc.bDealSpot.visible = false;
            mc.bDealSpot.mouseChildren = false;
            this._dealspot = null;
         }
      }
      
      public function ButtonClick(param1:String) : *
      {
         var label:String = param1;
         return function(param1:MouseEvent):*
         {
            if(label == "gift")
            {
               if(POPUPS.QueueCount("gifts") > 0)
               {
                  POPUPS.Show("gifts");
               }
               else
               {
                  POPUPS.Gift();
               }
            }
            else if(label == "alert")
            {
               POPUPS.Show("alerts");
            }
            else if(label == "invite")
            {
               POPUPS.Invite();
            }
            else if(label == "inbox")
            {
               if(GLOBAL._flags.messaging == 1)
               {
                  MAILBOX.Show();
               }
               else
               {
                  GLOBAL.Message(KEYS.Get("mail_disabled"));
               }
            }
            else if(label == "daily")
            {
               BUY.Offers("daily");
            }
            else if(label == "earn")
            {
               BUY.Offers("earn");
            }
         };
      }
      
      public function DescentDebuffShow() : void
      {
         var _loc1_:Boolean = (GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack") && BASE.isInferno() && !MAPROOM_DESCENT.DescentPassed && (MAPROOM_DESCENT.DescentLevel > 6 && MAPROOM_DESCENT.DescentLevel < MAPROOM_DESCENT._descentLvlMax);
         if(this._descentDebuff)
         {
            this.DescentDebuffHide();
         }
         if(_loc1_)
         {
            this._descentDebuff = new DescentDebuffPopup();
            this._descentDebuff.Show(MAPROOM_DESCENT.DescentLevel);
         }
      }
      
      public function DescentDebuffHide() : void
      {
         if(this._descentDebuff)
         {
            this._descentDebuff.Hide();
         }
      }
      
      public function DisplayBuffs() : void
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Object = null;
         var _loc12_:String = null;
         var _loc13_:MovieClip = null;
         if(BASE.isInferno())
         {
            this.BuffHide(null);
            return;
         }
         var _loc1_:Number = POWERUPS.CheckPowers(null,"NORMAL");
         var _loc2_:int = this.mcBuffHolder.numChildren;
         while(_loc2_--)
         {
            this.mcBuffHolder.getChildAt(_loc2_).removeEventListener(MouseEvent.ROLL_OVER,this.BuffShow);
            this.mcBuffHolder.getChildAt(_loc2_).removeEventListener(MouseEvent.ROLL_OUT,this.BuffHide);
            this.mcBuffHolder.removeChildAt(_loc2_);
         }
         if(_loc1_ > 0)
         {
            _loc3_ = 3;
            _loc4_ = 2;
            _loc5_ = -36;
            _loc6_ = 36;
            _loc7_ = 0;
            _loc8_ = 0;
            _loc9_ = 0;
            _loc10_ = 0;
            _loc11_ = POWERUPS.GetPowerups();
            for(_loc12_ in _loc11_)
            {
               if(POWERUPS._expireRealTime)
               {
                  if(_loc11_[_loc12_].endtime.Get() < GLOBAL.Timestamp())
                  {
                     this.BuffHide(null);
                     continue;
                  }
               }
               _loc13_ = new ui_buffIcon_CLIP();
               _loc13_.gotoAndStop(_loc12_);
               _loc13_.name = _loc12_;
               _loc13_.x = _loc9_ * _loc5_;
               _loc13_.y = _loc10_ * _loc6_;
               _loc9_++;
               if(_loc9_ >= _loc3_)
               {
                  _loc9_ = 0;
                  _loc10_++;
               }
               _loc13_.addEventListener(MouseEvent.ROLL_OVER,this.BuffShow);
               _loc13_.addEventListener(MouseEvent.ROLL_OUT,this.BuffHide);
               this.mcBuffHolder.addChild(_loc13_);
            }
         }
         else
         {
            this.BuffHide(null);
         }
      }
      
      public function BuffShow(param1:MouseEvent) : void
      {
         var _loc7_:bubblepopupBuff = null;
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         var _loc3_:String = "";
         var _loc4_:* = "";
         var _loc5_:* = _loc2_.name + "_desc";
         _loc3_ = KEYS.Get(_loc5_);
         _loc4_ = "<b>" + KEYS.Get("buff_duration") + "</b>";
         if(POWERUPS._expireRealTime)
         {
            if(POWERUPS.Timeleft(_loc2_.name) > 0)
            {
               _loc4_ += GLOBAL.ToTime(POWERUPS.Timeleft(_loc2_.name),true);
            }
            else
            {
               _loc4_ = "";
            }
         }
         else if(POWERUPS.Timeleft(_loc2_.name) > 0)
         {
            _loc4_ += GLOBAL.ToTime(POWERUPS.Timeleft(_loc2_.name),true);
         }
         else
         {
            _loc4_ = "";
         }
         if(!this._popupBuff)
         {
            _loc7_ = new bubblepopupBuff();
            this._popupBuff = addChild(_loc7_);
            _loc7_.Setup(_loc2_.x + _loc2_.width / 2,_loc2_.y + _loc2_.height + 4,_loc3_,_loc4_);
            _loc7_.x = this.mcBuffHolder.x + (_loc2_.x + _loc2_.width / 2);
            _loc7_.y = this.mcBuffHolder.y + (_loc2_.y + _loc2_.height + 4);
         }
         else
         {
            bubblepopupBuff(this._popupBuff).Update(_loc3_,_loc4_);
         }
      }
      
      public function BuffHide(param1:MouseEvent) : *
      {
         if(this._popupBuff)
         {
            removeChild(this._popupBuff);
            this._popupBuff = null;
         }
      }
      
      public function BuffOff(param1:MouseEvent) : void
      {
         POWERUPS._testToggleOffPowers = true;
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         POWERUPS.Remove(_loc2_.name);
         this.BuffHide(null);
      }
      
      public function ButtonInfoShow(param1:MouseEvent) : *
      {
         var _loc4_:String = null;
         var _loc2_:int = param1.target.x + 50;
         var _loc3_:int = param1.target.y + 25;
         var _loc5_:Boolean = true;
         switch(param1.target.name)
         {
            case "bInvite":
               _loc4_ = KEYS.Get("pop_invite");
               break;
            case "bGift":
               if(POPUPS.QueueCount("gifts") > 0)
               {
                  _loc4_ = KEYS.Get("pop_acceptgifts",{"v1":POPUPS.QueueCount("gifts")});
                  break;
               }
               _loc4_ = KEYS.Get("pop_sendgifts");
               break;
            case "bInbox":
               _loc4_ = KEYS.Get("pop_mailbox");
               break;
            case "bAlert":
               _loc4_ = KEYS.Get("pop_alerts");
               break;
            case "mcHit":
               _loc4_ = KEYS.Get("pop_outposts");
               _loc2_ = param1.target.parent.x + 140;
               _loc3_ = param1.target.parent.y + 20;
               break;
            case "bDealSpot":
            case "_dealspot":
               _loc4_ = "<b>DealSpot Offers</b><br>Check DealSpot to earn Shiny.";
               _loc2_ = param1.target.parent.x + 40;
               _loc3_ = param1.target.parent.y + 20;
               if(Boolean(this._dealspot) && this._dealspot._hasOffers)
               {
                  _loc4_ = "<b>DealSpot Offers</b><br>Check DealSpot to earn Shiny.";
                  _loc3_ = param1.target.parent.y + 25;
                  break;
               }
               _loc4_ = " ";
               mc.bDealSpot.mouseChildren = false;
               this.BubbleHide();
               mc.bDealSpot.visible = false;
               mc.bDealSpot.enabled = false;
               if(Boolean(this._dealspot) && Boolean(this._dealspot.parent))
               {
                  this._dealspot.parent.removeChild(this._dealspot);
               }
               _loc5_ = false;
               return;
         }
         if(_loc5_ && _loc4_ != null)
         {
            this.BubbleShow(_loc2_,_loc3_,_loc4_);
         }
         else if(_loc4_ == null)
         {
         }
      }
      
      public function ButtonInfoHide(param1:MouseEvent) : *
      {
         this.BubbleHide();
      }
      
      internal function SetPoints(param1:Number, param2:Number, param3:Number, param4:Number, param5:uint, param6:Boolean) : *
      {
         var p:int = 0;
         var pointsMin:Number = param1;
         var pointsMax:Number = param2;
         var pointsNeeded:Number = param3;
         var points:Number = param4;
         var level:uint = param5;
         var newLevel:Boolean = param6;
         try
         {
            if(GLOBAL._mode == "build")
            {
               mc.mcPoints.mcLevel.text = level.toString();
               p = 200 / (pointsMax - pointsMin) * (points - pointsMin);
               TweenLite.to(mc.mcPoints.mcBar,0.6,{
                  "width":p,
                  "ease":Elastic.easeInOut
               });
               if(newLevel)
               {
                  mc.mcPoints.mcStar.scaleX = mc.mcPoints.mcStar.scaleY = 0.8;
                  mc.mcPoints.mcStar.rotation = 3 * 60;
                  TweenLite.to(mc.mcPoints.mcStar,1,{
                     "scaleX":1,
                     "scaleY":1,
                     "rotation":0,
                     "ease":Elastic.easeOut
                  });
               }
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","" + pointsMin + ", " + pointsMax + ", " + pointsNeeded + ", " + points + ", " + level + ", " + newLevel);
         }
      }
      
      public function BubbleShow(param1:int, param2:int, param3:String, param4:int = 3) : *
      {
         var _loc5_:bubblepopup3 = new bubblepopup3();
         _loc5_.Setup(param1,param2,param3,param4);
         _loc5_.Wobble();
         this._bubbleDo = this.addChild(_loc5_);
      }
      
      public function BubbleHide() : *
      {
         if(Boolean(this._bubbleDo) && Boolean(this._bubbleDo.parent))
         {
            this.removeChild(this._bubbleDo);
         }
      }
   }
}

