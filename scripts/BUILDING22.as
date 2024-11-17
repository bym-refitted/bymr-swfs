package
{
   import com.cc.utils.SecNum;
   import com.monsters.monsters.MonsterBase;
   import com.monsters.siege.SiegeWeapons;
   import com.monsters.siege.weapons.Decoy;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gs.TweenLite;
   import gs.easing.Expo;
   
   public class BUILDING22 extends BFOUNDATION
   {
      public var _animMC:MovieClip;
      
      public var _animFrame:int = 0;
      
      public var _field:BitmapData;
      
      public var _fieldBMP:Bitmap;
      
      public var _frameNumber:int;
      
      public var _animBitmap:BitmapData;
      
      public var _blend:int;
      
      public var _blending:Boolean;
      
      public var _bank:SecNum;
      
      public var _monsters:Object;
      
      public var _open:Boolean;
      
      public var _releaseCooldown:int = 0;
      
      public var _targetCreeps:Array;
      
      public var _targetFlyers:Array;
      
      public var _targetCreep:*;
      
      public var _monstersDispatched:Object;
      
      public var _monstersDispatchedTotal:int = 0;
      
      public var _hasTargets:Boolean = false;
      
      public var _tickNumber:int = 0;
      
      public var _capacity:int = 0;
      
      public var _used:int = 0;
      
      private var _logged:Boolean = false;
      
      private var _radiusGraphic:Shape;
      
      public function BUILDING22()
      {
         super();
         _type = 22;
         this._frameNumber = 0;
         _footprint = [new Rectangle(0,0,90,90)];
         _gridCost = [[new Rectangle(0,0,10,10),50],[new Rectangle(80,0,10,10),50],[new Rectangle(0,80,10,10),50],[new Rectangle(80,80,10,10),50]];
         _spoutPoint = new Point(0,0);
         _spoutHeight = 40;
         this._monsters = {};
         this._monstersDispatched = {};
         this._targetCreeps = [];
         this._targetFlyers = [];
         SetProps();
      }
      
      public function FindTargets(param1:int, param2:int = 1) : void
      {
         var _loc3_:Object = null;
         var _loc4_:MonsterBase = null;
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         var _loc7_:Point = null;
         var _loc8_:int = 0;
         var _loc9_:Array = null;
         if(_lvl.Get() > 0 && _hp.Get() > 0)
         {
            _loc9_ = MAP.CreepCellFind(_position.add(new Point(0,_footprint[0].height / 2)),GLOBAL._buildingProps[21].stats[_lvl.Get() - 1].range);
            this._hasTargets = false;
            if(_loc9_.length > 0)
            {
               this._targetCreeps = [];
               if(param2 == 1)
               {
                  _loc9_.sortOn(["dist"],Array.NUMERIC);
               }
               else if(param2 == 2)
               {
                  _loc9_.sortOn(["dist"],Array.NUMERIC | Array.DESCENDING);
               }
               else if(param2 == 3)
               {
                  _loc9_.sortOn(["hp"],Array.NUMERIC | Array.DESCENDING);
               }
               else if(param2 == 4)
               {
                  _loc9_.sortOn(["hp"],Array.NUMERIC);
               }
               _loc8_ = 0;
               for(_loc5_ in _loc9_)
               {
                  _loc8_++;
                  if(_loc8_ <= param1 && _loc9_[_loc5_].creep._behaviour != "retreat")
                  {
                     _loc3_ = _loc9_[_loc5_];
                     _loc4_ = _loc3_.creep;
                     _loc6_ = Number(_loc3_.dist);
                     _loc7_ = _loc3_.pos;
                     this._targetCreeps.push({
                        "creep":_loc4_,
                        "dist":_loc6_,
                        "position":_loc7_
                     });
                     this._hasTargets = true;
                  }
               }
            }
            if(Boolean(this._monsters["C12"]) && Boolean(ACADEMY._upgrades["C12"].powerup) || Boolean(this._monsters["C5"]) && Boolean(ACADEMY._upgrades["C5"].powerup) || Boolean(this._monsters["IC5"]) || Boolean(this._monsters["IC7"]))
            {
               _loc9_ = MAP.CreepCellFind(_position.add(new Point(0,_footprint[0].height / 2)),GLOBAL._buildingProps[21].stats[_lvl.Get() - 1].range,2);
               if(_loc9_.length > 0)
               {
                  this._targetFlyers = [];
                  if(param2 == 1)
                  {
                     _loc9_.sortOn(["dist"],Array.NUMERIC);
                  }
                  else if(param2 == 2)
                  {
                     _loc9_.sortOn(["dist"],Array.NUMERIC | Array.DESCENDING);
                  }
                  else if(param2 == 3)
                  {
                     _loc9_.sortOn(["hp"],Array.NUMERIC | Array.DESCENDING);
                  }
                  else if(param2 == 4)
                  {
                     _loc9_.sortOn(["hp"],Array.NUMERIC);
                  }
                  _loc8_ = 0;
                  for(_loc5_ in _loc9_)
                  {
                     _loc8_++;
                     if(_loc8_ <= param1 && _loc9_[_loc5_].creep._behaviour != "retreat")
                     {
                        _loc3_ = _loc9_[_loc5_];
                        _loc4_ = _loc3_.creep;
                        _loc6_ = Number(_loc3_.dist);
                        _loc7_ = _loc3_.pos;
                        this._targetFlyers.push({
                           "creep":_loc4_,
                           "dist":_loc6_,
                           "position":_loc7_
                        });
                        this._hasTargets = true;
                     }
                  }
               }
            }
            else
            {
               this._targetFlyers = [];
            }
            return;
         }
         this._targetCreeps = [];
         this._targetFlyers = [];
         this._hasTargets = false;
      }
      
      public function GetTarget(param1:int = 0) : *
      {
         var _loc2_:int = 0;
         if(this._hasTargets)
         {
            if(param1 > 0 && this._targetFlyers.length > 0)
            {
               _loc2_ = int(Math.random() * this._targetFlyers.length);
               if(_loc2_ > this._targetFlyers.length)
               {
                  _loc2_ = 2;
               }
               return this._targetFlyers[_loc2_].creep;
            }
            if(this._targetCreeps.length > 0)
            {
               _loc2_ = int(Math.random() * this._targetCreeps.length);
               if(_loc2_ > this._targetCreeps.length)
               {
                  _loc2_ = 2;
               }
               return this._targetCreeps[_loc2_].creep;
            }
            return null;
         }
         return null;
      }
      
      public function EjectCreeps(param1:Point) : void
      {
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = undefined;
         var _loc2_:String = null;
         for(_loc3_ in this._monsters)
         {
            if(this._monsters[_loc3_] && this._monstersDispatched[_loc3_] < this._monsters[_loc3_] && _animTick >= 15)
            {
               _loc2_ = _loc3_;
               if(_loc2_)
               {
                  _loc4_ = param1.x - _position.x;
                  _loc5_ = param1.y - _position.y;
                  _loc6_ = int(_footprint[0].width);
                  _loc7_ = int(_footprint[0].height);
                  if(_loc5_ <= 0)
                  {
                     _loc5_ = _loc7_ / 4;
                     if(_loc4_ <= 0)
                     {
                        _loc4_ = _loc6_ / -3;
                     }
                     else
                     {
                        _loc4_ = _loc6_ / 2;
                     }
                  }
                  else
                  {
                     _loc5_ = _loc7_ / 2;
                     if(_loc4_ <= 0)
                     {
                        _loc4_ = _loc6_ / -4;
                     }
                     else
                     {
                        _loc4_ = _loc6_ / 2;
                     }
                  }
                  _loc8_ = CREATURES.Spawn(_loc2_,MAP._BUILDINGTOPS,"decoy",_position.add(new Point(_loc4_,_loc5_)),Math.random() * 360);
                  if(_loc8_)
                  {
                     _loc8_._homeBunker = this;
                     ++this._monstersDispatched[_loc2_];
                     ++this._monstersDispatchedTotal;
                  }
               }
            }
         }
      }
      
      private function DecoyInRange() : Boolean
      {
         var _loc1_:Decoy = null;
         var _loc2_:Point = null;
         if(Boolean(SiegeWeapons.activeWeapon) && SiegeWeapons.activeWeaponID == Decoy.ID)
         {
            _loc1_ = SiegeWeapons.activeWeapon as Decoy;
            if(_loc1_)
            {
               _loc2_ = new Point(_loc1_.x,_loc1_.y);
               if(GLOBAL.QuickDistance(_loc2_,_position) < _loc1_.range)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      override public function TickAttack() : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:* = undefined;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = undefined;
         var _loc11_:Array = null;
         var _loc12_:String = null;
         var _loc13_:Boolean = false;
         var _loc1_:Boolean = false;
         super.TickAttack();
         if(_hp.Get() > 0)
         {
            this._capacity = GLOBAL._buildingProps[21].capacity[_lvl.Get() - 1];
         }
         this._used = 0;
         for(_loc2_ in this._monsters)
         {
            this._used += CREATURES.GetProperty(_loc2_,"cStorage",0,true) * this._monsters[_loc2_];
            if(!this._monstersDispatched[_loc2_])
            {
               this._monstersDispatched[_loc2_] = 0;
            }
         }
         this.Cull();
         _loc3_ = 0;
         while(_loc3_ < this._targetCreeps.length)
         {
            if(this._targetCreeps[_loc3_].creep._health.Get() <= 0)
            {
               _loc1_ = true;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this._targetFlyers.length)
         {
            if(this._targetFlyers[_loc3_].creep._health.Get() <= 0)
            {
               _loc1_ = true;
            }
            _loc3_++;
         }
         if(_loc1_)
         {
            this._targetCreeps = [];
            this._targetFlyers = [];
            this._hasTargets = false;
         }
         if(_countdownUpgrade.Get() == 0 && ((!this._hasTargets || _loc1_) && this._frameNumber % 10 == 0 || this._frameNumber % 60 == 0))
         {
            this.FindTargets(3);
         }
         ++this._tickNumber;
         if((this._targetFlyers.length > 0 || this._targetCreeps.length > 0) && (_animTick >= 15 || GLOBAL._catchup) && this._tickNumber % 30 == 0)
         {
            _loc4_ = null;
            this._targetCreeps.sortOn(["dist"],Array.NUMERIC);
            this._targetFlyers.sortOn(["dist"],Array.NUMERIC);
            if(this._targetFlyers.length > 0 && this._monsters["C12"] > 0 && (this._monstersDispatched["C12"] < this._monsters["C12"] && ACADEMY._upgrades["C12"].powerup))
            {
               _loc4_ = "C12";
            }
            else if(this._targetFlyers.length > 0 && this._monsters["C5"] > 0 && this._monstersDispatched["C5"] < this._monsters["C5"] && Boolean(ACADEMY._upgrades["C5"].powerup))
            {
               _loc4_ = "C5";
            }
            else if(this._targetFlyers.length > 0 && this._monsters["IC5"] > 0 && this._monstersDispatched["IC5"] < this._monsters["IC5"])
            {
               _loc4_ = "IC5";
            }
            else if(this._targetFlyers.length > 0 && this._monsters["IC7"] > 0 && this._monstersDispatched["IC7"] < this._monsters["IC7"])
            {
               _loc4_ = "IC7";
            }
            else if(this._targetCreeps.length > 0)
            {
               for(_loc2_ in this._monsters)
               {
                  if(Boolean(this._monsters[_loc2_]) && this._monstersDispatched[_loc2_] < this._monsters[_loc2_])
                  {
                     _loc4_ = _loc2_;
                  }
               }
            }
            if(_loc4_)
            {
               if(!this._logged)
               {
                  _loc11_ = [];
                  for(_loc2_ in this._monsters)
                  {
                     if(this._monsters[_loc2_] > 0)
                     {
                        _loc13_ = false;
                        _loc12_ = KEYS.Get(CREATURELOCKER._creatures[_loc2_].name);
                        _loc11_.push([this._monsters[_loc2_],_loc12_]);
                     }
                  }
                  this._logged = true;
                  ATTACK.Log("b" + _id,"<font color=\"#FF0000\">" + KEYS.Get("attacklog_unleashed",{
                     "v1":_lvl.Get(),
                     "v2":KEYS.Get(_buildingProps.name),
                     "v3":GLOBAL.Array2String(_loc11_)
                  }) + "</font>");
               }
               if(this._targetFlyers.length > 0 && (_loc4_ == "C12" || _loc4_ == "C5" || _loc4_ == "IC5" || _loc4_ == "IC7"))
               {
                  _loc5_ = this._targetFlyers[int(Math.random() * this._targetFlyers.length)].creep;
               }
               else
               {
                  _loc5_ = this._targetCreeps[int(Math.random() * this._targetCreeps.length)].creep;
               }
               _loc6_ = _loc5_._tmpPoint.x - _position.x;
               _loc7_ = _loc5_._tmpPoint.y - _position.y;
               _loc8_ = int(_footprint[0].width);
               _loc9_ = int(_footprint[0].height);
               if(_loc7_ <= 0)
               {
                  _loc7_ = _loc9_ / 4;
                  if(_loc6_ <= 0)
                  {
                     _loc6_ = _loc8_ / -3;
                  }
                  else
                  {
                     _loc6_ = _loc8_ / 2;
                  }
               }
               else
               {
                  _loc7_ = _loc9_ / 2;
                  if(_loc6_ <= 0)
                  {
                     _loc6_ = _loc8_ / -4;
                  }
                  else
                  {
                     _loc6_ = _loc8_ / 2;
                  }
               }
               _loc10_ = CREATURES.Spawn(_loc4_,MAP._BUILDINGTOPS,"defend",_position.add(new Point(_loc6_,_loc7_)),Math.random() * 360);
               if(_loc10_)
               {
                  _loc10_._targetCreep = _loc5_;
                  _loc10_._homeBunker = this;
                  _loc10_._hasTarget = true;
                  if(_loc10_._pathing == "direct")
                  {
                     _loc10_.alpha = 0;
                     _loc10_._phase = 1;
                  }
                  _loc10_.WaypointTo(_loc10_._targetCreep._tmpPoint);
                  _loc10_._targetPosition = _loc10_._targetCreep._tmpPoint;
                  ++this._monstersDispatched[_loc4_];
                  ++this._monstersDispatchedTotal;
               }
            }
         }
      }
      
      override public function TickFast(param1:Event = null) : void
      {
         ++this._frameNumber;
         if(!GLOBAL._catchup)
         {
            if(this._used > 0 && (this._targetCreeps.length > 0 || this._targetFlyers.length > 0 || this._monstersDispatchedTotal > 0 || this.DecoyInRange()))
            {
               if(_animTick == 1)
               {
                  SOUNDS.Play("bunkerdoor");
               }
               if(_animTick < 15)
               {
                  _animTick += 1;
                  AnimFrame(false);
               }
            }
            else
            {
               if(_animTick == 15)
               {
                  SOUNDS.Play("bunkerdoor");
               }
               if(_animTick > 0)
               {
                  --_animTick;
                  AnimFrame(false);
               }
            }
         }
      }
      
      override public function Damage(param1:int, param2:int, param3:int, param4:int = 1, param5:Boolean = true, param6:SecNum = null) : int
      {
         if(POWERUPS.CheckPowers(POWERUPS.ALLIANCE_ARMAMENT,"DEFENSE"))
         {
            param1 = int(POWERUPS.Apply(POWERUPS.ALLIANCE_ARMAMENT,[param1]));
         }
         _hp.Add(-param1);
         if(_hp.Get() <= 0)
         {
            _hp.Set(0);
            if(!_destroyed)
            {
               this.Destroyed(param5);
            }
         }
         else if(_class != "wall")
         {
            ATTACK.Log("b" + _id,"<font color=\"#990000\">" + KEYS.Get("attack_log_%damaged",{
               "v1":_lvl.Get(),
               "v2":KEYS.Get(_buildingProps.name),
               "v3":100 - int(100 / _hpMax.Get() * _hp.Get())
            }) + "</font>");
         }
         this.Update();
         BASE.Save();
         return param1;
      }
      
      override public function Description() : void
      {
         super.Description();
         _upgradeDescription = KEYS.Get("bunker_upgrade_desc");
      }
      
      override public function Update(param1:Boolean = false) : void
      {
         super.Update(param1);
      }
      
      override public function Constructed() : void
      {
         var Brag:Function;
         var mc:MovieClip = null;
         super.Constructed();
         if(GLOBAL._mode == "build" && BASE._yardType == BASE.MAIN_YARD)
         {
            Brag = function(param1:MouseEvent):void
            {
               GLOBAL.CallJS("sendFeed",["build-wmb",KEYS.Get("pop_bunkerbuilt_streamtitle"),KEYS.Get("pop_bunkerbuilt_streambody"),"build-monsterbunker.png"]);
               POPUPS.Next();
            };
            mc = new popup_building();
            mc.tA.htmlText = "<b>" + KEYS.Get("pop_bunkerbuilt_title") + "</b>";
            mc.tB.htmlText = KEYS.Get("pop_bunkerbuilt_body");
            mc.bPost.SetupKey("btn_brag");
            mc.bPost.addEventListener(MouseEvent.CLICK,Brag);
            mc.bPost.Highlight = true;
            POPUPS.Push(mc,null,null,null,"build.v2.png");
         }
         if(_lvl.Get() > 0)
         {
            this._capacity = GLOBAL._buildingProps[21].capacity[_lvl.Get() - 1];
            super._range = GLOBAL._buildingProps[_type - 1].stats[_lvl.Get() - 1].range;
         }
      }
      
      override public function Destroyed(param1:Boolean = true) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in this._monsters)
         {
            this._monsters[_loc2_] = this._monstersDispatched[_loc2_];
            if(this._monsters[_loc2_] == 0)
            {
               delete this._monsters[_loc2_];
            }
         }
         super.Destroyed();
      }
      
      override public function Upgraded() : void
      {
         var Brag:Function;
         var mc:MovieClip = null;
         super.Upgraded();
         if(GLOBAL._mode == "build")
         {
            Brag = function(param1:MouseEvent):void
            {
               GLOBAL.CallJS("sendFeed",["upgrade-wmb-" + _lvl.Get(),KEYS.Get("pop_bunkerupgraded_streamtitle",{"v1":_lvl.Get()}),KEYS.Get("pop_bunkerupgraded_streambody"),"build-monsterbunker.png"]);
               POPUPS.Next();
            };
            mc = new popup_building();
            mc.tA.htmlText = "<b>" + KEYS.Get("pop_bunkerupgraded_title") + "</b>";
            mc.tB.htmlText = KEYS.Get("pop_bunkerupgraded_body",{"v1":_lvl.Get()});
            mc.bPost.SetupKey("btn_brag");
            mc.bPost.addEventListener(MouseEvent.CLICK,Brag);
            mc.bPost.Highlight = true;
            POPUPS.Push(mc,null,null,null,"build.v2.png");
         }
         if(_lvl.Get() > 0)
         {
            this._capacity = GLOBAL._buildingProps[21].capacity[_lvl.Get() - 1];
            super._range = GLOBAL._buildingProps[_type - 1].stats[_lvl.Get() - 1].range;
         }
      }
      
      override public function RecycleC() : void
      {
         super.RecycleC();
         this._capacity = 0;
         this.Cull();
      }
      
      public function Cull() : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc1_:Boolean = false;
         var _loc2_:int = this._monstersDispatchedTotal + 1;
         while(this._used > this._capacity)
         {
            for(_loc4_ in this._monsters)
            {
               if(this._monsters[_loc4_])
               {
                  --this._monsters[_loc4_];
                  this._used -= CREATURELOCKER._creatures[_loc4_].props.cStorage;
                  _loc1_ = true;
               }
               else
               {
                  this._monsters[_loc4_] = 0;
                  delete this._monsters[_loc4_];
                  _loc1_ = true;
               }
            }
            _loc2_ = 0;
            for each(_loc5_ in this._monsters)
            {
               _loc2_ += _loc5_;
            }
         }
         for(_loc3_ in this._monsters)
         {
            if(Boolean(this._monsters[_loc3_]) && this._monsters[_loc3_] == 0)
            {
               delete this._monsters[_loc3_];
               _loc1_ = true;
            }
         }
         if(_loc1_)
         {
            BASE.Save();
         }
      }
      
      override public function Setup(param1:Object) : void
      {
         var _loc2_:String = null;
         super.Setup(param1);
         this._monsters = param1.m;
         if(!this._monsters)
         {
            this._monsters = {};
         }
         else
         {
            for(_loc2_ in this._monsters)
            {
               this._monstersDispatched[_loc2_] = 0;
            }
         }
         if(_lvl.Get() > 0)
         {
            this._capacity = GLOBAL._buildingProps[21].capacity[_lvl.Get() - 1];
            super._range = GLOBAL._buildingProps[_type - 1].stats[_lvl.Get() - 1].range;
         }
      }
      
      public function RemoveCreature(param1:String) : void
      {
         --this._monsters[param1];
         if(this._monsters[param1] < 0)
         {
            this._monsters[param1] = 0;
         }
         --this._monstersDispatched[param1];
         if(this._monstersDispatched[param1] < 0)
         {
            this._monstersDispatched[param1] = 0;
         }
         --this._monstersDispatchedTotal;
         if(this._monstersDispatchedTotal < 0)
         {
            this._monstersDispatchedTotal = 0;
         }
      }
      
      override public function Over(param1:MouseEvent) : void
      {
         if(GLOBAL._mode == "build" && _lvl.Get() > 0 && _countdownBuild.Get() == 0 && _countdownFortify.Get() == 0 && _countdownUpgrade.Get() == 0 && _hp.Get() > 0)
         {
            TweenLite.delayedCall(0.25,this.RangeIndicator);
         }
      }
      
      private function RangeIndicator() : void
      {
         this._radiusGraphic = new Shape();
         this._radiusGraphic.graphics.beginFill(0xffffff,0.1);
         this._radiusGraphic.graphics.lineStyle(1,0xffffff,0.25);
         var _loc2_:Sprite = new Sprite();
         var _loc3_:Point = _position.add(new Point(0,_footprint[0].height * 0.25));
         var _loc4_:Point = new Point(_range * 2.8,_range * 1.2);
         this._radiusGraphic.graphics.drawEllipse(0,0,_loc4_.x,_loc4_.y);
         this._radiusGraphic.x = -(_loc4_.x * 0.5);
         this._radiusGraphic.y = -(_loc4_.y * 0.5);
         _loc2_.addChild(this._radiusGraphic);
         _loc2_.x = _loc3_.x;
         _loc2_.y = _loc3_.y;
         MAP._BUILDINGFOOTPRINTS.addChild(_loc2_);
         TweenLite.from(_loc2_,0.25,{
            "alpha":0.5,
            "scaleX":0.25,
            "scaleY":0,
            "delay":0,
            "ease":Expo.easeOut
         });
         TweenLite.killDelayedCallsTo(this.RangeIndicator);
      }
      
      override public function Out(param1:MouseEvent) : void
      {
         if(GLOBAL._mode == "build" && Boolean(this._radiusGraphic))
         {
            if(this._radiusGraphic.parent)
            {
               this._radiusGraphic.parent.removeChild(this._radiusGraphic);
            }
            this._radiusGraphic = null;
         }
         TweenLite.killDelayedCallsTo(this.RangeIndicator);
      }
      
      override public function Export() : Object
      {
         var _loc2_:int = 0;
         var _loc1_:Object = super.Export();
         if(Boolean(this._monsters) && _hp.Get() > 0)
         {
            for each(_loc2_ in this._monsters)
            {
               if(_loc2_ > 0)
               {
                  _loc1_.m = this._monsters;
                  break;
               }
            }
         }
         return _loc1_;
      }
   }
}

