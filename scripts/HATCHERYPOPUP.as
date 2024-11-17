package
{
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gs.TweenLite;
   import gs.easing.Circ;
   
   public class HATCHERYPOPUP extends HATCHERYPOPUP_CLIP
   {
      public var _hatchery:BUILDING13;
      
      public var _guidePage:int = 1;
      
      public function HATCHERYPOPUP()
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         super();
         title_txt.htmlText = KEYS.Get(GLOBAL._bHatchery._buildingProps.name);
         bSpeedup.tName.htmlText = "<b>" + KEYS.Get("btn_speedup") + "</b>";
         bSpeedup.mouseChildren = false;
         if(!BASE.isInferno())
         {
            bSpeedup.addEventListener(MouseEvent.CLICK,STORE.Show(3,2,["HOD","HOD2","HOD3"]));
         }
         else
         {
            bSpeedup.addEventListener(MouseEvent.CLICK,STORE.Show(3,2,["HODI","HOD2I","HOD3I"]));
         }
         bSpeedup.buttonMode = true;
         bFinish.tName.htmlText = "<b>" + KEYS.Get("str_finishnow") + "</b>";
         bFinish.mouseChildren = false;
         bFinish.addEventListener(MouseEvent.CLICK,this.FinishNow);
         bFinish.buttonMode = true;
         var _loc1_:int = 1;
         for(_loc2_ in CREATURELOCKER.GetAppropriateCreatures())
         {
            _loc3_ = int(_loc2_.substring(_loc2_.indexOf("C") + 1));
            _loc4_ = this["monster" + _loc3_];
            _loc4_.addEventListener(MouseEvent.MOUSE_OVER,this.MonsterInfo(_loc3_));
            ImageCache.GetImageWithCallBack("monsters/" + _loc2_ + "-medium.jpg",this.IconLoaded,true,1,"",[this["monster" + _loc3_]]);
            if(Boolean(CREATURELOCKER._lockerData[_loc2_]) && CREATURELOCKER._lockerData[_loc2_].t == 2)
            {
               _loc4_.addEventListener(MouseEvent.MOUSE_DOWN,this.QueueAdd(_loc3_));
               _loc4_.alpha = 1;
               _loc4_.buttonMode = true;
            }
            else
            {
               _loc4_.alpha = 0.5;
               _loc4_.buttonMode = false;
            }
            _loc1_++;
         }
         while(_loc1_ < 16)
         {
            _loc4_ = this["monster" + _loc1_];
            _loc4_.visible = false;
            _loc1_++;
         }
         mcMonsterInfo.speed_txt.htmlText = "<b>" + KEYS.Get("mon_att_speed") + "</b>";
         mcMonsterInfo.health_txt.htmlText = "<b>" + KEYS.Get("mon_att_health") + "</b>";
         mcMonsterInfo.damage_txt.htmlText = "<b>" + KEYS.Get("mon_att_damage") + "</b>";
         mcMonsterInfo.goo_txt.htmlText = "<b>" + KEYS.Get("mon_att_cost",{"v1":KEYS.Get(BRESOURCE.GetResourceNameKey(3))}) + "</b>";
         mcMonsterInfo.housing_txt.htmlText = "<b>" + KEYS.Get("mon_att_housing") + "</b>";
         mcMonsterInfo.time_txt.htmlText = "<b>" + KEYS.Get("mon_att_time") + "</b>";
         this.MonsterInfoB(1);
      }
      
      public function IconLoaded(param1:String, param2:BitmapData, param3:Array = null) : *
      {
         var _loc4_:Bitmap = new Bitmap(param2);
         _loc4_.smoothing = true;
         param3[0].mcImage.removeChildAt(0);
         param3[0].mcImage.addChild(_loc4_);
         param3[0].mcImage.visible = true;
      }
      
      public function MonsterInfo(param1:int) : *
      {
         var n:int = param1;
         return function(param1:MouseEvent = null):*
         {
            MonsterInfoB(n);
         };
      }
      
      public function MonsterInfoB(param1:int) : *
      {
         var _loc10_:String = null;
         var _loc11_:int = 0;
         var _loc2_:String = BASE.isInferno() ? "IC" + param1 : "C" + param1;
         var _loc3_:* = CREATURELOCKER._creatures[_loc2_];
         ImageCache.GetImageWithCallBack("monsters/" + _loc2_ + "-portrait.jpg",this.IconLoaded,true,1,"",[this.portrait1]);
         var _loc4_:Number = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         for(_loc10_ in CREATURELOCKER._creatures)
         {
            if(CREATURES.GetProperty(_loc10_,"speed") > _loc4_)
            {
               _loc4_ = CREATURES.GetProperty(_loc10_,"speed");
            }
            if(CREATURES.GetProperty(_loc10_,"health") > _loc5_)
            {
               _loc5_ = CREATURES.GetProperty(_loc10_,"health");
            }
            if(CREATURES.GetProperty(_loc10_,"damage") > _loc6_)
            {
               _loc6_ = CREATURES.GetProperty(_loc10_,"damage");
            }
            if(CREATURES.GetProperty(_loc10_,"cTime") > _loc7_)
            {
               _loc7_ = CREATURES.GetProperty(_loc10_,"cTime");
            }
            if(CREATURES.GetProperty(_loc10_,"cResource") > _loc8_)
            {
               _loc8_ = CREATURES.GetProperty(_loc10_,"cResource");
            }
            if(CREATURES.GetProperty(_loc10_,"cStorage") > _loc9_)
            {
               _loc9_ = CREATURES.GetProperty(_loc10_,"cStorage");
            }
         }
         _loc11_ = CREATURES.GetProperty(_loc2_,"damage");
         TweenLite.to(mcMonsterInfo.bSpeed.mcBar,0.4,{
            "width":100 / _loc4_ * CREATURES.GetProperty(_loc2_,"speed"),
            "ease":Circ.easeInOut,
            "delay":0
         });
         TweenLite.to(mcMonsterInfo.bHealth.mcBar,0.4,{
            "width":100 / _loc5_ * CREATURES.GetProperty(_loc2_,"health"),
            "ease":Circ.easeInOut,
            "delay":0.05
         });
         TweenLite.to(mcMonsterInfo.bDamage.mcBar,0.4,{
            "width":100 / _loc6_ * Math.abs(_loc11_),
            "ease":Circ.easeInOut,
            "delay":0.1
         });
         TweenLite.to(mcMonsterInfo.bTime.mcBar,0.4,{
            "width":100 / _loc7_ * CREATURES.GetProperty(_loc2_,"cTime"),
            "ease":Circ.easeInOut,
            "delay":0.15
         });
         TweenLite.to(mcMonsterInfo.bResource.mcBar,0.4,{
            "width":100 / _loc8_ * CREATURES.GetProperty(_loc2_,"cResource"),
            "ease":Circ.easeInOut,
            "delay":0.2
         });
         TweenLite.to(mcMonsterInfo.bStorage.mcBar,0.4,{
            "width":100 / _loc9_ * CREATURES.GetProperty(_loc2_,"cStorage"),
            "ease":Circ.easeInOut,
            "delay":0.25
         });
         mcMonsterInfo.tSpeed.htmlText = KEYS.Get("mon_statsspeed",{"v1":CREATURES.GetProperty(_loc2_,"speed")});
         mcMonsterInfo.tHealth.htmlText = GLOBAL.FormatNumber(CREATURES.GetProperty(_loc2_,"health"));
         if(_loc11_ > 0)
         {
            mcMonsterInfo.tDamage.htmlText = _loc11_;
         }
         else
         {
            mcMonsterInfo.tDamage.htmlText = -_loc11_ + " (" + KEYS.Get("str_heal") + ")";
         }
         mcMonsterInfo.tResource.htmlText = KEYS.Get("mon_att_costvalue",{
            "v1":GLOBAL.FormatNumber(CREATURES.GetProperty(_loc2_,"cResource")),
            "v2":KEYS.Get(BRESOURCE.GetResourceNameKey(3))
         });
         mcMonsterInfo.tStorage.htmlText = KEYS.Get("mon_att_housingvalue",{"v1":CREATURES.GetProperty(_loc2_,"cStorage")});
         mcMonsterInfo.tTime.htmlText = GLOBAL.ToTime(CREATURES.GetProperty(_loc2_,"cTime"),true);
         var _loc12_:int = 1;
         if(Boolean(ACADEMY._upgrades[_loc2_]) && ACADEMY._upgrades[_loc2_].level > 1)
         {
            _loc12_ = int(ACADEMY._upgrades[_loc2_].level);
         }
         mcMonsterInfo.tDescription.htmlText = "<b>" + KEYS.Get("hatcherypopup_level",{"v1":_loc12_}) + " " + KEYS.Get(_loc3_.name) + "</b><br>" + KEYS.Get(_loc3_.description);
         if(Boolean(CREATURELOCKER._lockerData[_loc2_]) && CREATURELOCKER._lockerData[_loc2_].t == 2)
         {
            mcMonsterInfo.mcLocked.visible = false;
         }
         else
         {
            mcMonsterInfo.mcLocked.tText.htmlText = KEYS.Get(BASE.isInferno() ? "incubator_unlockinlocker" : "hat_unlockinlocker",{
               "v1":KEYS.Get(CREATURELOCKER._creatures[_loc2_].name),
               "v2":KEYS.Get(GLOBAL._bHatchery._buildingProps.name)
            });
            mcMonsterInfo.mcLocked.visible = true;
         }
         this.MonsterInfoShow();
      }
      
      public function MonsterInfoShow() : *
      {
         mcMonsterInfo.visible = true;
      }
      
      public function MonsterInfoHide(param1:MouseEvent = null) : *
      {
         mcMonsterInfo.visible = false;
      }
      
      public function QueueAdd(param1:int) : *
      {
         var n:int = param1;
         return function(param1:MouseEvent = null):*
         {
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            var _loc2_:* = BASE.isInferno() ? "I" : "";
            _loc2_ += "C" + n;
            var _loc3_:* = 1 + _hatchery._lvl.Get();
            if(!BASE.Charge(4,CREATURES.GetProperty(_loc2_,"cResource"),true))
            {
               if(BASE.isInferno())
               {
                  GLOBAL.Message("Not enough Magma.");
               }
               else
               {
                  GLOBAL.Message(KEYS.Get("hat_notenoughgoo"));
               }
               return;
            }
            if(Boolean(CREATURELOCKER._lockerData[_loc2_]) && CREATURELOCKER._lockerData[_loc2_].t == 2)
            {
               _loc4_ = _hatchery._monsterQueue;
               _loc5_ = 0;
               while(_loc5_ < _loc4_.length)
               {
                  if(_loc4_[_loc5_][0] == _loc2_ && _loc4_[_loc5_][1] < 20)
                  {
                     ++_loc4_[_loc5_][1];
                     Charge(_loc2_);
                     RenderQueue();
                     return;
                  }
                  _loc5_++;
               }
               if(_loc4_.length > 0 && _loc4_[_loc4_.length - 1][0] == _loc2_)
               {
                  if(_loc4_[_loc4_.length - 1][1] < 20)
                  {
                     ++_loc4_[_loc4_.length - 1][1];
                     Charge(_loc2_);
                  }
                  else if(_loc4_.length < _loc3_)
                  {
                     _loc4_.push([_loc2_,1]);
                     Charge(_loc2_);
                  }
                  else
                  {
                     SOUNDS.Play("error1");
                  }
               }
               else
               {
                  if(_loc4_.length < _loc3_)
                  {
                     _loc4_.push([_loc2_,1]);
                     Charge(_loc2_);
                  }
                  else
                  {
                     SOUNDS.Play("error1");
                  }
                  if(!_hatchery._inProduction)
                  {
                     _hatchery.StartProduction();
                  }
                  BASE.Save();
               }
               RenderQueue();
            }
         };
      }
      
      private function Charge(param1:String) : *
      {
         BASE.Charge(4,CREATURES.GetProperty(param1,"cResource"));
         ResourcePackages.Create(BASE.isInferno() ? 8 : 4,this._hatchery,CREATURES.GetProperty(param1,"cResource"),true);
         BASE.Save();
      }
      
      public function QueueRemove(param1:int) : *
      {
         var n:int = param1;
         return function(param1:MouseEvent = null):*
         {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if(n > 0)
            {
               _loc3_ = _hatchery._monsterQueue;
               if(_loc3_.length >= n)
               {
                  _loc2_ = _loc3_[n - 1][0];
                  --_loc3_[n - 1][1];
                  if(_loc3_[n - 1][1] <= 0)
                  {
                     _loc3_.splice(n - 1,1);
                  }
                  BASE.Fund(4,CREATURES.GetProperty(_loc2_,"cResource"));
                  BASE.Save();
               }
               else
               {
                  SOUNDS.Play("error1");
               }
            }
            else if(_hatchery._inProduction != "")
            {
               BASE.Fund(4,CREATURES.GetProperty(_hatchery._inProduction,"cResource"));
               _hatchery.StartProduction();
            }
            RenderQueue();
         };
      }
      
      public function RenderQueue() : *
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:* = 2 + this._hatchery._lvl.Get();
         var _loc2_:Array = this._hatchery._monsterQueue;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            ImageCache.GetImageWithCallBack("monsters/" + _loc2_[_loc3_][0] + "-medium.jpg",this.IconLoaded,true,1,"",[this["slot" + (_loc3_ + 1)]]);
            this["mcCount" + (_loc3_ + 1)].visible = true;
            this["mcCount" + (_loc3_ + 1)].tCounter.text = _loc2_[_loc3_][1];
            _loc3_++;
         }
         _loc3_ = int(_loc2_.length);
         while(_loc3_ < _loc1_ - 1)
         {
            this["slot" + (_loc3_ + 1)].mcImage.visible = false;
            this["slot" + (_loc3_ + 1)].mcLoading.visible = false;
            this["mcCount" + (_loc3_ + 1)].visible = false;
            _loc3_++;
         }
         _loc3_ = _loc1_ - 1;
         while(_loc3_ < 4)
         {
            this["slot" + (_loc3_ + 1)].tLabel.htmlText = "<font color=\"#CC0000\">" + KEYS.Get("hat_slot_upgrade",{"v1":KEYS.Get(GLOBAL._bHatchery._buildingProps.name)}) + "</font>";
            this["slot" + (_loc3_ + 1)].mcImage.visible = false;
            this["slot" + (_loc3_ + 1)].mcLoading.visible = false;
            this["mcCount" + (_loc3_ + 1)].visible = false;
            _loc3_++;
         }
         if(this._hatchery._inProduction)
         {
            bFinish.gotoAndStop(2);
            bFinish.Enabled = true;
            ImageCache.GetImageWithCallBack("monsters/" + this._hatchery._inProduction + "-medium.jpg",this.IconLoaded,true,1,"",[this.slot0]);
            _loc4_ = CREATURES.GetProperty(this._hatchery._inProduction,"cTime");
            _loc5_ = 100 / _loc4_ * this._hatchery._countdownProduce.Get();
            if(_loc5_ < 0)
            {
               _loc5_ = 0;
            }
            bProgress.mcBar.width = 100 - _loc5_;
            if(this._hatchery._countdownProduce.Get() > 0)
            {
               tProgress.htmlText = "<b>" + GLOBAL.ToTime(this._hatchery._countdownProduce.Get(),true) + "</b>";
            }
            else
            {
               tProgress.htmlText = "<b>" + KEYS.Get("hat_status_waiting") + "</b>";
            }
            bProgress.visible = true;
            tProgress.visible = true;
            if(TUTORIAL._currentStage < 200 || GLOBAL._hatcheryOverdrivePower.Get() == 10)
            {
               bSpeedup.gotoAndStop(1);
            }
            else
            {
               bSpeedup.gotoAndStop(2);
            }
         }
         else
         {
            bFinish.gotoAndStop(1);
            bFinish.Enabled = false;
            slot0.mcImage.visible = false;
            slot0.mcLoading.visible = false;
            bProgress.visible = false;
            tProgress.visible = false;
            bSpeedup.gotoAndStop(1);
         }
      }
      
      public function Setup(param1:BUILDING13) : *
      {
         this._hatchery = param1;
         var _loc2_:* = 2 + this._hatchery._lvl.Get();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this["slot" + _loc3_].addEventListener(MouseEvent.MOUSE_DOWN,this.QueueRemove(_loc3_));
            this["slot" + _loc3_].addEventListener(MouseEvent.MOUSE_OVER,this.ShowRemove(this["mcRemove" + _loc3_]));
            this["slot" + _loc3_].addEventListener(MouseEvent.MOUSE_OUT,this.HideRemove(this["mcRemove" + _loc3_]));
            this["slot" + _loc3_].buttonMode = true;
            _loc3_++;
         }
         _loc3_ = _loc2_;
         while(_loc3_ < 5)
         {
            this["slot" + _loc3_].gotoAndStop("locked");
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            this["mcRemove" + _loc3_].visible = false;
            this["mcRemove" + _loc3_].mouseEnabled = false;
            _loc3_++;
         }
         this.MonsterInfoHide();
         this.Update();
      }
      
      public function ShowRemove(param1:MovieClip) : *
      {
         var n:MovieClip = param1;
         return function(param1:MouseEvent):*
         {
            n.visible = true;
         };
      }
      
      public function HideRemove(param1:MovieClip) : *
      {
         var n:MovieClip = param1;
         return function(param1:MouseEvent):*
         {
            n.visible = false;
         };
      }
      
      public function Update() : *
      {
         var _loc4_:Boolean = false;
         var _loc5_:Array = null;
         this.RenderQueue();
         var _loc1_:Array = this._hatchery._monsterQueue;
         var _loc2_:Array = [];
         var _loc3_:* = 1 + this._hatchery._lvl.Get();
         if(_loc1_.length == 0 && !this._hatchery._inProduction)
         {
            _loc2_ = [1,"<font color=\"#CC0000\"><b>" + KEYS.Get("hat_nothinginproduction") + "</b></font> " + KEYS.Get("hat_producing_message")];
         }
         else if(this._hatchery._canFunction)
         {
            if(this._hatchery._productionStage.Get() == 2 && !HOUSING.HousingStore(this._hatchery._inProduction,new Point(this._hatchery._mc.x,this._hatchery._mc.y),true))
            {
               _loc2_ = [2,KEYS.Get("hat_needhousing")];
            }
            else
            {
               _loc2_ = [1,"<b>" + KEYS.Get("hat_producing",{"v1":KEYS.Get(CREATURELOCKER._creatures[this._hatchery._inProduction].name)}) + "</b>"];
               _loc4_ = true;
               if(_loc1_.length < _loc3_)
               {
                  _loc4_ = false;
               }
               else
               {
                  for each(_loc5_ in _loc1_)
                  {
                     if(_loc5_[1] < 20)
                     {
                        _loc4_ = false;
                     }
                  }
               }
               if(!_loc4_)
               {
                  _loc2_[1] += " " + KEYS.Get("hat_producing_message");
               }
               else
               {
                  _loc2_[1] += " " + KEYS.Get("hat_queuefull");
               }
            }
         }
         else
         {
            _loc2_ = [2,KEYS.Get("hat_damaged")];
         }
         if(_loc2_[0] == 1)
         {
            mcMessage.gotoAndStop(1);
         }
         else
         {
            mcMessage.gotoAndStop(2);
         }
         mcMessage.tA.htmlText = _loc2_[1];
         if(GLOBAL._hatcheryOverdrive > 0)
         {
            mcOverdrive.t.htmlText = "<b>" + KEYS.Get("hat_xoverdrive",{
               "v1":GLOBAL._hatcheryOverdrivePower.Get(),
               "v2":GLOBAL.ToTime(GLOBAL._hatcheryOverdrive)
            }) + "</b>";
            mcOverdrive.visible = true;
         }
         else
         {
            mcOverdrive.visible = false;
         }
      }
      
      public function Help(param1:MouseEvent = null) : void
      {
         this._guidePage += 1;
         if(this._guidePage > 4)
         {
            this._guidePage = 1;
         }
         this.gotoAndStop(this._guidePage);
         if(this._guidePage > 1)
         {
            this.txtGuide.htmlText = KEYS.Get("hcc_tut_" + (this._guidePage - 1));
            if(this._guidePage == 2)
            {
               this.bContinue.addEventListener(MouseEvent.CLICK,this.Help);
               this.bContinue.SetupKey("btn_continue");
            }
         }
      }
      
      private function FinishNow(param1:MouseEvent) : *
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         if(!bFinish.Enabled)
         {
            return;
         }
         if(Boolean(this._hatchery) && this._hatchery._finishCost.Get() > 0)
         {
            if(BASE._credits.Get() >= this._hatchery._finishCost.Get())
            {
               _loc2_ = [];
               _loc4_ = this._hatchery._finishQueue;
               for(_loc5_ in _loc4_)
               {
                  if(_loc4_[_loc5_] > 0)
                  {
                     _loc3_ = KEYS.Get(CREATURELOCKER._creatures[_loc5_].name);
                     _loc2_.push([_loc4_[_loc5_],_loc3_]);
                  }
               }
               GLOBAL.Array2String(_loc2_);
               if(this._hatchery._finishAll)
               {
                  GLOBAL.Message(KEYS.Get("msg_finishqueue",{
                     "v1":GLOBAL.Array2String(_loc2_),
                     "v2":this._hatchery._finishCost.Get()
                  }),KEYS.Get("str_finishnow"),this.DoFinish);
               }
               else
               {
                  GLOBAL.Message(KEYS.Get("msg_fillhousing",{
                     "v1":GLOBAL.Array2String(_loc2_),
                     "v2":this._hatchery._finishCost.Get()
                  }),KEYS.Get("str_finishnow"),this.DoFinish);
               }
            }
            else
            {
               POPUPS.DisplayGetShiny(param1);
            }
         }
         else if(this._hatchery._finishCost.Get() <= 0)
         {
            GLOBAL.Message(KEYS.Get("msg_housingfull"));
         }
      }
      
      private function DoFinish() : *
      {
         this._hatchery.FinishNow();
      }
      
      public function Hide(param1:MouseEvent = null) : *
      {
         HATCHERY.Hide(param1);
      }
      
      public function Center() : void
      {
         POPUPSETTINGS.AlignToCenter(this);
      }
      
      public function ScaleUp() : void
      {
         POPUPSETTINGS.ScaleUp(this);
      }
   }
}

