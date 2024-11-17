package
{
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gs.TweenLite;
   import gs.easing.Circ;
   
   public class HATCHERYCCPOPUP extends HATCHERYCCPOPUP_CLIP
   {
      private var _tick:int = 0;
      
      private var _monsterID:int = 0;
      
      public var _guidePage:int = 1;
      
      public function HATCHERYCCPOPUP()
      {
         var _loc1_:String = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         super();
         bSpeedup.tName.htmlText = "<b>" + KEYS.Get("btn_speedup") + "</b>";
         bSpeedup.mouseChildren = false;
         bSpeedup.addEventListener(MouseEvent.CLICK,STORE.Show(3,2,["HOD","HOD2","HOD3"]));
         bSpeedup.buttonMode = true;
         bFinish.tName.htmlText = "<b>" + KEYS.Get("str_finishnow") + "</b>";
         bFinish.mouseChildren = false;
         bFinish.addEventListener(MouseEvent.CLICK,this.FinishNow);
         bFinish.buttonMode = true;
         bTopup.tName.htmlText = "<b>" + KEYS.Get("btn_topup2") + "</b>";
         bTopup.mouseChildren = false;
         bTopup.addEventListener(MouseEvent.CLICK,STORE.Show(2,4,["BR41","BR42","BR43"]));
         bTopup.buttonMode = true;
         var _loc2_:int = 1;
         while(_loc2_ <= 15)
         {
            _loc1_ = "C" + _loc2_;
            _loc3_ = this["monster" + _loc2_];
            _loc3_.addEventListener(MouseEvent.MOUSE_OVER,this.MonsterInfo(_loc2_));
            _loc3_.addEventListener(MouseEvent.MOUSE_DOWN,this.QueueAdd(_loc2_));
            _loc3_.buttonMode = true;
            ImageCache.GetImageWithCallBack("monsters/C" + _loc2_ + "-medium.jpg",this.IconLoaded,true,1,"",["monster",_loc2_]);
            _loc4_ = this["monsterLevel" + _loc2_];
            if(Boolean(ACADEMY._upgrades[_loc1_]) && ACADEMY._upgrades[_loc1_].level > 1)
            {
               _loc4_.visible = true;
               _loc4_.tLevel.htmlText = "<b>" + ACADEMY._upgrades[_loc1_].level + "</b>";
            }
            else
            {
               _loc4_.visible = false;
            }
            if(!(Boolean(CREATURELOCKER._lockerData[_loc1_]) && CREATURELOCKER._lockerData[_loc1_].t == 2))
            {
               _loc3_.alpha = 0.75;
               _loc4_.visible = false;
            }
            _loc2_++;
         }
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            this["hatchery" + _loc2_].gotoAndStop("blank");
            this["hatcheryRemove" + _loc2_].visible = false;
            this["hatchery" + _loc2_].addEventListener(MouseEvent.MOUSE_OVER,this.ShowRemove(this["hatcheryRemove" + _loc2_]));
            this["hatchery" + _loc2_].addEventListener(MouseEvent.MOUSE_OUT,this.HideRemove(this["hatcheryRemove" + _loc2_]));
            this["hatchery" + _loc2_].addEventListener(MouseEvent.MOUSE_DOWN,this.StopProduction(_loc2_));
            this["hatchery" + _loc2_].buttonMode = true;
            _loc2_++;
         }
         title_txt.text = KEYS.Get("hcc_title");
         mcMonsterInfo.speed_txt.htmlText = "<b>" + KEYS.Get("mon_att_speed") + "</b>";
         mcMonsterInfo.health_txt.htmlText = "<b>" + KEYS.Get("mon_att_health") + "</b>";
         mcMonsterInfo.damage_txt.htmlText = "<b>" + KEYS.Get("mon_att_damage") + "</b>";
         mcMonsterInfo.goo_txt.htmlText = "<b>" + KEYS.Get("mon_att_cost") + "</b>";
         mcMonsterInfo.housing_txt.htmlText = "<b>" + KEYS.Get("mon_att_housing") + "</b>";
         mcMonsterInfo.time_txt.htmlText = "<b>" + KEYS.Get("mon_att_time") + "</b>";
         hatlabel1_txt.htmlText = "<b>" + KEYS.Get("hcc_hatcherynum",{"v1":1}) + "</b>";
         hatlabel2_txt.htmlText = "<b>" + KEYS.Get("hcc_hatcherynum",{"v1":2}) + "</b>";
         hatlabel3_txt.htmlText = "<b>" + KEYS.Get("hcc_hatcherynum",{"v1":3}) + "</b>";
         hatlabel4_txt.htmlText = "<b>" + KEYS.Get("hcc_hatcherynum",{"v1":4}) + "</b>";
         hatlabel5_txt.htmlText = "<b>" + KEYS.Get("hcc_hatcherynum",{"v1":5}) + "</b>";
         addEventListener(MouseEvent.MOUSE_UP,this.ClearEvents);
         (this.mcFrame as frame).Setup(true,true);
      }
      
      public function IconLoaded(param1:String, param2:BitmapData, param3:Array = null) : *
      {
         var _loc4_:Bitmap = new Bitmap(param2);
         _loc4_.smoothing = true;
         this[param3[0] + param3[1]].mcImage.addChild(_loc4_);
         this[param3[0] + param3[1]].mcImage.visible = true;
      }
      
      public function MonsterInfo(param1:int) : Function
      {
         var n:int = param1;
         return function(param1:MouseEvent = null):*
         {
            MonsterInfoB(n);
         };
      }
      
      public function MonsterInfoB(param1:int) : *
      {
         var _loc11_:String = null;
         var _loc12_:int = 0;
         var _loc2_:int = 1;
         while(_loc2_ <= 13)
         {
            _loc2_++;
         }
         var _loc3_:* = "C" + param1;
         var _loc4_:* = CREATURELOCKER._creatures[_loc3_];
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         for(_loc11_ in CREATURELOCKER._creatures)
         {
            if(CREATURES.GetProperty(_loc11_,"speed") > _loc5_)
            {
               _loc5_ = CREATURES.GetProperty(_loc11_,"speed");
            }
            if(CREATURES.GetProperty(_loc11_,"health") > _loc6_)
            {
               _loc6_ = CREATURES.GetProperty(_loc11_,"health");
            }
            if(CREATURES.GetProperty(_loc11_,"damage") > _loc7_)
            {
               _loc7_ = CREATURES.GetProperty(_loc11_,"damage");
            }
            if(CREATURES.GetProperty(_loc11_,"cTime") > _loc8_)
            {
               _loc8_ = CREATURES.GetProperty(_loc11_,"cTime");
            }
            if(CREATURES.GetProperty(_loc11_,"cResource") > _loc9_)
            {
               _loc9_ = CREATURES.GetProperty(_loc11_,"cResource");
            }
            if(CREATURES.GetProperty(_loc11_,"cStorage") > _loc10_)
            {
               _loc10_ = CREATURES.GetProperty(_loc11_,"cStorage");
            }
         }
         _loc12_ = CREATURES.GetProperty(_loc3_,"damage");
         TweenLite.to(mcMonsterInfo.bSpeed.mcBar,0.4,{
            "width":100 / _loc5_ * CREATURES.GetProperty(_loc3_,"speed"),
            "ease":Circ.easeInOut,
            "delay":0
         });
         TweenLite.to(mcMonsterInfo.bHealth.mcBar,0.4,{
            "width":100 / _loc6_ * CREATURES.GetProperty(_loc3_,"health"),
            "ease":Circ.easeInOut,
            "delay":0.05
         });
         TweenLite.to(mcMonsterInfo.bDamage.mcBar,0.4,{
            "width":100 / _loc7_ * Math.abs(_loc12_),
            "ease":Circ.easeInOut,
            "delay":0.1
         });
         TweenLite.to(mcMonsterInfo.bResource.mcBar,0.4,{
            "width":100 / _loc8_ * CREATURES.GetProperty(_loc3_,"cTime"),
            "ease":Circ.easeInOut,
            "delay":0.15
         });
         TweenLite.to(mcMonsterInfo.bStorage.mcBar,0.4,{
            "width":100 / _loc9_ * CREATURES.GetProperty(_loc3_,"cResource"),
            "ease":Circ.easeInOut,
            "delay":0.2
         });
         TweenLite.to(mcMonsterInfo.bTime.mcBar,0.4,{
            "width":100 / _loc10_ * CREATURES.GetProperty(_loc3_,"cStorage"),
            "ease":Circ.easeInOut,
            "delay":0.25
         });
         mcMonsterInfo.tSpeed.text = KEYS.Get("mon_statsspeed",{"v1":CREATURES.GetProperty(_loc3_,"speed")});
         mcMonsterInfo.tHealth.text = GLOBAL.FormatNumber(CREATURES.GetProperty(_loc3_,"health"));
         if(_loc12_ > 0)
         {
            mcMonsterInfo.tDamage.text = _loc12_;
         }
         else
         {
            mcMonsterInfo.tDamage.text = -_loc12_ + " (" + KEYS.Get("str_heal") + ")";
         }
         mcMonsterInfo.tResource.text = KEYS.Get("mon_att_costvalue",{"v1":GLOBAL.FormatNumber(CREATURES.GetProperty(_loc3_,"cResource"))});
         mcMonsterInfo.tStorage.text = KEYS.Get("mon_att_housingvalue",{"v1":CREATURES.GetProperty(_loc3_,"cStorage")});
         mcMonsterInfo.tTime.text = GLOBAL.ToTime(CREATURES.GetProperty(_loc3_,"cTime"),true);
         var _loc13_:int = 1;
         if(Boolean(ACADEMY._upgrades[_loc3_]) && ACADEMY._upgrades[_loc3_].level > 1)
         {
            _loc13_ = int(ACADEMY._upgrades[_loc3_].level);
         }
         mcMonsterInfo.tDescription.htmlText = "<b>" + KEYS.Get("acad_status_level",{"v1":_loc13_}) + " " + KEYS.Get(_loc4_.name) + "</b><br>" + KEYS.Get(_loc4_.description);
         if(Boolean(CREATURELOCKER._lockerData[_loc3_]) && CREATURELOCKER._lockerData[_loc3_].t == 2)
         {
            mcMonsterInfo.mcLocked.visible = false;
         }
         else
         {
            mcMonsterInfo.mcLocked.tText.htmlText = "<b>" + KEYS.Get("hat_unlockinlocker",{"v1":KEYS.Get(CREATURELOCKER._creatures[_loc3_].name)}) + "</b>";
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
      
      public function QueueAdd(param1:int) : Function
      {
         var n:int = param1;
         return function(param1:MouseEvent = null):*
         {
            _tick = 0;
            _monsterID = n;
            QueueAddTick();
            addEventListener(Event.ENTER_FRAME,QueueAddTick);
         };
      }
      
      private function QueueAddTick(param1:Event = null) : *
      {
         var _loc4_:Array = null;
         this._tick += 1;
         if(this._tick < 20 && this._tick != 1)
         {
            return;
         }
         var _loc2_:* = "C" + this._monsterID;
         if(!BASE.Charge(4,CREATURES.GetProperty(_loc2_,"cResource"),true))
         {
            return;
         }
         if(Boolean(CREATURELOCKER._lockerData[_loc2_]) && CREATURELOCKER._lockerData[_loc2_].t == 2)
         {
            _loc4_ = GLOBAL._bHatcheryCC._monsterQueue;
            if(_loc4_.length > 0 && _loc4_[_loc4_.length - 1][0] == _loc2_)
            {
               if(_loc4_[_loc4_.length - 1][1] < 20)
               {
                  ++_loc4_[_loc4_.length - 1][1];
                  this.Charge(_loc2_);
               }
               else if(_loc4_.length < 7)
               {
                  _loc4_.push([_loc2_,1]);
                  this.Charge(_loc2_);
               }
               else
               {
                  SOUNDS.Play("error1");
               }
            }
            else if(_loc4_.length < 7)
            {
               _loc4_.push([_loc2_,1]);
               this.Charge(_loc2_);
            }
            else
            {
               SOUNDS.Play("error1");
            }
            this.Update();
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
         if(GLOBAL._bHatcheryCC && GLOBAL._bHatcheryCC._finishCost.Get() > 0)
         {
            if(BASE._credits.Get() >= GLOBAL._bHatcheryCC._finishCost.Get())
            {
               _loc2_ = [];
               _loc4_ = GLOBAL._bHatcheryCC._finishQueue;
               for(_loc5_ in _loc4_)
               {
                  if(_loc4_[_loc5_] > 0)
                  {
                     _loc3_ = KEYS.Get(CREATURELOCKER._creatures[_loc5_].name);
                     _loc2_.push([_loc4_[_loc5_],_loc3_]);
                  }
               }
               GLOBAL.Array2String(_loc2_);
               if(GLOBAL._bHatcheryCC._finishAll)
               {
                  GLOBAL.Message("Do you want to finish your queue of " + GLOBAL.Array2String(_loc2_) + " now for " + GLOBAL._bHatcheryCC._finishCost.Get() + " Shiny?","Finish Now",this.DoFinish);
               }
               else
               {
                  GLOBAL.Message("You have room in your Housing for " + GLOBAL.Array2String(_loc2_) + ", do you want to finish them now for " + GLOBAL._bHatcheryCC._finishCost.Get() + " Shiny?","Finish Now",this.DoFinish);
               }
            }
            else
            {
               POPUPS.DisplayGetShiny(param1);
            }
         }
         else if(GLOBAL._bHatcheryCC._finishCost.Get() <= 0)
         {
            GLOBAL.Message("There is no room in Housing for any of the monsters currently in production.");
         }
      }
      
      private function DoFinish() : *
      {
         GLOBAL._bHatcheryCC.FinishNow();
      }
      
      private function Charge(param1:String) : *
      {
         BASE.Charge(4,CREATURES.GetProperty(param1,"cResource"));
         ResourcePackages.Create(4,GLOBAL._bHatcheryCC,CREATURES.GetProperty(param1,"cResource"),true);
         BASE.Save();
      }
      
      public function QueueRemove(param1:int) : Function
      {
         var n:int = param1;
         return function(param1:MouseEvent = null):*
         {
            _tick = 0;
            _monsterID = n;
            QueueRemoveTick();
            addEventListener(Event.ENTER_FRAME,QueueRemoveTick);
         };
      }
      
      private function QueueRemoveTick(param1:Event = null) : *
      {
         this._tick += 1;
         if(this._tick < 20 && this._tick != 1)
         {
            return;
         }
         var _loc2_:Array = GLOBAL._bHatcheryCC._monsterQueue;
         if(_loc2_.length >= this._monsterID)
         {
            BASE.Fund(4,CREATURES.GetProperty(_loc2_[this._monsterID - 1][0],"cResource"));
            --_loc2_[this._monsterID - 1][1];
            if(_loc2_[this._monsterID - 1][1] <= 0)
            {
               _loc2_.splice(this._monsterID - 1,1);
            }
            BASE.Save();
         }
         else
         {
            SOUNDS.Play("error1");
         }
         this.Update();
      }
      
      private function ClearEvents(param1:MouseEvent) : *
      {
         removeEventListener(Event.ENTER_FRAME,this.QueueAddTick);
         removeEventListener(Event.ENTER_FRAME,this.QueueRemoveTick);
      }
      
      public function StopProduction(param1:int) : Function
      {
         var n:int = param1;
         return function(param1:MouseEvent = null):*
         {
            var _loc3_:* = undefined;
            var _loc2_:* = 1;
            for each(_loc3_ in BASE._buildingsMain)
            {
               if(_loc3_._type == 13)
               {
                  if(_loc3_._inProduction != "" && _loc2_ == n)
                  {
                     BASE.Fund(4,CREATURES.GetProperty(_loc3_._inProduction,"cResource"));
                     _loc3_._inProduction = "";
                     _loc3_.ResetProduction();
                  }
                  _loc2_++;
               }
            }
            Update();
         };
      }
      
      public function RenderQueue() : *
      {
         var _loc5_:int = 0;
         var _loc8_:BFOUNDATION = null;
         var _loc9_:int = 0;
         var _loc2_:Array = GLOBAL._bHatcheryCC._monsterQueue;
         var _loc3_:int = 1;
         while(_loc3_ <= 7)
         {
            this["slot" + _loc3_].mcImage.visible = false;
            this["slot" + _loc3_].mcLoading.visible = false;
            this["mcCount" + _loc3_].visible = false;
            _loc3_++;
         }
         _loc3_ = 1;
         while(_loc3_ <= _loc2_.length)
         {
            this["slot" + _loc3_].mcImage.visible = false;
            this["slot" + _loc3_].mcLoading.visible = true;
            ImageCache.GetImageWithCallBack("monsters/" + _loc2_[_loc3_ - 1][0] + "-medium.jpg",this.IconLoaded,true,1,"",["slot",_loc3_]);
            this["mcCount" + _loc3_].visible = true;
            this["mcCount" + _loc3_].tCounter.text = _loc2_[_loc3_ - 1][1];
            _loc3_++;
         }
         HOUSING.HousingSpace();
         _loc5_ = 100 / HOUSING._housingCapacity.Get() * HOUSING._housingUsed.Get();
         mcStorage.mcBar.width = 535 / HOUSING._housingCapacity.Get() * HOUSING._housingUsed.Get();
         var _loc6_:* = "<b>" + GLOBAL.FormatNumber(HOUSING._housingUsed.Get()) + " / " + GLOBAL.FormatNumber(HOUSING._housingCapacity.Get()) + "</b>";
         var _loc7_:int = 0;
         for each(_loc8_ in BASE._buildingsMain)
         {
            if(_loc8_._type == 13 && Boolean(_loc8_._inProduction))
            {
               _loc7_ += CREATURES.GetProperty(_loc8_._inProduction,"cStorage");
            }
         }
         _loc9_ = 0;
         while(_loc9_ < _loc2_.length)
         {
            _loc7_ += CREATURES.GetProperty(_loc2_[_loc9_][0],"cStorage") * _loc2_[_loc9_][1];
            _loc9_++;
         }
         if(_loc7_ > 0)
         {
            bFinish.Enabled = true;
            bFinish.gotoAndStop(2);
         }
         else
         {
            bFinish.Enabled = false;
            bFinish.gotoAndStop(1);
         }
         if(_loc7_ > 0 && GLOBAL._hatcheryOverdrivePower.Get() < 10)
         {
            bSpeedup.gotoAndStop(2);
            _loc6_ += "<br><font size=\"9\">" + KEYS.Get("hcc_queuedup",{"v1":GLOBAL.FormatNumber(HOUSING._housingUsed.Get() + _loc7_)});
            if(HOUSING._housingUsed.Get() + _loc7_ == HOUSING._housingCapacity.Get())
            {
               _loc6_ += " " + KEYS.Get("hcc_queuedfull");
            }
            if(HOUSING._housingUsed.Get() + _loc7_ > HOUSING._housingCapacity.Get())
            {
               _loc6_ += " " + KEYS.Get("hcc_queuedover");
            }
         }
         else
         {
            bSpeedup.gotoAndStop(1);
            _loc6_ += "<br><font size=\"9\">" + KEYS.Get("hcc_queuedup",{"v1":GLOBAL.FormatNumber(HOUSING._housingUsed.Get() + _loc7_)});
            if(HOUSING._housingUsed.Get() + _loc7_ == HOUSING._housingCapacity.Get())
            {
               _loc6_ += " " + KEYS.Get("hcc_queuedfull");
            }
            if(HOUSING._housingUsed.Get() + _loc7_ > HOUSING._housingCapacity.Get())
            {
               _loc6_ += " " + KEYS.Get("hcc_queuedover");
            }
         }
         _loc5_ = 535 / HOUSING._housingCapacity.Get() * (HOUSING._housingUsed.Get() + _loc7_);
         if(_loc5_ > 535)
         {
            _loc5_ = 535;
         }
         mcStorage.mcBarB.width = _loc5_;
         txtStorage.htmlText = _loc6_;
         var _loc10_:int = int(BASE._resources.r4.Get());
         _loc9_ = 0;
         while(_loc9_ < _loc2_.length)
         {
            _loc10_ -= CREATURES.GetProperty(_loc2_[_loc9_][0],"cResource") * _loc2_[_loc9_][1];
            _loc9_++;
         }
         mcGoo.mcBarB.width = 1;
         _loc5_ = 100 / BASE._resources.r4max * BASE._resources.r4.Get();
         if(_loc5_ > 100)
         {
            _loc5_ = 100;
         }
         mcGoo.mcBar.width = _loc5_;
         txtGoo.htmlText = "<b>" + GLOBAL.FormatNumber(BASE._resources.r4.Get()) + " Goo remaining</b>";
         bTopup.gotoAndStop(1);
         if(BASE._resources.r4.Get() < BASE._resources.r4max * 0.1)
         {
            bTopup.gotoAndStop(2);
         }
      }
      
      public function Setup() : *
      {
         var _loc2_:int = 1;
         while(_loc2_ <= 7)
         {
            this["slot" + _loc2_].addEventListener(MouseEvent.MOUSE_DOWN,this.QueueRemove(_loc2_));
            this["slot" + _loc2_].addEventListener(MouseEvent.MOUSE_OVER,this.ShowRemove(this["mcRemove" + _loc2_]));
            this["slot" + _loc2_].addEventListener(MouseEvent.MOUSE_OUT,this.HideRemove(this["mcRemove" + _loc2_]));
            this["slot" + _loc2_].buttonMode = true;
            this["mcRemove" + _loc2_].visible = false;
            this["mcRemove" + _loc2_].mouseEnabled = false;
            this["mcRemove" + _loc2_].mouseChildren = false;
            _loc2_++;
         }
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            this["hatcheryRemove" + _loc2_].visible = false;
            this["hatcheryRemove" + _loc2_].mouseEnabled = false;
            this["hatcheryRemove" + _loc2_].mouseChildren = false;
            _loc2_++;
         }
         this.MonsterInfoHide();
         this.Update();
      }
      
      public function ShowRemove(param1:MovieClip) : Function
      {
         var n:MovieClip = param1;
         return function(param1:MouseEvent):*
         {
            n.visible = true;
         };
      }
      
      public function HideRemove(param1:MovieClip) : Function
      {
         var n:MovieClip = param1;
         return function(param1:MouseEvent):*
         {
            n.visible = false;
         };
      }
      
      public function Update() : *
      {
         var _loc4_:MovieClip = null;
         var _loc7_:BFOUNDATION = null;
         var _loc8_:int = 0;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         this.RenderQueue();
         var _loc1_:Array = GLOBAL._bHatcheryCC._monsterQueue;
         var _loc3_:int = 1;
         var _loc6_:int = 1;
         while(_loc6_ < 15)
         {
            _loc10_ = "C" + _loc6_;
            _loc11_ = "monster" + _loc6_;
            _loc12_ = "monsterLevel" + _loc6_;
            if(!BASE.Charge(4,CREATURES.GetProperty(_loc10_,"cResource"),true))
            {
               this[_loc12_].alpha = 0.5;
               this[_loc11_].alpha = 0.5;
            }
            else
            {
               this[_loc12_].alpha = 1;
               this[_loc11_].alpha = 1;
            }
            _loc6_++;
         }
         for each(_loc7_ in BASE._buildingsMain)
         {
            if(_loc7_._type == 13)
            {
               _loc4_ = this["hatchery" + _loc3_];
               _loc4_.mouseEnabled = false;
               _loc4_.tLabel.text = "";
               _loc4_.mcImage.visible = false;
               _loc4_.mcLoading.visible = false;
               this["bProgress" + _loc3_].visible = false;
               this["tProgress" + _loc3_].visible = false;
               this["hatcheryRemove" + _loc3_].visible = false;
               if(_loc7_._countdownBuild.Get() > 0)
               {
                  _loc4_.mcImage.visible = false;
                  _loc4_.mcLoading.visible = false;
                  _loc4_.tLabel.htmlText = "<font color=\"#CC0000\">" + KEYS.Get("hat_slot_construction") + "</font>";
               }
               else if(_loc7_._countdownUpgrade.Get() > 0)
               {
                  _loc4_.mcImage.visible = false;
                  _loc4_.mcLoading.visible = false;
                  _loc4_.tLabel.htmlText = "<font color=\"#CC0000\">" + KEYS.Get("hat_slot_upgrading") + "</font>";
               }
               else if(_loc7_._inProduction != "")
               {
                  _loc4_.mcLoading.visible = true;
                  ImageCache.GetImageWithCallBack("monsters/" + _loc7_._inProduction + "-medium.jpg",this.IconLoaded,true,1,"",["hatchery",_loc3_]);
                  _loc13_ = int(CREATURELOCKER._creatures[_loc7_._inProduction].props.cTime);
                  _loc14_ = 100 / _loc13_ * _loc7_._countdownProduce.Get();
                  if(_loc14_ < 0)
                  {
                     _loc14_ = 0;
                  }
                  this["bProgress" + _loc3_].mcBar.width = 100 - _loc14_;
                  if(_loc7_._countdownProduce.Get() > 0 && _loc7_._hasResources)
                  {
                     this["tProgress" + _loc3_].htmlText = "<b>" + GLOBAL.ToTime(_loc7_._countdownProduce.Get(),true) + "</b>";
                  }
                  else if(_loc7_._productionStage.Get() == 2 && Boolean(_loc7_._inProduction))
                  {
                     this["tProgress" + _loc3_].htmlText = "<b>" + KEYS.Get("hat_status_nospace") + "</b>";
                  }
                  else if(_loc7_._productionStage.Get() == 3 && _loc7_._taken.Get() == 0)
                  {
                     this["tProgress" + _loc3_].htmlText = "<b>" + KEYS.Get("hat_status_nogoo") + "</b>";
                  }
                  else
                  {
                     this["tProgress" + _loc3_].htmlText = "<b>" + KEYS.Get("hat_status_waiting") + "</b>";
                  }
                  this["bProgress" + _loc3_].visible = true;
                  this["tProgress" + _loc3_].visible = true;
               }
               else
               {
                  _loc4_.mcImage.visible = false;
                  _loc4_.mcLoading.visible = false;
                  this["bProgress" + _loc3_].visible = false;
                  this["tProgress" + _loc3_].visible = false;
               }
               _loc3_++;
            }
         }
         _loc8_ = 5;
         if(BASE._isOutpost)
         {
            _loc8_ = 2;
         }
         var _loc9_:int = _loc3_;
         while(_loc9_ <= 5)
         {
            _loc4_ = this["hatchery" + _loc9_];
            if(_loc9_ <= _loc8_)
            {
               _loc4_.visible = true;
               _loc4_.tLabel.htmlText = "<font color=\"#CC0000\">" + KEYS.Get("hat_slot_buildanother") + "</font>";
               _loc4_.mcLoading.visible = false;
               this["bProgress" + _loc9_].visible = false;
               this["tProgress" + _loc9_].visible = false;
               this["hatcheryRemove" + _loc9_].visible = false;
            }
            else
            {
               _loc4_.visible = false;
               this["bProgress" + _loc9_].visible = false;
               this["tProgress" + _loc9_].visible = false;
               this["hatcheryRemove" + _loc9_].visible = false;
            }
            _loc9_++;
         }
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
         if(this._guidePage == 3)
         {
            this._guidePage = 4;
         }
         if(this._guidePage > 9)
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
      
      public function Hide(param1:MouseEvent = null) : *
      {
         HATCHERYCC.Hide(param1);
      }
   }
}

