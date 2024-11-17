package
{
   import com.monsters.display.ImageCache;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import gs.TweenLite;
   import gs.easing.*;
   
   public class CHAMPIONCHAMBERPOPUP extends GUARDIANCHAMBERPOPUP_CLIP
   {
      private var _guardChamber:CHAMPIONCHAMBER;
      
      private var _guardState:Object;
      
      private var _selectGuard:Object;
      
      private var _statsArr:Array;
      
      private var _activeSlots:int = 0;
      
      private var _useBonusIndicators:Boolean = false;
      
      public function CHAMPIONCHAMBERPOPUP()
      {
         super();
         this._guardChamber = GLOBAL._bChamber as CHAMPIONCHAMBER;
         this._statsArr = [damage_txt,tDamage,bDamage,health_txt,tHealth,bHealth,speed_txt,tSpeed,bSpeed,buff_txt,tBuff,bBuff,tEvoStage,tEvoDesc];
         this._activeSlots = 0;
         tTitle.htmlText = KEYS.Get("chamber_title");
         this.InitInteractions();
         this.SetupSlots();
         this.SelectGuard();
      }
      
      public function InitInteractions() : void
      {
         slot1.addEventListener(MouseEvent.ROLL_OVER,this.SelectGuard);
         slot2.addEventListener(MouseEvent.ROLL_OVER,this.SelectGuard);
         slot3.addEventListener(MouseEvent.ROLL_OVER,this.SelectGuard);
      }
      
      public function FreezeGuard(param1:MouseEvent = null) : *
      {
         if(GLOBAL._mode == "build" && BASE._yardType == BASE.MAIN_YARD)
         {
            this._guardChamber.FreezeGuardian();
            this.Hide();
         }
      }
      
      private function ThawGuard(param1:Number = 0) : *
      {
         var targetChamp:Number = param1;
         return function(param1:MouseEvent = null):*
         {
            if(GLOBAL._mode == "build" && BASE._yardType == BASE.MAIN_YARD)
            {
               _guardChamber.ThawGuardian(targetChamp);
               Hide();
            }
         };
      }
      
      public function SelectGuard(param1:MouseEvent = null) : *
      {
         var _loc3_:Object = null;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         if(Boolean(CREATURES._guardian) && Boolean(CREATURES._guardian._type))
         {
            _loc2_ = CREATURES._guardian._type;
         }
         if(param1)
         {
            if(param1.currentTarget == slot1)
            {
               _loc2_ = 1;
            }
            else if(param1.currentTarget == slot2)
            {
               _loc2_ = 2;
            }
            else if(param1.currentTarget == slot3)
            {
               _loc2_ = 3;
            }
         }
         if(Boolean(CREATURES._guardian) && CREATURES._guardian._type == _loc2_)
         {
            _loc3_ = {};
            if(CREATURES._guardian._name)
            {
               _loc3_.nm = CREATURES._guardian._name;
            }
            if(CREATURES._guardian._creatureID)
            {
               _loc3_.t = CREATURES._guardian._creatureID.substr(1,1);
               _loc3_.id = CREATURES._guardian._creatureID;
            }
            if(CREATURES._guardian._health)
            {
               _loc3_.hp = CREATURES._guardian._health.Get();
            }
            else
            {
               _loc3_.hp = 0;
            }
            if(CREATURES._guardian._level)
            {
               _loc3_.l = CREATURES._guardian._level.Get();
            }
            if(CREATURES._guardian._feedTime)
            {
               _loc3_.ft = CREATURES._guardian._feedTime.Get();
            }
            if(CREATURES._guardian._feeds)
            {
               _loc3_.fd = CREATURES._guardian._feeds.Get();
            }
            else
            {
               _loc3_.fd = 0;
            }
            if(CREATURES._guardian._foodBonus)
            {
               _loc3_.fb = CREATURES._guardian._foodBonus.Get();
            }
            else
            {
               _loc3_.fb = 0;
            }
            this._selectGuard = _loc3_;
         }
         else
         {
            _loc4_ = false;
            if(this._guardChamber._frozen)
            {
               _loc5_ = 0;
               while(_loc5_ < this._guardChamber._frozen.length)
               {
                  if(this._guardChamber._frozen[_loc5_].t == _loc2_)
                  {
                     _loc4_ = true;
                     _loc3_ = {};
                     if(this._guardChamber._frozen[_loc5_].nm)
                     {
                        _loc3_.nm = this._guardChamber._frozen[_loc5_].nm;
                     }
                     if(this._guardChamber._frozen[_loc5_].t)
                     {
                        _loc3_.t = this._guardChamber._frozen[_loc5_].t;
                        _loc3_.id = "G" + this._guardChamber._frozen[_loc5_].t;
                     }
                     if(this._guardChamber._frozen[_loc5_].hp)
                     {
                        _loc3_.hp = this._guardChamber._frozen[_loc5_].hp.Get();
                     }
                     else
                     {
                        _loc3_.hp = 0;
                     }
                     if(this._guardChamber._frozen[_loc5_].l)
                     {
                        _loc3_.l = this._guardChamber._frozen[_loc5_].l.Get();
                     }
                     if(this._guardChamber._frozen[_loc5_].ft)
                     {
                        _loc3_.ft = this._guardChamber._frozen[_loc5_].ft;
                     }
                     if(this._guardChamber._frozen[_loc5_].fd)
                     {
                        _loc3_.fd = this._guardChamber._frozen[_loc5_].fd;
                     }
                     else
                     {
                        _loc3_.fd = 0;
                     }
                     if(this._guardChamber._frozen[_loc5_].fb)
                     {
                        _loc3_.fb = this._guardChamber._frozen[_loc5_].fb.Get();
                     }
                     else
                     {
                        _loc3_.fb = 0;
                     }
                     this._selectGuard = _loc3_;
                  }
                  _loc5_++;
               }
            }
            if(_loc4_)
            {
            }
         }
         this.UpdateStats(this._selectGuard);
      }
      
      public function Update() : void
      {
      }
      
      public function UpdateInventory() : void
      {
         var _loc2_:String = null;
         var _loc3_:* = undefined;
         var _loc1_:int = 0;
         for(_loc2_ in CHAMPIONCAGE._guardians)
         {
            _loc1_++;
            _loc3_ = _loc2_;
            _loc3_.active = 0;
            _loc3_.frozen = 0;
            _loc3_.type = int(_loc3_.substr(1,1));
            this._guardState[_loc2_] = _loc3_;
         }
      }
      
      public function SetupSlots() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         this._activeSlots = 0;
         var _loc1_:* = 1;
         while(_loc1_ <= 3)
         {
            if(Boolean(CREATURES._guardian) && CREATURES._guardian._type == _loc1_)
            {
               this.SetupSlot(this["slot" + _loc1_],CREATURES._guardian,false);
               ++this._activeSlots;
            }
            else
            {
               _loc2_ = false;
               if(this._guardChamber._frozen)
               {
                  _loc3_ = 0;
                  while(_loc3_ < this._guardChamber._frozen.length)
                  {
                     if(this._guardChamber._frozen[_loc3_].t == _loc1_)
                     {
                        this.SetupSlot(this["slot" + _loc1_],this._guardChamber._frozen[_loc3_],true);
                        this.ShowSlot(_loc1_);
                        ++this._activeSlots;
                        _loc2_ = true;
                        if(!this._selectGuard)
                        {
                           _loc4_ = {};
                           if(this._guardChamber._frozen[_loc3_].nm)
                           {
                              _loc4_.nm = this._guardChamber._frozen[_loc3_].nm;
                           }
                           if(this._guardChamber._frozen[_loc3_].t)
                           {
                              _loc4_.t = this._guardChamber._frozen[_loc3_].t;
                              _loc4_.id = "G" + this._guardChamber._frozen[_loc3_].t;
                           }
                           if(this._guardChamber._frozen[_loc3_].hp)
                           {
                              _loc4_.hp = this._guardChamber._frozen[_loc3_].hp.Get();
                           }
                           else
                           {
                              _loc4_.hp = 0;
                           }
                           if(this._guardChamber._frozen[_loc3_].l)
                           {
                              _loc4_.l = this._guardChamber._frozen[_loc3_].l.Get();
                           }
                           if(this._guardChamber._frozen[_loc3_].ft)
                           {
                              _loc4_.ft = this._guardChamber._frozen[_loc3_].ft;
                           }
                           if(this._guardChamber._frozen[_loc3_].fd)
                           {
                              _loc4_.fd = this._guardChamber._frozen[_loc3_].fd;
                           }
                           else
                           {
                              _loc4_.fd = 0;
                           }
                           if(this._guardChamber._frozen[_loc3_].fb)
                           {
                              _loc4_.fb = this._guardChamber._frozen[_loc3_].fb.Get();
                           }
                           else
                           {
                              _loc4_.fb = 0;
                           }
                           this._selectGuard = _loc4_;
                        }
                     }
                     _loc3_++;
                  }
               }
               if(!_loc2_)
               {
                  this.HideSlot(_loc1_);
               }
            }
            _loc1_++;
         }
         this.LayoutSlots();
      }
      
      public function HideSlot(param1:int = 1) : void
      {
         this["slot" + param1].visible = false;
         this["bFreeze" + param1].visible = false;
      }
      
      public function ShowSlot(param1:int = 1) : void
      {
         this["slot" + param1].visible = true;
         this["bFreeze" + param1].visible = true;
      }
      
      public function SetupSlot(param1:MovieClip, param2:Object, param3:Boolean) : void
      {
         var UpdateFrozenImage:Function;
         var guardFrozen:Boolean = false;
         var guardType:String = null;
         var guardImage:String = null;
         var guardName:String = null;
         var guardLevel:int = 0;
         var guardData:Object = null;
         var description:String = null;
         var mcSlot:MovieClip = param1;
         var guardObj:Object = param2;
         var froze:Boolean = param3;
         if(!guardObj && !guardObj.t)
         {
            return;
         }
         mcSlot.visible = true;
         guardFrozen = froze;
         if(froze)
         {
            guardType = guardObj.t;
            guardLevel = int(guardObj.l.Get());
            guardImage = "monsters/G" + guardType + "_L" + guardLevel + "-150.png";
            guardName = CHAMPIONCAGE._guardians["G" + guardType].name;
            guardData = CHAMPIONCAGE._guardians["G" + guardType];
         }
         else
         {
            guardType = guardObj._type;
            guardLevel = int(guardObj._level.Get());
            guardImage = "monsters/G" + guardType + "_L" + guardLevel + "-150.png";
            guardName = CHAMPIONCAGE._guardians["G" + guardType].name;
            guardData = CHAMPIONCAGE._guardians["G" + guardType];
         }
         description = "<b>" + guardName + "</b><br>" + KEYS.Get("chamber_level",{"v1":guardLevel});
         mcSlot.tName.htmlText = description;
         if(guardImage)
         {
            UpdateFrozenImage = function(param1:String, param2:BitmapData):*
            {
               var _loc3_:int = int(mcSlot.mcImage.numChildren);
               while(_loc3_--)
               {
                  mcSlot.mcImage.removeChildAt(_loc3_);
               }
               var _loc4_:* = new Bitmap(param2);
               if(guardLevel <= 2)
               {
                  _loc4_.x = 20;
               }
               mcSlot.mcImage.addChild(_loc4_);
            };
            if(guardFrozen)
            {
               mcSlot.gotoAndStop("frozen");
            }
            else
            {
               mcSlot.gotoAndStop("thaw");
            }
            ImageCache.GetImageWithCallBack(guardImage,UpdateFrozenImage);
         }
         if(froze)
         {
            this["bFreeze" + guardType].removeEventListener(MouseEvent.CLICK,this.FreezeGuard);
            this["bFreeze" + guardType].Setup(KEYS.Get("btn_thawname",{"v1":guardName}),false,0,0);
            this["bFreeze" + guardType].addEventListener(MouseEvent.CLICK,this.ThawGuard(Number(guardType)));
         }
         else
         {
            this["bFreeze" + guardType].removeEventListener(MouseEvent.CLICK,this.ThawGuard(Number(guardType)));
            this["bFreeze" + guardType].Setup(KEYS.Get("btn_freezename",{"v1":guardName}),false,0,0);
            this["bFreeze" + guardType].addEventListener(MouseEvent.CLICK,this.FreezeGuard);
         }
      }
      
      public function LayoutSlots() : void
      {
         var _loc2_:int = slot1.width;
         var _loc5_:int = (600 - 25 * Math.max(0,this._activeSlots - 1)) / (this._activeSlots + 1);
         if(this._activeSlots == 3)
         {
            _loc5_ = 65;
         }
         var _loc6_:int = 0;
         var _loc7_:* = 1;
         while(_loc7_ <= 3)
         {
            if(!this["slot" + _loc7_].visible)
            {
               _loc6_++;
            }
            if(this._activeSlots == 3)
            {
               _loc6_ = 0;
            }
            this["slot" + _loc7_].x = this.x - this.width / 2 + _loc5_ + Math.max(0,_loc7_ - 1 - _loc6_) * (_loc2_ + 25);
            this["bFreeze" + _loc7_].x = this["slot" + _loc7_].x + 30;
            _loc7_++;
         }
      }
      
      private function UpdateStats(param1:Object = null) : *
      {
         var guard:*;
         var guardType:int;
         var guardLevel:*;
         var foodBonus:*;
         var guardID:*;
         var guardImage:String;
         var maxSpeed:Number;
         var maxHealth:Number;
         var maxDamage:Number;
         var maxBuff:Number;
         var maxLevel:Number;
         var UpdateSelectImage:Function;
         var s:int = 0;
         var apeDesc:String = null;
         var dragDesc:String = null;
         var flyDesc:String = null;
         var guardDamage:Number = NaN;
         var guardHealth:Number = NaN;
         var guardSpeed:Number = NaN;
         var guardBuff:Number = NaN;
         var baseDamage:Number = NaN;
         var baseHealth:Number = NaN;
         var baseSpeed:Number = NaN;
         var baseBuff:Number = NaN;
         var guardSpeedTxt:Number = NaN;
         var bonus:int = 0;
         var guardData:Object = param1;
         if(guardData == null)
         {
            s = 0;
            while(s < this._statsArr.length)
            {
               this._statsArr[s].visible = false;
               s++;
            }
            return;
         }
         s = 0;
         while(s < this._statsArr.length)
         {
            this._statsArr[s].visible = true;
            s++;
         }
         guard = guardData;
         guardType = int(guardData.t);
         guardLevel = guardData.l;
         foodBonus = guardData.fb;
         guardID = guardData.id;
         guardImage = "monsters/G" + guardType + "_L" + guardLevel + "-150.png";
         maxSpeed = CHAMPIONCAGEPOPUP._maxSpeed;
         maxHealth = CHAMPIONCAGEPOPUP._maxHealth;
         maxDamage = CHAMPIONCAGEPOPUP._maxDamage;
         maxBuff = CHAMPIONCAGEPOPUP._maxBuff;
         maxLevel = CHAMPIONCAGEPOPUP._maxLevel;
         if(guardImage)
         {
            UpdateSelectImage = function(param1:String, param2:BitmapData):*
            {
               var _loc3_:int = selectedImage.numChildren;
               while(_loc3_--)
               {
                  selectedImage.removeChildAt(_loc3_);
               }
               var _loc4_:* = new Bitmap(param2);
               selectedImage.addChild(_loc4_);
            };
            ImageCache.GetImageWithCallBack(guardImage,UpdateSelectImage);
         }
         if(guardData)
         {
            damage_txt.htmlText = "<b>" + KEYS.Get("gcage_labelDamage") + "</b>";
            health_txt.htmlText = "<b>" + KEYS.Get("gcage_labelHealth") + "</b>";
            speed_txt.htmlText = "<b>" + KEYS.Get("gcage_labelSpeed") + "</b>";
            buff_txt.htmlText = "<b>" + KEYS.Get("gcage_labelBuff") + "</b>";
            apeDesc = KEYS.Get("mon_gorgodesc");
            dragDesc = KEYS.Get("mon_drulldesc");
            flyDesc = KEYS.Get("mon_fomordesc");
            tEvoStage.htmlText = "<b>" + CHAMPIONCAGE._guardians["G" + guardType].name + "</b> " + KEYS.Get("chamber_level",{"v1":guardLevel});
            switch(guardType)
            {
               case 1:
                  tEvoDesc.htmlText = apeDesc;
                  break;
               case 2:
                  tEvoDesc.htmlText = dragDesc;
                  break;
               case 3:
                  tEvoDesc.htmlText = flyDesc;
            }
            guardDamage = CHAMPIONCAGE.GetGuardianProperty(guardID,guardLevel,"damage");
            guardHealth = CHAMPIONCAGE.GetGuardianProperty(guardID,guardLevel,"health");
            guardSpeed = CHAMPIONCAGE.GetGuardianProperty(guardID,guardLevel,"speed");
            guardBuff = CHAMPIONCAGE.GetGuardianProperty(guardID,guardLevel,"buffs") * 100;
            if(foodBonus > 0)
            {
               guardDamage += CHAMPIONCAGE.GetGuardianProperty(guardID,foodBonus,"bonusDamage");
               guardHealth += CHAMPIONCAGE.GetGuardianProperty(guardID,foodBonus,"bonusHealth");
               guardSpeed += CHAMPIONCAGE.GetGuardianProperty(guardID,foodBonus,"bonusSpeed");
               guardBuff += CHAMPIONCAGE.GetGuardianProperty(guardID,foodBonus,"bonusBuffs") * 100;
            }
            baseDamage = CHAMPIONCAGE.GetGuardianProperty(guardID,guardLevel,"damage");
            baseHealth = CHAMPIONCAGE.GetGuardianProperty(guardID,guardLevel,"health");
            baseSpeed = CHAMPIONCAGE.GetGuardianProperty(guardID,guardLevel,"speed");
            baseBuff = CHAMPIONCAGE.GetGuardianProperty(guardID,guardLevel,"buffs") * 100;
            guardSpeedTxt = int(guardSpeed * 10) / 10;
            tDamage.htmlText = "" + guardDamage;
            tHealth.htmlText = "" + guardHealth;
            tSpeed.htmlText = "" + guardSpeedTxt;
            tBuff.htmlText = "" + int(guardBuff) + "%";
            TweenLite.to(bDamage.mcBar,0.4,{
               "width":100 / maxDamage * guardDamage,
               "ease":Circ.easeInOut,
               "delay":0
            });
            bonus = 0;
            while(bonus <= 3)
            {
               if(bonus > 0)
               {
                  bDamage["mcBuff" + bonus].visible = false;
                  bDamage["mcBuff" + bonus].gotoAndStop(1 + bonus);
               }
               bonus++;
            }
            TweenLite.to(bHealth.mcBar,0.4,{
               "width":100 / maxHealth * guardHealth,
               "ease":Circ.easeInOut,
               "delay":0.05
            });
            bonus = 0;
            while(bonus <= 3)
            {
               if(bonus > 0)
               {
                  bHealth["mcBuff" + bonus].visible = false;
                  bHealth["mcBuff" + bonus].gotoAndStop(1 + bonus);
               }
               bonus++;
            }
            TweenLite.to(bSpeed.mcBar,0.4,{
               "width":100 / maxSpeed * guardSpeed,
               "ease":Circ.easeInOut,
               "delay":0.1
            });
            bonus = 0;
            while(bonus <= 3)
            {
               if(bonus > 0)
               {
                  bSpeed["mcBuff" + bonus].visible = false;
                  bSpeed["mcBuff" + bonus].gotoAndStop(1 + bonus);
               }
               bonus++;
            }
            TweenLite.to(bBuff.mcBar,0.4,{
               "width":100 / maxBuff * guardBuff,
               "ease":Circ.easeInOut,
               "delay":0.15
            });
            bonus = 0;
            while(bonus <= 3)
            {
               if(bonus > 0)
               {
                  bBuff["mcBuff" + bonus].visible = false;
                  bBuff["mcBuff" + bonus].gotoAndStop(1 + bonus);
               }
               bonus++;
            }
         }
      }
      
      public function Hide(param1:MouseEvent = null) : void
      {
         CHAMPIONCHAMBER.Hide();
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

