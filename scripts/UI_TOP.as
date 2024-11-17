package
{
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
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
      
      public var _creatureButtons:Array;
      
      public var _creatureButtonsMC:*;
      
      public var _bubbleDo:DisplayObject;
      
      public var _catapult:CATAPULTPOPUP;
      
      public var _buttonIcons:Array;
      
      public function UI_TOP()
      {
         var InfoShow:Function;
         var InfoHide:Function;
         var i:int = 0;
         var count:int = 0;
         var c:int = 0;
         var gb:MovieClip = null;
         var creature:String = null;
         var cb:MovieClip = null;
         super();
         gotoAndStop(GLOBAL._mode);
         if(GLOBAL._mode == "build")
         {
            InfoShow = function(param1:MouseEvent):*
            {
               mc.mcPoints.gotoAndStop(2);
               var _loc2_:Object = BASE.BaseLevel();
               mc.mcPoints.tInfo.htmlText = KEYS.Get("pop_experiencebar",{
                  "v1":GLOBAL.FormatNumber(_loc2_.points),
                  "v2":GLOBAL.FormatNumber(_loc2_.needed),
                  "v3":_loc2_.level + 1
               });
            };
            InfoHide = function(param1:MouseEvent):*
            {
               mc.mcPoints.gotoAndStop(1);
            };
            mc.mcPoints.addEventListener(MouseEvent.MOUSE_OVER,InfoShow);
            mc.mcPoints.addEventListener(MouseEvent.MOUSE_OUT,InfoHide);
            i = 1;
            while(i < 5)
            {
               mc["mcR" + i].mcHit.addEventListener(MouseEvent.MOUSE_OVER,this.StatsShow(i,false));
               mc["mcR" + i].mcHit.addEventListener(MouseEvent.MOUSE_OUT,this.StatsHide);
               mc["mcR" + i].bAdd.addEventListener(MouseEvent.CLICK,this.Topup(i));
               mc["mcR" + i].bAdd.buttonMode = true;
               mc["mcR" + i].bAdd.mouseEnabled = true;
               mc["mcR" + i].bAdd.mouseChildren = false;
               i++;
            }
            mc.mcR5.bAdd.txtAdd.autoSize = TextFieldAutoSize.LEFT;
            mc.mcR5.bAdd.txtAdd.text = KEYS.Get("ui_topaddshiny");
            mc.mcR5.bAdd.mcBG.width = mc.mcR5.bAdd.txtAdd.width + 11;
            mc.mcR5.mcBG.width = 82 + mc.mcR5.bAdd.width;
            mc.mcR5.bAdd.addEventListener(MouseEvent.CLICK,BUY.Show);
            mc.mcR5.bAdd.buttonMode = true;
            mc.mcR5.bAdd.mouseChildren = false;
            mc.mcOutposts.mcHit.addEventListener(MouseEvent.MOUSE_OVER,this.ButtonInfoShow);
            mc.mcOutposts.mcHit.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonInfoHide);
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
         else if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
         {
            this._creatureButtonsMC = mc.addChild(new flingerLevel());
            this._creatureButtonsMC.tA.text = KEYS.Get("attack_flingerbar");
            this._creatureButtonsMC.y = 84;
            count = 0;
            this._creatureButtons = [];
            if(Boolean(GLOBAL._playerGuardianData) && GLOBAL._playerGuardianData.hp.Get() > 0)
            {
               gb = this._creatureButtonsMC.addChild(new GUARDIANBUTTON("G" + GLOBAL._playerGuardianData.t,GLOBAL._playerGuardianData.l.Get()));
               gb.y = 25;
               this._creatureButtons.push(gb);
               count++;
            }
            c = 15;
            while(c >= 1)
            {
               if(GLOBAL._advancedMap && GLOBAL._attackerMapCreatures["C" + c] || !GLOBAL._advancedMap && GLOBAL._attackerCreatures["C" + c])
               {
                  creature = "C" + c;
                  if(GLOBAL._advancedMap)
                  {
                     if(GLOBAL._attackerMapCreatures[creature].Get() > 0)
                     {
                        cb = this._creatureButtonsMC.addChild(new CREATUREBUTTON(creature));
                        cb.y = 25 + count * 60;
                        if(count > 5)
                        {
                           if(Boolean(GLOBAL._playerGuardianData) && GLOBAL._playerGuardianData.hp.Get() > 0)
                           {
                              cb.y -= 300;
                           }
                           else
                           {
                              cb.y -= 360;
                           }
                           cb.x += 2 * 60;
                        }
                        this._creatureButtons.push(cb);
                        count++;
                     }
                  }
                  else if(GLOBAL._attackerCreatures[creature].Get() > 0)
                  {
                     cb = this._creatureButtonsMC.addChild(new CREATUREBUTTON(creature));
                     cb.y = 25 + count * 60;
                     if(count > 5)
                     {
                        if(Boolean(GLOBAL._playerGuardianData) && GLOBAL._playerGuardianData.hp.Get() > 0)
                        {
                           cb.y -= 300;
                        }
                        else
                        {
                           cb.y -= 360;
                        }
                        cb.x += 2 * 60;
                     }
                     this._creatureButtons.push(cb);
                     count++;
                  }
               }
               c--;
            }
            if(GLOBAL._attackersCatapult > 0)
            {
               this._catapult = new CATAPULTPOPUP();
               mc.addChild(this._catapult);
               this._catapult.x = 452;
               this._catapult.y = 4;
               this._catapult.Setup();
            }
         }
         this.Update();
      }
      
      public function Clear() : void
      {
      }
      
      public function Topup(param1:int) : *
      {
         var n:int = param1;
         return function(param1:MouseEvent = null):*
         {
            var _loc2_:* = Math.min((n - 1) * 0.4,1);
            STORE.ShowB(2,_loc2_,["BR" + n + "1","BR" + n + "2","BR" + n + "3"]);
         };
      }
      
      public function Setup() : *
      {
         var LoadImageError:Function;
         var loader:Loader = null;
         if(GLOBAL._mode != "build")
         {
            if(BASE._ownerName)
            {
               if(BASE._ownerName.toLowerCase().charAt(BASE._ownerName.length - 1) == "s")
               {
                  mc.mcPoints.tName.htmlText = BASE._ownerName.toUpperCase() + "\' YARD";
               }
               else
               {
                  mc.mcPoints.tName.htmlText = BASE._ownerName.toUpperCase() + "\'S YARD";
               }
            }
            else
            {
               mc.mcPoints.tName.htmlText = "BACKYARD MONSTERS";
            }
            try
            {
               LoadImageError = function(param1:IOErrorEvent):*
               {
               };
               loader = new Loader();
               loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,LoadImageError,false,0,true);
               mc.mcPic.mcBG.addChild(loader);
               if(GLOBAL._mode == "wmattack" || GLOBAL._mode == "wmview")
               {
                  loader.load(new URLRequest(GLOBAL._storageURL + BASE._ownerPic));
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
               if(!topup)
               {
                  _loc2_ = "<b><font size=\"12\">" + KEYS.Get(GLOBAL._resourceNames[n - 1]) + "</font></b><br>" + KEYS.Get("pop_resource",{
                     "v1":GLOBAL.FormatNumber(BASE._resources["r" + n + "max"]),
                     "v2":GLOBAL.FormatNumber(BASE._resources["r" + n + "Rate"])
                  });
                  _loc3_ = 3;
               }
               else
               {
                  _loc2_ = "<b><font size=\"12\">" + KEYS.Get(GLOBAL._resourceNames[n - 1]) + "</font></b><br><b>" + KEYS.Get("bubble_topup") + "</b>";
                  _loc3_ = 2;
               }
            }
            else
            {
               _loc2_ = "<b>" + KEYS.Get("bubble_getshiny") + "</b>";
               _loc3_ = 2;
            }
            var _loc4_:* = mc["mcR" + n];
            BubbleShow(_loc4_.x + _loc4_.width,_loc4_.y + int(_loc4_.height * 0.5),_loc2_,_loc3_);
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
         this._popupWarning.tA.htmlText = KEYS.Get("ui_needmoreroom");
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
      
      public function Update() : *
      {
         var _loc1_:int = 0;
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         if(!GLOBAL._catchup)
         {
            if(GLOBAL._mode == "build")
            {
               _loc1_ = 1;
               while(_loc1_ < 6)
               {
                  _loc4_ = mc["mcR" + _loc1_];
                  if(_loc1_ < 5)
                  {
                     _loc4_.tR.htmlText = "<b>" + GLOBAL.FormatNumber(BASE._resources["r" + _loc1_].Get()) + "</b>";
                     _loc3_ = 90 / BASE._resources["r" + _loc1_ + "max"] * BASE._resources["r" + _loc1_].Get();
                     if(_loc3_ > 90)
                     {
                        _loc3_ = 90;
                     }
                     _loc4_.mcBar.width = _loc3_;
                  }
                  else
                  {
                     _loc4_.tR.htmlText = "<b>" + GLOBAL.FormatNumber(BASE._credits.Get()) + "</b>";
                  }
                  _loc1_++;
               }
               if(GLOBAL._advancedMap)
               {
                  mc.mcOutposts.visible = true;
                  mc.mcOutposts.tR.htmlText = GLOBAL._mapOutpost.length + " Outposts";
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
                  _loc5_ = 0;
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
                  this.SortButtonIcons();
                  mc.bGift.visible = true;
                  _loc5_ = POPUPS.QueueCount("gifts");
                  if(_loc5_ > 0)
                  {
                     mc.bGift.mcSpinner.visible = true;
                     mc.bGift.mcCounter.visible = true;
                     if(_loc5_ < 10)
                     {
                        mc.bGift.mcCounter.t.htmlText = "<b>" + _loc5_ + "</b>";
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
                  _loc5_ = POPUPS.QueueCount("alerts");
                  if(_loc5_ > 0)
                  {
                     mc.bAlert.visible = true;
                     mc.bAlert.mcSpinner.visible = true;
                     mc.bAlert.mcCounter.visible = true;
                     if(_loc5_ < 10)
                     {
                        mc.bAlert.mcCounter.t.htmlText = "<b>" + _loc5_ + "</b>";
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
               }
            }
            else if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
            {
               _loc1_ = 1;
               while(_loc1_ < 5)
               {
                  _loc4_ = mc["mcR" + _loc1_];
                  _loc4_.tR.htmlText = "<b>" + GLOBAL.FormatNumber(ATTACK._loot["r" + _loc1_].Get()) + "</b>";
                  _loc4_.mcBar.visible = false;
                  _loc1_++;
               }
               _loc1_ = 0;
               while(_loc1_ < this._creatureButtons.length)
               {
                  this._creatureButtons[_loc1_].Update();
                  _loc1_++;
               }
               _loc7_ = _loc6_ = int(GLOBAL._buildingProps[4].capacity[GLOBAL._attackersFlinger - 1]);
               for(_loc8_ in ATTACK._flingerBucket)
               {
                  if(_loc8_.substr(0,1) == "G")
                  {
                     _loc7_ -= GUARDIANCAGE.GetGuardianProperty(_loc8_.substr(0,2),1,"bucket");
                  }
                  else
                  {
                     _loc7_ -= CREATURES.GetProperty(_loc8_,"bucket") * ATTACK._flingerBucket[_loc8_].Get();
                  }
               }
               this._creatureButtonsMC.mcBar.width = 100 - 100 / _loc6_ * _loc7_;
               if(ATTACK._countdown > 0)
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
            _loc2_ = BASE.BaseLevel();
            this.SetPoints(_loc2_.lower,_loc2_.upper,_loc2_.needed,_loc2_.points,_loc2_.level,false);
         }
      }
      
      public function SortButtonIcons(param1:int = 2, param2:int = 4) : void
      {
         var _loc5_:* = param1;
         var _loc6_:* = param2;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         if(GLOBAL._advancedMap)
         {
            _loc9_ += 35;
         }
         var _loc13_:int = 0;
         while(_loc13_ < this._buttonIcons.length)
         {
            if(this._buttonIcons[_loc13_].visible)
            {
               this._buttonIcons[_loc13_].x = 9 + _loc10_;
               this._buttonIcons[_loc13_].y = 195 + _loc9_;
               _loc12_++;
               _loc9_ += 55;
               if(_loc12_ >= _loc6_)
               {
                  _loc12_ = 0;
                  _loc11_++;
                  _loc9_ = 0;
                  _loc10_ += 67;
               }
            }
            _loc13_++;
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
                  GLOBAL.Message("<b>Mailbox Disabled</b><br>We\'re just updating the Mailbox and while it updates we\'ve disabled access to it. Please check back in a few minutes.");
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
      
      public function ButtonInfoShow(param1:MouseEvent) : *
      {
         var _loc4_:String = null;
         var _loc2_:int = param1.target.x + 50;
         var _loc3_:int = param1.target.y + 25;
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
               _loc4_ = "<b>Outposts</b><br>The number of outposts under your control.";
               _loc2_ = param1.target.parent.x + 140;
               _loc3_ = param1.target.parent.y + 20;
         }
         if(_loc4_ != null)
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

