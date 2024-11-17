package
{
   import com.cc.utils.SecNum;
   import com.monsters.ai.WMBASE;
   import com.monsters.siege.SiegeWeapons;
   import com.monsters.siege.weapons.Vacuum;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.media.SoundChannel;
   import flash.utils.getTimer;
   import gs.TweenLite;
   import gs.easing.Expo;
   
   public class BUILDING14 extends BSTORAGE
   {
      public static const END_URL:String = "siegeimages/anim1.bottom.png";
      
      public static const END_NUM_FRAMES:uint = 15;
      
      public static const END_WIDTH:uint = 52;
      
      public static const END_HEIGHT:uint = 52;
      
      public static const PIPE_URL:String = "siegeimages/anim1.top.png";
      
      public static const PIPE_NUM_FRAMES:uint = 15;
      
      public static const PIPE_WIDTH:uint = 26;
      
      public static const PIPE_HEIGHT:uint = 97;
      
      public static const UNDERHALL_LEVEL:String = "underhalLevel";
      
      public var _vacuum:MovieClip;
      
      public var _vacuumSound:SoundChannel;
      
      public var _vacuumHealth:SecNum;
      
      public var _vacuumMaxHealth:int;
      
      public var _vacuumLootRate:SecNum;
      
      public var _vacuumFrame:int;
      
      public var _vacuumStartTime:int;
      
      public var _vacuumCurrTime:int;
      
      public var _vacuumPipeSource:BitmapData;
      
      public var _vacuumEndSource:BitmapData;
      
      public var _vacuumHealthBar:BitmapData = new bmp_healthbarsmall(0,0);
      
      public var _vacuumLootTotals:Array;
      
      public function BUILDING14()
      {
         super();
         _type = 14;
         _footprint = BASE.isInferno() ? [new Rectangle(0,0,160,160)] : [new Rectangle(0,0,130,130)];
         _gridCost = BASE.isInferno() ? [[new Rectangle(0,0,160,160),10],[new Rectangle(10,10,140,140),200]] : [[new Rectangle(0,0,130,130),10],[new Rectangle(10,10,110,110),200]];
         _spoutPoint = new Point(1,-67);
         _spoutHeight = 135;
         SetProps();
         SPRITES.SetupSprite("vacuum_pipe");
         SPRITES.SetupSprite("vacuum_end");
      }
      
      override public function Repair() : *
      {
         super.Repair();
      }
      
      public function VacuumLoot(param1:int) : *
      {
         var _loc6_:Object = null;
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = [];
         if(BASE._resources.r1.Get() > 0)
         {
            _loc3_.push({
               "id":1,
               "quantity":BASE._resources.r1.Get()
            });
         }
         if(BASE._resources.r2.Get() > 0)
         {
            _loc3_.push({
               "id":2,
               "quantity":BASE._resources.r2.Get()
            });
         }
         if(BASE._resources.r3.Get() > 0)
         {
            _loc3_.push({
               "id":3,
               "quantity":BASE._resources.r3.Get()
            });
         }
         if(BASE._resources.r4.Get() > 0)
         {
            _loc3_.push({
               "id":4,
               "quantity":BASE._resources.r4.Get()
            });
         }
         if(_loc3_.length > 0)
         {
            _loc6_ = _loc3_[int(Math.random() * _loc3_.length)];
            if(_loc6_.quantity >= Math.ceil(param1))
            {
               _loc2_ = Math.ceil(param1);
            }
            else
            {
               _loc2_ = int(_loc6_.quantity);
            }
            BASE._resources["r" + _loc6_.id].Add(-_loc2_);
            BASE._hpResources["r" + _loc6_.id] -= _loc2_;
            if(BASE._deltaResources["r" + _loc6_.id])
            {
               BASE._deltaResources["r" + _loc6_.id].Add(-_loc2_);
               BASE._hpDeltaResources["r" + _loc6_.id] -= _loc2_;
            }
            else
            {
               BASE._deltaResources["r" + _loc6_.id] = new SecNum(-_loc2_);
               BASE._hpDeltaResources["r" + _loc6_.id] = -_loc2_;
            }
            BASE._deltaResources.dirty = true;
            BASE._hpDeltaResources.dirty = true;
            if(GLOBAL._mode == "wmattack")
            {
               _loc2_ = int(_loc2_ / 5);
            }
            ATTACK.Loot(_loc6_.id,_loc2_,_mc.x,_mc.y,9,this,true);
            this._vacuumLootTotals[_loc6_.id - 1] += _loc2_;
         }
         else
         {
            param1 = 0;
         }
         var _loc4_:Number = this._vacuumHealth.Get();
         var _loc5_:Number = Vacuum(SiegeWeapons.activeWeapon).durability;
         if(_loc4_ < _loc5_)
         {
            _loc7_ = 11 - int(11 / _loc5_ * _loc4_);
         }
      }
      
      override public function TickFast(param1:Event = null) : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this._vacuum)
         {
            ++this._vacuumFrame;
            SPRITES.GetFrameById(this._vacuumEndSource,"vacuum_end",this._vacuumFrame % END_NUM_FRAMES,0);
            SPRITES.GetFrameById(this._vacuumPipeSource,"vacuum_pipe",this._vacuumFrame % PIPE_NUM_FRAMES,0);
            if(this._vacuumHealth.Get() > 0)
            {
               _loc2_ = (this._vacuumCurrTime - this._vacuumStartTime) * this._vacuumLootRate.Get() / 1000;
               this._vacuumCurrTime = getTimer();
               _loc3_ = (this._vacuumCurrTime - this._vacuumStartTime) * this._vacuumLootRate.Get() / 1000;
               this.VacuumLoot(_loc3_ - _loc2_);
            }
            else if(SiegeWeapons.activeWeapon)
            {
               SiegeWeapons.deactivateWeapon();
            }
         }
      }
      
      override public function Place(param1:MouseEvent = null) : *
      {
         if(!MAP._dragged)
         {
            super.Place(param1);
            _hasResources = true;
         }
      }
      
      override public function Cancel() : *
      {
         GLOBAL._bTownhall = null;
         super.Cancel();
      }
      
      override public function Recycle() : *
      {
         GLOBAL.Message(KEYS.Get("msg_cantrecycleth",{"v1":GLOBAL._bTownhall._buildingProps.name}));
      }
      
      override public function RecycleB(param1:MouseEvent = null) : *
      {
         GLOBAL.Message(KEYS.Get("msg_cantrecycleth",{"v1":GLOBAL._bTownhall._buildingProps.name}));
      }
      
      override public function RecycleC() : *
      {
         GLOBAL.Message(KEYS.Get("msg_cantrecycleth",{"v1":GLOBAL._bTownhall._buildingProps.name}));
      }
      
      override public function Destroyed(param1:Boolean = true) : *
      {
         super.Destroyed(param1);
         if(GLOBAL._advancedMap == 0 && GLOBAL._mode == "wmattack")
         {
            WMBASE._destroyed = true;
         }
      }
      
      override public function Description() : *
      {
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Object = null;
         var _loc9_:Array = null;
         super.Description();
         _buildingDescription = KEYS.Get("th_upgradedesc");
         if(_lvl.Get() == 1)
         {
            _recycleDescription = KEYS.Get("th_recycledesc");
         }
         if(_lvl.Get() > 0 && _lvl.Get() < _buildingProps.costs.length)
         {
            _loc1_ = [];
            _loc2_ = [];
            _loc3_ = [];
            for each(_loc4_ in GLOBAL._buildingProps)
            {
               if(_loc4_.id != 14)
               {
                  _loc5_ = int(_loc4_.quantity[_lvl.Get()]);
                  _loc6_ = int(_loc4_.quantity[_lvl.Get() + 1]);
                  _loc7_ = _loc6_ - _loc5_;
                  if(_loc5_ == 0 && _loc6_ > 0 && !_loc4_.block)
                  {
                     _loc1_.push([0,KEYS.Get(_loc4_.name)]);
                  }
                  else if(_loc7_ > 0 && !_loc4_.block)
                  {
                     _loc2_.push([0,KEYS.Get(_loc4_.name) + "s"]);
                  }
                  _loc5_ = 0;
                  _loc6_ = 0;
                  for each(_loc8_ in _loc4_.costs)
                  {
                     for each(_loc9_ in _loc8_.re)
                     {
                        if(_loc9_[0] == 14)
                        {
                           if(_loc9_[2] <= _lvl.Get())
                           {
                              _loc5_ = 1;
                           }
                           if(_loc9_[2] == _lvl.Get() + 1)
                           {
                              _loc6_ = 1;
                           }
                        }
                     }
                  }
                  if(_loc5_ > 0 && _loc6_ > 0 && !_loc4_.block)
                  {
                     _loc3_.push([0,KEYS.Get(_loc4_.name)]);
                  }
               }
            }
            if(_loc1_.length > 0)
            {
               _upgradeDescription += KEYS.Get("th_willunlockthe",{"v1":GLOBAL.Array2StringB(_loc1_)}) + "<br><br>";
            }
            if(_loc2_.length > 0)
            {
               _upgradeDescription += "<b>" + KEYS.Get("th_willbuildmore") + "</b><br>" + GLOBAL.Array2StringB(_loc2_) + "<br><br>";
            }
            if(_loc3_.length > 0)
            {
               _upgradeDescription += "<b>" + KEYS.Get("th_willupgrade") + "</b><br>" + GLOBAL.Array2StringB(_loc3_);
            }
         }
      }
      
      override public function Update(param1:Boolean = false) : *
      {
         super.Update(param1);
      }
      
      override public function Constructed() : *
      {
         GLOBAL._bTownhall = this;
         ACHIEVEMENTS.Check("thlevel",_lvl.Get());
         ACHIEVEMENTS.Check(ACHIEVEMENTS.UNDERHALL_LEVEL,_lvl.Get());
         super.Constructed();
      }
      
      override public function UpgradeB() : *
      {
         super.UpgradeB();
         if(_lvl.Get() >= 2 && _countdownUpgrade.Get() > 0 && _countdownUpgrade.Get() * 0.005555555555555555 > BASE._credits.Get())
         {
            POPUPS.DisplayPleaseBuy("TH");
         }
      }
      
      override public function Upgraded() : *
      {
         LOGGER.KongStat([2,_lvl.Get()]);
         ACHIEVEMENTS.Check("thlevel",_lvl.Get());
         ACHIEVEMENTS.Check(ACHIEVEMENTS.UNDERHALL_LEVEL,_lvl.Get());
         super.Upgraded();
         this.UnlockBuildings();
      }
      
      public function ApplyVacuum(param1:int, param2:int) : void
      {
         var _loc6_:Bitmap = null;
         this._vacuum = new MovieClip();
         this._vacuumEndSource = new BitmapData(END_WIDTH,END_HEIGHT,true,0);
         this._vacuumPipeSource = new BitmapData(PIPE_WIDTH,PIPE_HEIGHT,true,0);
         var _loc3_:Bitmap = new Bitmap(this._vacuumEndSource);
         this._vacuum.addChild(_loc3_);
         MAP._EFFECTSTOP.addChild(this._vacuum);
         this._vacuumSound = SOUNDS.Play("vacuumstart");
         if(this._vacuumSound)
         {
            this._vacuumSound.addEventListener(Event.SOUND_COMPLETE,this.onLoopStartSoundComplete,false,0,true);
         }
         this._vacuumLootTotals = [];
         this._vacuumLootTotals = [0,0,0,0];
         var _loc4_:int = -GLOBAL._mapHeight;
         var _loc5_:int = 0;
         _loc3_.x = -(END_WIDTH / 2);
         _loc3_.y = _loc5_ = _loc5_ - END_HEIGHT;
         while(_loc5_ > _loc4_)
         {
            _loc6_ = new Bitmap(this._vacuumPipeSource);
            _loc6_.x = -(PIPE_WIDTH / 2);
            _loc6_.y = _loc5_ = _loc5_ - PIPE_HEIGHT;
            this._vacuum.addChild(_loc6_);
         }
         this._vacuumLootRate = new SecNum(param2);
         this._vacuumMaxHealth = param1;
         this._vacuumHealth = new SecNum(param1);
         this._vacuumStartTime = this._vacuumCurrTime = getTimer();
         _mc.addEventListener(Event.ENTER_FRAME,this.TickFast);
         this._vacuum.x = _mc.x;
         this._vacuum.y = _mc.y - 400;
         this._vacuum.alpha = 0;
         TweenLite.to(this._vacuum,2,{
            "y":_mc.y + _spoutPoint.y - 50,
            "alpha":1,
            "ease":Expo.easeOut
         });
      }
      
      public function onLoopStartSoundComplete(param1:Event) : void
      {
         this._vacuumSound = SOUNDS.Play("vacuumloop",0.8,0,100);
      }
      
      public function RemoveVacuum(param1:Boolean = false) : void
      {
         var ActuallyRemove:Function = null;
         var savedVacuum:MovieClip = null;
         var wasDestroyed:Boolean = param1;
         ActuallyRemove = function():void
         {
            if(savedVacuum.parent)
            {
               savedVacuum.parent.removeChild(savedVacuum);
            }
            _vacuumEndSource.dispose();
            _vacuumPipeSource.dispose();
         };
         if(this._vacuum)
         {
            savedVacuum = this._vacuum;
            this._vacuum = null;
            if(this._vacuumHealth)
            {
               this._vacuumHealth.Set(0);
            }
            this._vacuumMaxHealth = 0;
            _mc.removeEventListener(Event.ENTER_FRAME,this.TickFast);
            if(this._vacuumSound)
            {
               this._vacuumSound.stop();
               SOUNDS.Play(wasDestroyed ? "vacuumbroken" : "vacuumloopoff");
            }
            TweenLite.to(savedVacuum,2,{
               "y":_mc.y - 400,
               "alpha":0,
               "ease":Expo.easeOut,
               "onComplete":ActuallyRemove
            });
         }
      }
      
      private function UnlockBuildings() : void
      {
         var _loc1_:int = 0;
         if(GLOBAL._mode == "build")
         {
            _loc1_ = _lvl.Get();
            if(BASE.isInferno())
            {
               GLOBAL.StatSet(UNDERHALL_LEVEL,_loc1_);
            }
         }
      }
      
      override public function Setup(param1:Object) : *
      {
         super.Setup(param1);
         GLOBAL._bTownhall = this;
         this.UnlockBuildings();
         ACHIEVEMENTS.Check("thlevel",_lvl.Get());
         ACHIEVEMENTS.Check(ACHIEVEMENTS.UNDERHALL_LEVEL,_lvl.Get());
      }
   }
}

