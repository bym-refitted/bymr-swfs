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
   
   public class CREEP_INFERNO extends CREEP_CLIP
   {
      public var _behaviour:String;
      
      public var _frameNumber:int;
      
      public var _spawned:Boolean;
      
      public var _creatureID:String;
      
      public var _graphic:BitmapData;
      
      public var _middle:int;
      
      public var _visible:Boolean = true;
      
      public var _clicked:Boolean = false;
      
      public var _looking:Boolean = false;
      
      public var _glow:GlowFilter = null;
      
      public var _invisibleTime:int;
      
      public var _invisibleCooldown:int = 80;
      
      public var _blinkState:int = 0;
      
      public var _blinkPoints:int = 0;
      
      public var _blinkDistance:Number;
      
      public var _speed:Number;
      
      public var _maxSpeed:Number;
      
      public var _health:SecNum;
      
      public var _maxHealth:Number;
      
      public var _damage:SecNum;
      
      public var _size:int;
      
      public var _goo:int;
      
      private var _secureDamageMult:SecNum;
      
      private var _secureSpeedMult:SecNum;
      
      public var _venom:SecNum;
      
      public var _targetRotation:Number;
      
      public var _targetPosition:Point;
      
      public var _targetCenter:Point;
      
      public var _waypoints:Array;
      
      private var _pathID:int = 0;
      
      private var _jumping:Boolean = false;
      
      private var _jumpingUp:Boolean = false;
      
      private const _noDefensePath:Boolean = false;
      
      private var _doDefenseBurrow:Boolean = true;
      
      private var _lastFrame:int = -1;
      
      public var _hasTarget:Boolean;
      
      public var _hasPath:Boolean;
      
      public var _attacking:Boolean;
      
      public var _intercepting:Boolean;
      
      public var _targetBuilding:BFOUNDATION;
      
      public var _homeBunker:*;
      
      public var _targetCreeps:Array;
      
      public var _targetCreep:*;
      
      public var _id:*;
      
      public var _attackDelay:int;
      
      public var _friendly:Boolean;
      
      public var _house:BFOUNDATION;
      
      public var _hits:int;
      
      public var _spawnPoint:Point;
      
      public var _lastRotation:int = 400;
      
      public var _targetGroup:int;
      
      public var _explode:int = 0;
      
      public var _goeasy:Boolean = false;
      
      public var _hitLimit:int = 50;
      
      public var _enraged:Number = 0;
      
      public var _damageMult:Number = 1;
      
      public var _speedMult:Number = 1;
      
      public var _altitude:int = 40;
      
      private var _defenderRemoved:Boolean = false;
      
      internal var attackCooldown:int;
      
      internal var frameCount:int;
      
      internal var shocking:Boolean;
      
      internal var node:*;
      
      internal var newNode:*;
      
      public var _tmpPoint:Point;
      
      public var _spawnTime:int;
      
      public var _atTarget:Boolean = false;
      
      public var _xd:Number = 0;
      
      public var _yd:Number = 0;
      
      public var _mc:*;
      
      public var _graphicMC:DisplayObject;
      
      public var _shadow:BitmapData;
      
      public var _shadowMC:DisplayObject;
      
      public var _phase:Number = 0;
      
      public var _movement:String = "";
      
      public var _pathing:String = "";
      
      private const DEFENSE_RANGE:int = 30;
      
      private const DEFENSE_MODIFIER:Number = 1;
      
      private const HEALING_RANGE:int = 150;
      
      private var _dying:Boolean = false;
      
      private var _dead:Boolean = false;
      
      public function CREEP_INFERNO(param1:String, param2:String, param3:Point, param4:Number, param5:Point = null, param6:Boolean = false, param7:BFOUNDATION = null, param8:Number = 1, param9:Boolean = false, param10:CREEP = null)
      {
         var _loc12_:Point = null;
         this._secureDamageMult = new SecNum(100);
         this._secureSpeedMult = new SecNum(100);
         this._venom = new SecNum(0);
         this._tmpPoint = new Point(0,0);
         super();
         var _loc11_:int = getTimer();
         this._mc = this;
         this._id = GLOBAL.NextCreepID();
         this._friendly = param6;
         this._creatureID = param1;
         this._middle = 5;
         this._house = param7;
         this._hits = 0;
         this._spawnPoint = new Point(int(param3.x / 100) * 100,int(param3.y / 100) * 100);
         this._goeasy = param9;
         this._movement = CREATURELOCKER._creatures[param1].movement;
         this._pathing = CREATURELOCKER._creatures[param1].pathing;
         if(this._house)
         {
            this._house._creatures.push(this);
         }
         this._behaviour = param2;
         this._targetGroup = CREATURES.GetProperty(param1,"targetGroup");
         this._explode = CREATURES.GetProperty(param1,"explode");
         this._spawnTime = GLOBAL.Timestamp();
         this._waypoints = [];
         this._targetCreeps = [];
         this._targetCreep = null;
         this._homeBunker = null;
         this._invisibleTime = 0;
         mouseEnabled = false;
         mouseChildren = false;
         this._speed = 0;
         this._maxSpeed = CREATURES.GetProperty(this._creatureID,"speed") / 2;
         this._maxSpeed *= 1.1;
         if(TUTORIAL._stage < 200)
         {
            this._maxSpeed *= 2;
         }
         this._health = new SecNum(int(CREATURES.GetProperty(this._creatureID,"health") * param8));
         this._maxHealth = this._health.Get();
         this._damage = new SecNum(int(CREATURES.GetProperty(this._creatureID,"damage") * param8));
         this._goo = CREATURES.GetProperty(this._creatureID,"cResource");
         this._targetPosition = param3;
         this._targetCenter = param5;
         x = this._targetPosition.x;
         y = this._targetPosition.y;
         this._tmpPoint.x = x;
         this._tmpPoint.y = y;
         if(param4)
         {
            this._targetRotation = param4;
         }
         else
         {
            this._targetRotation = 0;
         }
         mcMarker.rotation = this._targetRotation;
         this._attackDelay = 60;
         if(this._creatureID == "C7" && this._friendly && this.PoweredUp() && this.PowerUpLevel() > 1)
         {
            this._attackDelay /= 1 + this.PowerUpLevel() * 0.5;
         }
         this._attacking = false;
         this._frameNumber = 0;
         SPRITES.SetupSprite(this._creatureID);
         if(this._movement == "fly")
         {
            SPRITES.SetupSprite("shadow");
            this._shadow = new BitmapData(52,50,true,0xffffff);
            this._shadowMC = addChild(new Bitmap(this._shadow));
            this._shadowMC.x = -21;
            this._shadowMC.y = -16;
            this._frameNumber = int(Math.random() * 1000);
         }
         this._graphic = new BitmapData(64,50,true,0xffffff);
         this._graphicMC = addChild(new Bitmap(this._graphic));
         this._graphicMC.x = -26;
         this._graphicMC.y = -36;
         if(param2 == "housing")
         {
            _loc12_ = GRID.ToISO(this._targetCenter.x + 100,this._targetCenter.y + 100,0);
            if(this._movement == "fly")
            {
               this._graphicMC.y -= this._altitude;
            }
            else
            {
               this._altitude = 0;
            }
            PATHING.GetPath(this._tmpPoint,new Rectangle(_loc12_.x,_loc12_.y,10,10),this.SetWaypoints,true);
         }
         else if(this._behaviour == "bounce")
         {
            if(GLOBAL._render && this._movement != "fly")
            {
               EFFECTS.Dig(int(this._tmpPoint.x),int(this._tmpPoint.y));
               TweenLite.to(this._graphicMC,0.4,{
                  "y":this._graphicMC.y - 20,
                  "ease":Sine.easeOut,
                  "overwrite":false
               });
               TweenLite.to(this._graphicMC,0.4,{
                  "y":this._graphicMC.y,
                  "ease":Bounce.easeOut,
                  "overwrite":false,
                  "delay":0.4,
                  "onComplete":this.ModeAttack
               });
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
               if(this._targetGroup == 5)
               {
                  this.ModeHeal();
               }
               else if(this._targetGroup == 6)
               {
                  this.ModeHunt();
               }
               else
               {
                  this.ModeAttack();
               }
            }
         }
         else if(this._behaviour == "loot")
         {
            this.node = MAP.CreepCellAdd(this._tmpPoint,this._id,this);
         }
         else if(this._behaviour == "defend")
         {
            this.ModeDefend();
         }
         if(param8 > 1)
         {
            LOGGER.Log("log","MONSTER Strength");
            GLOBAL.ErrorMessage("CREEP_INFERNO");
         }
         if(this._behaviour == "juice")
         {
            this.ModeJuice();
         }
         if(this._behaviour == "feed")
         {
            this.ModeFeed();
         }
         this.UpdateBuffs();
         this.Render();
      }
      
      public function ModeJuice() : void
      {
         this._behaviour = "juice";
         this._hasTarget = false;
         this._atTarget = false;
         this._hasPath = false;
         this._targetBuilding = GLOBAL._bJuicer;
         if(this._movement == "fly" && this._altitude < 60)
         {
            TweenLite.to(this._graphicMC,2,{
               "y":this._graphicMC.y - (40 - this._altitude),
               "ease":Sine.easeIn,
               "onComplete":this.FlyerTakeOff
            });
         }
         PATHING.GetPath(this._tmpPoint,new Rectangle(this._targetBuilding._mc.x,this._targetBuilding._mc.y,80,80),this.SetWaypoints,true);
         GLOBAL._bJuicer.Prep(this._creatureID);
      }
      
      public function ModeFeed() : void
      {
         this._behaviour = "feed";
         this._hasTarget = false;
         this._atTarget = false;
         this._hasPath = false;
         this._targetBuilding = GLOBAL._bCage;
         this.WaypointTo(CREATURES._guardian._tmpPoint,null);
      }
      
      public function ModeHousing() : void
      {
         this._behaviour = "housing";
         this._hasTarget = false;
         this._atTarget = false;
         this._hasPath = false;
         var _loc1_:Point = GRID.ToISO(this._targetCenter.x + 100,this._targetCenter.y + 60,0);
         PATHING.GetPath(this._tmpPoint,new Rectangle(_loc1_.x,_loc1_.y,10,10),this.SetWaypoints,true);
      }
      
      public function ModeEnrage(param1:Number, param2:Number, param3:Number) : void
      {
         this._enraged = param1;
         this._speedMult = param2;
         this._damageMult = param3;
         this.UpdateBuffs();
      }
      
      private function d2h(param1:uint) : String
      {
         var _loc4_:* = 0;
         var _loc2_:Array = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];
         if(param1 == 0)
         {
            return "0x0";
         }
         var _loc3_:String = "";
         if(param1 > 0xffffff)
         {
            param1 = 16777215;
         }
         while(param1 > 0)
         {
            _loc4_ = param1 & 15;
            _loc3_ = _loc2_[_loc4_] + _loc3_;
            param1 >>= 4;
         }
         return "0x" + _loc3_;
      }
      
      public function UpdateBuffs() : void
      {
         if(this._enraged > 0)
         {
            if(this._enraged > 0)
            {
               if(this._glow)
               {
                  this._glow.color = 13582340;
                  this._glow.blurX = 3;
                  this._glow.blurY = 3;
                  this._glow.strength = 5;
               }
               else
               {
                  this._glow = new GlowFilter(13582340,1,3,3,5,1);
               }
               filters = [this._glow];
            }
         }
         this._secureSpeedMult = new SecNum(int(this._speedMult * 100));
         this._secureDamageMult = new SecNum(int(this._damageMult * 100));
      }
      
      public function ModeAttack() : void
      {
         this._behaviour = "attack";
         this._hasTarget = false;
         this._atTarget = false;
         this._hasPath = false;
         this.node = MAP.CreepCellAdd(this._tmpPoint,this._id,this);
         this.FindTarget(this._targetGroup,true);
      }
      
      public function ModeHunt() : void
      {
         this._behaviour = "hunt";
         this._hasTarget = false;
         this._atTarget = false;
         this._hasPath = false;
         this.node = MAP.CreepCellAdd(this._tmpPoint,this._id,this);
         this.FindTarget(this._targetGroup,true);
      }
      
      public function ModeHeal() : void
      {
         this._behaviour = "heal";
         this._hasTarget = false;
         this._atTarget = false;
         this._hasPath = false;
         this.node = MAP.CreepCellAdd(this._tmpPoint,this._id,this);
         this.FindHealingTargets();
      }
      
      public function ModeDefend() : void
      {
         this._behaviour = "defend";
         this._hasTarget = false;
         this._atTarget = false;
         this._hasPath = false;
      }
      
      public function ModeBunker() : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:BFOUNDATION = null;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         this._behaviour = "bunker";
         this._hasTarget = false;
         this._atTarget = false;
         this._hasPath = false;
         this._doDefenseBurrow = false;
         if(this._homeBunker == null)
         {
            for(_loc2_ in BASE._buildingsAll)
            {
               _loc3_ = 9999999;
               if(MONSTERBUNKER.isBunkerBuilding(BASE._buildingsAll[_loc2_]._type) && BASE._buildingsAll[_loc2_]._countdownBuild.Get() <= 0 && BASE._buildingsAll[_loc2_]._hp.Get() > 0)
               {
                  _loc4_ = BASE._buildingsAll[_loc2_];
                  _loc5_ = _loc4_._mc.x - this._tmpPoint.x;
                  _loc6_ = _loc4_._mc.y - this._tmpPoint.y;
                  _loc7_ = int(Math.sqrt(_loc5_ * _loc5_ + _loc6_ * _loc6_));
                  if(_loc3_ > _loc7_)
                  {
                     this._homeBunker = _loc4_;
                  }
               }
            }
         }
         if(this._homeBunker)
         {
            this._targetCenter = GRID.FromISO(this._homeBunker._mc.x,this._homeBunker._mc.y);
            this._targetPosition = GRID.FromISO(this._homeBunker._mc.x,this._homeBunker._mc.y);
            this._jumpingUp = false;
            var _loc1_:Point = GRID.ToISO(this._targetCenter.x + 100,this._targetCenter.y + 60,0);
            PATHING.GetPath(this._tmpPoint,new Rectangle(_loc1_.x,_loc1_.y,10,10),this.SetWaypoints,true);
            return;
         }
      }
      
      public function ModeRetreat() : void
      {
         this._behaviour = "retreat";
         this._hasTarget = false;
         this._atTarget = false;
         this._hasPath = false;
         this._attacking = false;
         if(this._movement == "burrow")
         {
            EFFECTS.Dig(x,y);
            SOUNDS.Play("dig");
            this.Clear();
         }
         else
         {
            this.WaypointTo(this._spawnPoint);
         }
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         this._health.Set(0);
         if(this._house)
         {
            _loc1_ = 0;
            while(_loc1_ < this._house._creatures.length)
            {
               if(this._house._creatures[_loc1_] == this)
               {
                  this._house._creatures.splice(_loc1_,1);
                  return;
               }
               _loc1_++;
            }
         }
      }
      
      public function InterceptTarget() : void
      {
         var _loc1_:Number = NaN;
         this._intercepting = false;
         this._looking = true;
         if(GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < this.DEFENSE_RANGE || this.CanShootCreep())
         {
            this._waypoints = [];
            this._atTarget = true;
            this._looking = false;
         }
         else if(this._noDefensePath || GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < this.DEFENSE_RANGE * 3 || this._pathing == "direct")
         {
            this._waypoints = [this._targetCreep._tmpPoint];
            this._targetPosition = this._targetCreep._tmpPoint;
            _loc1_ = GLOBAL.QuickDistance(this._tmpPoint,this._targetCreep._tmpPoint);
            if(this._pathing == "direct" && !this._hasTarget && _loc1_ < 2 * 60)
            {
               this._doDefenseBurrow = false;
            }
            else
            {
               this._doDefenseBurrow = true;
            }
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
      
      public function FindHealingTargets() : void
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
         var _loc4_:Boolean = false;
         this._targetCreeps = MAP.CreepCellFind(this._tmpPoint,25 * 60,1,this);
         if(this._targetCreeps.length > 0)
         {
            this._targetCreeps.sortOn(["dist"],Array.NUMERIC);
            if(!(this._targetCreep && this._targetCreep._health.Get() > 0 && this._targetCreep._health.Get() < this._targetCreep._maxHealth))
            {
               _loc4_ = true;
               while(this._targetCreeps.length > 0 && this._targetCreeps[0].creep._creatureID == this._creatureID)
               {
                  this._targetCreeps.shift();
               }
               if(this._targetCreeps.length > 0)
               {
                  this._targetCreep = this._targetCreeps[0].creep;
                  this._waypoints = [this._targetCreep._tmpPoint];
               }
            }
            while(this._targetCreeps.length > 0 && (this._targetCreeps[0].creep._behaviour == "retreat" || this._targetCreeps[0].creep._creatureID == this._creatureID || this._targetCreeps[0].creep._health.Get() == this._targetCreeps[0].creep._maxHealth))
            {
               this._targetCreeps.shift();
            }
         }
         if(this._targetCreeps.length > 0)
         {
            _loc4_ = false;
            this._targetCreep = this._targetCreeps[0].creep;
            this._waypoints = [this._targetCreep._tmpPoint];
            this._targetPosition = this._targetCreep._tmpPoint;
            this._behaviour = "heal";
         }
         else if(this._targetCreep && this._targetCreep._health.Get() > 0 && this._targetCreep._health.Get() < this._targetCreep._maxHealth)
         {
            _loc4_ = false;
            this._waypoints = [this._targetCreep._tmpPoint];
            this._targetPosition = this._targetCreep._tmpPoint;
            this._behaviour = "heal";
         }
         if(this._waypoints.length)
         {
            this._hasTarget = true;
            this._hasPath = true;
            this.WaypointTo(this._waypoints[0],null);
         }
      }
      
      public function FindHuntingTargets() : void
      {
         var _loc3_:* = undefined;
         var _loc1_:int = 0;
         var _loc2_:Array = [];
         for each(_loc3_ in CREATURES._creatures)
         {
            if(!(_loc3_._behaviour != "defend" && BASE._yardType < BASE.INFERNO_YARD))
            {
               _loc2_.push({
                  "creep":_loc3_,
                  "dist":GLOBAL.QuickDistance(_loc3_._tmpPoint,this._tmpPoint)
               });
               _loc1_++;
               if(_loc1_ >= 10)
               {
                  break;
               }
            }
         }
         if(Boolean(CREATURES._guardian) && CREATURES._guardian._health.Get() > 0)
         {
            _loc2_.push({
               "creep":CREATURES._guardian,
               "dist":GLOBAL.QuickDistance(CREATURES._guardian._tmpPoint,this._tmpPoint)
            });
         }
         if(_loc2_.length > 0)
         {
            _loc2_.sortOn("dist",Array.NUMERIC);
            while(_loc2_.length > 0 && _loc2_[0].creep._health.Get() <= 0)
            {
               _loc2_.splice(0,1);
            }
         }
         if(_loc2_.length > 0)
         {
            this._targetCreep = _loc2_[0].creep;
            this._waypoints = [this._targetCreep._tmpPoint];
         }
      }
      
      public function FindDefenseTargets() : void
      {
         var _loc3_:int = 0;
         if(this._creatureID == "IC7" || this._creatureID == "IC5")
         {
            _loc3_ = 1;
         }
         this._targetCreeps = MAP.CreepCellFind(this._tmpPoint,200,_loc3_);
         if(this._targetCreeps.length > 0)
         {
            this._targetCreeps.sortOn(["dist"],Array.NUMERIC);
            while(this._targetCreeps.length > 0 && this._targetCreeps[0].creep._behaviour == "retreat")
            {
               this._targetCreeps.splice(0,1);
            }
         }
         if(this._targetCreeps.length > 0)
         {
            this._targetCreep = this._targetCreeps[0].creep;
            this.InterceptTarget();
            this._behaviour = "defend";
         }
         else if(this._targetCreep && this._targetCreep._health.Get() > 0)
         {
            if(this._noDefensePath || this._pathing == "direct")
            {
               this.InterceptTarget();
            }
            this._behaviour = "defend";
         }
         else if(this._homeBunker && this._homeBunker._hp.Get() > 0)
         {
            this._targetCreep = this._homeBunker.GetTarget(_loc3_);
            if(this._targetCreep)
            {
               this._atTarget = false;
               this._attacking = false;
               this._behaviour = "defend";
               this.InterceptTarget();
            }
            else if(this._behaviour != "bunker")
            {
               this.ModeBunker();
            }
         }
         else if(this._behaviour != "bunker")
         {
            this.ModeBunker();
         }
      }
      
      public function FindTarget(param1:int, param2:Boolean = false) : void
      {
         var _loc5_:BFOUNDATION = null;
         var _loc9_:Point = null;
         var _loc10_:Point = null;
         var _loc11_:int = 0;
         var _loc13_:* = undefined;
         var _loc14_:* = undefined;
         var _loc15_:Boolean = false;
         var _loc16_:int = 0;
         var _loc17_:Point = null;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:Number = NaN;
         var _loc22_:* = undefined;
         var _loc23_:* = undefined;
         var _loc3_:int = getTimer();
         var _loc12_:Array = [];
         this._looking = true;
         if(this._behaviour == "hunt" && (CREATURES._creatureCount > 0 || CREATURES._guardian && CREATURES._guardian._health.Get() > 0))
         {
            this.FindHuntingTargets();
            if(this._targetCreep)
            {
               this._hasTarget = true;
               this._hasPath = true;
               this._waypoints = [this._targetCreep._tmpPoint];
               this._targetPosition = this._targetCreep._tmpPoint;
               this._targetCenter = this._targetCreep._tmpPoint;
            }
         }
         _loc9_ = PATHING.FromISO(this._tmpPoint);
         if(param1 == 2)
         {
            for each(_loc5_ in BASE._buildingsWalls)
            {
               if(!_loc5_._destroyed)
               {
                  _loc10_ = GRID.FromISO(_loc5_._mc.x,_loc5_._mc.y + _loc5_._middle);
                  _loc11_ = GLOBAL.QuickDistance(_loc9_,_loc10_) - _loc5_._middle;
                  _loc12_.push({
                     "building":_loc5_,
                     "distance":_loc11_
                  });
               }
            }
         }
         else if(param1 == 3)
         {
            for each(_loc5_ in BASE._buildingsMain)
            {
               if(_loc5_._hp.Get() > 0 && (_loc5_._class == "resource" || _loc5_._type == 6 || _loc5_._type == 14 || _loc5_._type == 112) && !_loc5_._looted)
               {
                  _loc10_ = GRID.FromISO(_loc5_._mc.x,_loc5_._mc.y + _loc5_._middle);
                  _loc11_ = GLOBAL.QuickDistance(_loc9_,_loc10_) - _loc5_._middle;
                  _loc12_.push({
                     "building":_loc5_,
                     "distance":_loc11_
                  });
               }
            }
         }
         else if(param1 == 4)
         {
            for each(_loc5_ in BASE._buildingsTowers)
            {
               if(MONSTERBUNKER.isBunkerBuilding(_loc5_._type))
               {
                  _loc13_ = _loc5_;
                  if(_loc13_._hp.Get() > 0 && (_loc13_._used > 0 || _loc13_._monstersDispatchedTotal > 0))
                  {
                     _loc10_ = GRID.FromISO(_loc5_._mc.x,_loc5_._mc.y + _loc5_._middle);
                     _loc11_ = GLOBAL.QuickDistance(_loc9_,_loc10_) - _loc5_._middle;
                     _loc12_.push({
                        "building":_loc5_,
                        "distance":_loc11_,
                        "expand":false
                     });
                  }
               }
               else if(_loc5_._class != "trap" && _loc5_._hp.Get() > 0)
               {
                  _loc10_ = GRID.FromISO(_loc5_._mc.x,_loc5_._mc.y + _loc5_._middle);
                  _loc11_ = GLOBAL.QuickDistance(_loc9_,_loc10_) - _loc5_._middle;
                  _loc12_.push({
                     "building":_loc5_,
                     "distance":_loc11_,
                     "expand":false
                  });
               }
            }
         }
         else if(this._targetGroup == 6)
         {
            for each(_loc14_ in BASE._buildingsBunkers)
            {
               if(_loc14_._hp.Get() > 0)
               {
                  _loc15_ = false;
                  if(_loc14_._type == 22)
                  {
                     if(_loc14_._used > 0 || _loc14_._monstersDispatchedTotal > 0)
                     {
                        _loc15_ = true;
                     }
                  }
                  if(_loc14_._type == 128)
                  {
                     if(HOUSING._housingUsed.Get() > 0)
                     {
                        _loc15_ = true;
                     }
                  }
                  if(_loc15_)
                  {
                     _loc10_ = GRID.FromISO(_loc14_._mc.x,_loc14_._mc.y + _loc14_._middle);
                     _loc11_ = GLOBAL.QuickDistance(_loc9_,_loc10_) - _loc14_._middle;
                     _loc12_.push({
                        "building":_loc14_,
                        "distance":_loc11_,
                        "expand":false
                     });
                  }
               }
            }
         }
         if(_loc12_.length == 0 || param1 == 1)
         {
            for each(_loc5_ in BASE._buildingsMain)
            {
               if(_loc5_._class != "decoration" && _loc5_._class != "immovable" && _loc5_._hp.Get() > 0 && _loc5_._class != "enemy")
               {
                  this._targetGroup = 1;
                  _loc10_ = GRID.FromISO(_loc5_._mc.x,_loc5_._mc.y + _loc5_._middle);
                  _loc11_ = GLOBAL.QuickDistance(_loc9_,_loc10_) - _loc5_._middle;
                  _loc12_.push({
                     "building":_loc5_,
                     "distance":_loc11_,
                     "expand":true
                  });
               }
            }
         }
         if(_loc12_.length == 0 && !this._targetCreep)
         {
            this.ModeRetreat();
         }
         else
         {
            _loc12_.sortOn("distance",Array.NUMERIC);
            _loc16_ = 0;
            if(this._movement == "burrow")
            {
               this._hasTarget = true;
               this._hasPath = true;
               _loc17_ = GRID.FromISO(_loc12_[_loc16_].building._mc.x,_loc12_[_loc16_].building._mc.y);
               _loc18_ = int(Math.random() * 4);
               _loc19_ = int(_loc12_[_loc16_].building._footprint[0].height);
               _loc20_ = int(_loc12_[_loc16_].building._footprint[0].width);
               if(_loc18_ == 0)
               {
                  _loc17_.x += Math.random() * _loc19_;
                  _loc17_.y += _loc20_;
               }
               else if(_loc18_ == 1)
               {
                  _loc17_.x += _loc19_;
                  _loc17_.y += _loc20_;
               }
               else if(_loc18_ == 2)
               {
                  _loc17_.x += _loc19_ - Math.random() * _loc19_ / 2;
                  _loc17_.y -= _loc20_ / 4;
               }
               else if(_loc18_ == 3)
               {
                  _loc17_.x -= _loc19_ / 4;
                  _loc17_.y += _loc20_ - Math.random() * _loc20_ / 2;
               }
               this._waypoints = [GRID.ToISO(_loc17_.x,_loc17_.y,0)];
               this._targetPosition = this._waypoints[0];
               this._targetBuilding = _loc12_[_loc16_].building;
            }
            else if(this._movement == "fly" || this._movement == "fly_low")
            {
               this._hasTarget = true;
               this._hasPath = true;
               this._targetBuilding = _loc12_[_loc16_].building;
               this._targetCenter = this._targetBuilding._position;
               if(!this._targetCreep)
               {
                  if(GLOBAL.QuickDistance(this._tmpPoint,this._targetCenter) < 50)
                  {
                     this._atTarget = true;
                     this._hasPath = true;
                     this._targetPosition = this._targetCenter;
                  }
                  else
                  {
                     this._movement = "fly";
                     _loc21_ = Math.atan2(this._tmpPoint.y - this._targetCenter.y,this._tmpPoint.x - this._targetCenter.x) * 57.2957795;
                     _loc21_ = _loc21_ + (Math.random() * 40 - 20);
                     _loc21_ = _loc21_ / (180 / Math.PI);
                     _loc22_ = 30 + Math.random() * 10;
                     _loc23_ = new Point(this._targetCenter.x + Math.cos(_loc21_) * _loc22_,this._targetCenter.y + Math.sin(_loc21_) * _loc22_);
                     this._waypoints = [_loc23_];
                     this._targetPosition = this._waypoints[0];
                  }
               }
            }
            else if(GLOBAL._catchup)
            {
               this.WaypointTo(new Point(_loc12_[0].building._mc.x,_loc12_[0].building._mc.y),_loc12_[0].building);
            }
            else
            {
               _loc16_ = 0;
               while(_loc16_ < 2)
               {
                  if(_loc12_.length > _loc16_)
                  {
                     this.WaypointTo(new Point(_loc12_[_loc16_].building._mc.x,_loc12_[_loc16_].building._mc.y),_loc12_[_loc16_].building);
                  }
                  _loc16_++;
               }
            }
         }
      }
      
      public function WaypointTo(param1:Point, param2:BFOUNDATION = null) : void
      {
         var _loc3_:Boolean = false;
         if(this._behaviour == "juice" || this._behaviour == "housing" || this._behaviour == "pen" || this._behaviour == "defend" || this._behaviour == "feed" || this._movement == "jump")
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
      
      public function SetWaypoints(param1:Array, param2:BFOUNDATION = null, param3:Boolean = false) : void
      {
         var _loc4_:Boolean = false;
         if(param3)
         {
            if(this._behaviour == "attack")
            {
               this.FindTarget(this._targetGroup);
            }
            if(this._behaviour == "housing")
            {
               this.ModeHousing();
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
      
      public function Click(param1:MouseEvent) : void
      {
         if(this._waypoints.length > 0)
         {
            PATHING.RenderPath(this._waypoints,true);
         }
         if(!this._clicked)
         {
            this._clicked = true;
         }
         else
         {
            this._clicked = false;
         }
      }
      
      public function FlyerDeath() : void
      {
         this._dead = true;
      }
      
      public function FlyerLanded() : void
      {
         this._altitude = 0;
      }
      
      public function FlyerTakeOff() : void
      {
         this._altitude = 40;
      }
      
      public function PoweredUp() : Boolean
      {
         if(!this._friendly)
         {
            if(GLOBAL._mode != "build" && GLOBAL._playerCreatureUpgrades[this._creatureID] && Boolean(GLOBAL._playerCreatureUpgrades[this._creatureID].powerup))
            {
               return true;
            }
         }
         else if(Boolean(ACADEMY._upgrades[this._creatureID]) && Boolean(ACADEMY._upgrades[this._creatureID].powerup))
         {
            return true;
         }
         return false;
      }
      
      public function CanShootCreep() : Boolean
      {
         if(this._creatureID != "IC7")
         {
            return false;
         }
         if(this._targetCreep == null)
         {
            return false;
         }
         if(this._targetCreep._targetCreep == this)
         {
            return true;
         }
         var _loc1_:Number = GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint);
         if(_loc1_ > 4 * 60 && this._targetCreep._targetCreep != this)
         {
            return false;
         }
         if(PATHING.LineOfSight(this._tmpPoint.x,this._tmpPoint.y,this._targetCreep._tmpPoint.x,this._targetCreep._tmpPoint.y))
         {
            return true;
         }
         return false;
      }
      
      private function CanShootBuilding() : Boolean
      {
         if(this._creatureID != "IC7")
         {
            return false;
         }
         if(this._targetBuilding == null)
         {
            return false;
         }
         var _loc1_:Number = GLOBAL.QuickDistance(this._targetBuilding._position,this._tmpPoint);
         if(_loc1_ > 4 * 60)
         {
            return false;
         }
         if(PATHING.LineOfSight(this._tmpPoint.x,this._tmpPoint.y,this._targetBuilding._position.x,this._targetBuilding._position.y,this._targetBuilding))
         {
            return true;
         }
         return false;
      }
      
      private function RocketRange() : int
      {
         return 0;
      }
      
      private function PowerUpLevel() : int
      {
         if(!this.PoweredUp())
         {
            return 0;
         }
         if(!this._friendly)
         {
            if(GLOBAL._playerCreatureUpgrades[this._creatureID].powerup)
            {
               return GLOBAL._playerCreatureUpgrades[this._creatureID].powerup;
            }
         }
         else if(ACADEMY._upgrades[this._creatureID].powerup)
         {
            return ACADEMY._upgrades[this._creatureID].powerup;
         }
         return 0;
      }
      
      public function WithinBlinkRange() : Boolean
      {
         return false;
      }
      
      public function WormzerBlast() : void
      {
         var tmpAttDamage:int = 0;
         var tmpPointA:Point = null;
         var tmpPointB:Point = null;
         var tmpPointC:Point = null;
         var dist:int = 0;
         var building:BFOUNDATION = null;
         var creep:* = undefined;
         var distGuard:int = 0;
         var tmpDefDamage:Number = NaN;
         var i:int = 0;
         var tmpDamage:int = 0;
         if(this._creatureID != "IC8")
         {
            return;
         }
         if(this._behaviour == "attack")
         {
            tmpAttDamage = 6;
            if(Boolean(GLOBAL._attackerMonsterOverdrive) && GLOBAL._attackerMonsterOverdrive.Get() >= GLOBAL.Timestamp())
            {
               tmpAttDamage *= 1.25;
            }
            ATTACK.Damage(this._tmpPoint.x,this._tmpPoint.y - 5,this._damage.Get() * tmpAttDamage,this._mc.visible);
            try
            {
               tmpPointA = PATHING.FromISO(this._tmpPoint).add(new Point(-5,-5));
               tmpPointB = new Point(0,0);
               tmpPointC = new Point(0,0);
               for each(building in BASE._buildingsAll)
               {
                  if(building._class != "decoration" && building._class != "enemy" && building._class != "trap")
                  {
                     tmpPointC.x = building.x;
                     tmpPointC.y = building.y;
                     tmpPointB = PATHING.FromISO(tmpPointC);
                     tmpPointC.x = building._middle;
                     tmpPointC.y = building._middle;
                     tmpPointB.add(tmpPointC);
                     dist = GLOBAL.QuickDistance(tmpPointA,tmpPointB);
                     if(dist < 100)
                     {
                        building.Damage(int(this._damage.Get() * tmpAttDamage * ((100 - dist) / 100)),this._tmpPoint.x,this._tmpPoint.y,this._targetGroup,false);
                        building.Update(true);
                     }
                  }
               }
               if(this._targetCreep && GLOBAL.QuickDistance(this._tmpPoint,this._targetCreep._tmpPoint) < 90)
               {
                  this._targetCreep._health.Add(-(this._damage.Get() * tmpAttDamage * this._targetCreep._damageMult));
               }
               for each(creep in CREATURES._creatures)
               {
                  if((creep._behaviour == "defend" || creep._behaviour == "bunker") && creep != this._targetCreep)
                  {
                     dist = GLOBAL.QuickDistance(creep._tmpPoint,this._tmpPoint);
                     if(dist < 60)
                     {
                        creep._health.Add(-int(this._damage.Get() * tmpAttDamage * this._targetCreep._damageMult * ((60 - dist) / 60)));
                     }
                  }
               }
               if(CREATURES._guardian._behaviour == "defend" && CREATURES._guardian != this._targetCreep)
               {
                  distGuard = GLOBAL.QuickDistance(creep._tmpPoint,this._tmpPoint);
                  if(distGuard < 60)
                  {
                     creep._health.Add(-int(this._damage.Get() * tmpAttDamage * this._targetCreep._damageMult * ((60 - distGuard) / 60)));
                  }
               }
               this._targetBuilding.Update(true);
            }
            catch(e:Error)
            {
            }
         }
         else
         {
            tmpDefDamage = 1;
            if(Boolean(GLOBAL._monsterOverdrive) && GLOBAL._monsterOverdrive.Get() >= GLOBAL.Timestamp())
            {
               tmpDefDamage *= 1.25;
            }
            ATTACK.Damage(this._tmpPoint.x,this._tmpPoint.y - 5,this._damage.Get() * tmpDefDamage,this._mc.visible);
            try
            {
               this._targetCreeps = MAP.CreepCellFind(this._tmpPoint,60,-1);
               i = 0;
               while(i < this._targetCreeps.length)
               {
                  creep = this._targetCreeps[i].creep;
                  if(i == 0)
                  {
                     tmpDamage = tmpDefDamage;
                  }
                  else
                  {
                     tmpDamage = int(tmpDefDamage * ((60 - this._targetCreeps[i].dist) / 60));
                  }
                  creep._health.Add(-(this._damage.Get() * tmpDamage * creep._damageMult));
                  i++;
               }
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public function TickBDeathRun() : Boolean
      {
         if(this._health.Get() <= 0)
         {
            MAP.CreepCellDelete(this._id,this.node);
            if(this._movement == "fly")
            {
               if(!this._dying)
               {
                  this._dying = true;
                  TweenLite.to(this._graphicMC,0.4,{
                     "y":this._graphicMC.y + this._altitude,
                     "ease":Sine.easeOut,
                     "onComplete":this.FlyerDeath
                  });
               }
               if(!this._dead)
               {
                  return false;
               }
            }
            ++QUESTS._global.kills;
            return true;
         }
         if(this._atTarget)
         {
            if(this._behaviour == "juice")
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
               GLOBAL._bJuicer.Blend(Math.ceil(this._goo / 400),this._creatureID);
            }
            if(this._behaviour == "feed")
            {
               GIBLETS.Create(this._tmpPoint,0.8,100,this._goo / 400,36);
            }
            return true;
         }
         return false;
      }
      
      public function TickBHeal() : Boolean
      {
         var _loc1_:Number = 1;
         if(Boolean(GLOBAL._attackerMonsterOverdrive) && GLOBAL._attackerMonsterOverdrive.Get() >= GLOBAL.Timestamp())
         {
            _loc1_ *= 1.25;
         }
         if(this._health.Get() <= 0)
         {
            MAP.CreepCellDelete(this._id,this.node);
            if(this._movement == "fly")
            {
               if(!this._dying)
               {
                  this._dying = true;
                  TweenLite.to(this._graphicMC,0.4,{
                     "y":this._graphicMC.y + this._altitude,
                     "ease":Sine.easeOut,
                     "onComplete":this.FlyerDeath
                  });
               }
               if(!this._dead)
               {
                  return false;
               }
            }
            ++QUESTS._global.kills;
            if(this._creatureID == "C12")
            {
               SOUNDS.Play("monsterlanddave");
            }
            else
            {
               SOUNDS.Play("monsterland" + (1 + int(Math.random() * 3)));
            }
            return true;
         }
         if(this._hasTarget)
         {
            if(!this._targetCreep || this._targetCreep._health.Get() <= 0 || this._targetCreep._health.Get() == this._targetCreep._maxHealth && this._frameNumber % 100 == 0)
            {
               this._hasTarget = false;
               this._attacking = false;
               this._atTarget = false;
               this._hasPath = false;
               if(this._targetCreep && this._targetCreep._health.Get() <= 0)
               {
                  this._targetCreep = null;
               }
               this.FindHealingTargets();
            }
            else if(!this._attacking && this._frameNumber % 120 == 0)
            {
               this.FindHealingTargets();
            }
            else if(GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < this.HEALING_RANGE)
            {
               this._atTarget = true;
            }
            else if(this._attacking && GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) > this.HEALING_RANGE * 1.25)
            {
               this._attacking = false;
               this._atTarget = false;
               this._waypoints = [this._targetCreep._tmpPoint];
            }
         }
         else
         {
            this._attacking = false;
            this._atTarget = false;
            this._hasPath = false;
            this.FindHealingTargets();
         }
         if(this._atTarget)
         {
            if(this.attackCooldown <= 0)
            {
               this.attackCooldown += int(this._attackDelay / this._speedMult);
               if(this._targetCreep._health.Get() > 0 && this._targetCreep._health.Get() < this._targetCreep._maxHealth)
               {
                  this._attacking = true;
                  FIREBALLS.Spawn2(new Point(this._tmpPoint.x,this._tmpPoint.y - this._altitude),this._targetCreep._tmpPoint,this._targetCreep,25,this._damage.Get() * _loc1_,50);
                  SOUNDS.Play("ihit" + int(1 + Math.random() * 7),0.1 + Math.random() * 0.1);
               }
               else
               {
                  this._attacking = false;
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
         return false;
      }
      
      public function TickBAttack() : Boolean
      {
         var _loc1_:Number = 1;
         if(Boolean(GLOBAL._attackerMonsterOverdrive) && GLOBAL._attackerMonsterOverdrive.Get() >= GLOBAL.Timestamp())
         {
            _loc1_ *= 1.25;
         }
         if(this._health.Get() <= 0)
         {
            MAP.CreepCellDelete(this._id,this.node);
            if(this._movement == "fly" || this._movement == "fly_low")
            {
               if(!this._dying)
               {
                  this._dying = true;
                  TweenLite.to(this._graphicMC,0.4,{
                     "y":this._graphicMC.y + this._altitude,
                     "ease":Sine.easeOut,
                     "onComplete":this.FlyerDeath
                  });
               }
               if(!this._dead)
               {
                  return false;
               }
            }
            ++QUESTS._global.kills;
            SOUNDS.Play("monsterland" + (1 + int(Math.random() * 3)));
            return true;
         }
         if(this._hasTarget)
         {
            if(!this._targetCreep)
            {
               if(this._behaviour == "hunt" && (CREATURES._creatureCount > 0 || CREATURES._guardian && CREATURES._guardian._health.Get() > 0) && this._frameNumber % 150 == 0)
               {
                  this.FindTarget(this._targetGroup);
               }
               else if(this._targetBuilding == null || this._targetBuilding._hp.Get() <= 0 || this._targetGroup == 3 && this._targetBuilding._looted)
               {
                  this._hasTarget = false;
                  this._attacking = false;
                  this._atTarget = false;
                  this._invisibleCooldown = 80;
                  this.FindTarget(this._targetGroup);
               }
            }
            else
            {
               if(this._targetCreep._health.Get() <= 0)
               {
                  this._hasTarget = false;
                  this._attacking = false;
                  this._atTarget = false;
                  this._targetCreep = null;
                  this._invisibleCooldown = 80;
                  this.FindTarget(this._targetGroup);
               }
               if(this._targetCreep && GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < 50)
               {
                  this._atTarget = true;
               }
               else if(this._targetCreep)
               {
                  this._waypoints = [this._targetCreep._tmpPoint];
               }
            }
         }
         if(!this._looking && this._frameNumber % (GLOBAL._catchup ? 5 * 60 : 150) == 0 && !this._attacking)
         {
            this.FindTarget(this._targetGroup,true);
         }
         if(this._atTarget)
         {
            this._attacking = true;
            if(this._movement == "fly")
            {
               this._movement = "fly_low";
            }
            if(this.attackCooldown <= 0)
            {
               this.attackCooldown += int(this._attackDelay / this._speedMult);
               if(this._targetCreep)
               {
                  if(this._behaviour == "hunt")
                  {
                     _loc1_ *= 3;
                  }
                  if(this._creatureID != "IC7")
                  {
                     ATTACK.Damage(this._tmpPoint.x,this._tmpPoint.y - 5 - (this._movement == "fly" || this._movement == "fly_low" ? this._altitude : 0),this._damage.Get() * _loc1_ * this._targetCreep._damageMult,this._mc.visible);
                  }
               }
               else
               {
                  if(this._targetGroup == 2 && this._targetBuilding._class == "wall")
                  {
                     _loc1_ *= 2;
                  }
                  if(this._targetGroup == 4 && this._targetBuilding._class == "tower")
                  {
                     _loc1_ *= 2;
                  }
                  if(this._creatureID != "IC7")
                  {
                     if(this._targetBuilding._fortification.Get() > 0)
                     {
                        ATTACK.Damage(this._tmpPoint.x,this._tmpPoint.y - 5 - (this._movement == "fly" || this._movement == "fly_low" ? this._altitude : 0),this._damage.Get() * _loc1_ * (100 - (this._targetBuilding._fortification.Get() * 10 + 10)) / 100,this._mc.visible);
                     }
                     else
                     {
                        ATTACK.Damage(this._tmpPoint.x,this._tmpPoint.y - 5 - (this._movement == "fly" || this._movement == "fly_low" ? this._altitude : 0),this._damage.Get() * _loc1_,this._mc.visible);
                     }
                  }
               }
               if(this._targetCreep)
               {
                  if(this._creatureID == "IC7")
                  {
                     FIREBALLS.Spawn2(this._tmpPoint,this._targetCreep._tmpPoint,this._targetCreep,10,this._damage.Get() * _loc1_);
                  }
                  else
                  {
                     this._targetCreep._health.Add(-(this._damage.Get() * this._targetCreep._damageMult));
                     if(!this._targetCreep._targetCreep || !this._targetCreep._atTarget)
                     {
                        this._targetCreep._targetCreep = this;
                        this._targetCreep._hasTarget = true;
                        this._targetCreep._atTarget = true;
                        if(this._targetCreep._behaviour != "defend")
                        {
                           this._targetCreep._behaviour = "defend";
                        }
                     }
                  }
                  if(this._behaviour == "hunt")
                  {
                     this._targetCreep._venom.Add(this._damage.Get() * 0.1 * 0.025 * _loc1_);
                  }
               }
               else if(this._creatureID == "IC7")
               {
                  FIREBALLS.Spawn(this._tmpPoint,this._targetBuilding._position,this._targetBuilding,10,this._damage.Get() * _loc1_);
               }
               else
               {
                  this._targetBuilding.Damage(this._damage.Get() * _loc1_,this._tmpPoint.x,this._tmpPoint.y,this._targetGroup);
               }
               if(!this._targetCreep)
               {
                  ++this._hits;
               }
               SOUNDS.Play("ihit" + int(1 + Math.random() * 7),0.1 + Math.random() * 0.1);
            }
            else
            {
               --this.attackCooldown;
            }
         }
         else
         {
            this._attacking = false;
            if(this._movement == "fly_low")
            {
               this._movement = "fly";
            }
         }
         return false;
      }
      
      public function TickBDefend() : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:Number = 1;
         if(Boolean(GLOBAL._monsterOverdrive) && GLOBAL._monsterOverdrive.Get() >= GLOBAL.Timestamp())
         {
            _loc1_ *= 1.25;
         }
         if(this._creatureID == "IC5")
         {
            _loc1_ *= 3;
         }
         if(this._health.Get() <= 0)
         {
            SOUNDS.Play("monsterland" + (1 + int(Math.random() * 3)));
            if(this._homeBunker)
            {
               if(Boolean(this._homeBunker._monsters) && !this._defenderRemoved)
               {
                  this._homeBunker.RemoveCreature(this._creatureID);
                  this._defenderRemoved = true;
                  this._behaviour = "pen";
                  return false;
               }
            }
            return true;
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
            else if(GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < this.DEFENSE_RANGE || this.CanShootCreep())
            {
               this._waypoints = [];
               this._atTarget = true;
            }
            else if(!this._attacking && this._frameNumber % 150 == 0)
            {
               this.FindDefenseTargets();
            }
            else if(this._attacking && GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) > this.DEFENSE_RANGE * 2 && !this.CanShootCreep())
            {
               this._attacking = false;
               this._atTarget = false;
               this._hasPath = false;
               this.FindDefenseTargets();
            }
         }
         if(this._atTarget)
         {
            this._targetPosition = this._targetCreep._tmpPoint;
            this._attacking = true;
            this._intercepting = false;
            if(this._targetCreep._behaviour != "heal" && this._invisibleTime == 0 && !this._targetCreep._explode && !this._explode)
            {
               this._waypoints = [];
               this._targetCreep._targetCreep = this;
               if(this._targetCreep.CanShootCreep() || GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < 50 || this._targetCreep._movement == "fly")
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
               this._targetCreep._hasPath = true;
            }
            if(this.attackCooldown <= 0)
            {
               this.attackCooldown += int(this._attackDelay / this._speedMult);
               if(this._creatureID == "IC7")
               {
                  FIREBALLS.Spawn2(this._tmpPoint,this._targetCreep._tmpPoint,this._targetCreep,10,this._damage.Get() * _loc1_);
               }
               else
               {
                  ATTACK.Damage(this._tmpPoint.x,this._tmpPoint.y - 5 - (this._movement == "fly" ? this._altitude : 0),this._damage.Get() * _loc1_ * this._targetCreep._damageMult,this._mc.visible);
                  this._targetCreep._health.Add(-(this._damage.Get() * _loc1_ * this._targetCreep._damageMult));
               }
               if(!this._explode)
               {
                  if(!this._targetCreep._explode && !this._targetCreep._targetCreep && this._targetCreep._behaviour != "heal")
                  {
                     this._waypoints = [];
                     this._targetCreep._targetCreep = this;
                     if(Boolean(this._targetCreep.CanShootCreep()) || GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < 50)
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
                     this._targetCreep._hasPath = true;
                     this._targetCreep._hasTarget = true;
                  }
                  if(this._invisibleTime == 0)
                  {
                     _loc2_ = MAP.CreepCellFind(this._tmpPoint,50);
                     _loc3_ = int(_loc2_.length);
                     _loc4_ = 0;
                     while(_loc4_ < 5 && _loc4_ < _loc3_)
                     {
                        if(!_loc2_[_loc4_].creep._explode)
                        {
                           _loc2_[_loc4_].creep._targetCreep = this;
                           _loc2_[_loc4_].creep._atTarget = true;
                           _loc2_[_loc4_].creep._hasTarget = true;
                        }
                        _loc4_++;
                     }
                  }
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
         return false;
      }
      
      public function TickBBunker() : Boolean
      {
         if(this._health.Get() <= 0)
         {
            if(this._homeBunker)
            {
               if(Boolean(this._homeBunker._monsters) && !this._defenderRemoved)
               {
                  --this._homeBunker._monsters[this._creatureID];
                  --this._homeBunker._monsters[this._creatureID];
                  if(this._homeBunker._monsters[this._creatureID] < 0)
                  {
                     this._homeBunker._monsters[this._creatureID] = 0;
                  }
                  --this._homeBunker._monstersDispatched[this._creatureID];
                  if(this._homeBunker._monstersDispatched[this._creatureID] < 0)
                  {
                     this._homeBunker._monstersDispatched[this._creatureID] = 0;
                  }
                  --this._homeBunker._monstersDispatchedTotal;
                  if(this._homeBunker._monstersDispatchedTotal < 0)
                  {
                     this._homeBunker._monstersDispatchedTotal = 0;
                  }
                  this._defenderRemoved = true;
               }
            }
            return true;
         }
         if(this._frameNumber % 200)
         {
            this.FindDefenseTargets();
         }
         if(this._atTarget && this._behaviour == "bunker")
         {
            if(this._homeBunker)
            {
               try
               {
                  --this._homeBunker._monstersDispatched[this._creatureID];
                  if(this._homeBunker._monstersDispatched[this._creatureID] < 0)
                  {
                     this._homeBunker._monstersDispatched[this._creatureID] = 0;
                  }
                  --this._homeBunker._monstersDispatchedTotal;
                  if(this._homeBunker._monstersDispatchedTotal < 0)
                  {
                     this._homeBunker._monstersDispatchedTotal = 0;
                  }
               }
               catch(error:Error)
               {
               }
            }
         }
         return false;
      }
      
      public function Tick() : Boolean
      {
         var _loc2_:Number = NaN;
         this._frameNumber += 1;
         if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
         {
            if(this._health.Get() > this._maxHealth)
            {
               LOGGER.Log("hak","Regular monster health exceeds maximum");
               GLOBAL.ErrorMessage("CREEP_INFERNO hack 1");
               return false;
            }
            if(this._frameNumber % 30 == 0)
            {
               if(this._secureSpeedMult.Get() != int(this._speedMult * 100))
               {
                  LOGGER.Log("hak","Regular monster speed buff incorrect");
                  GLOBAL.ErrorMessage("CREEP_INFERNO hack 4");
                  return false;
               }
               if(this._secureDamageMult.Get() != int(this._damageMult * 100))
               {
                  LOGGER.Log("hak","Regular monster damage buff incorrect");
                  GLOBAL.ErrorMessage("CREEP_INFERNO hack 5");
                  return false;
               }
            }
         }
         if(this._movement == "fly" && this._health.Get() > 0 && this._behaviour != "pen")
         {
            if(this._behaviour != "juice" && this._behaviour != "feed" || this._altitude >= 35)
            {
               _loc2_ = Math.sin(this._frameNumber / 50) * 5;
               this._altitude = 40 - _loc2_;
               this._graphicMC.y = -this._altitude - 36 + _loc2_;
            }
         }
         if(this._homeBunker && (this._behaviour != "defend" && this._behaviour != "bunker" && this._behaviour != "juice" && this._behaviour != "pen"))
         {
            this._behaviour = "defend";
         }
         if((GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack") && this._damage.Get() > int(CREATURES.GetProperty(this._creatureID,"damage")))
         {
            LOGGER.Log("log","Creep damage altered");
            GLOBAL.ErrorMessage("Creep damage altered");
            return false;
         }
         if(this._venom.Get() > 0)
         {
            this._health.Add(-(this._venom.Get() * this._damageMult));
         }
         switch(this._behaviour)
         {
            case "retreat":
            case "juice":
            case "feed":
               if(this.TickBDeathRun())
               {
                  return true;
               }
               break;
            case "heal":
               if(this.TickBHeal())
               {
                  return true;
               }
               break;
            case "attack":
            case "hunt":
               if(this.TickBAttack())
               {
                  return true;
               }
               break;
            case "wander":
               if(this._frameNumber > 8 * 60 && !this._targetCenter)
               {
                  this._targetPosition = new Point(Math.random() * 200,Math.random() * 150);
               }
               break;
            case "defend":
               if(this.TickBDefend())
               {
                  return true;
               }
               break;
            case "housing":
               if(this._health.Get() <= 0)
               {
                  return true;
               }
               if(this._atTarget)
               {
                  this._behaviour = "pen";
                  if(this._movement == "fly")
                  {
                     TweenLite.to(this._graphicMC,1.2,{
                        "y":this._graphicMC.y + this._altitude,
                        "ease":Sine.easeOut,
                        "onComplete":this.FlyerLanded
                     });
                  }
                  this._waypoints[0] = HOUSING.PointInHouse(this._targetCenter);
               }
               break;
            case "bunker":
               if(this.TickBBunker())
               {
                  return true;
               }
               break;
            case "pen":
               if(this._health.Get() <= 0)
               {
                  return true;
               }
               if(this._frameNumber > 4 * 60 && int(Math.random() * 200) == 1 && GLOBAL._fps > 25)
               {
                  this._targetPosition = HOUSING.PointInHouse(this._targetCenter);
                  this._hasPath = true;
               }
               break;
         }
         if((this._behaviour == "attack" || this._behaviour == "retreat" || this._behaviour == "heal" || this._behaviour == "hunt") && this._frameNumber % 5 == 0)
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
         if(this._enraged == 0 && filters.length > 0)
         {
            this.UpdateBuffs();
         }
         this.Move();
         this.Render();
         return false;
      }
      
      public function Move() : void
      {
         var targetDistance:Number = NaN;
         var building:BFOUNDATION = null;
         this._speed = this._maxSpeed * 0.5 * this._speedMult;
         if(this._behaviour == "pen")
         {
            this._speed *= 0.5;
         }
         if(this._behaviour == "juice" || this._behaviour == "housing" || this._behaviour == "bunker")
         {
            this._speed *= 1.5;
         }
         if(this._behaviour == "defend")
         {
            this._speed *= 1.5;
         }
         if(this._behaviour == "juice" && this._movement == "fly" && this._altitude < 25)
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
         if(this._creatureID == "IC7" && this._behaviour != "juice" && this._behaviour != "housing" && this._behaviour != "bunker" && this._behaviour != "pen" && !this._atTarget && (this._targetCreep && this.CanShootCreep() || this.CanShootBuilding()))
         {
            this._atTarget = true;
            if(this._targetCreep)
            {
               this._xd = this._targetCreep._tmpPoint.x - this._tmpPoint.x;
               this._yd = this._targetCreep._tmpPoint.y - this._tmpPoint.y;
               this._targetPosition = this._targetCreep._tmpPoint;
            }
            else
            {
               this._xd = this._targetBuilding._position.x - this._tmpPoint.x;
               this._yd = this._targetBuilding._position.y - this._tmpPoint.y;
               this._targetPosition = this._targetBuilding._position;
            }
         }
         else if(this._waypoints.length > 0)
         {
            if(GLOBAL.QuickDistance(this._targetPosition,this._tmpPoint) <= 10)
            {
               while(this._waypoints.length > 0 && GLOBAL.QuickDistance(this._targetPosition,this._tmpPoint) <= 10)
               {
                  this._waypoints.splice(0,1);
                  if(this._waypoints[0])
                  {
                     this._targetPosition = this._waypoints[0];
                     if(this._movement == "jump" && !this._jumping)
                     {
                        building = PATHING.GetBuildingFromISO(this._targetPosition);
                        if(building)
                        {
                           if(building._hp.Get() > 0)
                           {
                              TweenLite.to(this._graphicMC,0.4,{
                                 "y":this._graphicMC.y - 60,
                                 "ease":Sine.easeOut,
                                 "overwrite":false,
                                 "onComplete":function():*
                                 {
                                    _jumpingUp = false;
                                 }
                              });
                              TweenLite.to(this._graphicMC,0.4,{
                                 "y":this._graphicMC.y,
                                 "ease":Bounce.easeOut,
                                 "overwrite":false,
                                 "delay":0.4,
                                 "onComplete":function():*
                                 {
                                    _jumping = false;
                                 }
                              });
                              this._jumping = true;
                              this._jumpingUp = true;
                           }
                        }
                     }
                  }
                  else if(this._behaviour == "defend")
                  {
                     if(this._targetCreep)
                     {
                        targetDistance = GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint);
                        if(targetDistance < this.DEFENSE_RANGE || this.CanShootCreep())
                        {
                           this._waypoints = [];
                           this._atTarget = true;
                           this._targetCreep._targetCreep = this;
                           if(Boolean(this._targetCreep.CanShootCreep()) || GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < 50)
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
                           return;
                        }
                     }
                  }
                  else
                  {
                     if(this._behaviour != "heal")
                     {
                        this._atTarget = true;
                        return;
                     }
                     if(this._targetCreep && GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < this.HEALING_RANGE)
                     {
                        this._atTarget = true;
                        return;
                     }
                  }
               }
               if(this._behaviour == "defend")
               {
                  if(this._targetCreep && (GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < this.DEFENSE_RANGE || this.CanShootCreep()))
                  {
                     this._atTarget = true;
                     this._waypoints = [];
                     if(!this._targetCreep._explode)
                     {
                        this._targetCreep._targetCreep = this;
                        if(Boolean(this._targetCreep.CanShootCreep()) || GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < 50)
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
                     this._targetPosition = this._targetCreep._tmpPoint;
                     return;
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
               else if(this._behaviour == "heal")
               {
                  if(this._targetCreep && GLOBAL.QuickDistance(this._targetCreep._tmpPoint,this._tmpPoint) < this.HEALING_RANGE)
                  {
                     this._atTarget = true;
                     return;
                  }
                  if(this._targetCreep && this._waypoints.length == 0 && this._hasPath)
                  {
                     this._waypoints = [this._targetCreep._tmpPoint];
                     this.WaypointTo(this._targetCreep._tmpPoint,null);
                  }
               }
               else if(this._waypoints.length == 0 && this._hasPath && this._targetCreep)
               {
                  this._atTarget = true;
                  return;
               }
            }
            if(this._waypoints.length > 0 && !this._atTarget)
            {
               this._targetPosition = this._waypoints[0];
            }
            if(this._behaviour == "attack" && this._targetCreep)
            {
               this._xd = this._targetCreep._tmpPoint.x - this._tmpPoint.x;
               this._yd = this._targetCreep._tmpPoint.y - this._tmpPoint.y;
            }
            else if(this._behaviour == "defend" || this._behaviour == "heal")
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
      
      public function Render() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
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
            if(this._movement == "burrow" && (this._behaviour == "attack" || this._behaviour == "defend"))
            {
               if(this._speed > 0 && (this._behaviour == "attack" || this._doDefenseBurrow))
               {
                  if(this._phase != 1)
                  {
                     this._phase = 1;
                     if(alpha)
                     {
                        alpha = 0;
                     }
                     this._visible = false;
                     EFFECTS.Dig(x,y);
                     SOUNDS.Play("dig",0.5);
                  }
                  else if(this._frameNumber % 5 == 0)
                  {
                     EFFECTS.Burrow(x,y);
                  }
               }
               else if(this._phase == 1)
               {
                  this._phase = 0;
                  this.Jump();
                  if(!alpha)
                  {
                     alpha = 1;
                  }
                  this._visible = true;
                  if(this._behaviour == "attack" || this._doDefenseBurrow)
                  {
                     EFFECTS.Dig(x,y);
                     if(this._creatureID == "IC8")
                     {
                        this.WormzerBlast();
                     }
                  }
                  SOUNDS.Play("arise",0.5);
               }
            }
            else
            {
               this._visible = true;
               if(!alpha)
               {
                  alpha = 1;
               }
            }
            if(this._movement == "fly" || this._movement == "fly_low")
            {
               SPRITES.GetSprite(this._shadow,"shadow","shadow",0);
            }
            this._lastFrame = SPRITES.GetSprite(this._graphic,this._creatureID,"walking",mcMarker.rotation,this._frameNumber,this._lastFrame);
            this._lastRotation = int(mcMarker.rotation / 12);
            if(this._health.Get() < this._maxHealth)
            {
               _loc5_ = 11 - int(11 / this._maxHealth * this._health.Get());
               this._graphic.copyPixels(CREEPS._bmdHPbar,new Rectangle(0,5 * _loc5_,17,5),new Point(17,6));
            }
            this._graphic.unlock();
            if(this._shadow)
            {
               this._shadow.unlock();
            }
         }
      }
      
      public function Jump() : *
      {
         var Land:Function = null;
         Land = function():*
         {
            TweenLite.to(_graphicMC,0.6,{
               "y":_graphicMC.y + 15,
               "ease":Bounce.easeOut
            });
         };
         TweenLite.to(this._graphicMC,0.3,{
            "y":this._graphicMC.y - 15,
            "ease":Sine.easeIn,
            "onComplete":Land
         });
      }
   }
}

