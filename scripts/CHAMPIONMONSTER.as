package
{
   import com.cc.utils.SecNum;
   import com.monsters.champions.KOTHChampion;
   import com.monsters.components.statusEffects.FlameEffect;
   import com.monsters.interfaces.ILootable;
   import com.monsters.pathing.PATHING;
   import com.monsters.siege.SiegeWeapons;
   import com.monsters.siege.weapons.Decoy;
   import com.monsters.siege.weapons.SiegeWeapon;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import gs.*;
   import gs.easing.*;
   
   public class CHAMPIONMONSTER extends CreepBase
   {
      public static const KORATH_POWER_NORMAL:* = 1;
      
      public static const KORATH_POWER_FIREBALL:* = 2;
      
      public static const KORATH_POWER_STOMP:* = 3;
      
      public var _behaviourMode:String = "defend";
      
      public var _attackType:String = "melee";
      
      public var _feeds:SecNum;
      
      public var _feedTime:SecNum;
      
      public var _level:SecNum;
      
      public var _foodBonus:SecNum;
      
      public var _powerLevel:SecNum;
      
      public var _warned:Boolean = false;
      
      public var _warnStarve:Boolean = false;
      
      public var _spriteID:String;
      
      public var _name:String;
      
      public var _regen:int;
      
      public var _range:int;
      
      public var _buff:Number = 0;
      
      public var _buffRadius:Number = 0;
      
      public var _quaking:Boolean;
      
      public var _helpCreep:*;
      
      public var _type:int = 1;
      
      public var _blinkState:int = 0;
      
      public var _lastHeal:int = 0;
      
      public const DEFENSE_RANGE:int = 30;
      
      public const DEFENSE_MODIFIER:Number = 1;
      
      private var _dying:Boolean = false;
      
      private var _dead:Boolean = false;
      
      public var _attackNum:int;
      
      public function CHAMPIONMONSTER(param1:String, param2:Point, param3:Number, param4:Point = null, param5:Boolean = false, param6:BFOUNDATION = null, param7:int = 1, param8:int = 0, param9:int = 0, param10:int = 1, param11:int = 20000, param12:int = 0, param13:int = 0)
      {
         super();
         var _loc14_:int = getTimer();
         _mc = this;
         _id = GLOBAL.NextCreepID();
         _friendly = param5;
         this._level = new SecNum(param7);
         _middle = param7 * 5;
         _creatureID = "G" + param10;
         this._feeds = new SecNum(param8);
         if(param9 > 0)
         {
            this._feedTime = new SecNum(param9);
         }
         else
         {
            this._feedTime = new SecNum(int(GLOBAL.Timestamp() + CHAMPIONCAGE.GetGuardianProperty(_creatureID,param7,"feedTime")));
         }
         if(param12)
         {
            this._foodBonus = new SecNum(param12);
         }
         else
         {
            this._foodBonus = new SecNum(0);
         }
         if(param13)
         {
            this._powerLevel = new SecNum(param13);
         }
         else
         {
            this._powerLevel = new SecNum(0);
         }
         this._lastHeal = GLOBAL.Timestamp();
         _house = param6;
         _hits = 0;
         this._type = param10;
         _pathing = "";
         _spawnTime = GLOBAL.Timestamp();
         _spawnPoint = new Point(int(param2.x / 100) * 100,int(param2.y / 100) * 100);
         _targetGroup = 3;
         _waypoints = [];
         _targetCreeps = [];
         _targetCreep = null;
         mouseEnabled = false;
         mouseChildren = false;
         _speed = 0;
         if(this._foodBonus.Get() > 0)
         {
            _maxSpeed = (CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"speed") + CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._foodBonus.Get(),"bonusSpeed")) / 2;
         }
         else
         {
            _maxSpeed = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"speed") / 2;
         }
         _maxSpeed *= 1.1;
         if(this._foodBonus.Get() > 0)
         {
            _maxHealth = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"health") + CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._foodBonus.Get(),"bonusHealth");
         }
         else
         {
            _maxHealth = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"health");
         }
         this._regen = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"healtime");
         if(param11 > 0 && param11 <= _maxHealth)
         {
            _health = new SecNum(param11);
         }
         else if(param11 >= _maxHealth)
         {
            _health = new SecNum(_maxHealth);
         }
         else
         {
            _health = new SecNum(1);
         }
         if(this._foodBonus.Get() > 0)
         {
            _damage = new SecNum(int(CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"damage")) + int(CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._foodBonus.Get(),"bonusDamage")));
            this._range = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"range") + CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._foodBonus.Get(),"bonusRange");
         }
         else
         {
            _damage = new SecNum(int(CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"damage")));
            this._range = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"range");
         }
         _movement = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"movement");
         if(this._foodBonus.Get() > 0)
         {
            this._buff = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"buffs") + CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._foodBonus.Get(),"bonusBuffs");
         }
         else
         {
            this._buff = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"buffs");
         }
         if(CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"buffRadius"))
         {
            this._buffRadius = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"buffRadius");
         }
         _goo = 250000;
         _behaviour = param1;
         if(_creatureID == "G3")
         {
            _attackDelay = 8;
         }
         else if(_creatureID == "G4")
         {
            _attackDelay = 72;
         }
         else
         {
            _attackDelay = 56;
         }
         _targetPosition = param2;
         _targetCenter = param4;
         x = _targetPosition.x;
         y = _targetPosition.y;
         _tmpPoint.x = x;
         _tmpPoint.y = y;
         if(param3)
         {
            _targetRotation = param3;
         }
         else
         {
            _targetRotation = 0;
         }
         mcMarker.rotation = _targetRotation;
         _attacking = false;
         this._quaking = false;
         _frameNumber = Math.random() * 7;
         if(this is KOTHChampion)
         {
            this._spriteID = _creatureID + "_" + this._powerLevel.Get();
         }
         else
         {
            this._spriteID = _creatureID + "_" + this._level.Get();
         }
         SPRITES.SetupSprite(this._spriteID);
         if(_movement == "fly")
         {
            SPRITES.SetupSprite("bigshadow");
            _shadow = new BitmapData(52,50,true,0xffffff);
            _shadowMC = addChild(new Bitmap(_shadow));
            _shadowMC.x = -21;
            _shadowMC.y = -26;
            _frameNumber = int(Math.random() * 1000);
         }
         var _loc15_:Object = SPRITES.GetSpriteDescriptor(this._spriteID);
         _graphic = new BitmapData(_loc15_.width,_loc15_.height,true,0xffffff);
         _graphicMC = addChild(new Bitmap(_graphic));
         if(this is KOTHChampion)
         {
            _graphicMC.x = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._powerLevel.Get(),"offset_x");
            _graphicMC.y = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._powerLevel.Get(),"offset_y");
         }
         else
         {
            _graphicMC.x = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"offset_x");
            _graphicMC.y = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"offset_y");
         }
         if(_movement == "fly")
         {
            _altitude = 108;
         }
         else
         {
            _altitude = 0;
         }
         if(_behaviour == "bounce")
         {
            if(GLOBAL._render && _movement != "fly")
            {
               _graphicMC.y -= 90;
               if(_creatureID == "G3")
               {
                  TweenLite.to(_graphicMC,0.6,{
                     "y":_graphicMC.y + 90,
                     "ease":Bounce.easeOut,
                     "onComplete":this.ModeBuff
                  });
               }
               else
               {
                  TweenLite.to(_graphicMC,0.6,{
                     "y":_graphicMC.y + 90,
                     "ease":Bounce.easeOut,
                     "onComplete":this.ModeAttack
                  });
               }
            }
            else
            {
               if(_movement == "fly")
               {
                  _graphicMC.y -= _altitude;
               }
               else
               {
                  _altitude = 0;
               }
               if(_creatureID == "G3")
               {
                  this.ModeBuff();
               }
               else
               {
                  this.ModeAttack();
               }
            }
         }
         else if(_behaviour == "defend")
         {
            _altitude = 0;
            this.ModeDefend();
         }
         else if(_behaviour == "decoy")
         {
            this.ModeDecoy();
         }
         if(_behaviour == "juice")
         {
            this.ModeJuice();
         }
         this.ApplyInfernoVenom();
         this.Render();
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public static function Show() : *
      {
      }
      
      public function ModeJuice() : *
      {
         _behaviour = "juice";
         _hasTarget = false;
         _atTarget = false;
         _hasPath = false;
         _targetBuilding = GLOBAL._bJuicer;
         if(_movement == "fly" && _altitude < 60)
         {
            TweenLite.to(_graphicMC,2,{
               "y":_graphicMC.y - (108 - _altitude),
               "ease":Sine.easeIn,
               "onComplete":this.FlyerTakeOff
            });
         }
         ++CREATURES._creatureID;
         ++CREATURES._creatureCount;
         CREATURES._creatures[CREATURES._creatureID] = this;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < BASE._guardianData.length)
         {
            if(BASE._guardianData[_loc1_].t == CREATURES._guardian._type)
            {
               break;
            }
            _loc1_++;
         }
         BASE._guardianData.splice(_loc1_,1);
         if(GLOBAL._mode == "build")
         {
            _loc1_ = GLOBAL.getPlayerGuardianIndex(CREATURES._guardian._type);
            GLOBAL._playerGuardianData[_loc1_] = null;
            GLOBAL._playerGuardianData.splice(_loc1_,1);
         }
         CREATURES._guardian = null;
         BASE.Save();
         PATHING.GetPath(_tmpPoint,new Rectangle(_targetBuilding._mc.x,_targetBuilding._mc.y,80,80),this.SetWaypoints,true);
      }
      
      override public function ModeAttack() : void
      {
         _behaviour = "attack";
         _hasTarget = false;
         _atTarget = false;
         _hasPath = false;
         node = MAP.CreepCellAdd(_tmpPoint,_id,this);
         _targetCreep = null;
         this.FindTarget(0,true);
      }
      
      public function ModeCage() : *
      {
         _behaviour = "cage";
         _hasTarget = false;
         _atTarget = false;
         _attacking = false;
         this._quaking = false;
         _hasPath = false;
         var _loc1_:Point = new Point(_house._mc.x + 50,_house._mc.y + 60);
         _targetCenter = GRID.FromISO(GLOBAL._bCage._mc.x,GLOBAL._bCage._mc.y);
         PATHING.GetPath(_tmpPoint,new Rectangle(_loc1_.x,_loc1_.y,10,10),this.SetWaypoints,true);
         _house = GLOBAL._bCage;
      }
      
      public function ModeFreeze() : *
      {
         _behaviour = "freeze";
         _hasTarget = false;
         _atTarget = false;
         _attacking = false;
         this._quaking = false;
         _hasPath = false;
         ++CREATURES._creatureID;
         ++CREATURES._creatureCount;
         CREATURES._creatures[CREATURES._creatureID] = this;
         PATHING.GetPath(_tmpPoint,new Rectangle(GLOBAL._bChamber._mc.x,GLOBAL._bChamber._mc.y,80,80),this.SetWaypoints,true);
      }
      
      override public function ModeEnrage(param1:Number, param2:Number, param3:Number) : void
      {
         _enraged = param1;
         _speedMult = param2;
         _damageMult = param3;
         _secureSpeedMult = new SecNum(int(param2 * 100));
         _secureDamageMult = new SecNum(int(param3 * 100));
         if(_enraged > 0)
         {
            if(_enraged > 0 && filters.length == 0)
            {
               filters = [new GlowFilter(16724735,1,3,3,5,1)];
            }
         }
         else
         {
            filters = [];
         }
      }
      
      public function ModeBuff() : *
      {
         _behaviour = k_sBHVR_BUFF;
         _hasTarget = false;
         _atTarget = false;
         _hasPath = false;
         node = MAP.CreepCellAdd(_tmpPoint,_id,this);
         this.FindBuffTargets();
      }
      
      public function ModeDefend() : *
      {
         _behaviour = k_sBHVR_DEFEND;
         _hasTarget = false;
         _atTarget = false;
         _hasPath = false;
      }
      
      public function ModeDecoy() : void
      {
         var _loc2_:Decoy = null;
         var _loc3_:Rectangle = null;
         var _loc4_:Point = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:* = undefined;
         var _loc1_:SiegeWeapon = SiegeWeapons.activeWeapon;
         if(Boolean(_loc1_) && _loc1_ is Decoy)
         {
            _behaviour = "decoy";
            _hasTarget = false;
            _atTarget = false;
            _hasPath = false;
            _attacking = false;
            this._quaking = false;
            _targetCreep = null;
            _loc2_ = _loc1_ as Decoy;
            _loc3_ = new Rectangle(_loc2_.x,_loc2_.y + _loc2_.decoyGraphic.height / 2,40,40);
            _targetCenter = new Point(_loc3_.x,_loc3_.y);
            if(_movement == "burrow")
            {
               _hasTarget = true;
               _hasPath = true;
               _loc4_ = GRID.FromISO(_loc3_.x,_loc3_.y);
               _loc5_ = int(Math.random() * 4);
               _loc6_ = _loc3_.height;
               _loc7_ = _loc3_.width;
               if(_loc5_ == 0)
               {
                  _loc4_.x += Math.random() * _loc6_;
                  _loc4_.y += _loc7_;
               }
               else if(_loc5_ == 1)
               {
                  _loc4_.x += _loc6_;
                  _loc4_.y += _loc7_;
               }
               else if(_loc5_ == 2)
               {
                  _loc4_.x += _loc6_ - Math.random() * _loc6_ / 2;
                  _loc4_.y -= _loc7_ / 4;
               }
               else if(_loc5_ == 3)
               {
                  _loc4_.x -= _loc6_ / 4;
                  _loc4_.y += _loc7_ - Math.random() * _loc7_ / 2;
               }
               _waypoints = [GRID.ToISO(_loc4_.x,_loc4_.y,0)];
               _targetPosition = _waypoints[0];
            }
            else if(_movement == "fly")
            {
               _hasTarget = true;
               _hasPath = true;
               if(GLOBAL.QuickDistance(_tmpPoint,_targetCenter) < 50)
               {
                  _atTarget = true;
                  _hasPath = true;
                  _targetPosition = _targetCenter;
               }
               else
               {
                  _loc8_ = Math.atan2(_tmpPoint.y - _targetCenter.y,_tmpPoint.x - _targetCenter.x) * 57.2957795;
                  _loc8_ = _loc8_ + (Math.random() * 90 - 45);
                  _loc8_ = _loc8_ / (180 / Math.PI);
                  _loc9_ = 10 + Math.random() * 10;
                  _loc10_ = new Point(_targetCenter.x + Math.cos(_loc8_) * _loc9_ * 1.7,_targetCenter.y + Math.sin(_loc8_) * _loc9_);
                  _waypoints = [_loc10_];
                  _targetPosition = _waypoints[0];
               }
            }
            else
            {
               _loc8_ = Math.atan2(_tmpPoint.y - _targetCenter.y,_tmpPoint.x - _targetCenter.x) * 57.2957795;
               _loc8_ = _loc8_ + (Math.random() * 90 - 45);
               _loc8_ = _loc8_ / (180 / Math.PI);
               _loc9_ = 10 + Math.random() * 10;
               _loc11_ = new Point(_targetCenter.x + Math.cos(_loc8_) * _loc9_ * 1.7,_targetCenter.y + Math.sin(_loc8_) * _loc9_);
               _loc11_.x += Math.random() * -10 + 5;
               _loc11_.y += Math.random() * -10 + 5;
               _targetPosition = _targetCenter;
               WaypointTo(_loc11_);
            }
         }
         else
         {
            _hasTarget = false;
            this.FindDefenseTargets();
         }
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
         if(_targetCreep == null)
         {
            return false;
         }
         if(_targetCreep._movement == "fly")
         {
            if(_creatureID != "G3")
            {
               if(_creatureID != "G4")
               {
                  return false;
               }
               if(this._powerLevel.Get() < KORATH_POWER_FIREBALL || this._level.Get() < 4)
               {
                  return false;
               }
            }
         }
         var _loc1_:Number = GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint);
         if(_loc1_ > this._range)
         {
            return false;
         }
         if(_movement == "fly")
         {
            return true;
         }
         if(PATHING.LineOfSight(_tmpPoint.x,_tmpPoint.y,_targetCreep._tmpPoint.x,_targetCreep._tmpPoint.y))
         {
            return true;
         }
         return false;
      }
      
      private function CanHitBuilding() : Boolean
      {
         if(_targetBuilding == null)
         {
            return false;
         }
         var _loc1_:Number = GLOBAL.QuickDistance(_targetBuilding._position,_tmpPoint);
         if(_loc1_ > this._range)
         {
            return false;
         }
         if(_movement == "fly")
         {
            return true;
         }
         if(PATHING.LineOfSight(_tmpPoint.x,_tmpPoint.y,_targetBuilding._position.x,_targetBuilding._position.y,_targetBuilding))
         {
            return true;
         }
         return false;
      }
      
      override public function Clear() : void
      {
         _health.Set(0);
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
         _intercepting = false;
         _looking = true;
         if(_movement == "fly" && _altitude < 60)
         {
            TweenLite.to(_graphicMC,2,{
               "y":_graphicMC.y - (108 - _altitude),
               "ease":Sine.easeIn,
               "onComplete":this.FlyerTakeOff
            });
            _altitude = 61;
         }
         if(GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < this._range)
         {
            _atTarget = true;
            _looking = false;
         }
         else if(_noDefensePath || GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < this._range * 2 || _movement == "fly")
         {
            _waypoints = [_targetCreep._tmpPoint];
            _targetPosition = _targetCreep._tmpPoint;
         }
         else if(_targetCreep._atTarget || _targetCreep._waypoints.length < 8 || GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < 250)
         {
            WaypointTo(_targetCreep._tmpPoint,null);
         }
         else
         {
            WaypointTo(_targetCreep._waypoints[7],null);
            _intercepting = true;
         }
         _hasTarget = true;
      }
      
      public function FindBuffTargets() : *
      {
         var _loc2_:BFOUNDATION = null;
         var _loc3_:Boolean = false;
         var _loc1_:Object = BASE._buildingsMain;
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_._class !== "decoration" && _loc2_._class !== "immovable" && _loc2_._hp.Get() > 0 && _loc2_._class !== "enemy")
            {
               _loc3_ = true;
            }
         }
         if(!_loc3_)
         {
            ModeRetreat();
            return;
         }
         _looking = true;
         var _loc5_:Boolean = false;
         _targetCreeps = MAP.CreepCellFind(_tmpPoint,25 * 60,1,this);
         if(_targetCreeps.length > 0)
         {
            _targetCreeps.sortOn(["dist"],Array.NUMERIC);
            if(!(_targetCreep && _targetCreep._health.Get() > 0 && _targetCreep._health.Get() < _targetCreep._maxHealth))
            {
               _loc5_ = true;
               while(_targetCreeps.length > 0 && (_targetCreeps[0].creep._behaviour == "heal" || _targetCreeps[0].creep._health.Get() == _targetCreeps[0].creep._maxHealth))
               {
                  _targetCreeps.shift();
               }
               if(_targetCreeps.length > 0)
               {
                  this._helpCreep = _targetCreeps[0].creep;
                  if(_movement == "fly")
                  {
                     _waypoints = [this._helpCreep._tmpPoint];
                     _targetPosition = this._helpCreep._tmpPoint;
                  }
                  else
                  {
                     WaypointTo(this._helpCreep._tmpPoint,null);
                  }
               }
            }
         }
         if(_targetCreeps.length > 0)
         {
            _loc5_ = false;
            this._helpCreep = _targetCreeps[0].creep;
            if(_movement == "fly")
            {
               _waypoints = [this._helpCreep._tmpPoint];
               _targetPosition = this._helpCreep._tmpPoint;
            }
            else
            {
               WaypointTo(this._helpCreep._tmpPoint,null);
            }
            _behaviour = k_sBHVR_BUFF;
         }
         else if(this._helpCreep && this._helpCreep._health.Get() > 0 && this._helpCreep._health.Get() < this._helpCreep._maxHealth)
         {
            _loc5_ = false;
            if(_movement == "fly")
            {
               _waypoints = [this._helpCreep._tmpPoint];
               _targetPosition = this._helpCreep._tmpPoint;
            }
            else
            {
               WaypointTo(this._helpCreep._tmpPoint,null);
            }
            _behaviour = k_sBHVR_BUFF;
         }
         else if(_targetCreeps.length == 0)
         {
            this.ModeAttack();
            return;
         }
         if(_waypoints.length)
         {
            _hasTarget = true;
            _hasPath = true;
         }
      }
      
      public function FindDefenseTargets() : *
      {
         if(_creatureID == "G3" || _creatureID == "G4" && this._powerLevel.Get() >= KORATH_POWER_FIREBALL && this._level.Get() > 3)
         {
            _targetCreeps = MAP.CreepCellFind(_tmpPoint,800,1);
         }
         else
         {
            _targetCreeps = MAP.CreepCellFind(_tmpPoint,800);
         }
         if(_targetCreeps.length > 0)
         {
            _targetCreeps.sortOn(["dist"],Array.NUMERIC);
            while(_targetCreeps.length > 0 && (_targetCreeps[0].creep._behaviour == "retreat" || _movement != "fly" && _targetCreeps[0].creep._creatureID == "C5"))
            {
               _targetCreeps.splice(0,1);
            }
         }
         if(_targetCreeps.length > 0)
         {
            _targetCreep = _targetCreeps[0].creep;
            this.InterceptTarget();
            if(_movement == "fly" && _altitude < 60)
            {
               TweenLite.to(_graphicMC,2,{
                  "y":_graphicMC.y - (108 - _altitude),
                  "ease":Sine.easeIn,
                  "onComplete":this.FlyerTakeOff
               });
            }
            _behaviour = "defend";
         }
         else if(_targetCreep && _targetCreep._health.Get() > 0)
         {
            if(_movement == "fly")
            {
               this.InterceptTarget();
            }
            _behaviour = "defend";
         }
         else if(_behaviour != "cage" && _behaviour != "pen")
         {
            _atTarget = false;
            this.ModeCage();
         }
      }
      
      override public function FindTarget(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc5_:BFOUNDATION = null;
         var _loc9_:Point = null;
         var _loc10_:Point = null;
         var _loc11_:int = 0;
         var _loc12_:Array = null;
         var _loc13_:* = undefined;
         var _loc14_:int = 0;
         var _loc15_:Point = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:Number = NaN;
         var _loc20_:* = undefined;
         var _loc21_:* = undefined;
         var _loc3_:int = getTimer();
         _loc12_ = [];
         _looking = true;
         _loc9_ = PATHING.FromISO(_tmpPoint);
         for each(_loc5_ in BASE._buildingsMain)
         {
            if(_loc5_._hp.Get() > 0 && (_loc5_._class == "resource" || _loc5_._type == 6 || _loc5_._type == 14 || _loc5_._type == 112))
            {
               _loc10_ = GRID.FromISO(_loc5_._mc.x,_loc5_._mc.y + _loc5_._middle);
               _loc11_ = GLOBAL.QuickDistance(_loc9_,_loc10_) - _loc5_._middle;
               _loc12_.push({
                  "building":_loc5_,
                  "distance":_loc11_
               });
            }
         }
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
         if(_loc12_.length == 0)
         {
            for each(_loc5_ in BASE._buildingsMain)
            {
               if(_loc5_._class != "decoration" && _loc5_._class != "immovable" && _loc5_._hp.Get() > 0 && _loc5_._class != "enemy")
               {
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
         if(_loc12_.length == 0)
         {
            ModeRetreat();
         }
         else
         {
            _loc12_.sortOn("distance",Array.NUMERIC);
            _loc14_ = 0;
            if(_movement == "burrow")
            {
               _hasTarget = true;
               _hasPath = true;
               _loc15_ = GRID.FromISO(_loc12_[_loc14_].building._mc.x,_loc12_[_loc14_].building._mc.y);
               _loc16_ = int(Math.random() * 4);
               _loc17_ = int(_loc12_[_loc14_].building._footprint[0].height);
               _loc18_ = int(_loc12_[_loc14_].building._footprint[0].width);
               if(_loc16_ == 0)
               {
                  _loc15_.x += Math.random() * _loc17_;
                  _loc15_.y += _loc18_;
               }
               else if(_loc16_ == 1)
               {
                  _loc15_.x += _loc17_;
                  _loc15_.y += _loc18_;
               }
               else if(_loc16_ == 2)
               {
                  _loc15_.x += _loc17_ - Math.random() * _loc17_ / 2;
                  _loc15_.y -= _loc18_ / 4;
               }
               else if(_loc16_ == 3)
               {
                  _loc15_.x -= _loc17_ / 4;
                  _loc15_.y += _loc18_ - Math.random() * _loc18_ / 2;
               }
               _waypoints = [GRID.ToISO(_loc15_.x,_loc15_.y,0)];
               _targetPosition = _waypoints[0];
               _targetBuilding = _loc12_[_loc14_].building;
            }
            else if(_movement == "fly")
            {
               _hasTarget = true;
               _hasPath = true;
               _targetBuilding = _loc12_[_loc14_].building;
               _targetCenter = _targetBuilding._position;
               if(GLOBAL.QuickDistance(_tmpPoint,_targetCenter) < 170)
               {
                  _atTarget = true;
                  _hasPath = true;
                  _targetPosition = _targetCenter;
               }
               else
               {
                  _loc19_ = Math.atan2(_tmpPoint.y - _targetCenter.y,_tmpPoint.x - _targetCenter.x) * 57.2957795;
                  _loc19_ = _loc19_ + (Math.random() * 40 - 20);
                  _loc19_ = _loc19_ / (180 / Math.PI);
                  _loc20_ = 2 * 60 + Math.random() * 10;
                  _loc21_ = new Point(_targetCenter.x + Math.cos(_loc19_) * _loc20_ * 1.7,_targetCenter.y + Math.sin(_loc19_) * _loc20_);
                  _waypoints = [_loc21_];
                  _targetPosition = _waypoints[0];
               }
            }
            else if(GLOBAL._catchup)
            {
               WaypointTo(new Point(_loc12_[0].building._mc.x,_loc12_[0].building._mc.y),_loc12_[0].building);
            }
            else
            {
               _loc14_ = 0;
               while(_loc14_ < 2)
               {
                  if(_loc12_.length > _loc14_)
                  {
                     WaypointTo(new Point(_loc12_[_loc14_].building._mc.x,_loc12_[_loc14_].building._mc.y),_loc12_[_loc14_].building);
                  }
                  _loc14_++;
               }
            }
         }
      }
      
      override public function SetWaypoints(param1:Array, param2:BFOUNDATION = null, param3:Boolean = false) : void
      {
         var _loc4_:Boolean = false;
         if(param3)
         {
            if(_behaviour == "attack")
            {
               this.FindTarget();
            }
            if(_behaviour == "cage")
            {
               this.ModeCage();
            }
            if(_behaviour == "retreat")
            {
               ModeRetreat();
            }
         }
         else
         {
            _loc4_ = false;
            if(param1.length < _waypoints.length)
            {
               _loc4_ = true;
            }
            if(_loc4_ && param2 && param2._class == "wall" && _targetGroup != 2)
            {
               _loc4_ = false;
            }
            if(!_hasTarget)
            {
               _loc4_ = true;
            }
            if(_behaviour == "defend")
            {
               _loc4_ = true;
            }
            if(_loc4_)
            {
               _hasTarget = true;
               _atTarget = false;
               _hasPath = true;
               _waypoints = param1;
               _targetPosition = _waypoints[0];
               if(param2)
               {
                  _targetBuilding = param2;
               }
            }
            _looking = false;
         }
      }
      
      public function LevelSet(param1:int, param2:int = 0) : *
      {
         var _loc3_:Object = null;
         if(param1 != this._level.Get())
         {
            this._level = new SecNum(param1);
            if(this is KOTHChampion)
            {
               this._spriteID = _creatureID + "_" + this._powerLevel.Get();
            }
            else
            {
               this._spriteID = _creatureID + "_" + param1;
            }
            if(_graphicMC.parent)
            {
               _graphicMC.parent.removeChild(_graphicMC);
            }
            SPRITES.SetupSprite(this._spriteID);
            _loc3_ = SPRITES.GetSpriteDescriptor(this._spriteID);
            _graphic = new BitmapData(_loc3_.width,_loc3_.height,true,0xffffff);
            _graphicMC = addChild(new Bitmap(_graphic));
            if(this is KOTHChampion)
            {
               _graphicMC.x = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._powerLevel.Get(),"offset_x");
               _graphicMC.y = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._powerLevel.Get(),"offset_y");
            }
            else
            {
               _graphicMC.x = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"offset_x");
               _graphicMC.y = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"offset_y");
            }
            this._feeds = new SecNum(0);
            this._feedTime = new SecNum(int(GLOBAL.Timestamp() + CHAMPIONCAGE.GetGuardianProperty(_creatureID,param1,"feedTime")));
            LOGGER.Log("fed","level " + this._level.Get());
            _maxHealth = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"health");
            _maxSpeed = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"speed") / 2;
            _maxSpeed *= 1.1;
            this._regen = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"healtime");
            _health.Set(_maxHealth);
            _damage = new SecNum(int(CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"damage")));
            this._range = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"range");
            _movement = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"movement");
            if(param1 >= 6)
            {
               QUESTS.Check("upgrade_champ" + _creatureID.substr(1,1),1);
            }
            LOGGER.Stat([57,_creatureID,param2,this._level.Get()]);
            BASE.Save();
         }
      }
      
      public function TickBAttack() : *
      {
         var _loc2_:Object = null;
         var _loc3_:* = undefined;
         var _loc4_:CreepBase = null;
         var _loc5_:Point = null;
         if(_health.Get() <= 0)
         {
            MAP.CreepCellDelete(_id,node);
            ModeRetreat();
            _venom.Set(0);
            ATTACK.Log(_creatureID,LOGIN._playerName + "\'s Level " + this._level.Get() + " " + CHAMPIONCAGE._guardians[_creatureID].name + " retreated.");
            SOUNDS.Play("monsterland" + (1 + int(Math.random() * 3)));
            if(GLOBAL._mode == "attack")
            {
               LOGGER.Stat([54,_creatureID,1,this._level.Get()]);
            }
            BASE.Save();
            return;
         }
         if(this.DoQuakeCheck())
         {
            return;
         }
         var _loc1_:Number = 1;
         if(Boolean(GLOBAL._attackerMonsterOverdrive) && GLOBAL._attackerMonsterOverdrive.Get() >= GLOBAL.Timestamp())
         {
            _loc1_ *= 1.25;
         }
         if(_creatureID == "G3" && _frameNumber % 100 == 0)
         {
            this.FindBuffTargets();
            if(_behaviour == k_sBHVR_BUFF)
            {
               this.TickBBuff();
               return;
            }
            _loc2_ = CREEPS._creeps;
            for each(_loc3_ in _loc2_)
            {
               if(_loc3_ != this)
               {
                  _loc4_ = _loc3_ as CreepBase;
                  if((_loc4_) && _loc4_._damageMult >= 1 - this._buff && GLOBAL.QuickDistanceSquared(_tmpPoint,_loc4_._tmpPoint) < 62500)
                  {
                     _loc3_.ModeEnrage(GLOBAL.Timestamp() + 5,1 + this._buff * 2,1 - this._buff);
                  }
               }
            }
         }
         if(_hasTarget)
         {
            if(!_targetCreep)
            {
               if(_targetBuilding == null || _targetBuilding._hp.Get() <= 0 || _targetBuilding._class == "tower" && !MONSTERBUNKER.isBunkerBuilding(_targetBuilding._type) && (_targetBuilding as BTOWER).isJard)
               {
                  _hasTarget = false;
                  _attacking = false;
                  _atTarget = false;
                  this.FindTarget();
               }
            }
            else if(_targetCreep._health.Get() <= 0)
            {
               _hasTarget = false;
               _attacking = false;
               _atTarget = false;
               _targetCreep = null;
               this.FindTarget();
            }
         }
         if(!_looking && _frameNumber % (GLOBAL._catchup ? 200 : 100) == 0 && !_attacking)
         {
            this.FindTarget(0,true);
         }
         if(_atTarget)
         {
            _attacking = true;
            if(attackCooldown <= 0)
            {
               attackCooldown += int(_attackDelay / _speedMult);
               if(_creatureID == "G3" || _creatureID == "G4" && _targetCreep && _targetCreep._movement == "fly" && this._powerLevel.Get() >= KORATH_POWER_FIREBALL && this._level.Get() > 3)
               {
                  if(_targetCreep && _targetCreep._health.Get() > 0)
                  {
                     _loc5_ = Point.interpolate(_tmpPoint.add(new Point(0,-_altitude)),_targetPosition,0.8);
                     if(_creatureID == "G4")
                     {
                        FIREBALLS.Spawn2(_loc5_,_targetCreep._tmpPoint,_targetCreep,8,_damage.Get() * _loc1_ / 4,0,FIREBALLS.TYPE_MAGMA);
                        this.AddFlameDOT(_targetCreep);
                     }
                     else
                     {
                        FIREBALLS.Spawn2(_loc5_,_targetCreep._tmpPoint,_targetCreep,8,_damage.Get() * _loc1_);
                        FIREBALLS._fireballs[FIREBALLS._id - 1]._graphic.gotoAndStop(3);
                     }
                  }
                  else if(_targetBuilding)
                  {
                     _loc5_ = Point.interpolate(_tmpPoint.add(new Point(0,-_altitude)),_targetPosition,0.8);
                     FIREBALLS.Spawn(_loc5_,_targetPosition,_targetBuilding,8,_damage.Get() * _loc1_);
                     FIREBALLS._fireballs[FIREBALLS._id - 1]._graphic.gotoAndStop(3);
                  }
                  else
                  {
                     this.FindBuffTargets();
                  }
               }
               else
               {
                  ++this._attackNum;
                  if(Boolean(_targetBuilding) && _targetBuilding._fortification.Get() > 0)
                  {
                     ATTACK.Damage(_tmpPoint.x,_tmpPoint.y - 5,_damage.Get() * _loc1_ * (100 - (_targetBuilding._fortification.Get() * 10 + 10)) / 100,_mc.visible);
                  }
                  else
                  {
                     ATTACK.Damage(_tmpPoint.x,_tmpPoint.y - 5,_damage.Get() * _loc1_,_mc.visible);
                  }
                  if(_targetCreep)
                  {
                     _targetCreep._health.Add(-(_damage.Get() * _loc1_ * _targetCreep._damageMult));
                     if(_creatureID == "G4")
                     {
                        this.AddFlameDOT(_targetCreep);
                     }
                  }
                  else if(_targetBuilding)
                  {
                     _targetBuilding.Damage(_damage.Get() * _loc1_,_tmpPoint.x,_tmpPoint.y,_targetGroup,true,_secureLootMult);
                     if(_creatureID === "G5" && _targetBuilding is ILootable)
                     {
                        if(_targetBuilding._looted)
                        {
                           this.FindTarget();
                        }
                     }
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
               --attackCooldown;
            }
         }
         else
         {
            _attacking = false;
         }
      }
      
      public function TickBDefend() : *
      {
         var _loc1_:Object = null;
         var _loc2_:Vector.<CHAMPIONMONSTER> = null;
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Point = null;
         if(_health.Get() <= 0)
         {
            ATTACK.Log(_creatureID,KEYS.Get("attacklog_champ_injured",{
               "v1":BASE._ownerName,
               "v2":this._level.Get(),
               "v3":CHAMPIONCAGE._guardians[_creatureID].name
            }));
            _venom.Set(0);
            ModeRetreat();
            if(GLOBAL._mode == "attack")
            {
               LOGGER.Stat([56,_creatureID,1,this._level.Get()]);
            }
            BASE.Save();
            return;
         }
         if(this.DoQuakeCheck())
         {
            return;
         }
         if(_creatureID == "G3" && _frameNumber % 100 == 0)
         {
            _loc2_ = CREATURES._guardianList;
            _loc3_ = CREATURES._creatures;
            for each(_loc1_ in _loc2_)
            {
               if(_loc1_._behaviour === k_sBHVR_DEFEND && _loc1_._damageMult >= 1 - this._buff && GLOBAL.QuickDistance(_loc1_._tmpPoint,_tmpPoint) < 250 && _loc1_ != this)
               {
                  _loc1_.ModeEnrage(GLOBAL.Timestamp() + 5,1 + this._buff * 2,1 - this._buff);
               }
            }
            for each(_loc1_ in _loc3_)
            {
               if(_loc1_._behaviour === k_sBHVR_DEFEND && _loc1_._damageMult >= 1 - this._buff && GLOBAL.QuickDistance(_loc1_._tmpPoint,_tmpPoint) < 250 && _loc1_ != this)
               {
                  _loc1_.ModeEnrage(GLOBAL.Timestamp() + 5,1 + this._buff * 2,1 - this._buff);
               }
            }
         }
         if(_hasTarget)
         {
            if(_targetCreep._health.Get() <= 0)
            {
               _hasTarget = false;
               _atTarget = false;
               _attacking = false;
               _hasPath = false;
               this.FindDefenseTargets();
            }
            else if(GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < this._range)
            {
               _atTarget = true;
            }
            else if(_creatureID == "G4" && _targetCreep._movement == "fly" && GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < this._range * 2)
            {
               _atTarget = true;
            }
            else if(!_attacking && _frameNumber % 60 == 0)
            {
               this.FindDefenseTargets();
            }
            else if(_attacking && GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) > this._range * 2)
            {
               _attacking = false;
               _atTarget = false;
               _hasPath = false;
               this.FindDefenseTargets();
            }
         }
         if(_atTarget)
         {
            _attacking = true;
            _intercepting = false;
            if(_movement != "fly" || _targetCreep._creatureID == "C14" || _targetCreep._creatureID == "C12" && _targetCreep.PoweredUp() || _targetCreep._creatureID == "G3" || _targetCreep._creatureID == "G4" || _targetCreep._creatureID == "IC7" || _targetCreep._creatureID == "IC5")
            {
               if(_targetCreep._behaviour != "heal")
               {
                  _targetCreep._targetCreep = this;
                  if(_targetCreep._creatureID == "C14" || _targetCreep._creatureID == "IC7" || _targetCreep._creatureID == "C12" && _targetCreep.PoweredUp() || _targetCreep._creatureID == "G3" || _targetCreep._creatureID == "G4" || (GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < 50 || _targetCreep._creatureID.substr(0,1) == "G") && _movement != "fly")
                  {
                     _targetCreep._atTarget = true;
                  }
                  else
                  {
                     _targetCreep._atTarget = false;
                     _targetCreep._waypoints = [_tmpPoint];
                  }
                  _targetCreep._hasTarget = true;
                  _targetCreep._looking = false;
                  _targetCreep._hasTarget = true;
               }
            }
            if(attackCooldown <= 0)
            {
               attackCooldown += int(_attackDelay / _speedMult);
               if(_creatureID == "G3" || _creatureID == "G4" && this._powerLevel.Get() >= KORATH_POWER_FIREBALL && this._level.Get() > 3 && _targetCreep._movement == "fly")
               {
                  _loc7_ = Point.interpolate(_tmpPoint.add(new Point(0,-_altitude)),_targetCreep._tmpPoint,0.8);
                  if(_creatureID == "G4")
                  {
                     FIREBALLS.Spawn2(_loc7_,_targetCreep._tmpPoint,_targetCreep,8,_damage.Get() / 4,0,FIREBALLS.TYPE_MAGMA);
                     this.AddFlameDOT(_targetCreep);
                  }
                  else
                  {
                     FIREBALLS.Spawn2(_loc7_,_targetCreep._tmpPoint,_targetCreep,8,_damage.Get(),0);
                     FIREBALLS._fireballs[FIREBALLS._id - 1]._graphic.gotoAndStop(3);
                  }
               }
               else
               {
                  ++this._attackNum;
                  ATTACK.Damage(_tmpPoint.x,_tmpPoint.y - 5,_damage.Get() * _targetCreep._damageMult,_mc.visible);
                  _targetCreep._health.Add(-(_damage.Get() * _targetCreep._damageMult));
                  if(_creatureID == "G4")
                  {
                     this.AddFlameDOT(_targetCreep);
                  }
               }
               if(_targetCreep._creatureID == "C14" || _targetCreep._creatureID == "G3" || _targetCreep.CanShootCreep() || GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < 50 && _movement != "fly")
               {
                  if(!_targetCreep._explode && !_targetCreep._targetCreep && _targetCreep._behaviour != "heal")
                  {
                     _targetCreep._targetCreep = this;
                     if(_targetCreep._creatureID == "C14" || _targetCreep.CanShootCreep() || GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < 50 && _movement != "fly")
                     {
                        _targetCreep._atTarget = true;
                     }
                     else
                     {
                        _targetCreep._atTarget = false;
                        _targetCreep._waypoints = [_tmpPoint];
                     }
                     _targetCreep._hasTarget = true;
                     _targetCreep._looking = false;
                     _targetCreep._hasTarget = true;
                  }
               }
               _loc4_ = MAP.CreepCellFind(_tmpPoint,50);
               _loc5_ = int(_loc4_.length);
               _loc6_ = 0;
               while(_loc6_ < 5 && _loc6_ < _loc5_)
               {
                  if(_movement != "fly" || _loc4_[_loc6_].creep.CanShootCreep() || GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < 50 && _movement != "fly")
                  {
                     if(!_loc4_[_loc6_].creep._explode && _loc4_[_loc6_].creep._behaviour != "heal")
                     {
                        _loc4_[_loc6_].creep._targetCreep = this;
                        if(_loc4_[_loc6_].creep.CanShootCreep() || GLOBAL.QuickDistance(_loc4_[_loc6_].creep._tmpPoint,_tmpPoint) < 50 && _movement != "fly" || _loc4_[_loc6_].creep._creatureID == "C14")
                        {
                           _loc4_[_loc6_].creep._atTarget = true;
                        }
                        _loc4_[_loc6_].creep._hasTarget = true;
                     }
                  }
                  _loc6_++;
               }
            }
            else
            {
               --attackCooldown;
            }
         }
         else
         {
            _attacking = false;
         }
      }
      
      public function TickBJuice(param1:int) : Boolean
      {
         if(_health.Get() <= 0)
         {
            _health.Set(0);
            MAP.CreepCellDelete(_id,node);
            ModeRetreat();
            return false;
         }
         if(_atTarget)
         {
            if(_movement == "fly" && !this._dying)
            {
               this._dying = true;
               TweenLite.to(_graphicMC,0.9,{
                  "y":_graphicMC.y + _altitude,
                  "ease":Sine.easeOut,
                  "onComplete":this.FlyerDeath
               });
            }
            if(_movement == "fly" && !this._dead)
            {
               return false;
            }
            GLOBAL._bJuicer.BlendGuardian(1000 ^ this._level.Get() / 2);
            return true;
         }
         return false;
      }
      
      public function TickBFreeze(param1:int) : Boolean
      {
         if(_atTarget)
         {
            if(_movement == "fly" && !this._dying)
            {
               this._dying = true;
               TweenLite.to(_graphicMC,0.9,{
                  "y":_graphicMC.y + _altitude,
                  "ease":Sine.easeOut,
                  "onComplete":this.FlyerDeath
               });
            }
            if(_movement == "fly" && !this._dead)
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      public function TickBDecoy() : Boolean
      {
         if(_health.Get() <= 0)
         {
            ATTACK.Log(_creatureID,KEYS.Get("attacklog_champ_injured",{
               "v1":BASE._ownerName,
               "v2":this._level.Get(),
               "v3":CHAMPIONCAGE._guardians[_creatureID].name
            }));
            _venom.Set(0);
            ModeRetreat();
            if(GLOBAL._mode == "attack")
            {
               LOGGER.Stat([56,_creatureID,1,this._level.Get()]);
            }
            BASE.Save();
            return false;
         }
         if(!(SiegeWeapons.activeWeapon && SiegeWeapons.activeWeapon is Decoy))
         {
            _hasTarget = false;
            _atTarget = false;
            _attacking = false;
            _hasPath = false;
            this.FindDefenseTargets();
         }
         return false;
      }
      
      public function FlyerDeath() : *
      {
         this._dead = true;
      }
      
      public function FlyerLanded() : *
      {
         _altitude = 0;
      }
      
      public function FlyerTakeOff() : *
      {
         _altitude = 108;
      }
      
      override public function PoweredUp() : Boolean
      {
         return false;
      }
      
      public function TickBPen(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         if(_health.Get() < _maxHealth)
         {
            if(this._lastHeal <= GLOBAL.Timestamp() - 5)
            {
               _health.Add(int(_maxHealth * 5 / this._regen) * param1);
               _health.Set(Math.min(_health.Get(),_maxHealth));
               this._lastHeal = GLOBAL.Timestamp();
            }
         }
         _venom.Set(0);
         if(this._behaviourMode == "defend" && _frameNumber % 200 == 0)
         {
            this.FindDefenseTargets();
         }
         if(_behaviour == "pen" && _frameNumber > 4 * 60 && int(Math.random() * 150) == 1 && GLOBAL._fps > 25)
         {
            _targetPosition = CHAMPIONCAGE.PointInCage(_targetCenter);
            _hasPath = true;
         }
         if(GLOBAL._mode == "build" && this._level.Get() < 6)
         {
            if(!this._warnStarve)
            {
               if(GLOBAL.Timestamp() > this._feedTime.Get() + CHAMPIONCAGE.STARVETIMER)
               {
                  CHAMPIONCAGE.Hide();
                  if(!GLOBAL._catchup)
                  {
                     GLOBAL.Message(KEYS.Get("msg_champion_starving"));
                  }
                  this._feeds.Add(-1);
                  if(this._feeds.Get() < 0)
                  {
                     this._feeds.Set(0);
                  }
                  this._feedTime = new SecNum(int(GLOBAL.Timestamp() + CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"feedTime")));
                  this._warnStarve = true;
                  LOGGER.Log("fed","Starved level " + this._level.Get());
               }
            }
            else if(!this._warned)
            {
               if(GLOBAL.Timestamp() > this._feedTime.Get())
               {
                  CHAMPIONCAGE.Hide();
                  if(!GLOBAL._catchup)
                  {
                     GLOBAL.Message(KEYS.Get("msg_champion_hungry",{"v1":GLOBAL.ToTime(this._feedTime.Get() - GLOBAL.Timestamp() + CHAMPIONCAGE.STARVETIMER)}));
                  }
                  this._warned = true;
               }
            }
            if(this._feeds.Get() >= CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"feeds"))
            {
               this.LevelSet(this._level.Get() + 1);
            }
         }
         else if(GLOBAL._mode == "build" && this._level.Get() == 6)
         {
            if(GLOBAL.Timestamp() > this._feedTime.Get() + CHAMPIONCAGE.STARVETIMER)
            {
               CHAMPIONCAGE.Hide();
               _loc2_ = _health.Get();
               _loc3_ = Math.max(1,this._foodBonus.Get() - 1);
               _loc4_ = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"health") + CHAMPIONCAGE.GetGuardianProperty(_creatureID,_loc3_,"bonusHealth");
               if(_loc2_ < 1)
               {
                  _loc2_ = 1;
               }
               else if(_loc2_ >= _loc4_)
               {
                  _loc2_ = _loc4_;
               }
               _health.Set(_loc2_);
               this._foodBonus.Add(-param1);
               if(this._foodBonus.Get() < 0)
               {
                  this._foodBonus.Set(0);
               }
               this._feedTime = new SecNum(int(GLOBAL.Timestamp() + CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"feedTime")));
            }
         }
      }
      
      public function TickBCage(param1:int) : void
      {
         _venom.Set(0);
         if(_atTarget)
         {
            _behaviour = k_sBHVR_PEN;
            if(_movement == "fly" && _altitude > 60)
            {
               TweenLite.to(_graphicMC,1.2,{
                  "y":_graphicMC.y + _altitude,
                  "ease":Sine.easeOut,
                  "onComplete":this.FlyerLanded
               });
            }
            _waypoints[0] = CHAMPIONCAGE.PointInCage(_targetCenter);
         }
         else if(this._behaviourMode == k_sBHVR_DEFEND && _frameNumber % 200 == 0)
         {
            this.FindDefenseTargets();
         }
      }
      
      public function TickBBuff() : *
      {
         var _loc2_:* = undefined;
         var _loc3_:Point = null;
         var _loc1_:Number = 1;
         if(Boolean(GLOBAL._attackerMonsterOverdrive) && GLOBAL._attackerMonsterOverdrive.Get() >= GLOBAL.Timestamp())
         {
            _loc1_ *= 1.25;
         }
         if(_health.Get() <= 0)
         {
            MAP.CreepCellDelete(_id,node);
            ModeRetreat();
            ATTACK.Log(_creatureID,KEYS.Get("attacklog_champ_retreated",{
               "v1":LOGIN._playerName,
               "v2":this._level.Get(),
               "v3":CHAMPIONCAGE._guardians[_creatureID].name
            }));
            if(GLOBAL._mode == "attack")
            {
               LOGGER.Stat([54,_creatureID,1,this._level.Get()]);
            }
            SOUNDS.Play("monsterland" + (1 + int(Math.random() * 3)));
            return;
         }
         if(_frameNumber % 100 == 0)
         {
            for each(_loc2_ in CREEPS._creeps)
            {
               if(_loc2_ != this)
               {
                  if(_loc2_ && _loc2_._damageMult >= 1 - this._buff && GLOBAL.QuickDistance(_tmpPoint,_loc2_._tmpPoint) < 250)
                  {
                     _loc2_.ModeEnrage(GLOBAL.Timestamp() + 5,1 + this._buff * 2,1 - this._buff);
                  }
               }
            }
            if(!_attacking)
            {
               this.FindBuffTargets();
            }
         }
         if(_hasTarget)
         {
            if(_targetCreep)
            {
               if(_targetCreep._health.Get() <= 0 || _targetCreep._health.Get() == _targetCreep._maxHealth && _frameNumber % 20 == 0)
               {
                  _hasTarget = false;
                  _attacking = false;
                  _atTarget = false;
                  _hasPath = false;
                  this._helpCreep = null;
                  if(_targetCreep && _targetCreep._health.Get() <= 0)
                  {
                     _targetCreep = null;
                  }
                  this.FindBuffTargets();
               }
               else if(GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < this._range)
               {
                  _atTarget = true;
               }
               else
               {
                  _atTarget = false;
               }
            }
            else if(this._helpCreep)
            {
               if(this._helpCreep._targetBuilding)
               {
                  _targetBuilding = this._helpCreep._targetBuilding;
               }
               if(this._helpCreep._health.Get() <= 0 || this._helpCreep._health.Get() == this._helpCreep._maxHealth && _frameNumber % 20 == 0)
               {
                  _hasTarget = false;
                  _attacking = false;
                  _atTarget = false;
                  _hasPath = false;
                  if(this._helpCreep && this._helpCreep._health.Get() <= 0)
                  {
                     this._helpCreep = null;
                  }
                  this.FindBuffTargets();
               }
               else if(this._helpCreep && GLOBAL.QuickDistance(this._helpCreep._tmpPoint,_tmpPoint) < this._range && Boolean(this._helpCreep._targetBuilding) && GLOBAL.QuickDistance(this._helpCreep._targetBuilding._position,_tmpPoint) < this._range)
               {
                  _atTarget = true;
               }
               else if(!_attacking && !_looking && _frameNumber % 120 == 0)
               {
                  this.FindBuffTargets();
               }
               else if(_attacking && this._helpCreep && GLOBAL.QuickDistance(this._helpCreep._tmpPoint,_tmpPoint) > this._range * 1.25)
               {
                  _attacking = false;
                  _atTarget = false;
               }
               else if(_waypoints.length == 0 && !_atTarget)
               {
                  if(this.CanHitBuilding())
                  {
                     _atTarget = true;
                  }
                  else if(!_looking)
                  {
                     if(_movement == "fly")
                     {
                        _hasPath = true;
                        _waypoints = [_targetBuilding._position];
                        _targetPosition = _targetBuilding._position;
                     }
                     else if(!_looking)
                     {
                        _hasPath = false;
                        _hasTarget = false;
                        WaypointTo(_targetBuilding._position,_targetBuilding);
                     }
                  }
               }
            }
            else if(Boolean(_targetBuilding) && _targetBuilding._hp.Get() > 0)
            {
               if(this.CanHitBuilding())
               {
                  _atTarget = true;
               }
               else
               {
                  _atTarget = false;
                  _attacking = false;
                  if(_waypoints.length == 0 && !_looking)
                  {
                     _hasPath = false;
                     if(_movement == "fly")
                     {
                        _waypoints = [this._helpCreep._tmpPoint];
                        _targetPosition = this._helpCreep._tmpPoint;
                     }
                     else
                     {
                        WaypointTo(this._helpCreep._tmpPoint,_targetBuilding);
                     }
                  }
               }
            }
            else
            {
               _attacking = false;
               _atTarget = false;
               _hasPath = false;
               _targetCreep = null;
               this._helpCreep = null;
               _targetBuilding = null;
               this.FindBuffTargets();
            }
         }
         else
         {
            _attacking = false;
            _atTarget = false;
            _hasPath = false;
            _targetCreep = null;
            this._helpCreep = null;
            _targetBuilding = null;
            this.FindBuffTargets();
         }
         if(_atTarget)
         {
            if(attackCooldown <= 0)
            {
               attackCooldown += int(_attackDelay / _speedMult);
               if(_targetCreep && _targetCreep._health.Get() > 0)
               {
                  _attacking = true;
                  _loc3_ = Point.interpolate(_tmpPoint.add(new Point(0,-_altitude)),_targetPosition,0.8);
                  FIREBALLS.Spawn2(_loc3_,_targetCreep._tmpPoint,_targetCreep,8,_damage.Get() * _loc1_);
                  FIREBALLS._fireballs[FIREBALLS._id - 1]._graphic.gotoAndStop(3);
                  SOUNDS.Play("hit" + int(1 + Math.random() * 3),0.1 + Math.random() * 0.1);
                  _targetCenter = _targetCreep._tmpPoint;
                  _targetPosition = _targetCreep._tmpPoint;
               }
               else if(this._helpCreep && this._helpCreep._targetBuilding && this._helpCreep._targetBuilding._hp.Get() > 0 || _targetBuilding && _targetBuilding._hp.Get() > 0)
               {
                  if(this._helpCreep)
                  {
                     _targetBuilding = this._helpCreep._targetBuilding;
                  }
                  if(Boolean(_targetBuilding) && GLOBAL.QuickDistance(_targetBuilding._position,_tmpPoint) < this._range)
                  {
                     _attacking = true;
                     _targetCenter = _targetBuilding._position;
                     _targetPosition = _targetBuilding._position;
                     _loc3_ = Point.interpolate(_tmpPoint.add(new Point(0,-_altitude)),_targetPosition,0.8);
                     FIREBALLS.Spawn(_loc3_,_targetPosition,_targetBuilding,8,_damage.Get() * _loc1_);
                     FIREBALLS._fireballs[FIREBALLS._id - 1]._graphic.gotoAndStop(3);
                     SOUNDS.Play("hit" + int(1 + Math.random() * 3),0.1 + Math.random() * 0.1);
                  }
                  else if(_targetBuilding)
                  {
                     _attacking = false;
                     _atTarget = false;
                     if(_movement == "fly")
                     {
                        _hasPath = true;
                        _waypoints = [_targetBuilding._position];
                        _targetPosition = _targetBuilding._position;
                     }
                     else if(!_looking)
                     {
                        _hasPath = false;
                        _hasTarget = false;
                        WaypointTo(_targetBuilding._position,_targetBuilding);
                     }
                  }
                  else
                  {
                     _attacking = false;
                     _atTarget = false;
                     _hasPath = false;
                     _targetCreep = null;
                     this._helpCreep = null;
                     _targetBuilding = null;
                     this.FindBuffTargets();
                  }
               }
               else
               {
                  _attacking = false;
                  _atTarget = false;
                  _hasTarget = false;
                  _hasPath = false;
                  _targetBuilding = null;
                  _targetCreep = null;
                  this._helpCreep = null;
                  this.FindBuffTargets();
               }
            }
            else
            {
               --attackCooldown;
            }
         }
         else
         {
            _attacking = false;
         }
      }
      
      public function TickBRetreat() : *
      {
         _venom.Set(0);
         if(_atTarget)
         {
            return true;
         }
      }
      
      public function TickDefault() : *
      {
      }
      
      public function Export(param1:Boolean = true) : void
      {
         var _loc4_:int = 0;
         if(_behaviour == "juice" || _behaviour == "freeze")
         {
            return;
         }
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < CREATURES._guardianList.length)
         {
            if(CREATURES._guardianList[_loc2_] == this)
            {
               _loc3_ = true;
               break;
            }
            _loc2_++;
         }
         if(param1 && _loc3_)
         {
            _loc4_ = 0;
            _loc2_ = 0;
            while(_loc2_ < BASE._guardianData.length)
            {
               if(BASE._guardianData[_loc2_].t == _creatureID.substr(1))
               {
                  break;
               }
               _loc2_++;
            }
            BASE._guardianData[_loc2_] = {};
            BASE._guardianData[_loc2_].hp = new SecNum(_health.Get());
            BASE._guardianData[_loc2_].l = new SecNum(this._level.Get());
            BASE._guardianData[_loc2_].fd = this._feeds.Get();
            BASE._guardianData[_loc2_].ft = this._feedTime.Get();
            BASE._guardianData[_loc2_].nm = this._name;
            BASE._guardianData[_loc2_].t = int(_creatureID.substr(1,1));
            BASE._guardianData[_loc2_].fb = new SecNum(this._foodBonus.Get());
            BASE._guardianData[_loc2_].pl = new SecNum(this._powerLevel.Get());
         }
         if(!param1 && GLOBAL._mode != "build" || param1 && _loc3_ && GLOBAL._mode == "build")
         {
            _loc2_ = GLOBAL.getPlayerGuardianIndex(int(_creatureID.substr(1)));
            if(_loc2_ < 0)
            {
               _loc2_ = int(GLOBAL._playerGuardianData.length);
            }
            GLOBAL._playerGuardianData[_loc2_] = {};
            GLOBAL._playerGuardianData[_loc2_].hp = new SecNum(_health.Get());
            GLOBAL._playerGuardianData[_loc2_].l = new SecNum(this._level.Get());
            GLOBAL._playerGuardianData[_loc2_].fd = this._feeds.Get();
            GLOBAL._playerGuardianData[_loc2_].ft = this._feedTime.Get();
            GLOBAL._playerGuardianData[_loc2_].nm = this._name;
            GLOBAL._playerGuardianData[_loc2_].t = int(_creatureID.substr(1,1));
            GLOBAL._playerGuardianData[_loc2_].fb = new SecNum(this._foodBonus.Get());
            GLOBAL._playerGuardianData[_loc2_].pl = new SecNum(this._powerLevel.Get());
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
               GLOBAL.Message(KEYS.Get("msg_healchampion",{"v1":_loc1_}),KEYS.Get("str_heal"),this.HealB);
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
            _health.Set(_maxHealth);
            BASE.Purchase("IHE",_loc1_,"CHAMPION.Heal");
            this.Export(_friendly);
            LOGGER.Stat([58,_creatureID,_loc1_,this._level.Get()]);
            BASE.Save();
         }
      }
      
      public function GetHealCost() : int
      {
         var _loc1_:Number = (_maxHealth - _health.Get()) / _maxHealth;
         var _loc2_:int = int(_loc1_ * CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"healtime"));
         return STORE.GetTimeCost(_loc2_,false);
      }
      
      override public function UpdateBuffs() : void
      {
         super.UpdateBuffs();
         if(this._foodBonus.Get() > 0)
         {
            _maxSpeed = (CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"speed") + CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._foodBonus.Get(),"bonusSpeed")) / 2;
         }
         else
         {
            _maxSpeed = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"speed") / 2;
         }
         _maxSpeed *= 1.1;
         if(_speed > _maxSpeed)
         {
            _speed = _maxSpeed;
         }
         if(this._foodBonus.Get() > 0)
         {
            _maxHealth = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"health") + CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._foodBonus.Get(),"bonusHealth");
         }
         else
         {
            _maxHealth = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"health");
         }
         if(_health.Get() > _maxHealth)
         {
            _health.Set(_maxHealth);
         }
         if(this._foodBonus.Get() > 0)
         {
            _damage = new SecNum(int(CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"damage")) + int(CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._foodBonus.Get(),"bonusDamage")));
         }
         else
         {
            _damage = new SecNum(int(CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"damage")));
         }
         if(this._foodBonus.Get() > 0)
         {
            this._range = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"range") + CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._foodBonus.Get(),"bonusRange");
         }
         else
         {
            this._range = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"range");
         }
         if(this._foodBonus.Get() > 0)
         {
            this._buff = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"buffs") + CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._foodBonus.Get(),"bonusBuffs");
         }
         else
         {
            this._buff = CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"buffs");
         }
      }
      
      private function ApplyInfernoVenom() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Array = null;
         if(BASE.isInferno() && (GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack"))
         {
            _loc2_ = [0,0,0,0,0,0,0,0,0,5 * 60,270,4 * 60,210,2 * 60,60,10,5,1];
            if(MAPROOM_DESCENT._descentLvl >= _loc2_.length)
            {
               _loc1_ = _health.Get() / 40;
            }
            _loc1_ = Math.max(_health.Get() / (40 * _loc2_[MAPROOM_DESCENT._descentLvl - 1]),1);
            _venom.Add(_loc1_);
         }
      }
      
      public function get tickLimit() : int
      {
         if(_behaviour != "cage" && _behaviour != "pen" && _behaviour != "juice" && _behaviour != "freeze")
         {
            return 1;
         }
         return int.MAX_VALUE;
      }
      
      override public function Tick(param1:int = 1) : Boolean
      {
         var _loc2_:Number = NaN;
         super.Tick(param1);
         this.UpdateBuffs();
         _frameNumber += 1;
         if(_venom.Get() > 0)
         {
            _health.Add(-(_venom.Get() * _damageMult) * param1);
         }
         if(_health.Get() > _maxHealth)
         {
            LOGGER.Log("hak","Champion monster health exceeds maximum");
            GLOBAL.ErrorMessage("GUARDIANMONSTER hack 1");
            return false;
         }
         if(_frameNumber % 30 == 0)
         {
            if(_maxHealth != CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"health"))
            {
               if(_maxHealth != CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"health") + CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._foodBonus.Get(),"bonusHealth"))
               {
                  LOGGER.Log("hak","Champion monster health max incorrect");
                  GLOBAL.ErrorMessage("GUARDIANMONSTER hack 2");
                  return false;
               }
            }
            if(_maxSpeed != CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"speed") / 2 * 1.1)
            {
               if(_maxSpeed != (CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"speed") + CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._foodBonus.Get(),"bonusSpeed")) / 2 * 1.1)
               {
                  LOGGER.Log("hak","Champion monster speed incorrect");
                  GLOBAL.ErrorMessage("GUARDIANMONSTER hack 3");
                  return false;
               }
            }
            if(this._range != CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"range"))
            {
               if(this._range != CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._level.Get(),"range") + CHAMPIONCAGE.GetGuardianProperty(_creatureID,this._foodBonus.Get(),"bonusRange"))
               {
                  LOGGER.Log("hak","Champion monster range incorrect");
                  GLOBAL.ErrorMessage("GUARDIANMONSTER hack 4");
                  return false;
               }
            }
            if(_secureSpeedMult.Get() != int(_speedMult * 100))
            {
               LOGGER.Log("hak","Champion monster speed buff incorrect");
               GLOBAL.ErrorMessage("GUARDIANMONSTER hack 5");
               return false;
            }
            if(_secureDamageMult.Get() != int(_damageMult * 100))
            {
               LOGGER.Log("hak","Champion monster damage buff incorrect");
               GLOBAL.ErrorMessage("GUARDIANMONSTER hack 6");
               return false;
            }
         }
         this.Export(_friendly);
         if(_movement == "fly" && _health.Get() > 0 && _behaviour != "pen")
         {
            if(_altitude >= 60)
            {
               _loc2_ = Math.sin(_frameNumber / 50) * 5;
               _altitude = 108 - _loc2_;
               _graphicMC.y = -_altitude - 36 + _loc2_;
            }
         }
         switch(_behaviour)
         {
            case k_sBHVR_ATTACK:
            case k_sBHVR_BOUNCE:
               this.TickBAttack();
               break;
            case k_sBHVR_DEFEND:
               this.TickBDefend();
               break;
            case k_sBHVR_BUFF:
               this.TickBBuff();
               break;
            case k_sBHVR_PEN:
               this.TickBPen(param1);
               break;
            case "cage":
               this.TickBCage(param1);
               break;
            case k_sBHVR_JUICE:
               if(this.TickBJuice(param1))
               {
                  return true;
               }
               break;
            case "freeze":
               if(this.TickBFreeze(param1))
               {
                  return true;
               }
               break;
            case k_sBHVR_RETREAT:
               if(this.TickBRetreat())
               {
                  return true;
               }
               break;
            case k_sBHVR_DECOY:
               if(this.TickBDecoy())
               {
                  return true;
               }
               break;
            default:
               this.TickDefault();
         }
         if((_behaviour == "attack" || _behaviour == "retreat" && _health.Get() > 0 || _behaviour == "buff") && _frameNumber % 5 == 0)
         {
            newNode = MAP.CreepCellMove(_tmpPoint,_id,this,node);
            if(newNode)
            {
               node = newNode;
            }
         }
         if(_enraged != 0 && _enraged <= GLOBAL.Timestamp())
         {
            this.ModeEnrage(0,1,1);
         }
         this.Move();
         this.Render();
         return false;
      }
      
      public function Move() : *
      {
         _speed = _maxSpeed * 0.5 * _speedMult;
         if(_behaviour == "pen")
         {
            _speed *= 0.5;
         }
         if(_behaviour == "juice" || _behaviour == "cage" || _behaviour == "bunker" || _behaviour == "freeze")
         {
            _speed *= 1.5;
         }
         if(_behaviour == "defend")
         {
            _speed *= 1.5;
         }
         if(_behaviour == "juice" && _movement == "fly" && _altitude < 60)
         {
            _speed = 0;
         }
         if(_attacking)
         {
            _speed = 0;
         }
         if(_jumping)
         {
            if(_jumpingUp)
            {
               _speed *= 3;
            }
            else
            {
               _speed *= 2;
            }
         }
         if(!_atTarget && _behaviour != "cage" && _behaviour != "pen" && _behaviour != "juice" && (_targetCreep && this.CanShootCreep() || this.CanHitBuilding()))
         {
            _atTarget = true;
            if(_targetCreep)
            {
               _xd = _targetCreep._tmpPoint.x - _tmpPoint.x;
               _yd = _targetCreep._tmpPoint.y - _tmpPoint.y;
               _targetPosition = _targetCreep._tmpPoint;
            }
            else if(_targetBuilding)
            {
               _targetPosition = new Point(_targetBuilding._mc.x,_targetBuilding._mc.y + _targetBuilding._footprint[0].height / 2);
               _xd = _targetPosition.x - _tmpPoint.x;
               _yd = _targetPosition.y - _tmpPoint.y;
            }
            else if(_waypoints.length > 0)
            {
               _xd = _waypoints[_waypoints.length - 1].x - _tmpPoint.x;
               _yd = _waypoints[_waypoints.length - 1].y - _tmpPoint.y;
               _targetPosition = _waypoints[_waypoints.length - 1];
            }
         }
         else if(_targetCreep && _behaviour == "attack")
         {
            _xd = _targetCreep._tmpPoint.x - _tmpPoint.x;
            _yd = _targetCreep._tmpPoint.y - _tmpPoint.y;
            _targetPosition = _targetCreep._tmpPoint;
            if(GLOBAL.QuickDistance(_targetPosition,_tmpPoint) > this._range)
            {
               _tmpPoint.x += Math.cos(Math.atan2(_yd,_xd)) * _speed;
               _tmpPoint.y += Math.sin(Math.atan2(_yd,_xd)) * _speed;
            }
            else
            {
               _atTarget = true;
            }
         }
         else if(_waypoints.length > 0)
         {
            _targetPosition = _waypoints[0];
            if(GLOBAL.QuickDistance(_targetPosition,_tmpPoint) <= 10)
            {
               while(_waypoints.length > 0 && GLOBAL.QuickDistance(_targetPosition,_tmpPoint) <= 10)
               {
                  _waypoints.splice(0,1);
                  if(_waypoints[0])
                  {
                     _targetPosition = _waypoints[0];
                  }
                  else
                  {
                     if(_behaviour != "defend")
                     {
                        _atTarget = true;
                        return false;
                     }
                     if(GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < this._range)
                     {
                        _atTarget = true;
                        if(_targetCreep._behaviour != "heal")
                        {
                           _targetCreep._targetCreep = this;
                           if(_targetCreep._creatureID == "C14" || _targetCreep.CanShootCreep() || GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < 50 && _movement != "fly")
                           {
                              _targetCreep._atTarget = true;
                           }
                           else
                           {
                              _targetCreep._atTarget = false;
                              _targetCreep._waypoints = [_tmpPoint];
                           }
                           _targetCreep._hasTarget = true;
                           _targetCreep._looking = false;
                           _targetCreep._hasTarget = true;
                        }
                        return false;
                     }
                  }
               }
               if(_behaviour == k_sBHVR_DEFEND)
               {
                  if(_creatureID != "G3" && GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < this._range || this.CanShootCreep())
                  {
                     _atTarget = true;
                     _targetPosition = _targetCreep._tmpPoint;
                     if(!_targetCreep._explode && _targetCreep._behaviour != "heal")
                     {
                        _targetCreep._targetCreep = this;
                        if(_targetCreep._creatureID == "C14" || _targetCreep.CanShootCreep() || GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < 50 && _movement != "fly")
                        {
                           _targetCreep._atTarget = true;
                        }
                        else
                        {
                           _targetCreep._atTarget = false;
                           _targetCreep._waypoints = [_tmpPoint];
                        }
                        _targetCreep._hasTarget = true;
                        _targetCreep._looking = false;
                        _targetCreep._hasTarget = true;
                     }
                     return false;
                  }
                  if(_targetCreep && _waypoints.length == 0 && _hasPath)
                  {
                     if(_noDefensePath)
                     {
                        _targetPosition = _targetCreep._tmpPoint;
                        _waypoints = [_targetCreep._tmpPoint];
                     }
                     else
                     {
                        WaypointTo(_targetCreep._tmpPoint,null);
                     }
                  }
               }
               else if(_waypoints.length == 0 && _hasPath && (_targetCreep || _behaviour == "cage" || _behaviour == "juice" || _behaviour == "retreat" || _behaviour == "pen"))
               {
                  _atTarget = true;
                  return false;
               }
            }
            if(_waypoints.length > 0)
            {
               _targetPosition = _waypoints[0];
            }
            if(_behaviour == "attack" && _targetCreep)
            {
               _xd = _targetCreep._tmpPoint.x - _tmpPoint.x;
               _yd = _targetCreep._tmpPoint.y - _tmpPoint.y;
            }
            else if(_behaviour == "defend")
            {
               if(_attacking)
               {
                  _xd = _targetCreep._tmpPoint.x - _tmpPoint.x;
                  _yd = _targetCreep._tmpPoint.y - _tmpPoint.y;
               }
               else if(_targetPosition)
               {
                  _xd = _targetPosition.x - _tmpPoint.x;
                  _yd = _targetPosition.y - _tmpPoint.y;
               }
            }
            else if(_targetPosition)
            {
               _xd = _targetPosition.x - _tmpPoint.x;
               _yd = _targetPosition.y - _tmpPoint.y;
            }
            _tmpPoint.x += Math.cos(Math.atan2(_yd,_xd)) * _speed;
            _tmpPoint.y += Math.sin(Math.atan2(_yd,_xd)) * _speed;
         }
         else if(_hasPath)
         {
            if(_targetCreep)
            {
               _xd = _targetCreep._tmpPoint.x - _tmpPoint.x;
               _yd = _targetCreep._tmpPoint.y - _tmpPoint.y;
            }
            else if(_targetBuilding)
            {
               _xd = _targetBuilding.x - _tmpPoint.x;
               _yd = _targetBuilding.y + _targetBuilding._middle - _tmpPoint.y;
            }
            else if(_targetPosition)
            {
               _xd = _targetPosition.x - _tmpPoint.x;
               _yd = _targetPosition.y - _tmpPoint.y;
               if(!_atTarget && GLOBAL.QuickDistance(_targetPosition,_tmpPoint) > 5)
               {
                  _tmpPoint.x += Math.cos(Math.atan2(_yd,_xd)) * _speed;
                  _tmpPoint.y += Math.sin(Math.atan2(_yd,_xd)) * _speed;
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
            _targetRotation = Math.atan2(_yd,_xd) * 57.2957795 - 90;
            _loc1_ = mcMarker.rotation - _targetRotation;
            if(_loc1_ > 3 * 60)
            {
               _targetRotation += 6 * 60;
            }
            else if(_loc1_ < -180)
            {
               _targetRotation -= 360;
            }
            _targetRotation += 90;
            _loc2_ = (_targetRotation - mcMarker.rotation) / 5;
            _loc2_ = _loc2_ * 0.5 * GLOBAL._loops;
            if(_loc2_ != 0)
            {
               mcMarker.rotation += _loc2_;
            }
            if(x != int(_tmpPoint.x) || y != int(_tmpPoint.y))
            {
               x = int(_tmpPoint.x);
               y = int(_tmpPoint.y);
            }
            _graphic.lock();
            if(_shadow)
            {
               _shadow.lock();
            }
            _loc4_ = 0;
            _visible = true;
            if(!alpha)
            {
               alpha = 1;
            }
            if(_behaviour == "pen" && !_hasPath)
            {
               SPRITES.GetSprite(_graphic,this._spriteID,"idle",mcMarker.rotation - 45);
            }
            else if(this._quaking)
            {
               SPRITES.GetSprite(_graphic,this._spriteID,"stomp",mcMarker.rotation - 45,_frameNumber);
            }
            else if(_attacking)
            {
               SPRITES.GetSprite(_graphic,this._spriteID,"attack",mcMarker.rotation - 45,_frameNumber);
            }
            else
            {
               SPRITES.GetSprite(_graphic,this._spriteID,"walking",mcMarker.rotation - 45,_frameNumber);
            }
            if(_movement == "fly")
            {
               SPRITES.GetSprite(_shadow,"bigshadow","bigshadow",0);
            }
            _lastRotation = int(mcMarker.rotation / 12);
            if(_health.Get() < _maxHealth)
            {
               _loc5_ = 11 - int(11 / _maxHealth * _health.Get());
               _loc6_ = SPRITES.GetSpriteDescriptor(this._spriteID);
               _graphic.copyPixels(CREEPS._bmdHPbar,new Rectangle(0,5 * _loc5_,17,5),new Point(-_graphicMC.x - CREEPS._bmdHPbar.width / 2,6));
            }
            _graphic.unlock();
            if(_shadow)
            {
               _shadow.unlock();
            }
         }
      }
      
      private function AddFlameDOT(param1:CreepBase) : Boolean
      {
         param1.addStatusEffect(new FlameEffect(param1,_damage.Get() * 0.1));
         return true;
      }
      
      private function DoQuakeCheck() : Boolean
      {
         var _loc1_:Number = NaN;
         if(_creatureID != "G4")
         {
            return false;
         }
         if(this._quaking)
         {
            if(_frameNumber / 8 % 10 + 20 == 26)
            {
               _loc1_ = 1;
               if(Boolean(GLOBAL._attackerMonsterOverdrive) && GLOBAL._attackerMonsterOverdrive.Get() >= GLOBAL.Timestamp())
               {
                  _loc1_ *= 1.25;
               }
               this._attackNum = 0;
               SOUNDS.Play("quake",0.4);
               this.Quake(_damage.Get() * _loc1_);
            }
            else if(_frameNumber / 8 % 10 + 20 == 29)
            {
               this._quaking = false;
            }
         }
         else if(attackCooldown <= 0)
         {
            if(this._powerLevel.Get() >= KORATH_POWER_STOMP && this._level.Get() > 4 && this._attackNum >= 3)
            {
               this._quaking = true;
               _frameNumber = 0;
            }
         }
         return this._quaking;
      }
      
      private function Quake(param1:int) : void
      {
         var _loc3_:Array = null;
         var _loc6_:BFOUNDATION = null;
         var _loc2_:Point = new Point(_mc.x,_mc.y);
         if(_behaviour == "attack")
         {
            _loc3_ = MAP.getDefendingCreepsInRange(this._range * 2.5,new Point(_mc.x,_mc.y));
            for each(_loc6_ in BASE._buildingsAll)
            {
               if(_loc6_._class != "cage")
               {
                  if(GLOBAL.QuickDistance(_loc2_,new Point(_loc6_.x,_loc6_.y)) < this._range * 2.5)
                  {
                     _loc3_.push(_loc6_);
                  }
               }
            }
         }
         else
         {
            _loc3_ = MAP.getAttackingCreepsInRange(this._range * 2.5,new Point(_mc.x,_mc.y));
         }
         if(_loc3_)
         {
            MAP.DealLinearAEDamage(_loc2_,this._range * 2.5,_damage.Get(),_loc3_,this._range * 1.5);
         }
         var _loc5_:G4QuakeGraphic = new G4QuakeGraphic(20,this._range * 2.5);
         _loc5_.graphic.y = _loc5_.graphic.y + 0;
         _mc.addChildAt(_loc5_.graphic,getChildIndex(_graphicMC) - 1);
      }
   }
}

import flash.display.Shape;
import flash.filters.GlowFilter;
import gs.TweenLite;

class G4QuakeGraphic
{
   public var graphic:Shape;
   
   public function G4QuakeGraphic(param1:uint, param2:uint)
   {
      super();
      this.graphic = new Shape();
      this.graphic.graphics.lineStyle(0.3,15893760,0.5);
      this.graphic.graphics.drawEllipse(-param1,-param1 / 2,param1 * 2,param1);
      this.graphic.graphics.drawEllipse(-param1 * 0.8,-param1 / 2.5,param1 * 1.6,param1 * 0.8);
      this.graphic.graphics.drawEllipse(-param1 * 0.6,-param1 / 3.333333,param1 * 1.2,param1 * 0.6);
      var _loc3_:GlowFilter = new GlowFilter(0xff6600,1,20,20,5 + Math.random() * 5,1,false,false);
      this.graphic.filters = [_loc3_];
      TweenLite.to(this.graphic,1,{
         "width":param2 * 2,
         "height":param2,
         "alpha":0,
         "onComplete":this.onComplete
      });
   }
   
   private function onComplete() : void
   {
      this.graphic.parent.removeChild(this.graphic);
      this.graphic.filters = [];
      this.graphic = null;
   }
}
