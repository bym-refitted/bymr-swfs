package
{
   import com.cc.utils.SecNum;
   import com.monsters.components.Component;
   import com.monsters.components.statusEffects.CStatusEffect;
   import com.monsters.interfaces.ILootable;
   import com.monsters.pathing.PATHING;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class CreepBase extends CREEP_CLIP
   {
      public static const k_sBHVR_ATTACK:String = "attack";
      
      public static const k_sBHVR_RETREAT:String = "retreat";
      
      public static const k_sBHVR_JUICE:String = "juice";
      
      public static const k_sBHVR_HOUSING:String = "housing";
      
      public static const k_sBHVR_PEN:String = "pen";
      
      public static const k_sBHVR_DEFEND:String = "defend";
      
      public static const k_sBHVR_FEED:String = "feed";
      
      public static const k_sBHVR_JUMP:String = "jump";
      
      public static const k_sBHVR_DECOY:String = "decoy";
      
      public static const k_sBHVR_BUNKER:String = "bunker";
      
      public static const k_sBHVR_HEAL:String = "heal";
      
      public static const k_sBHVR_LOOT:String = "loot";
      
      public static const k_sBHVR_WANDER:String = "wander";
      
      public static const k_sBHVR_BOUNCE:String = "bounce";
      
      public static const k_sBHVR_HUNT:String = "hunt";
      
      public static const k_sBHVR_BUFF:String = "buff";
      
      public var _components:Vector.<Component> = new Vector.<Component>();
      
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
      
      public var _speed:Number;
      
      public var _maxSpeed:Number;
      
      public var _health:SecNum;
      
      public var _maxHealth:Number;
      
      public var _damage:SecNum;
      
      public var _size:int;
      
      public var _goo:int;
      
      public var _venom:SecNum = new SecNum(0);
      
      public var _damagePerSecond:SecNum = new SecNum(0);
      
      public var _targetRotation:Number;
      
      public var _targetPosition:Point;
      
      public var _targetCenter:Point;
      
      public var _waypoints:Array;
      
      protected var _pathID:int = 0;
      
      protected var _jumping:Boolean = false;
      
      protected var _jumpingUp:Boolean = false;
      
      protected const _noDefensePath:Boolean = false;
      
      protected var _doDefenseBurrow:Boolean = true;
      
      public var _behaviour:String;
      
      public var _hasTarget:Boolean;
      
      public var _hasPath:Boolean;
      
      public var _attacking:Boolean;
      
      public var _intercepting:Boolean;
      
      public var _targetBuilding:BFOUNDATION;
      
      public var _homeBunker:*;
      
      public var _targetCreeps:Array;
      
      public var _targetCreep:*;
      
      public var _id:String;
      
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
      
      public var _tmpPoint:Point = new Point(0,0);
      
      public var _spawnTime:int;
      
      public var _atTarget:Boolean = false;
      
      public var _xd:Number = 0;
      
      public var _yd:Number = 0;
      
      public var _mc:Object;
      
      public var _shadow:BitmapData;
      
      public var _shadowMC:DisplayObject;
      
      protected var attackCooldown:int;
      
      protected var frameCount:int;
      
      protected var shocking:Boolean;
      
      protected var node:*;
      
      protected var newNode:Object;
      
      public var _phase:Number = 0;
      
      public var _movement:String = "";
      
      public var _pathing:String = "";
      
      public var _enraged:Number = 0;
      
      public var _damageMult:Number = 1;
      
      public var _speedMult:Number = 1;
      
      public var _lootMult:Number = 1;
      
      public var _lootMultTime:int = 0;
      
      protected var _secureDamageMult:SecNum = new SecNum(100);
      
      protected var _secureSpeedMult:SecNum = new SecNum(100);
      
      protected var _secureLootMult:SecNum = new SecNum(100);
      
      public var _graphicMC:DisplayObject;
      
      public var _altitude:int = 0;
      
      protected var _currentSkinOverride:String = null;
      
      public function CreepBase()
      {
         super();
      }
      
      public function set currentSkinOverride(param1:String) : void
      {
         this._currentSkinOverride = param1;
      }
      
      public function addStatusEffect(param1:CStatusEffect) : void
      {
         var _loc2_:CStatusEffect = this.getComponentByType(Object(param1).constructor) as CStatusEffect;
         if(_loc2_)
         {
            _loc2_.renew();
         }
         else
         {
            this.addComponent(param1);
         }
      }
      
      public function removeStatusEffect(param1:Class) : Boolean
      {
         var _loc2_:CStatusEffect = this.getComponentByType(param1) as CStatusEffect;
         if(_loc2_)
         {
            this.removeComponent(_loc2_);
            return true;
         }
         return false;
      }
      
      public function addComponent(param1:Component, param2:uint = 0) : void
      {
         var _loc3_:int = -1;
         var _loc4_:int = 0;
         while(_loc4_ < this._components.length)
         {
            if(this._components[_loc4_].priority < param2)
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         if(_loc3_ < 0 || _loc3_ >= this._components.length)
         {
            this._components.push(param1);
         }
         else
         {
            this._components.splice(_loc3_,0,param1);
         }
         param1.register(this,name);
      }
      
      public function removeComponent(param1:Component) : void
      {
         param1.unregister();
         this._components.splice(this._components.indexOf(param1),1);
      }
      
      public function getComponent(param1:Component) : Component
      {
         var _loc2_:int = int(this._components.indexOf(param1));
         if(_loc2_ >= 0)
         {
            return this._components[_loc2_];
         }
         return null;
      }
      
      public function getComponentByType(param1:Class) : Component
      {
         var _loc3_:Component = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._components.length)
         {
            _loc3_ = this._components[_loc2_];
            if(_loc3_ is param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getComponentByName(param1:String) : Component
      {
         var _loc3_:Component = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._components.length)
         {
            _loc3_ = this._components[_loc2_];
            if(_loc3_.name == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function Tick(param1:int = 1) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = int(this._components.length);
         while(_loc3_ < _loc2_)
         {
            this._components[_loc3_].tick(param1);
            _loc3_++;
         }
         if(this._enraged != 0 && this._enraged <= GLOBAL.Timestamp())
         {
            this.ModeEnrage(0,1,1);
         }
         if(this._lootMultTime !== 0 && this._lootMultTime < GLOBAL.Timestamp())
         {
            this.ModeLootBuff(0,1);
         }
         if(this._enraged == 0 && filters.length > 0)
         {
            if(this._friendly)
            {
               if(GLOBAL._mode == "build")
               {
                  if(GLOBAL._playerMonsterOverdrive && GLOBAL._playerMonsterOverdrive.Get() < GLOBAL.Timestamp() || GLOBAL._playerMonsterDefenseOverdrive && GLOBAL._playerMonsterDefenseOverdrive.Get() < GLOBAL.Timestamp() || GLOBAL._playerMonsterSpeedOverdrive && GLOBAL._playerMonsterSpeedOverdrive.Get() < GLOBAL.Timestamp())
                  {
                     this.UpdateBuffs();
                  }
               }
               if(GLOBAL._mode != "build")
               {
                  if(GLOBAL._monsterOverdrive && GLOBAL._monsterOverdrive.Get() < GLOBAL.Timestamp() || GLOBAL._monsterDefenseOverdrive && GLOBAL._monsterDefenseOverdrive.Get() < GLOBAL.Timestamp() || GLOBAL._monsterSpeedOverdrive && GLOBAL._monsterSpeedOverdrive.Get() < GLOBAL.Timestamp())
                  {
                     this.UpdateBuffs();
                  }
               }
            }
            else if(GLOBAL._attackerMonsterOverdrive && GLOBAL._attackerMonsterOverdrive.Get() < GLOBAL.Timestamp() || GLOBAL._attackerMonsterDefenseOverdrive && GLOBAL._attackerMonsterDefenseOverdrive.Get() < GLOBAL.Timestamp() || GLOBAL._attackerMonsterSpeedOverdrive && GLOBAL._attackerMonsterSpeedOverdrive.Get() < GLOBAL.Timestamp())
            {
               this.UpdateBuffs();
            }
         }
         return true;
      }
      
      public function ModeEnrage(param1:Number, param2:Number, param3:Number) : void
      {
         this._enraged = param1;
         this._speedMult = param2;
         this._damageMult = param3;
         this.UpdateBuffs();
      }
      
      public function ModeLootBuff(param1:int, param2:Number) : void
      {
         this._lootMultTime = param1;
         this._lootMult = param2;
         this.UpdateBuffs();
      }
      
      public function ModeAttack() : void
      {
         if(this._behaviour === k_sBHVR_RETREAT)
         {
            return;
         }
         this._behaviour = k_sBHVR_ATTACK;
         this._hasTarget = false;
         this._atTarget = false;
         this._hasPath = false;
         if(this._creatureID == "C9" && this.PoweredUp())
         {
            this._invisibleTime = GLOBAL.Timestamp() + 5 * this.PowerUpLevel();
         }
         this.node = MAP.CreepCellAdd(this._tmpPoint,this._id,this);
         this.FindTarget(this._targetGroup,true);
      }
      
      public function ModeRetreat() : void
      {
         this._behaviour = k_sBHVR_RETREAT;
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
      
      public function ModeHousing() : void
      {
         this._behaviour = k_sBHVR_HOUSING;
         this._hasTarget = false;
         this._atTarget = false;
         this._hasPath = false;
         var _loc1_:Point = GRID.ToISO(this._targetCenter.x + 100,this._targetCenter.y + 60,0);
         PATHING.GetPath(this._tmpPoint,new Rectangle(_loc1_.x,_loc1_.y,10,10),this.SetWaypoints,true);
      }
      
      public function UpdateBuffs() : void
      {
         var _loc1_:* = 0;
         if(this._enraged > 0)
         {
            this._glow = this._glow || new GlowFilter();
            this._glow.color = 16724735;
            this._glow.blurX = 3;
            this._glow.blurY = 3;
            this._glow.strength = 5;
            filters = [this._glow];
         }
         else if(this._lootMultTime > 0)
         {
            this._glow = this._glow || new GlowFilter();
            this._glow.color = 5635873;
            this._glow.blurX = 3;
            this._glow.blurY = 3;
            this._glow.strength = 5;
            filters = [this._glow];
         }
         else
         {
            _loc1_ = 0;
            if(this._friendly)
            {
               if(Boolean(GLOBAL._monsterOverdrive) && GLOBAL._monsterOverdrive.Get() >= GLOBAL.Timestamp())
               {
                  _loc1_ |= 13421568;
               }
               if(Boolean(GLOBAL._monsterDefenseOverdrive) && GLOBAL._monsterDefenseOverdrive.Get() >= GLOBAL.Timestamp())
               {
                  this._damageMult = 0.7;
                  _loc1_ |= 255;
               }
               if(Boolean(GLOBAL._monsterSpeedOverdrive) && GLOBAL._monsterSpeedOverdrive.Get() >= GLOBAL.Timestamp())
               {
                  this._speedMult = 1.5;
                  _loc1_ |= 16711680;
               }
            }
            else
            {
               if(Boolean(GLOBAL._attackerMonsterOverdrive) && GLOBAL._attackerMonsterOverdrive.Get() >= GLOBAL.Timestamp())
               {
                  _loc1_ |= 13421568;
               }
               if(Boolean(GLOBAL._attackerMonsterDefenseOverdrive) && GLOBAL._attackerMonsterDefenseOverdrive.Get() >= GLOBAL.Timestamp())
               {
                  this._damageMult = 0.7;
                  _loc1_ |= 255;
               }
               if(Boolean(GLOBAL._attackerMonsterSpeedOverdrive) && GLOBAL._attackerMonsterSpeedOverdrive.Get() >= GLOBAL.Timestamp())
               {
                  this._speedMult = 1.5;
                  _loc1_ |= 16711680;
               }
            }
            if(_loc1_ != 0)
            {
               if(this._glow)
               {
                  this._glow.color = _loc1_;
                  this._glow.strength = 6;
                  this._glow.blurX = 7;
                  this._glow.blurY = 7;
               }
               else
               {
                  this._glow = new GlowFilter(_loc1_,1,7,7,6,1);
               }
               filters = [this._glow];
            }
            else
            {
               this._damageMult = this._speedMult = this._lootMult = 1;
               filters = [];
               this._glow = null;
            }
         }
         this._secureSpeedMult = new SecNum(int(this._speedMult * 100));
         this._secureDamageMult = new SecNum(int(this._damageMult * 100));
         this._secureLootMult = new SecNum(int(this._lootMult * 100));
      }
      
      public function PoweredUp() : Boolean
      {
         if(!this._friendly)
         {
            if(GLOBAL._wmCreaturePowerups[this._creatureID])
            {
               if(GLOBAL._wmCreaturePowerups[this._creatureID])
               {
                  return true;
               }
            }
            else if(GLOBAL._mode != "build" && GLOBAL._playerCreatureUpgrades[this._creatureID] && Boolean(GLOBAL._playerCreatureUpgrades[this._creatureID].powerup))
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
      
      protected function PowerUpLevel() : int
      {
         if(!this.PoweredUp())
         {
            return 0;
         }
         if(!this._friendly)
         {
            if(GLOBAL._wmCreaturePowerups[this._creatureID])
            {
               if(GLOBAL._wmCreaturePowerups[this._creatureID])
               {
                  return GLOBAL._wmCreaturePowerups[this._creatureID];
               }
            }
            else if(GLOBAL._playerCreatureUpgrades[this._creatureID].powerup)
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
      
      public function FindHuntingTargets() : void
      {
         var _loc3_:* = undefined;
         var _loc1_:int = 0;
         var _loc2_:Array = [];
         for each(_loc3_ in CREATURES._creatures)
         {
            if(!(_loc3_._behaviour != k_sBHVR_DEFEND && _loc3_._behaviour != k_sBHVR_BUNKER && BASE._yardType < BASE.INFERNO_YARD))
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
      
      public function FindTarget(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc5_:BFOUNDATION = null;
         var _loc9_:Point = null;
         var _loc10_:Point = null;
         var _loc11_:int = 0;
         var _loc12_:Array = null;
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
         _loc12_ = [];
         this._looking = true;
         if(this._behaviour == k_sBHVR_HUNT && (CREATURES._creatureCount > 0 || CREATURES._guardian && CREATURES._guardian._health.Get() > 0))
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
               if(_loc5_._hp.Get() > 0 && _loc5_ is ILootable && !_loc5_._looted)
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
               else if(_loc5_._class != "trap" && _loc5_._hp.Get() > 0 && !(_loc5_ as BTOWER).isJard)
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
                  if(this._targetGroup != 4)
                  {
                     this._targetGroup = 1;
                  }
                  if(_loc5_._class == "tower" && !MONSTERBUNKER.isBunkerBuilding(_loc5_._type))
                  {
                     if((_loc5_ as BTOWER).isJard)
                     {
                        continue;
                     }
                  }
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
               if(this._creatureID == "IC5")
               {
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
               else if(GLOBAL.QuickDistance(this._tmpPoint,this._targetCenter) < 170)
               {
                  this._atTarget = true;
                  this._hasPath = true;
                  this._targetPosition = this._targetCenter;
               }
               else
               {
                  _loc21_ = Math.atan2(this._tmpPoint.y - this._targetCenter.y,this._tmpPoint.x - this._targetCenter.x) * 57.2957795;
                  _loc21_ = _loc21_ + (Math.random() * 40 - 20);
                  _loc21_ = _loc21_ / (180 / Math.PI);
                  _loc22_ = 2 * 60 + Math.random() * 10;
                  _loc23_ = new Point(this._targetCenter.x + Math.cos(_loc21_) * _loc22_ * 1.7,this._targetCenter.y + Math.sin(_loc21_) * _loc22_);
                  this._waypoints = [_loc23_];
                  this._targetPosition = this._waypoints[0];
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
         if(this._behaviour === k_sBHVR_JUICE || this._behaviour === k_sBHVR_HOUSING || this._behaviour === k_sBHVR_PEN || this._behaviour === k_sBHVR_DEFEND || this._behaviour === k_sBHVR_FEED || this._movement === k_sBHVR_JUMP || this._behaviour === k_sBHVR_DECOY)
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
            switch(this._behaviour)
            {
               case k_sBHVR_ATTACK:
                  this.FindTarget(this._targetGroup);
                  break;
               case k_sBHVR_HOUSING:
                  this.ModeHousing();
                  break;
               case k_sBHVR_RETREAT:
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
            if(this._behaviour == k_sBHVR_DEFEND)
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
   }
}

