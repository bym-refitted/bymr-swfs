package
{
   import com.cc.utils.SecNum;
   import com.monsters.pathing.PATHING;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import gs.*;
   import gs.easing.*;
   
   public class GUARDIANMONSTER extends CREEP_CLIP
   {
      public var _behaviourMode:String = "defend";
      
      public var _attackType:String = "melee";
      
      public var _feeds:SecNum;
      
      public var _feedTime:SecNum;
      
      public var _level:SecNum;
      
      public var _warned:Boolean = false;
      
      public var _warnStarve:Boolean = false;
      
      public var _behaviour:String;
      
      public var _frameNumber:int;
      
      public var _spawned:Boolean;
      
      public var _graphic:BitmapData;
      
      public var _middle:int;
      
      public var _visible:Boolean = true;
      
      public var _clicked:Boolean = false;
      
      public var _looking:Boolean = false;
      
      public var _creatureID:String;
      
      public var _spriteID:String;
      
      public var _name:String;
      
      public var _speed:Number;
      
      public var _maxSpeed:Number;
      
      public var _health:SecNum;
      
      public var _maxHealth:Number;
      
      public var _damage:SecNum;
      
      public var _size:int;
      
      public var _goo:int;
      
      public var _regen:int;
      
      public var _range:int;
      
      public var _buff:Number = 0;
      
      public var _venom:SecNum = new SecNum(0);
      
      public var _targetRotation:Number;
      
      public var _targetPosition:Point;
      
      public var _targetCenter:Point;
      
      public var _waypoints:Array;
      
      private var _pathID:int = 0;
      
      private var _jumping:Boolean = false;
      
      private var _jumpingUp:Boolean = false;
      
      private const _noDefensePath:Boolean = false;
      
      private var _doDefenseBurrow:Boolean = true;
      
      public var _hasTarget:Boolean;
      
      public var _hasPath:Boolean;
      
      public var _attacking:Boolean;
      
      public var _intercepting:Boolean;
      
      public var _targetBuilding:BFOUNDATION;
      
      public var _targetCreeps:Array;
      
      public var _targetCreep:*;
      
      public var _helpCreep:*;
      
      public var _id:*;
      
      public var _attackDelay:int;
      
      public var _friendly:Boolean;
      
      public var _house:BFOUNDATION;
      
      public var _hits:int;
      
      public var _spawnPoint:Point;
      
      public var _lastRotation:int = 400;
      
      public var _targetGroup:int;
      
      public var _goeasy:Boolean = false;
      
      public var _hitLimit:int = 50;
      
      public var _type:int = 1;
      
      public var _enraged:Number = 0;
      
      public var _damageMult:Number = 1;
      
      public var _speedMult:Number = 1;
      
      private var _secureDamageMult:SecNum = new SecNum(100);
      
      private var _secureSpeedMult:SecNum = new SecNum(100);
      
      public var _blinkState:int = 0;
      
      public var _invisibleTime:int = 0;
      
      public var _explode:int = 0;
      
      public var _altitude:int = 0;
      
      internal var attackCooldown:int;
      
      internal var frameCount:int;
      
      internal var shocking:Boolean;
      
      internal var node:*;
      
      internal var newNode:*;
      
      public var _tmpPoint:Point = new Point(0,0);
      
      public var _spawnTime:int;
      
      public var _atTarget:Boolean = false;
      
      public var _xd:Number = 0;
      
      public var _yd:Number = 0;
      
      public var _mc:*;
      
      public var _graphicMC:DisplayObject;
      
      public var _shadow:BitmapData;
      
      public var _shadowMC:DisplayObject;
      
      public var _lastHeal:int = 0;
      
      public var _phase:Number = 0;
      
      public var _movement:String = "";
      
      public var _pathing:String = "";
      
      public const DEFENSE_RANGE:int = 30;
      
      public const DEFENSE_MODIFIER:Number = 1;
      
      private var _dying:Boolean = false;
      
      private var _dead:Boolean = false;
      
      public function GUARDIANMONSTER(param1:String, param2:Point, param3:Number, param4:Point = null, param5:Boolean = false, param6:BFOUNDATION = null, param7:int = 1, param8:int = 0, param9:int = 0, param10:int = 1, param11:int = 20000)
      {
         super();
         var _loc12_:int = getTimer();
         this._mc = this;
         this._id = GLOBAL.NextCreepID();
         this._friendly = param5;
         this._level = new SecNum(param7);
         this._creatureID = "G" + param10;
         this._feeds = new SecNum(param8);
         if(param9 > 0)
         {
            this._feedTime = new SecNum(param9);
         }
         else
         {
            this._feedTime = new SecNum(int(GLOBAL.Timestamp() + GUARDIANCAGE.GetGuardianProperty(this._creatureID,param7,"feedTime")));
         }
         this._lastHeal = GLOBAL.Timestamp();
         this._house = param6;
         this._hits = 0;
         this._type = param10;
         this._pathing = "";
         this._spawnTime = GLOBAL.Timestamp();
         this._spawnPoint = new Point(int(param2.x / 100) * 100,int(param2.y / 100) * 100);
         this._targetGroup = 3;
         this._waypoints = [];
         this._targetCreeps = [];
         this._targetCreep = null;
         mouseEnabled = false;
         mouseChildren = false;
         this._speed = 0;
         this._maxSpeed = GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"speed") / 2;
         this._maxSpeed *= 1.1;
         this._maxHealth = GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"health");
         this._regen = GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"healtime");
         if(param11 > 0 && param11 <= this._maxHealth)
         {
            this._health = new SecNum(param11);
         }
         else
         {
            this._health = new SecNum(1);
         }
         this._damage = new SecNum(int(GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"damage")));
         this._range = GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"range");
         this._movement = GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"movement");
         this._buff = GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"buffs");
         this._goo = 250000;
         this._behaviour = param1;
         if(this._creatureID == "G3")
         {
            this._attackDelay = 8;
         }
         else
         {
            this._attackDelay = 56;
         }
         this._attacking = false;
         this._frameNumber = Math.random() * 7;
         this._targetPosition = param2;
         this._targetCenter = param4;
         x = this._targetPosition.x;
         y = this._targetPosition.y;
         this._tmpPoint.x = x;
         this._tmpPoint.y = y;
         if(param3)
         {
            this._targetRotation = param3;
         }
         else
         {
            this._targetRotation = 0;
         }
         mcMarker.rotation = this._targetRotation;
         this._attacking = false;
         this._frameNumber = Math.random() * 7;
         this._spriteID = this._creatureID + "_" + this._level.Get();
         SPRITES.SetupSprite(this._spriteID);
         if(this._movement == "fly")
         {
            SPRITES.SetupSprite("bigshadow");
            this._shadow = new BitmapData(52,50,true,0xffffff);
            this._shadowMC = addChild(new Bitmap(this._shadow));
            this._shadowMC.x = -21;
            this._shadowMC.y = -26;
            this._frameNumber = int(Math.random() * 1000);
         }
         var _loc13_:Object = SPRITES.GetSpriteDescriptor(this._spriteID);
         this._graphic = new BitmapData(_loc13_.width,_loc13_.height,true,0xffffff);
         this._graphicMC = addChild(new Bitmap(this._graphic));
         this._graphicMC.x = GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"offset_x");
         this._graphicMC.y = GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"offset_y");
         if(this._movement == "fly")
         {
            this._altitude = 108;
         }
         else
         {
            this._altitude = 0;
         }
         if(this._behaviour == "bounce")
         {
            if(GLOBAL._render && this._movement != "fly")
            {
               this._graphicMC.y -= 90;
               if(this._creatureID == "G3")
               {
                  TweenLite.to(this._graphicMC,0.6,{
                     "y":this._graphicMC.y + 90,
                     "ease":Bounce.easeOut,
                     "onComplete":this.ModeBuff
                  });
               }
               else
               {
                  TweenLite.to(this._graphicMC,0.6,{
                     "y":this._graphicMC.y + 90,
                     "ease":Bounce.easeOut,
                     "onComplete":this.ModeAttack
                  });
               }
            }
            else
            {
               if(this._movement == "fly")
               {
                  this._graphicMC.y -= this._altitude;
               }
               else
               {
                  this._altitude = 0;
               }
               if(this._creatureID == "G3")
               {
                  this.ModeBuff();
               }
               else
               {
                  this.ModeAttack();
               }
            }
         }
         else if(this._behaviour == "defend")
         {
            this._altitude = 0;
            this.ModeDefend();
         }
         if(this._behaviour == "juice")
         {
            this.ModeJuice();
         }
         this.Render();
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public static function Show() : *
      {
      }
      
      public function ModeJuice() : *
      {
         this._behaviour = "juice";
         this._hasTarget = false;
         this._atTarget = false;
         this._hasPath = false;
         this._targetBuilding = GLOBAL._bJuicer;
         if(this._movement == "fly" && this._altitude < 60)
         {
            TweenLite.to(this._graphicMC,2,{
               "y":this._graphicMC.y - (108 - this._altitude),
               "ease":Sine.easeIn,
               "onComplete":this.FlyerTakeOff
            });
         }
         ++CREATURES._creatureID;
         ++CREATURES._creatureCount;
         CREATURES._creatures[CREATURES._creatureID] = this;
         CREATURES._guardian = null;
         BASE._guardianData = null;
         if(GLOBAL._mode == "build")
         {
            GLOBAL._playerGuardianData = null;
         }
         BASE.Save();
         PATHING.GetPath(this._tmpPoint,new Rectangle(this._targetBuilding._mc.x,this._targetBuilding._mc.y,80,80),this.SetWaypoints,true);
      }
      
      public function ModeCage() : *
      {
         this._behaviour = "cage";
         this._hasTarget = false;
         this._atTarget = false;
         this._attacking = false;
         this._hasPath = false;
         var _loc1_:Point = new Point(this._house._mc.x + 50,this._house._mc.y + 60);
         PATHING.GetPath(this._tmpPoint,new Rectangle(_loc1_.x,_loc1_.y,10,10),this.SetWaypoints,true);
      }
      
      public function ModeRetreat() : *
      {
         this._behaviour = "retreat";
         this._hasTarget = false;
         this._atTarget = false;
         this._hasPath = false;
         this._attacking = false;
         this.WaypointTo(this._spawnPoint);
      }
      
      public function ModeEnrage(param1:Number, param2:Number, param3:Number) : *
      {
         this._enraged = param1;
         this._speedMult = param2;
         this._damageMult = param3;
         this._secureSpeedMult = new SecNum(int(param2 * 100));
         this._secureDamageMult = new SecNum(int(param3 * 100));
         if(this._enraged > 0)
         {
            if(this._enraged > 0 && filters.length == 0)
            {
               filters = [new GlowFilter(16724735,1,3,3,5,1)];
            }
         }
         else
         {
            filters = [];
         }
      }
      
      public function ModeAttack() : *
      {
         this._behaviour = "attack";
         this._hasTarget = false;
         this._atTarget = false;
         this._hasPath = false;
         this.node = MAP.CreepCellAdd(this._tmpPoint,this._id,this);
         this._targetCreep = null;
         this.FindTarget(true);
      }
      
      public function ModeBuff() : *
      {
         this._behaviour = "buff";
         this._hasTarget = false;
         this._atTarget = false;
         this._hasPath = false;
         this.node = MAP.CreepCellAdd(this._tmpPoint,this._id,this);
         this.FindBuffTargets();
      }
      
      public function ModeDefend() : *
      {
         this._behaviour = "defend";
         this._hasTarget = false;
         this._atTarget = false;
         this._hasPath = false;
      }
      
      public function Click(param1:MouseEvent) : *
      {
         if(GLOBAL._mode == "build")
         {
            Show();
         }
      }
      
      public function CanShootCreep() : Boolean
      {
         if(this._targetCreep == null)
         {
            return false;
         }
         if(this._creatureID != "G3" && this._targetCreep._movement == "fly")
         {
            return false;
         }
         var _loc1_:Number = GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint);
         if(_loc1_ > this._range)
         {
            return false;
         }
         if(this._movement == "fly")
         {
            return true;
         }
         if(PATHING.LineOfSight(this._tmpPoint.x,this._tmpPoint.y,this._targetCreep._tmpPoint.x,this._targetCreep._tmpPoint.y))
         {
            return true;
         }
         return false;
      }
      
      private function CanHitBuilding() : Boolean
      {
         if(this._targetBuilding == null)
         {
            return false;
         }
         var _loc1_:Number = GLOBAL.QuickDistance(this._targetBuilding._position,this._tmpPoint);
         if(_loc1_ > this._range)
         {
            return false;
         }
         if(this._movement == "fly")
         {
            return true;
         }
         if(PATHING.LineOfSight(this._tmpPoint.x,this._tmpPoint.y,this._targetBuilding._position.x,this._targetBuilding._position.y,this._targetBuilding))
         {
            return true;
         }
         return false;
      }
      
      public function Clear() : *
      {
         this._health.Set(0);
         if(CREATURES._guardian == this)
         {
            CREATURES._guardian = null;
         }
         if(CREEPS._guardian == this)
         {
            CREEPS._guardian = null;
         }
      }
      
      public function InterceptTarget() : *
      {
         this._intercepting = false;
         this._looking = true;
         if(this._movement == "fly" && this._altitude < 60)
         {
            TweenLite.to(this._graphicMC,2,{
               "y":this._graphicMC.y - (108 - this._altitude),
               "ease":Sine.easeIn,
               "onComplete":this.FlyerTakeOff
            });
            this._altitude = 61;
         }
         if(GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < this._range)
         {
            this._atTarget = true;
            this._looking = false;
         }
         else if(this._noDefensePath || GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < this._range * 2 || this._movement == "fly")
         {
            this._waypoints = [this._targetCreep._tmpPoint];
            this._targetPosition = this._targetCreep._tmpPoint;
         }
         else if(this._targetCreep._atTarget || this._targetCreep._waypoints.length < 8 || GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < 250)
         {
            this.WaypointTo(this._targetCreep._tmpPoint,null);
         }
         else
         {
            this.WaypointTo(this._targetCreep._waypoints[7],null);
            this._intercepting = true;
         }
         this._hasTarget = true;
      }
      
      public function FindBuffTargets() : *
      {
         var _loc2_:BFOUNDATION = null;
         var _loc1_:* = false;
         for each(_loc2_ in BASE._buildingsMain)
         {
            if(_loc2_._class != "decoration" && _loc2_._class != "immovable" && _loc2_._hp.Get() > 0 && _loc2_._class != "enemy")
            {
               _loc1_ = true;
            }
         }
         if(!_loc1_)
         {
            this.ModeRetreat();
            return;
         }
         this._looking = true;
         var _loc4_:Boolean = false;
         this._targetCreeps = MAP.CreepCellFind(this._tmpPoint,25 * 60,1,this);
         if(this._targetCreeps.length > 0)
         {
            this._targetCreeps.sortOn(["dist"],Array.NUMERIC);
            if(!(this._targetCreep && this._targetCreep._health.Get() > 0 && this._targetCreep._health.Get() < this._targetCreep._maxHealth))
            {
               _loc4_ = true;
               while(this._targetCreeps.length > 0 && (this._targetCreeps[0].creep._behaviour == "heal" || this._targetCreeps[0].creep._health.Get() == this._targetCreeps[0].creep._maxHealth))
               {
                  this._targetCreeps.shift();
               }
               if(this._targetCreeps.length > 0)
               {
                  this._helpCreep = this._targetCreeps[0].creep;
                  if(this._movement == "fly")
                  {
                     this._waypoints = [this._helpCreep._tmpPoint];
                     this._targetPosition = this._helpCreep._tmpPoint;
                  }
                  else
                  {
                     this.WaypointTo(this._helpCreep._tmpPoint,null);
                  }
               }
            }
         }
         if(this._targetCreeps.length > 0)
         {
            _loc4_ = false;
            this._helpCreep = this._targetCreeps[0].creep;
            if(this._movement == "fly")
            {
               this._waypoints = [this._helpCreep._tmpPoint];
               this._targetPosition = this._helpCreep._tmpPoint;
            }
            else
            {
               this.WaypointTo(this._helpCreep._tmpPoint,null);
            }
            this._behaviour = "buff";
         }
         else if(this._helpCreep && this._helpCreep._health.Get() > 0 && this._helpCreep._health.Get() < this._helpCreep._maxHealth)
         {
            _loc4_ = false;
            if(this._movement == "fly")
            {
               this._waypoints = [this._helpCreep._tmpPoint];
               this._targetPosition = this._helpCreep._tmpPoint;
            }
            else
            {
               this.WaypointTo(this._helpCreep._tmpPoint,null);
            }
            this._behaviour = "buff";
         }
         else if(this._targetCreeps.length == 0)
         {
            this.ModeAttack();
            return;
         }
         if(this._waypoints.length)
         {
            this._hasTarget = true;
            this._hasPath = true;
         }
      }
      
      public function FindDefenseTargets() : *
      {
         if(this._creatureID == "G3")
         {
            this._targetCreeps = MAP.CreepCellFind(this._tmpPoint,800,1);
         }
         else
         {
            this._targetCreeps = MAP.CreepCellFind(this._tmpPoint,800);
         }
         if(this._targetCreeps.length > 0)
         {
            this._targetCreeps.sortOn(["dist"],Array.NUMERIC);
            while(this._targetCreeps.length > 0 && (this._targetCreeps[0].creep._behaviour == "retreat" || this._movement != "fly" && this._targetCreeps[0].creep._creatureID == "C5"))
            {
               this._targetCreeps.splice(0,1);
            }
         }
         if(this._targetCreeps.length > 0)
         {
            this._targetCreep = this._targetCreeps[0].creep;
            this.InterceptTarget();
            if(this._movement == "fly" && this._altitude < 60)
            {
               TweenLite.to(this._graphicMC,2,{
                  "y":this._graphicMC.y - (108 - this._altitude),
                  "ease":Sine.easeIn,
                  "onComplete":this.FlyerTakeOff
               });
            }
            this._behaviour = "defend";
         }
         else if(this._targetCreep && this._targetCreep._health.Get() > 0)
         {
            if(this._movement == "fly")
            {
               this.InterceptTarget();
            }
            this._behaviour = "defend";
         }
         else if(this._behaviour != "cage" && this._behaviour != "pen")
         {
            this._atTarget = false;
            this.ModeCage();
         }
      }
      
      public function FindTarget(param1:Boolean = false) : *
      {
         var _loc4_:BFOUNDATION = null;
         var _loc8_:Point = null;
         var _loc9_:Point = null;
         var _loc10_:int = 0;
         var _loc12_:BUILDING22 = null;
         var _loc13_:int = 0;
         var _loc14_:Point = null;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:Number = NaN;
         var _loc19_:* = undefined;
         var _loc20_:* = undefined;
         var _loc2_:int = getTimer();
         var _loc11_:Array = [];
         this._looking = true;
         _loc8_ = PATHING.FromISO(this._tmpPoint);
         for each(_loc4_ in BASE._buildingsMain)
         {
            if(_loc4_._hp.Get() > 0 && (_loc4_._class == "resource" || _loc4_._type == 6 || _loc4_._type == 14 || _loc4_._type == 112))
            {
               _loc9_ = GRID.FromISO(_loc4_._mc.x,_loc4_._mc.y + _loc4_._middle);
               _loc10_ = GLOBAL.QuickDistance(_loc8_,_loc9_) - _loc4_._middle;
               _loc11_.push({
                  "building":_loc4_,
                  "distance":_loc10_
               });
            }
         }
         for each(_loc4_ in BASE._buildingsTowers)
         {
            if(_loc4_._type == 22)
            {
               _loc12_ = _loc4_ as BUILDING22;
               if(_loc12_._hp.Get() > 0 && (_loc12_._used > 0 || _loc12_._monstersDispatchedTotal > 0))
               {
                  _loc9_ = GRID.FromISO(_loc4_._mc.x,_loc4_._mc.y + _loc4_._middle);
                  _loc10_ = GLOBAL.QuickDistance(_loc8_,_loc9_) - _loc4_._middle;
                  _loc11_.push({
                     "building":_loc4_,
                     "distance":_loc10_,
                     "expand":false
                  });
               }
            }
            else if(_loc4_._class != "trap" && _loc4_._hp.Get() > 0)
            {
               _loc9_ = GRID.FromISO(_loc4_._mc.x,_loc4_._mc.y + _loc4_._middle);
               _loc10_ = GLOBAL.QuickDistance(_loc8_,_loc9_) - _loc4_._middle;
               _loc11_.push({
                  "building":_loc4_,
                  "distance":_loc10_,
                  "expand":false
               });
            }
         }
         if(_loc11_.length == 0)
         {
            for each(_loc4_ in BASE._buildingsMain)
            {
               if(_loc4_._class != "decoration" && _loc4_._class != "immovable" && _loc4_._hp.Get() > 0 && _loc4_._class != "enemy")
               {
                  this._targetGroup = 1;
                  _loc9_ = GRID.FromISO(_loc4_._mc.x,_loc4_._mc.y + _loc4_._middle);
                  _loc10_ = GLOBAL.QuickDistance(_loc8_,_loc9_) - _loc4_._middle;
                  _loc11_.push({
                     "building":_loc4_,
                     "distance":_loc10_,
                     "expand":true
                  });
               }
            }
         }
         if(_loc11_.length == 0)
         {
            this.ModeRetreat();
         }
         else
         {
            _loc11_.sortOn("distance",Array.NUMERIC);
            _loc13_ = 0;
            if(this._movement == "burrow")
            {
               this._hasTarget = true;
               this._hasPath = true;
               _loc14_ = GRID.FromISO(_loc11_[_loc13_].building._mc.x,_loc11_[_loc13_].building._mc.y);
               _loc15_ = int(Math.random() * 4);
               _loc16_ = int(_loc11_[_loc13_].building._footprint[0].height);
               _loc17_ = int(_loc11_[_loc13_].building._footprint[0].width);
               if(_loc15_ == 0)
               {
                  _loc14_.x += Math.random() * _loc16_;
                  _loc14_.y += _loc17_;
               }
               else if(_loc15_ == 1)
               {
                  _loc14_.x += _loc16_;
                  _loc14_.y += _loc17_;
               }
               else if(_loc15_ == 2)
               {
                  _loc14_.x += _loc16_ - Math.random() * _loc16_ / 2;
                  _loc14_.y -= _loc17_ / 4;
               }
               else if(_loc15_ == 3)
               {
                  _loc14_.x -= _loc16_ / 4;
                  _loc14_.y += _loc17_ - Math.random() * _loc17_ / 2;
               }
               this._waypoints = [GRID.ToISO(_loc14_.x,_loc14_.y,0)];
               this._targetPosition = this._waypoints[0];
               this._targetBuilding = _loc11_[_loc13_].building;
            }
            else if(this._movement == "fly")
            {
               this._hasTarget = true;
               this._hasPath = true;
               this._targetBuilding = _loc11_[_loc13_].building;
               this._targetCenter = this._targetBuilding._position;
               if(GLOBAL.QuickDistance(this._tmpPoint,this._targetCenter) < 170)
               {
                  this._atTarget = true;
                  this._hasPath = true;
                  this._targetPosition = this._targetCenter;
               }
               else
               {
                  _loc18_ = Math.atan2(this._tmpPoint.y - this._targetCenter.y,this._tmpPoint.x - this._targetCenter.x) * 57.2957795;
                  _loc18_ = _loc18_ + (Math.random() * 40 - 20);
                  _loc18_ = _loc18_ / (180 / Math.PI);
                  _loc19_ = 2 * 60 + Math.random() * 10;
                  _loc20_ = new Point(this._targetCenter.x + Math.cos(_loc18_) * _loc19_ * 1.7,this._targetCenter.y + Math.sin(_loc18_) * _loc19_);
                  this._waypoints = [_loc20_];
                  this._targetPosition = this._waypoints[0];
               }
            }
            else if(GLOBAL._catchup)
            {
               this.WaypointTo(new Point(_loc11_[0].building._mc.x,_loc11_[0].building._mc.y),_loc11_[0].building);
            }
            else
            {
               _loc13_ = 0;
               while(_loc13_ < 2)
               {
                  if(_loc11_.length > _loc13_)
                  {
                     this.WaypointTo(new Point(_loc11_[_loc13_].building._mc.x,_loc11_[_loc13_].building._mc.y),_loc11_[_loc13_].building);
                  }
                  _loc13_++;
               }
            }
         }
      }
      
      public function WaypointTo(param1:Point, param2:BFOUNDATION = null) : *
      {
         var _loc3_:Boolean = false;
         if(this._behaviour == "juice" || this._behaviour == "housing" || this._behaviour == "pen" || this._behaviour == "defend")
         {
            _loc3_ = true;
         }
         if(param2)
         {
            PATHING.GetPath(this._tmpPoint,new Rectangle(int(param1.x),int(param1.y),param2._footprint[0].width,param2._footprint[0].height),this.SetWaypoints,_loc3_,param2);
         }
         else
         {
            PATHING.GetPath(this._tmpPoint,new Rectangle(int(param1.x),int(param1.y),10,10),this.SetWaypoints,_loc3_);
         }
      }
      
      public function SetWaypoints(param1:Array, param2:BFOUNDATION = null, param3:Boolean = false) : *
      {
         var _loc4_:Boolean = false;
         if(param3)
         {
            if(this._behaviour == "attack")
            {
               this.FindTarget();
            }
            if(this._behaviour == "cage")
            {
               this.ModeCage();
            }
            if(this._behaviour == "retreat")
            {
               this.ModeRetreat();
            }
         }
         else
         {
            _loc4_ = false;
            if(param1.length < this._waypoints.length)
            {
               _loc4_ = true;
            }
            if(_loc4_ && param2 && param2._class == "wall" && this._targetGroup != 2)
            {
               _loc4_ = false;
            }
            if(!this._hasTarget)
            {
               _loc4_ = true;
            }
            if(this._behaviour == "defend")
            {
               _loc4_ = true;
            }
            if(_loc4_)
            {
               this._hasTarget = true;
               this._atTarget = false;
               this._hasPath = true;
               this._waypoints = param1;
               this._targetPosition = this._waypoints[0];
               if(param2)
               {
                  this._targetBuilding = param2;
               }
            }
            this._looking = false;
         }
      }
      
      public function LevelSet(param1:int, param2:int = 0) : *
      {
         var _loc3_:Object = null;
         if(param1 != this._level.Get())
         {
            this._level = new SecNum(param1);
            this._spriteID = this._creatureID + "_" + param1;
            if(this._graphicMC.parent)
            {
               this._graphicMC.parent.removeChild(this._graphicMC);
            }
            SPRITES.SetupSprite(this._spriteID);
            _loc3_ = SPRITES.GetSpriteDescriptor(this._spriteID);
            this._graphic = new BitmapData(_loc3_.width,_loc3_.height,true,0xffffff);
            this._graphicMC = addChild(new Bitmap(this._graphic));
            this._graphicMC.x = GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"offset_x");
            this._graphicMC.y = GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"offset_y");
            this._feeds = new SecNum(0);
            this._feedTime = new SecNum(int(GLOBAL.Timestamp() + GUARDIANCAGE.GetGuardianProperty(this._creatureID,param1,"feedTime")));
            LOGGER.Log("fed","level " + this._level.Get());
            this._maxHealth = GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"health");
            this._maxSpeed = GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"speed") / 2;
            this._maxSpeed *= 1.1;
            this._regen = GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"healtime");
            this._health.Set(this._maxHealth);
            this._damage = new SecNum(int(GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"damage")));
            this._range = GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"range");
            this._movement = GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"movement");
            if(param1 >= 6)
            {
               QUESTS.Check("upgrade_champ" + this._creatureID.substr(1,1),1);
            }
            LOGGER.Stat([57,this._creatureID,param2,this._level.Get()]);
            BASE.Save();
         }
      }
      
      public function TickBAttack() : *
      {
         var _loc2_:* = undefined;
         var _loc3_:CREEP = null;
         var _loc4_:Point = null;
         if(this._health.Get() <= 0)
         {
            MAP.CreepCellDelete(this._id,this.node);
            this.ModeRetreat();
            ATTACK.Log(this._creatureID,LOGIN._playerName + "\'s Level " + this._level.Get() + " " + GUARDIANCAGE._guardians[this._creatureID].name + " retreated.");
            SOUNDS.Play("monsterland" + (1 + int(Math.random() * 3)));
            if(GLOBAL._mode == "attack")
            {
               LOGGER.Stat([54,this._creatureID,1,this._level.Get()]);
            }
            BASE.Save();
            return;
         }
         var _loc1_:Number = 1;
         if(Boolean(GLOBAL._attackerMonsterOverdrive) && GLOBAL._attackerMonsterOverdrive.Get() >= GLOBAL.Timestamp())
         {
            _loc1_ *= 1.25;
         }
         if(this._creatureID == "G3" && this._frameNumber % 100 == 0)
         {
            this.FindBuffTargets();
            if(this._behaviour == "buff")
            {
               this.TickBBuff();
               return;
            }
            for each(_loc2_ in CREEPS._creeps)
            {
               if(_loc2_ != this)
               {
                  _loc3_ = _loc2_ as CREEP;
                  if(_loc3_ && _loc3_._damageMult >= 1 - this._buff && GLOBAL.QuickDistance(this._tmpPoint,_loc3_._tmpPoint) < 250)
                  {
                     _loc2_.ModeEnrage(GLOBAL.Timestamp() + 5,1 + this._buff * 2,1 - this._buff);
                  }
               }
            }
         }
         if(this._hasTarget)
         {
            if(!this._targetCreep)
            {
               if(this._targetBuilding._hp.Get() <= 0)
               {
                  this._hasTarget = false;
                  this._attacking = false;
                  this._atTarget = false;
                  this.FindTarget();
               }
            }
            else if(this._targetCreep._health.Get() <= 0)
            {
               this._hasTarget = false;
               this._attacking = false;
               this._atTarget = false;
               this._targetCreep = null;
               this.FindTarget();
            }
         }
         if(!this._looking && this._frameNumber % (GLOBAL._catchup ? 200 : 100) == 0 && !this._attacking)
         {
            this.FindTarget(true);
         }
         if(this._atTarget)
         {
            this._attacking = true;
            if(this.attackCooldown <= 0)
            {
               this.attackCooldown += int(this._attackDelay / this._speedMult);
               if(this._creatureID == "G3")
               {
                  if(this._targetCreep && this._targetCreep._health.Get() > 0)
                  {
                     _loc4_ = Point.interpolate(this._tmpPoint.add(new Point(0,-this._altitude)),this._targetPosition,0.8);
                     FIREBALLS.Spawn2(_loc4_,this._targetCreep._tmpPoint,this._targetCreep,8,this._damage.Get() * _loc1_);
                     FIREBALLS._fireballs[FIREBALLS._id - 1].gotoAndStop(3);
                     this._targetCenter = this._targetCreep._tmpPoint;
                     this._targetPosition = this._targetCreep._tmpPoint;
                  }
                  else if(this._targetBuilding)
                  {
                     this._targetCenter = this._targetBuilding._position;
                     this._targetPosition = this._targetBuilding._position;
                     _loc4_ = Point.interpolate(this._tmpPoint.add(new Point(0,-this._altitude)),this._targetPosition,0.8);
                     FIREBALLS.Spawn(_loc4_,this._targetPosition,this._targetBuilding,8,this._damage.Get() * _loc1_);
                     FIREBALLS._fireballs[FIREBALLS._id - 1].gotoAndStop(3);
                  }
                  else
                  {
                     this.FindBuffTargets();
                  }
               }
               else
               {
                  ATTACK.Damage(this._tmpPoint.x,this._tmpPoint.y - 5,this._damage.Get() * _loc1_,this._mc.visible);
                  if(this._targetCreep)
                  {
                     this._targetCreep._health.Add(-(this._damage.Get() * _loc1_ * this._targetCreep._damageMult));
                  }
                  else if(this._targetBuilding)
                  {
                     this._targetBuilding.Damage(this._damage.Get() * _loc1_,this._tmpPoint.x,this._tmpPoint.y,this._targetGroup);
                  }
                  else
                  {
                     this.FindTarget();
                  }
               }
               SOUNDS.Play("hit" + int(4 + Math.random() * 1),0.1 + Math.random() * 0.1);
            }
            else
            {
               --this.attackCooldown;
            }
         }
         else
         {
            this._attacking = false;
         }
      }
      
      public function TickBDefend() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Point = null;
         if(this._health.Get() <= 0)
         {
            ATTACK.Log(this._creatureID,BASE._ownerName + "\'s Level " + this._level.Get() + " " + GUARDIANCAGE._guardians[this._creatureID].name + " was critically injured and fled the battle.");
            this.ModeRetreat();
            if(GLOBAL._mode == "attack")
            {
               LOGGER.Stat([56,this._creatureID,1,this._level.Get()]);
            }
            BASE.Save();
            return;
         }
         if(this._creatureID == "G3" && this._frameNumber % 100 == 0)
         {
            for each(_loc1_ in CREATURES._creatures)
            {
               if(_loc1_._behaviour == "defend" && _loc1_._damageMult >= 1 - this._buff && GLOBAL.QuickDistance(_loc1_._tmpPoint,this._tmpPoint) < 250 && _loc1_ != this)
               {
                  _loc1_.ModeEnrage(GLOBAL.Timestamp() + 5,1 + this._buff * 2,1 - this._buff);
               }
            }
         }
         if(this._hasTarget)
         {
            if(this._targetCreep._health.Get() <= 0)
            {
               this._hasTarget = false;
               this._atTarget = false;
               this._attacking = false;
               this._hasPath = false;
               this.FindDefenseTargets();
            }
            else if(GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < this._range)
            {
               this._atTarget = true;
            }
            else if(!this._attacking && this._frameNumber % 60 == 0)
            {
               this.FindDefenseTargets();
            }
            else if(this._attacking && GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) > this._range * 2)
            {
               this._attacking = false;
               this._atTarget = false;
               this._hasPath = false;
               this.FindDefenseTargets();
            }
         }
         if(this._atTarget)
         {
            this._attacking = true;
            this._intercepting = false;
            if(this._movement != "fly" || this._targetCreep._creatureID == "C14" || this._targetCreep._creatureID == "C12" && this._targetCreep.PoweredUp() || this._targetCreep._creatureID == "G3")
            {
               if(this._targetCreep._behaviour != "heal")
               {
                  this._targetCreep._targetCreep = this;
                  if(this._targetCreep._creatureID == "C14" || this._targetCreep.CanShootCreep() || GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < 50 && this._movement != "fly")
                  {
                     this._targetCreep._atTarget = true;
                  }
                  else
                  {
                     this._targetCreep._atTarget = false;
                     this._targetCreep._waypoints = [this._tmpPoint];
                  }
                  this._targetCreep._hasTarget = true;
                  this._targetCreep._looking = false;
                  this._targetCreep._hasTarget = true;
               }
            }
            if(this.attackCooldown <= 0)
            {
               this.attackCooldown += int(this._attackDelay / this._speedMult);
               if(this._creatureID == "G3")
               {
                  _loc5_ = Point.interpolate(this._tmpPoint.add(new Point(0,-this._altitude)),this._targetCreep._tmpPoint,0.8);
                  FIREBALLS.Spawn2(_loc5_,this._targetCreep._tmpPoint,this._targetCreep,8,this._damage.Get(),0);
                  FIREBALLS._fireballs[FIREBALLS._id - 1].gotoAndStop(3);
               }
               else
               {
                  ATTACK.Damage(this._tmpPoint.x,this._tmpPoint.y - 5,this._damage.Get() * this._targetCreep._damageMult,this._mc.visible);
                  this._targetCreep._health.Add(-(this._damage.Get() * this._targetCreep._damageMult));
               }
               if(this._targetCreep._creatureID == "C14" || this._targetCreep._creatureID == "G3" || this._targetCreep.CanShootCreep() || GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < 50 && this._movement != "fly")
               {
                  if(!this._targetCreep._explode && !this._targetCreep._targetCreep && this._targetCreep._behaviour != "heal")
                  {
                     this._targetCreep._targetCreep = this;
                     if(this._targetCreep._creatureID == "C14" || this._targetCreep.CanShootCreep() || GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < 50 && this._movement != "fly")
                     {
                        this._targetCreep._atTarget = true;
                     }
                     else
                     {
                        this._targetCreep._atTarget = false;
                        this._targetCreep._waypoints = [this._tmpPoint];
                     }
                     this._targetCreep._hasTarget = true;
                     this._targetCreep._looking = false;
                     this._targetCreep._hasTarget = true;
                  }
               }
               _loc2_ = MAP.CreepCellFind(this._tmpPoint,50);
               _loc3_ = int(_loc2_.length);
               _loc4_ = 0;
               while(_loc4_ < 5 && _loc4_ < _loc3_)
               {
                  if(this._movement != "fly" || _loc2_[_loc4_].creep.CanShootCreep() || GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < 50 && this._movement != "fly")
                  {
                     if(!_loc2_[_loc4_].creep._explode && _loc2_[_loc4_].creep._behaviour != "heal")
                     {
                        _loc2_[_loc4_].creep._targetCreep = this;
                        if(_loc2_[_loc4_].creep.CanShootCreep() || GLOBAL.QuickDistance(_loc2_[_loc4_].creep._tmpPoint,this._tmpPoint) < 50 && this._movement != "fly" || _loc2_[_loc4_].creep._creatureID == "C14")
                        {
                           _loc2_[_loc4_].creep._atTarget = true;
                        }
                        _loc2_[_loc4_].creep._hasTarget = true;
                     }
                  }
                  _loc4_++;
               }
            }
            else
            {
               --this.attackCooldown;
            }
         }
         else
         {
            this._attacking = false;
         }
      }
      
      public function TickBJuice() : *
      {
         if(this._health.Get() <= 0)
         {
            this._health.Set(0);
            MAP.CreepCellDelete(this._id,this.node);
            this.ModeRetreat();
            return;
         }
         if(this._atTarget)
         {
            if(this._movement == "fly" && !this._dying)
            {
               this._dying = true;
               TweenLite.to(this._graphicMC,0.9,{
                  "y":this._graphicMC.y + this._altitude,
                  "ease":Sine.easeOut,
                  "onComplete":this.FlyerDeath
               });
            }
            if(this._movement == "fly" && !this._dead)
            {
               return false;
            }
            GLOBAL._bJuicer.BlendGuardian(1000 ^ this._level.Get() / 2);
            return true;
         }
      }
      
      public function FlyerDeath() : *
      {
         this._dead = true;
      }
      
      public function FlyerLanded() : *
      {
         this._altitude = 0;
      }
      
      public function FlyerTakeOff() : *
      {
         this._altitude = 108;
      }
      
      public function PoweredUp() : Boolean
      {
         return false;
      }
      
      public function TickBPen() : *
      {
         if(this._health.Get() < this._maxHealth)
         {
            if(this._lastHeal <= GLOBAL.Timestamp() - 5)
            {
               this._health.Add(int(this._maxHealth * 5 / this._regen));
               this._health.Set(Math.min(this._health.Get(),this._maxHealth));
               this._lastHeal = GLOBAL.Timestamp();
            }
         }
         if(this._behaviourMode == "defend" && this._frameNumber % 200 == 0)
         {
            this.FindDefenseTargets();
         }
         if(this._behaviour == "pen" && this._frameNumber > 4 * 60 && int(Math.random() * 150) == 1 && GLOBAL._fps > 25)
         {
            this._targetPosition = GUARDIANCAGE.PointInCage(this._targetCenter);
            this._hasPath = true;
         }
         if(GLOBAL._mode == "build" && this._level.Get() < 6)
         {
            if(!this._warnStarve)
            {
               if(GLOBAL.Timestamp() > this._feedTime.Get() + 86400)
               {
                  GUARDIANCAGE.Hide();
                  if(!GLOBAL._catchup)
                  {
                     GLOBAL.Message("Your Champion is starving and his evolution has stalled!  Now you must start feeding him over in order to get him to evolve!");
                  }
                  this._feeds.Add(-1);
                  if(this._feeds.Get() < 0)
                  {
                     this._feeds.Set(0);
                  }
                  this._feedTime = new SecNum(int(GLOBAL.Timestamp() + GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"feedTime")));
                  this._warnStarve = true;
                  LOGGER.Log("fed","Starved level " + this._level.Get());
               }
            }
            else if(!this._warned)
            {
               if(GLOBAL.Timestamp() > this._feedTime.Get())
               {
                  GUARDIANCAGE.Hide();
                  if(!GLOBAL._catchup)
                  {
                     GLOBAL.Message("Your Champion is hungry!  You must feed him within " + GLOBAL.ToTime(this._feedTime.Get() - GLOBAL.Timestamp() + 86400) + " or his evolution will stall!");
                  }
                  this._warned = true;
               }
            }
            if(this._feeds.Get() >= GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"feeds"))
            {
               this.LevelSet(this._level.Get() + 1);
            }
         }
      }
      
      public function TickBCage() : *
      {
         if(this._atTarget)
         {
            this._behaviour = "pen";
            if(this._movement == "fly" && this._altitude > 60)
            {
               TweenLite.to(this._graphicMC,1.2,{
                  "y":this._graphicMC.y + this._altitude,
                  "ease":Sine.easeOut,
                  "onComplete":this.FlyerLanded
               });
            }
            this._waypoints[0] = GUARDIANCAGE.PointInCage(this._targetCenter);
         }
         else if(this._behaviourMode == "defend" && this._frameNumber % 200 == 0)
         {
            this.FindDefenseTargets();
         }
      }
      
      public function TickBBuff() : *
      {
         var _loc2_:* = undefined;
         var _loc3_:CREEP = null;
         var _loc4_:Point = null;
         var _loc1_:Number = 1;
         if(Boolean(GLOBAL._attackerMonsterOverdrive) && GLOBAL._attackerMonsterOverdrive.Get() >= GLOBAL.Timestamp())
         {
            _loc1_ *= 1.25;
         }
         if(this._health.Get() <= 0)
         {
            MAP.CreepCellDelete(this._id,this.node);
            this.ModeRetreat();
            ATTACK.Log(this._creatureID,LOGIN._playerName + "\'s Level " + this._level.Get() + " " + GUARDIANCAGE._guardians[this._creatureID].name + " retreated.");
            if(GLOBAL._mode == "attack")
            {
               LOGGER.Stat([54,this._creatureID,1,this._level.Get()]);
            }
            SOUNDS.Play("monsterland" + (1 + int(Math.random() * 3)));
            return;
         }
         if(this._frameNumber % 100 == 0)
         {
            for each(_loc2_ in CREEPS._creeps)
            {
               if(_loc2_ != this)
               {
                  _loc3_ = _loc2_ as CREEP;
                  if(_loc3_ && _loc3_._damageMult >= 1 - this._buff && GLOBAL.QuickDistance(this._tmpPoint,_loc3_._tmpPoint) < 250)
                  {
                     _loc2_.ModeEnrage(GLOBAL.Timestamp() + 5,1 + this._buff * 2,1 - this._buff);
                  }
               }
            }
            if(!this._attacking)
            {
               this.FindBuffTargets();
            }
         }
         if(this._hasTarget)
         {
            if(this._targetCreep)
            {
               if(this._targetCreep._health.Get() <= 0 || this._targetCreep._health.Get() == this._targetCreep._maxHealth && this._frameNumber % 20 == 0)
               {
                  this._hasTarget = false;
                  this._attacking = false;
                  this._atTarget = false;
                  this._hasPath = false;
                  this._helpCreep = null;
                  if(this._targetCreep && this._targetCreep._health.Get() <= 0)
                  {
                     this._targetCreep = null;
                  }
                  this.FindBuffTargets();
               }
               else if(GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < this._range)
               {
                  this._atTarget = true;
               }
               else
               {
                  this._atTarget = false;
               }
            }
            else if(this._helpCreep)
            {
               if(this._helpCreep._targetBuilding)
               {
                  this._targetBuilding = this._helpCreep._targetBuilding;
               }
               if(this._helpCreep._health.Get() <= 0 || this._helpCreep._health.Get() == this._helpCreep._maxHealth && this._frameNumber % 20 == 0)
               {
                  this._hasTarget = false;
                  this._attacking = false;
                  this._atTarget = false;
                  this._hasPath = false;
                  if(this._helpCreep && this._helpCreep._health.Get() <= 0)
                  {
                     this._helpCreep = null;
                  }
                  this.FindBuffTargets();
               }
               else if(this._helpCreep && GLOBAL.QuickDistance(this._helpCreep._tmpPoint,this._tmpPoint) < this._range && Boolean(this._helpCreep._targetBuilding) && GLOBAL.QuickDistance(this._helpCreep._targetBuilding._position,this._tmpPoint) < this._range)
               {
                  this._atTarget = true;
               }
               else if(!this._attacking && !this._looking && this._frameNumber % 120 == 0)
               {
                  this.FindBuffTargets();
               }
               else if(this._attacking && this._helpCreep && GLOBAL.QuickDistance(this._helpCreep._tmpPoint,this._tmpPoint) > this._range * 1.25)
               {
                  this._attacking = false;
                  this._atTarget = false;
               }
               else if(this._waypoints.length == 0 && !this._atTarget)
               {
                  if(this.CanHitBuilding())
                  {
                     this._atTarget = true;
                  }
                  else if(!this._looking)
                  {
                     if(this._movement == "fly")
                     {
                        this._hasPath = true;
                        this._waypoints = [this._targetBuilding._position];
                        this._targetPosition = this._targetBuilding._position;
                     }
                     else if(!this._looking)
                     {
                        this._hasPath = false;
                        this._hasTarget = false;
                        this.WaypointTo(this._targetBuilding._position,this._targetBuilding);
                     }
                  }
               }
            }
            else if(Boolean(this._targetBuilding) && this._targetBuilding._hp.Get() > 0)
            {
               if(this.CanHitBuilding())
               {
                  this._atTarget = true;
               }
               else
               {
                  this._atTarget = false;
                  this._attacking = false;
                  if(this._waypoints.length == 0 && !this._looking)
                  {
                     this._hasPath = false;
                     if(this._movement == "fly")
                     {
                        this._waypoints = [this._helpCreep._tmpPoint];
                        this._targetPosition = this._helpCreep._tmpPoint;
                     }
                     else
                     {
                        this.WaypointTo(this._helpCreep._tmpPoint,this._targetBuilding);
                     }
                  }
               }
            }
            else
            {
               this._attacking = false;
               this._atTarget = false;
               this._hasPath = false;
               this._targetCreep = null;
               this._helpCreep = null;
               this._targetBuilding = null;
               this.FindBuffTargets();
            }
         }
         else
         {
            this._attacking = false;
            this._atTarget = false;
            this._hasPath = false;
            this._targetCreep = null;
            this._helpCreep = null;
            this._targetBuilding = null;
            this.FindBuffTargets();
         }
         if(this._atTarget)
         {
            if(this.attackCooldown <= 0)
            {
               this.attackCooldown += int(this._attackDelay / this._speedMult);
               if(this._targetCreep && this._targetCreep._health.Get() > 0)
               {
                  this._attacking = true;
                  _loc4_ = Point.interpolate(this._tmpPoint.add(new Point(0,-this._altitude)),this._targetPosition,0.8);
                  FIREBALLS.Spawn2(_loc4_,this._targetCreep._tmpPoint,this._targetCreep,8,this._damage.Get() * _loc1_);
                  FIREBALLS._fireballs[FIREBALLS._id - 1].gotoAndStop(3);
                  SOUNDS.Play("hit" + int(1 + Math.random() * 3),0.1 + Math.random() * 0.1);
                  this._targetCenter = this._targetCreep._tmpPoint;
                  this._targetPosition = this._targetCreep._tmpPoint;
               }
               else if(this._helpCreep && this._helpCreep._targetBuilding && this._helpCreep._targetBuilding._hp.Get() > 0 || this._targetBuilding && this._targetBuilding._hp.Get() > 0)
               {
                  if(this._helpCreep)
                  {
                     this._targetBuilding = this._helpCreep._targetBuilding;
                  }
                  if(Boolean(this._targetBuilding) && GLOBAL.QuickDistance(this._targetBuilding._position,this._tmpPoint) < this._range)
                  {
                     this._attacking = true;
                     this._targetCenter = this._targetBuilding._position;
                     this._targetPosition = this._targetBuilding._position;
                     _loc4_ = Point.interpolate(this._tmpPoint.add(new Point(0,-this._altitude)),this._targetPosition,0.8);
                     FIREBALLS.Spawn(_loc4_,this._targetPosition,this._targetBuilding,8,this._damage.Get() * _loc1_);
                     FIREBALLS._fireballs[FIREBALLS._id - 1].gotoAndStop(3);
                     SOUNDS.Play("hit" + int(1 + Math.random() * 3),0.1 + Math.random() * 0.1);
                  }
                  else if(this._targetBuilding)
                  {
                     this._attacking = false;
                     this._atTarget = false;
                     if(this._movement == "fly")
                     {
                        this._hasPath = true;
                        this._waypoints = [this._targetBuilding._position];
                        this._targetPosition = this._targetBuilding._position;
                     }
                     else if(!this._looking)
                     {
                        this._hasPath = false;
                        this._hasTarget = false;
                        this.WaypointTo(this._targetBuilding._position,this._targetBuilding);
                     }
                  }
                  else
                  {
                     this._attacking = false;
                     this._atTarget = false;
                     this._hasPath = false;
                     this._targetCreep = null;
                     this._helpCreep = null;
                     this._targetBuilding = null;
                     this.FindBuffTargets();
                  }
               }
               else
               {
                  this._attacking = false;
                  this._atTarget = false;
                  this._hasTarget = false;
                  this._hasPath = false;
                  this._targetBuilding = null;
                  this._targetCreep = null;
                  this._helpCreep = null;
                  this.FindBuffTargets();
               }
            }
            else
            {
               --this.attackCooldown;
            }
         }
         else
         {
            this._attacking = false;
         }
      }
      
      public function TickBRetreat() : *
      {
         if(this._atTarget)
         {
            return true;
         }
      }
      
      public function TickDefault() : *
      {
      }
      
      public function Export(param1:Boolean = true) : *
      {
         if(this._behaviour == "juice")
         {
            return;
         }
         if(param1 && CREATURES._guardian == this)
         {
            BASE._guardianData = {};
            BASE._guardianData.hp = new SecNum(this._health.Get());
            BASE._guardianData.l = new SecNum(this._level.Get());
            BASE._guardianData.fd = this._feeds.Get();
            BASE._guardianData.ft = this._feedTime.Get();
            BASE._guardianData.nm = this._name;
            BASE._guardianData.t = int(this._creatureID.substr(1,1));
         }
         if(!param1 || GLOBAL._mode == "build")
         {
            GLOBAL._playerGuardianData = {};
            GLOBAL._playerGuardianData.hp = new SecNum(this._health.Get());
            GLOBAL._playerGuardianData.l = new SecNum(this._level.Get());
            GLOBAL._playerGuardianData.fd = this._feeds.Get();
            GLOBAL._playerGuardianData.ft = this._feedTime.Get();
            GLOBAL._playerGuardianData.nm = this._name;
            GLOBAL._playerGuardianData.t = int(this._creatureID.substr(1,1));
         }
      }
      
      public function Heal() : *
      {
         var _loc1_:int = 0;
         if(GLOBAL._mode == "build")
         {
            _loc1_ = this.GetHealCost();
            if(_loc1_ > 0)
            {
               GLOBAL.Message("Heal your Champion for " + _loc1_ + " Shiny?","Heal",this.HealB);
            }
         }
      }
      
      public function HealB() : *
      {
         var _loc1_:int = 0;
         if(GLOBAL._mode == "build")
         {
            _loc1_ = this.GetHealCost();
            if(_loc1_ > BASE._credits.Get())
            {
               POPUPS.DisplayGetShiny();
               return;
            }
            this._health.Set(this._maxHealth);
            BASE.Purchase("IHE",_loc1_,"store");
            this.Export(this._friendly);
            LOGGER.Stat([58,this._creatureID,_loc1_,this._level.Get()]);
            BASE.Save();
         }
      }
      
      public function GetHealCost() : int
      {
         var _loc1_:Number = (this._maxHealth - this._health.Get()) / this._maxHealth;
         var _loc2_:int = int(_loc1_ * GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"healtime"));
         return STORE.GetTimeCost(_loc2_,false);
      }
      
      public function Tick() : *
      {
         var _loc1_:Number = NaN;
         this._frameNumber += 1;
         if(this._venom.Get() > 0)
         {
            this._health.Add(-(this._venom.Get() * this._damageMult));
         }
         if(this._health.Get() > this._maxHealth)
         {
            LOGGER.Log("hak","Champion monster health exceeds maximum");
            GLOBAL.ErrorMessage("GUARDIANMONSTER hack 1");
            return;
         }
         if(this._frameNumber % 30 == 0)
         {
            if(this._maxHealth != GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"health"))
            {
               LOGGER.Log("hak","Champion monster health max incorrect");
               GLOBAL.ErrorMessage("GUARDIANMONSTER hack 2");
               return;
            }
            if(this._maxSpeed != GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"speed") / 2 * 1.1)
            {
               LOGGER.Log("hak","Champion monster speed incorrect");
               GLOBAL.ErrorMessage("GUARDIANMONSTER hack 3");
               return;
            }
            if(this._range != GUARDIANCAGE.GetGuardianProperty(this._creatureID,this._level.Get(),"range"))
            {
               LOGGER.Log("hak","Champion monster range incorrect");
               GLOBAL.ErrorMessage("GUARDIANMONSTER hack 4");
               return;
            }
            if(this._secureSpeedMult.Get() != int(this._speedMult * 100))
            {
               LOGGER.Log("hak","Champion monster speed buff incorrect");
               GLOBAL.ErrorMessage("GUARDIANMONSTER hack 5");
               return;
            }
            if(this._secureDamageMult.Get() != int(this._damageMult * 100))
            {
               LOGGER.Log("hak","Champion monster damage buff incorrect");
               GLOBAL.ErrorMessage("GUARDIANMONSTER hack 6");
               return;
            }
         }
         this.Export(this._friendly);
         if(this._movement == "fly" && this._health.Get() > 0 && this._behaviour != "pen")
         {
            if(this._altitude >= 60)
            {
               _loc1_ = Math.sin(this._frameNumber / 50) * 5;
               this._altitude = 108 - _loc1_;
               this._graphicMC.y = -this._altitude - 36 + _loc1_;
            }
         }
         switch(this._behaviour)
         {
            case "attack":
            case "bounce":
               this.TickBAttack();
               break;
            case "defend":
               this.TickBDefend();
               break;
            case "buff":
               this.TickBBuff();
               break;
            case "pen":
               this.TickBPen();
               break;
            case "cage":
               this.TickBCage();
               break;
            case "juice":
               if(this.TickBJuice())
               {
                  return true;
               }
               break;
            case "retreat":
               if(this.TickBRetreat())
               {
                  return true;
               }
               break;
            default:
               this.TickDefault();
         }
         if((this._behaviour == "attack" || this._behaviour == "retreat" && this._health.Get() > 0) && this._frameNumber % 5 == 0)
         {
            this.newNode = MAP.CreepCellMove(this._tmpPoint,this._id,this,this.node);
            if(this.newNode)
            {
               this.node = this.newNode;
            }
         }
         if(this._enraged != 0 && this._enraged <= GLOBAL.Timestamp())
         {
            this.ModeEnrage(0,1,1);
         }
         this.Move();
         this.Render();
      }
      
      public function Move() : *
      {
         this._speed = this._maxSpeed * 0.5 * this._speedMult;
         if(this._behaviour == "pen")
         {
            this._speed *= 0.5;
         }
         if(this._behaviour == "juice" || this._behaviour == "cage" || this._behaviour == "bunker")
         {
            this._speed *= 1.5;
         }
         if(this._behaviour == "defend")
         {
            this._speed *= 1.5;
         }
         if(this._behaviour == "juice" && this._movement == "fly" && this._altitude < 60)
         {
            this._speed = 0;
         }
         if(this._attacking)
         {
            this._speed = 0;
         }
         if(this._jumping)
         {
            if(this._jumpingUp)
            {
               this._speed *= 3;
            }
            else
            {
               this._speed *= 2;
            }
         }
         if(!this._atTarget && this._behaviour != "cage" && this._behaviour != "pen" && this._behaviour != "juice" && (this._targetCreep && this.CanShootCreep() || this.CanHitBuilding()))
         {
            this._atTarget = true;
            if(this._targetCreep)
            {
               this._xd = this._targetCreep._tmpPoint.x - this._tmpPoint.x;
               this._yd = this._targetCreep._tmpPoint.y - this._tmpPoint.y;
               this._targetPosition = this._targetCreep._tmpPoint;
            }
            else if(this._targetBuilding)
            {
               this._targetPosition = new Point(this._targetBuilding._mc.x,this._targetBuilding._mc.y + this._targetBuilding._footprint[0].height / 2);
               this._xd = this._targetPosition.x - this._tmpPoint.x;
               this._yd = this._targetPosition.y - this._tmpPoint.y;
            }
            else if(this._waypoints.length > 0)
            {
               this._xd = this._waypoints[this._waypoints.length - 1].x - this._tmpPoint.x;
               this._yd = this._waypoints[this._waypoints.length - 1].y - this._tmpPoint.y;
               this._targetPosition = this._waypoints[this._waypoints.length - 1];
            }
         }
         else if(this._targetCreep && this._behaviour == "attack")
         {
            this._xd = this._targetCreep._tmpPoint.x - this._tmpPoint.x;
            this._yd = this._targetCreep._tmpPoint.y - this._tmpPoint.y;
            this._targetPosition = this._targetCreep._tmpPoint;
            if(GLOBAL.QuickDistance(this._targetPosition,this._tmpPoint) > this._range)
            {
               this._tmpPoint.x += Math.cos(Math.atan2(this._yd,this._xd)) * this._speed;
               this._tmpPoint.y += Math.sin(Math.atan2(this._yd,this._xd)) * this._speed;
            }
            else
            {
               this._atTarget = true;
            }
         }
         else if(this._waypoints.length > 0)
         {
            this._targetPosition = this._waypoints[0];
            if(GLOBAL.QuickDistance(this._targetPosition,this._tmpPoint) <= 10)
            {
               while(this._waypoints.length > 0 && GLOBAL.QuickDistance(this._targetPosition,this._tmpPoint) <= 10)
               {
                  this._waypoints.splice(0,1);
                  if(this._waypoints[0])
                  {
                     this._targetPosition = this._waypoints[0];
                  }
                  else
                  {
                     if(this._behaviour != "defend")
                     {
                        this._atTarget = true;
                        return false;
                     }
                     if(GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < this._range)
                     {
                        this._atTarget = true;
                        if(this._targetCreep._behaviour != "heal")
                        {
                           this._targetCreep._targetCreep = this;
                           if(this._targetCreep._creatureID == "C14" || this._targetCreep.CanShootCreep() || GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < 50 && this._movement != "fly")
                           {
                              this._targetCreep._atTarget = true;
                           }
                           else
                           {
                              this._targetCreep._atTarget = false;
                              this._targetCreep._waypoints = [this._tmpPoint];
                           }
                           this._targetCreep._hasTarget = true;
                           this._targetCreep._looking = false;
                           this._targetCreep._hasTarget = true;
                        }
                        return false;
                     }
                  }
               }
               if(this._behaviour == "defend")
               {
                  if(this._creatureID != "G3" && GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < this._range || this.CanShootCreep())
                  {
                     this._atTarget = true;
                     this._targetPosition = this._targetCreep._tmpPoint;
                     if(!this._targetCreep._explode && this._targetCreep._behaviour != "heal")
                     {
                        this._targetCreep._targetCreep = this;
                        if(this._targetCreep._creatureID == "C14" || this._targetCreep.CanShootCreep() || GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < 50 && this._movement != "fly")
                        {
                           this._targetCreep._atTarget = true;
                        }
                        else
                        {
                           this._targetCreep._atTarget = false;
                           this._targetCreep._waypoints = [this._tmpPoint];
                        }
                        this._targetCreep._hasTarget = true;
                        this._targetCreep._looking = false;
                        this._targetCreep._hasTarget = true;
                     }
                     return false;
                  }
                  if(this._targetCreep && this._waypoints.length == 0 && this._hasPath)
                  {
                     if(this._noDefensePath)
                     {
                        this._targetPosition = this._targetCreep._tmpPoint;
                        this._waypoints = [this._targetCreep._tmpPoint];
                     }
                     else
                     {
                        this.WaypointTo(this._targetCreep._tmpPoint,null);
                     }
                  }
               }
               else if(this._waypoints.length == 0 && this._hasPath && this._targetCreep)
               {
                  this._atTarget = true;
                  return false;
               }
            }
            if(this._waypoints.length > 0)
            {
               this._targetPosition = this._waypoints[0];
            }
            if(this._behaviour == "attack" && this._targetCreep)
            {
               this._xd = this._targetCreep._tmpPoint.x - this._tmpPoint.x;
               this._yd = this._targetCreep._tmpPoint.y - this._tmpPoint.y;
            }
            else if(this._behaviour == "defend")
            {
               if(this._attacking)
               {
                  this._xd = this._targetCreep._tmpPoint.x - this._tmpPoint.x;
                  this._yd = this._targetCreep._tmpPoint.y - this._tmpPoint.y;
               }
               else if(this._targetPosition)
               {
                  this._xd = this._targetPosition.x - this._tmpPoint.x;
                  this._yd = this._targetPosition.y - this._tmpPoint.y;
               }
            }
            else if(this._targetPosition)
            {
               this._xd = this._targetPosition.x - this._tmpPoint.x;
               this._yd = this._targetPosition.y - this._tmpPoint.y;
            }
            this._tmpPoint.x += Math.cos(Math.atan2(this._yd,this._xd)) * this._speed;
            this._tmpPoint.y += Math.sin(Math.atan2(this._yd,this._xd)) * this._speed;
         }
         else if(this._hasPath)
         {
            if(this._targetCreep)
            {
               this._xd = this._targetCreep._tmpPoint.x - this._tmpPoint.x;
               this._yd = this._targetCreep._tmpPoint.y - this._tmpPoint.y;
            }
            else if(this._targetBuilding)
            {
               this._xd = this._targetBuilding.x - this._tmpPoint.x;
               this._yd = this._targetBuilding.y + this._targetBuilding._middle - this._tmpPoint.y;
            }
            else if(this._targetPosition)
            {
               this._xd = this._targetPosition.x - this._tmpPoint.x;
               this._yd = this._targetPosition.y - this._tmpPoint.y;
               if(GLOBAL.QuickDistance(this._targetPosition,this._tmpPoint) > 5)
               {
                  this._tmpPoint.x += Math.cos(Math.atan2(this._yd,this._xd)) * this._speed;
                  this._tmpPoint.y += Math.sin(Math.atan2(this._yd,this._xd)) * this._speed;
               }
            }
         }
      }
      
      public function Render() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         if(!GLOBAL._catchup)
         {
            this._targetRotation = Math.atan2(this._yd,this._xd) * 57.2957795 - 90;
            _loc1_ = mcMarker.rotation - this._targetRotation;
            if(_loc1_ > 3 * 60)
            {
               this._targetRotation += 6 * 60;
            }
            else if(_loc1_ < -180)
            {
               this._targetRotation -= 360;
            }
            this._targetRotation += 90;
            _loc2_ = (this._targetRotation - mcMarker.rotation) / 5;
            _loc2_ = _loc2_ * 0.5 * GLOBAL._loops;
            if(_loc2_ != 0)
            {
               mcMarker.rotation += _loc2_;
            }
            if(x != int(this._tmpPoint.x) || y != int(this._tmpPoint.y))
            {
               x = int(this._tmpPoint.x);
               y = int(this._tmpPoint.y);
            }
            this._graphic.lock();
            if(this._shadow)
            {
               this._shadow.lock();
            }
            _loc4_ = 0;
            this._visible = true;
            if(!alpha)
            {
               alpha = 1;
            }
            if(this._behaviour == "pen" && !this._hasPath)
            {
               SPRITES.GetSprite(this._graphic,this._spriteID,"idle",mcMarker.rotation - 45);
            }
            else if(this._attacking)
            {
               SPRITES.GetSprite(this._graphic,this._spriteID,"attack",mcMarker.rotation - 45,this._frameNumber);
            }
            else
            {
               SPRITES.GetSprite(this._graphic,this._spriteID,"walking",mcMarker.rotation - 45,this._frameNumber);
            }
            if(this._movement == "fly")
            {
               SPRITES.GetSprite(this._shadow,"bigshadow","bigshadow",0);
            }
            this._lastRotation = int(mcMarker.rotation / 12);
            if(this._health.Get() < this._maxHealth)
            {
               _loc5_ = 11 - int(11 / this._maxHealth * this._health.Get());
               _loc6_ = SPRITES.GetSpriteDescriptor(this._spriteID);
               this._graphic.copyPixels(CREEPS._bmdHPbar,new Rectangle(0,5 * _loc5_,17,5),new Point(_loc6_.width / 2 - 28,6));
            }
            this._graphic.unlock();
            if(this._shadow)
            {
               this._shadow.unlock();
            }
         }
      }
   }
}

