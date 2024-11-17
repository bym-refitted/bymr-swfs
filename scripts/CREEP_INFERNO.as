package
{
   import com.cc.utils.SecNum;
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
   
   public class CREEP_INFERNO extends CreepBase
   {
      public var _blinkState:int = 0;
      
      public var _blinkPoints:int = 0;
      
      public var _blinkDistance:Number;
      
      private var _secureDamageMult:SecNum;
      
      private var _secureSpeedMult:SecNum;
      
      private var _lastFrame:int = -1;
      
      private var _defenderRemoved:Boolean = false;
      
      private const DEFENSE_RANGE:int = 30;
      
      private const DEFENSE_MODIFIER:Number = 1;
      
      private const HEALING_RANGE:int = 150;
      
      private var _dying:Boolean = false;
      
      private var _dead:Boolean = false;
      
      public function CREEP_INFERNO(param1:String, param2:String, param3:Point, param4:Number, param5:Point = null, param6:Boolean = false, param7:BFOUNDATION = null, param8:Number = 1, param9:Boolean = false, param10:* = null)
      {
         var _loc12_:Point = null;
         this._secureDamageMult = new SecNum(100);
         this._secureSpeedMult = new SecNum(100);
         super();
         var _loc11_:int = getTimer();
         _mc = this;
         _id = GLOBAL.NextCreepID();
         _friendly = param6;
         _creatureID = param1;
         _middle = 5;
         _house = param7;
         _hits = 0;
         _spawnPoint = new Point(int(param3.x / 100) * 100,int(param3.y / 100) * 100);
         _goeasy = param9;
         _movement = CREATURELOCKER._creatures[param1].movement;
         _pathing = CREATURELOCKER._creatures[param1].pathing;
         if(_house)
         {
            _house._creatures.push(this);
         }
         _behaviour = param2;
         _targetGroup = CREATURES.GetProperty(param1,"targetGroup");
         _explode = CREATURES.GetProperty(param1,"explode");
         _spawnTime = GLOBAL.Timestamp();
         _waypoints = [];
         _targetCreeps = [];
         _targetCreep = null;
         _homeBunker = null;
         _invisibleTime = 0;
         mouseEnabled = false;
         mouseChildren = false;
         _speed = 0;
         _maxSpeed = CREATURES.GetProperty(_creatureID,"speed",0,_friendly) / 2;
         _maxSpeed *= 1.1;
         if(TUTORIAL._stage < 200)
         {
            _maxSpeed *= 2;
         }
         _health = new SecNum(int(CREATURES.GetProperty(_creatureID,"health",0,_friendly) * param8));
         _maxHealth = _health.Get();
         _damage = new SecNum(int(CREATURES.GetProperty(_creatureID,"damage",0,_friendly) * param8));
         _goo = CREATURES.GetProperty(_creatureID,"cResource",0,_friendly);
         _targetPosition = param3;
         _targetCenter = param5;
         x = _targetPosition.x;
         y = _targetPosition.y;
         _tmpPoint.x = x;
         _tmpPoint.y = y;
         if(param4)
         {
            _targetRotation = param4;
         }
         else
         {
            _targetRotation = 0;
         }
         mcMarker.rotation = _targetRotation;
         _attackDelay = 60;
         if(_creatureID == "C7" && _friendly && PoweredUp() && PowerUpLevel() > 1)
         {
            _attackDelay /= 1 + PowerUpLevel() * 0.5;
         }
         _attacking = false;
         _frameNumber = 0;
         SPRITES.SetupSprite(_creatureID);
         if(_movement == "fly")
         {
            SPRITES.SetupSprite("shadow");
            _shadow = new BitmapData(52,50,true,0xffffff);
            _shadowMC = addChild(new Bitmap(_shadow));
            _shadowMC.x = -21;
            _shadowMC.y = -16;
            _frameNumber = int(Math.random() * 1000);
         }
         _graphic = new BitmapData(64,50,true,0xffffff);
         _graphicMC = addChild(new Bitmap(_graphic));
         _graphicMC.x = -26;
         _graphicMC.y = -36;
         if(param2 == "housing")
         {
            _loc12_ = GRID.ToISO(_targetCenter.x + 100,_targetCenter.y + 100,0);
            if(_movement == "fly")
            {
               _graphicMC.y -= _altitude;
            }
            else
            {
               _altitude = 0;
            }
            PATHING.GetPath(_tmpPoint,new Rectangle(_loc12_.x,_loc12_.y,10,10),SetWaypoints,true);
         }
         else if(_behaviour == "bounce")
         {
            if(GLOBAL._render && _movement != "fly")
            {
               EFFECTS.Dig(int(_tmpPoint.x),int(_tmpPoint.y));
               TweenLite.to(_graphicMC,0.4,{
                  "y":_graphicMC.y - 20,
                  "ease":Sine.easeOut,
                  "overwrite":false
               });
               TweenLite.to(_graphicMC,0.4,{
                  "y":_graphicMC.y,
                  "ease":Bounce.easeOut,
                  "overwrite":false,
                  "delay":0.4,
                  "onComplete":ModeAttack
               });
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
               if(_targetGroup == 5)
               {
                  this.ModeHeal();
               }
               else if(_targetGroup == 6)
               {
                  this.ModeHunt();
               }
               else
               {
                  ModeAttack();
               }
            }
         }
         else if(_behaviour == "loot")
         {
            node = MAP.CreepCellAdd(_tmpPoint,_id,this);
         }
         else if(_behaviour == "defend")
         {
            this.ModeDefend();
         }
         else if(_behaviour == "decoy")
         {
            this.ModeDecoy();
         }
         if(param8 > 1)
         {
            LOGGER.Log("log","MONSTER Strength");
            GLOBAL.ErrorMessage("CREEP_INFERNO");
         }
         if(_behaviour == "juice")
         {
            this.ModeJuice();
         }
         if(_behaviour == "feed")
         {
            this.ModeFeed();
         }
         this.UpdateBuffs();
         this.Render();
      }
      
      public function ModeJuice() : void
      {
         _behaviour = "juice";
         _hasTarget = false;
         _atTarget = false;
         _hasPath = false;
         _targetBuilding = GLOBAL._bJuicer;
         if(_movement == "fly" && _altitude < 60)
         {
            TweenLite.to(_graphicMC,2,{
               "y":_graphicMC.y - (40 - _altitude),
               "ease":Sine.easeIn,
               "onComplete":this.FlyerTakeOff
            });
         }
         PATHING.GetPath(_tmpPoint,new Rectangle(_targetBuilding._mc.x,_targetBuilding._mc.y,80,80),SetWaypoints,true);
         GLOBAL._bJuicer.Prep(_creatureID);
      }
      
      public function ModeFeed() : void
      {
         _behaviour = "feed";
         _hasTarget = false;
         _atTarget = false;
         _hasPath = false;
         _targetBuilding = GLOBAL._bCage;
         WaypointTo(CREATURES._guardian._tmpPoint,null);
      }
      
      public function ModeEnrage(param1:Number, param2:Number, param3:Number) : void
      {
         _enraged = param1;
         _speedMult = param2;
         _damageMult = param3;
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
         var _loc1_:* = 0;
         if(_enraged > 0)
         {
            if(_enraged > 0)
            {
               if(_glow)
               {
                  _glow.color = 16724735;
                  _glow.blurX = 3;
                  _glow.blurY = 3;
                  _glow.strength = 5;
               }
               else
               {
                  _glow = new GlowFilter(16724735,1,3,3,5,1);
               }
               filters = [_glow];
            }
         }
         else if(!BASE.isInferno())
         {
            _loc1_ = 0;
            if(_friendly)
            {
               if(Boolean(GLOBAL._monsterOverdrive) && GLOBAL._monsterOverdrive.Get() >= GLOBAL.Timestamp())
               {
                  _loc1_ |= 13421568;
               }
               if(Boolean(GLOBAL._monsterDefenseOverdrive) && GLOBAL._monsterDefenseOverdrive.Get() >= GLOBAL.Timestamp())
               {
                  _damageMult = 0.7;
                  _loc1_ |= 255;
               }
               if(Boolean(GLOBAL._monsterSpeedOverdrive) && GLOBAL._monsterSpeedOverdrive.Get() >= GLOBAL.Timestamp())
               {
                  _speedMult = 1.5;
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
                  _damageMult = 0.7;
                  _loc1_ |= 255;
               }
               if(Boolean(GLOBAL._attackerMonsterSpeedOverdrive) && GLOBAL._attackerMonsterSpeedOverdrive.Get() >= GLOBAL.Timestamp())
               {
                  _speedMult = 1.5;
                  _loc1_ |= 16711680;
               }
            }
            if(_loc1_ != 0)
            {
               if(_glow)
               {
                  _glow.color = _loc1_;
                  _glow.strength = 6;
                  _glow.blurX = 7;
                  _glow.blurY = 7;
               }
               else
               {
                  _glow = new GlowFilter(_loc1_,1,7,7,6,1);
               }
               filters = [_glow];
            }
            else
            {
               _damageMult = 1;
               _speedMult = 1;
               filters = [];
               _glow = null;
            }
         }
         this._secureSpeedMult = new SecNum(int(_speedMult * 100));
         this._secureDamageMult = new SecNum(int(_damageMult * 100));
      }
      
      public function ModeHunt() : void
      {
         _behaviour = "hunt";
         _hasTarget = false;
         _atTarget = false;
         _hasPath = false;
         node = MAP.CreepCellAdd(_tmpPoint,_id,this);
         FindTarget(_targetGroup,true);
      }
      
      public function ModeHeal() : void
      {
         _behaviour = "heal";
         _hasTarget = false;
         _atTarget = false;
         _hasPath = false;
         node = MAP.CreepCellAdd(_tmpPoint,_id,this);
         this.FindHealingTargets();
      }
      
      public function ModeDefend() : void
      {
         _behaviour = "defend";
         _hasTarget = false;
         _atTarget = false;
         _hasPath = false;
      }
      
      public function ModeBunker() : void
      {
         var _loc1_:Point = null;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:BFOUNDATION = null;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         _behaviour = "bunker";
         _hasTarget = false;
         _atTarget = false;
         _hasPath = false;
         _doDefenseBurrow = false;
         if(_homeBunker == null)
         {
            for(_loc2_ in BASE._buildingsAll)
            {
               _loc3_ = 9999999;
               if(MONSTERBUNKER.isBunkerBuilding(BASE._buildingsAll[_loc2_]._type) && BASE._buildingsAll[_loc2_]._countdownBuild.Get() <= 0 && BASE._buildingsAll[_loc2_]._hp.Get() > 0)
               {
                  _loc4_ = BASE._buildingsAll[_loc2_];
                  _loc5_ = _loc4_._mc.x - _tmpPoint.x;
                  _loc6_ = _loc4_._mc.y - _tmpPoint.y;
                  _loc7_ = int(Math.sqrt(_loc5_ * _loc5_ + _loc6_ * _loc6_));
                  if(_loc3_ > _loc7_)
                  {
                     _homeBunker = _loc4_;
                  }
               }
            }
         }
         if(_homeBunker)
         {
            if(BASE.isInferno())
            {
               _targetCenter = GRID.FromISO(_homeBunker._mc.x,_homeBunker._mc.y);
               _targetPosition = GRID.FromISO(_homeBunker._mc.x,_homeBunker._mc.y);
               _loc8_ = 100;
               _loc9_ = 60;
            }
            else
            {
               _loc8_ = _tmpPoint.x - _homeBunker._position.x;
               _loc9_ = _tmpPoint.y - _homeBunker._position.y;
               _loc10_ = int(_homeBunker._footprint[0].width);
               _loc11_ = int(_homeBunker._footprint[0].height);
               if(_loc9_ <= 0)
               {
                  _loc9_ = _loc11_ / 4;
                  if(_loc8_ <= 0)
                  {
                     _loc8_ = _loc10_ / -3;
                  }
                  else
                  {
                     _loc8_ = _loc10_ / 2;
                  }
               }
               else
               {
                  _loc9_ = _loc11_ / 2;
                  if(_loc8_ <= 0)
                  {
                     _loc8_ = _loc10_ / -4;
                  }
                  else
                  {
                     _loc8_ = _loc10_ / 2;
                  }
               }
               _targetCenter = GRID.FromISO(_homeBunker._position.x + _loc8_,_homeBunker._position.y + _loc9_);
               _targetPosition = new Point(_homeBunker._mc.x,_homeBunker._mc.y);
            }
            _jumpingUp = false;
            if(BASE.isInferno())
            {
               _loc1_ = GRID.ToISO(_targetCenter.x + _loc8_,_targetCenter.y + _loc9_,0);
            }
            else
            {
               _loc1_ = GRID.ToISO(_targetCenter.x,_targetCenter.y,0);
            }
            PATHING.GetPath(_tmpPoint,new Rectangle(_loc1_.x,_loc1_.y,10,10),SetWaypoints,true);
            return;
         }
      }
      
      public function ModeDecoy() : void
      {
         var _loc1_:SiegeWeapon = null;
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
         _loc1_ = SiegeWeapons.activeWeapon;
         if(Boolean(_loc1_) && _loc1_ is Decoy)
         {
            _behaviour = "decoy";
            _hasTarget = false;
            _atTarget = false;
            _hasPath = false;
            _attacking = false;
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
                  _loc9_ = 30 + Math.random() * 10;
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
               _loc9_ = 30 + Math.random() * 10;
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
      
      public function InterceptTarget() : void
      {
         var _loc1_:Number = NaN;
         _intercepting = false;
         _looking = true;
         if(GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < this.DEFENSE_RANGE || this.CanShootCreep())
         {
            _waypoints = [];
            _atTarget = true;
            _looking = false;
         }
         else if(_noDefensePath || GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < this.DEFENSE_RANGE * 3 || _pathing == "direct")
         {
            _waypoints = [_targetCreep._tmpPoint];
            _targetPosition = _targetCreep._tmpPoint;
            _loc1_ = GLOBAL.QuickDistance(_tmpPoint,_targetCreep._tmpPoint);
            if(_pathing == "direct" && !_hasTarget && _loc1_ < 2 * 60)
            {
               _doDefenseBurrow = false;
            }
            else
            {
               _doDefenseBurrow = true;
            }
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
            ModeRetreat();
            return;
         }
         var _loc4_:Boolean = false;
         _targetCreeps = MAP.CreepCellFind(_tmpPoint,25 * 60,1,this);
         if(_targetCreeps.length > 0)
         {
            _targetCreeps.sortOn(["dist"],Array.NUMERIC);
            if(!(_targetCreep && _targetCreep._health.Get() > 0 && _targetCreep._health.Get() < _targetCreep._maxHealth))
            {
               _loc4_ = true;
               while(_targetCreeps.length > 0 && _targetCreeps[0].creep._creatureID == _creatureID)
               {
                  _targetCreeps.shift();
               }
               if(_targetCreeps.length > 0)
               {
                  _targetCreep = _targetCreeps[0].creep;
                  _waypoints = [_targetCreep._tmpPoint];
               }
            }
            while(_targetCreeps.length > 0 && (_targetCreeps[0].creep._behaviour == "retreat" || _targetCreeps[0].creep._creatureID == _creatureID || _targetCreeps[0].creep._health.Get() == _targetCreeps[0].creep._maxHealth))
            {
               _targetCreeps.shift();
            }
         }
         if(_targetCreeps.length > 0)
         {
            _loc4_ = false;
            _targetCreep = _targetCreeps[0].creep;
            _waypoints = [_targetCreep._tmpPoint];
            _targetPosition = _targetCreep._tmpPoint;
            _behaviour = "heal";
         }
         else if(_targetCreep && _targetCreep._health.Get() > 0 && _targetCreep._health.Get() < _targetCreep._maxHealth)
         {
            _loc4_ = false;
            _waypoints = [_targetCreep._tmpPoint];
            _targetPosition = _targetCreep._tmpPoint;
            _behaviour = "heal";
         }
         if(_waypoints.length)
         {
            _hasTarget = true;
            _hasPath = true;
            WaypointTo(_waypoints[0],null);
         }
      }
      
      public function FindDefenseTargets() : void
      {
         var _loc3_:int = 0;
         if(_creatureID == "IC7" || _creatureID == "IC5")
         {
            _loc3_ = 1;
         }
         _targetCreeps = MAP.CreepCellFind(_tmpPoint,200,_loc3_);
         if(_targetCreeps.length > 0)
         {
            _targetCreeps.sortOn(["dist"],Array.NUMERIC);
            while(_targetCreeps.length > 0 && _targetCreeps[0].creep._behaviour == "retreat")
            {
               _targetCreeps.splice(0,1);
            }
            if(_creatureID == "IC5")
            {
               while(_targetCreeps.length > 0 && _targetCreeps[0].creep._creatureID == "C5")
               {
                  _targetCreeps.splice(0,1);
               }
            }
         }
         if(_targetCreeps.length > 0)
         {
            _targetCreep = _targetCreeps[0].creep;
            this.InterceptTarget();
            _behaviour = "defend";
         }
         else if(_targetCreep && _targetCreep._health.Get() > 0)
         {
            if(_noDefensePath || _pathing == "direct")
            {
               this.InterceptTarget();
            }
            _behaviour = "defend";
         }
         else if(_homeBunker && _homeBunker._hp.Get() > 0)
         {
            _targetCreep = _homeBunker.GetTarget(_loc3_);
            if(_targetCreep)
            {
               _atTarget = false;
               _attacking = false;
               _behaviour = "defend";
               this.InterceptTarget();
            }
            else if(_behaviour != "bunker")
            {
               this.ModeBunker();
            }
         }
         else if(_behaviour != "bunker")
         {
            this.ModeBunker();
         }
      }
      
      public function Click(param1:MouseEvent) : void
      {
         if(_waypoints.length > 0)
         {
            PATHING.RenderPath(_waypoints,true);
         }
         if(!_clicked)
         {
            _clicked = true;
         }
         else
         {
            _clicked = false;
         }
      }
      
      public function FlyerDeath() : void
      {
         this._dead = true;
      }
      
      public function FlyerLanded() : void
      {
         _altitude = 0;
      }
      
      public function FlyerTakeOff() : void
      {
         _altitude = 40;
      }
      
      public function CanShootCreep() : Boolean
      {
         if(_creatureID != "IC7")
         {
            return false;
         }
         if(_targetCreep == null)
         {
            return false;
         }
         if(_targetCreep._targetCreep == this)
         {
            return true;
         }
         var _loc1_:Number = GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint);
         if(_loc1_ > 4 * 60 && _targetCreep._targetCreep != this)
         {
            return false;
         }
         if(PATHING.LineOfSight(_tmpPoint.x,_tmpPoint.y,_targetCreep._tmpPoint.x,_targetCreep._tmpPoint.y))
         {
            return true;
         }
         return false;
      }
      
      private function CanShootBuilding() : Boolean
      {
         if(_creatureID != "IC7")
         {
            return false;
         }
         if(_targetBuilding == null)
         {
            return false;
         }
         var _loc1_:Number = GLOBAL.QuickDistance(_targetBuilding._position,_tmpPoint);
         if(_loc1_ > 4 * 60)
         {
            return false;
         }
         if(PATHING.LineOfSight(_tmpPoint.x,_tmpPoint.y,_targetBuilding._position.x,_targetBuilding._position.y,_targetBuilding))
         {
            return true;
         }
         return false;
      }
      
      private function RocketRange() : int
      {
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
         if(_creatureID != "IC8")
         {
            return;
         }
         if(_behaviour == "attack")
         {
            tmpAttDamage = 4;
            if(Boolean(GLOBAL._attackerMonsterOverdrive) && GLOBAL._attackerMonsterOverdrive.Get() >= GLOBAL.Timestamp())
            {
               tmpAttDamage *= 1.25;
            }
            ATTACK.Damage(_tmpPoint.x,_tmpPoint.y - 5,_damage.Get() * tmpAttDamage,_mc.visible);
            try
            {
               tmpPointA = PATHING.FromISO(_tmpPoint).add(new Point(-5,-5));
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
                        building.Damage(int(_damage.Get() * tmpAttDamage * ((100 - dist) / 100)),_tmpPoint.x,_tmpPoint.y,_targetGroup,false);
                        building.Update(true);
                     }
                  }
               }
               if(_targetCreep && GLOBAL.QuickDistance(_tmpPoint,_targetCreep._tmpPoint) < 90 && _targetCreep._movement != "fly")
               {
                  _targetCreep._health.Add(-(_damage.Get() * tmpAttDamage * _targetCreep._damageMult));
               }
               for each(creep in CREATURES._creatures)
               {
                  if((creep._behaviour == "defend" || creep._behaviour == "bunker") && creep != _targetCreep && creep._movement != "fly")
                  {
                     dist = GLOBAL.QuickDistance(creep._tmpPoint,_tmpPoint);
                     if(dist < 60)
                     {
                        creep._health.Add(-int(_damage.Get() * tmpAttDamage * _targetCreep._damageMult * ((50 - dist) / 50)));
                     }
                  }
               }
               if(CREATURES._guardian._behaviour == "defend" && CREATURES._guardian != _targetCreep && CREATURES._guardian._movement != "fly")
               {
                  distGuard = GLOBAL.QuickDistance(creep._tmpPoint,_tmpPoint);
                  if(distGuard < 60)
                  {
                     creep._health.Add(-int(_damage.Get() * tmpAttDamage * _targetCreep._damageMult * ((60 - distGuard) / 60)));
                  }
               }
               _targetBuilding.Update(true);
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
            ATTACK.Damage(_tmpPoint.x,_tmpPoint.y - 5,_damage.Get() * tmpDefDamage,_mc.visible);
            try
            {
               _targetCreeps = MAP.CreepCellFind(_tmpPoint,60,-1);
               i = 0;
               while(i < _targetCreeps.length)
               {
                  creep = _targetCreeps[i].creep;
                  if(i == 0)
                  {
                     tmpDamage = tmpDefDamage;
                  }
                  else
                  {
                     tmpDamage = int(tmpDefDamage * ((60 - _targetCreeps[i].dist) / 60));
                  }
                  creep._health.Add(-(_damage.Get() * tmpDamage * creep._damageMult));
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
         if(_health.Get() <= 0)
         {
            MAP.CreepCellDelete(_id,node);
            if(_movement == "fly")
            {
               if(!this._dying)
               {
                  this._dying = true;
                  TweenLite.to(_graphicMC,0.4,{
                     "y":_graphicMC.y + _altitude,
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
         if(_atTarget)
         {
            if(_behaviour == "juice")
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
               GLOBAL._bJuicer.Blend(Math.ceil(_goo / 400),_creatureID);
            }
            if(_behaviour == "feed")
            {
               GIBLETS.Create(_tmpPoint,0.8,100,_goo / 400,36);
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
         if(_health.Get() <= 0)
         {
            MAP.CreepCellDelete(_id,node);
            if(_movement == "fly")
            {
               if(!this._dying)
               {
                  this._dying = true;
                  TweenLite.to(_graphicMC,0.4,{
                     "y":_graphicMC.y + _altitude,
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
            if(_creatureID == "C12")
            {
               SOUNDS.Play("monsterlanddave");
            }
            else
            {
               SOUNDS.Play("monsterland" + (1 + int(Math.random() * 3)));
            }
            return true;
         }
         if(_hasTarget)
         {
            if(!_targetCreep || _targetCreep._health.Get() <= 0 || _targetCreep._health.Get() == _targetCreep._maxHealth && _frameNumber % 100 == 0)
            {
               _hasTarget = false;
               _attacking = false;
               _atTarget = false;
               _hasPath = false;
               if(_targetCreep && _targetCreep._health.Get() <= 0)
               {
                  _targetCreep = null;
               }
               this.FindHealingTargets();
            }
            else if(!_attacking && _frameNumber % 120 == 0)
            {
               this.FindHealingTargets();
            }
            else if(GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < this.HEALING_RANGE)
            {
               _atTarget = true;
            }
            else if(_attacking && GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) > this.HEALING_RANGE * 1.25)
            {
               _attacking = false;
               _atTarget = false;
               _waypoints = [_targetCreep._tmpPoint];
            }
         }
         else
         {
            _attacking = false;
            _atTarget = false;
            _hasPath = false;
            this.FindHealingTargets();
         }
         if(_atTarget)
         {
            if(attackCooldown <= 0)
            {
               attackCooldown += int(_attackDelay / _speedMult);
               if(_targetCreep._health.Get() > 0 && _targetCreep._health.Get() < _targetCreep._maxHealth)
               {
                  _attacking = true;
                  FIREBALLS.Spawn2(new Point(_tmpPoint.x,_tmpPoint.y - _altitude),_targetCreep._tmpPoint,_targetCreep,25,_damage.Get() * _loc1_,50);
                  SOUNDS.Play("ihit" + int(1 + Math.random() * 7),0.1 + Math.random() * 0.1);
               }
               else
               {
                  _attacking = false;
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
         return false;
      }
      
      public function TickBAttack() : Boolean
      {
         var _loc2_:String = null;
         var _loc1_:Number = 1;
         if(Boolean(GLOBAL._attackerMonsterOverdrive) && GLOBAL._attackerMonsterOverdrive.Get() >= GLOBAL.Timestamp())
         {
            _loc1_ *= 1.25;
         }
         if(_health.Get() <= 0)
         {
            MAP.CreepCellDelete(_id,node);
            if(_movement == "fly" || _movement == "fly_low")
            {
               if(!this._dying)
               {
                  this._dying = true;
                  TweenLite.to(_graphicMC,0.4,{
                     "y":_graphicMC.y + _altitude,
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
         if(_hasTarget)
         {
            if(!_targetCreep)
            {
               if(_behaviour == "hunt" && (CREATURES._creatureCount > 0 || CREATURES._guardian && CREATURES._guardian._health.Get() > 0) && _frameNumber % 150 == 0)
               {
                  FindTarget(_targetGroup);
               }
               else if(_targetBuilding == null || _targetBuilding._hp.Get() <= 0 || _targetGroup == 3 && _targetBuilding._looted || _targetBuilding._class == "tower" && !MONSTERBUNKER.isBunkerBuilding(_targetBuilding._type) && (_targetBuilding as BTOWER).isJard)
               {
                  _hasTarget = false;
                  _attacking = false;
                  _atTarget = false;
                  _invisibleCooldown = 80;
                  FindTarget(_targetGroup);
               }
            }
            else
            {
               if(_targetCreep._health.Get() <= 0)
               {
                  _hasTarget = false;
                  _attacking = false;
                  _atTarget = false;
                  _targetCreep = null;
                  _invisibleCooldown = 80;
                  FindTarget(_targetGroup);
               }
               if(_targetCreep && GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < 50)
               {
                  _atTarget = true;
               }
               else if(_targetCreep)
               {
                  _waypoints = [_targetCreep._tmpPoint];
               }
            }
         }
         if(!_looking && _frameNumber % (GLOBAL._catchup ? 5 * 60 : 150) == 0 && !_attacking)
         {
            FindTarget(_targetGroup,true);
         }
         if(_atTarget)
         {
            _attacking = true;
            if(_movement == "fly" && (!_targetCreep || _targetCreep._movement != "fly"))
            {
               _movement = "fly_low";
            }
            if(attackCooldown <= 0)
            {
               attackCooldown += int(_attackDelay / _speedMult);
               if(_targetCreep)
               {
                  if(_behaviour == "hunt")
                  {
                     _loc1_ *= 3;
                  }
                  if(_creatureID != "IC7")
                  {
                     ATTACK.Damage(_tmpPoint.x,_tmpPoint.y - 5 - (_movement == "fly" || _movement == "fly_low" ? _altitude : 0),_damage.Get() * _loc1_ * _targetCreep._damageMult,_mc.visible);
                  }
               }
               else
               {
                  if(_targetGroup == 2 && _targetBuilding._class == "wall")
                  {
                     _loc1_ *= 2;
                  }
                  if(_targetGroup == 4 && _targetBuilding._class == "tower")
                  {
                     _loc1_ *= 2;
                  }
                  if(_creatureID != "IC7")
                  {
                     if(_targetBuilding._fortification.Get() > 0)
                     {
                        ATTACK.Damage(_tmpPoint.x,_tmpPoint.y - 5 - (_movement == "fly" || _movement == "fly_low" ? _altitude : 0),_damage.Get() * _loc1_ * (100 - (_targetBuilding._fortification.Get() * 10 + 10)) / 100,_mc.visible);
                     }
                     else
                     {
                        ATTACK.Damage(_tmpPoint.x,_tmpPoint.y - 5 - (_movement == "fly" || _movement == "fly_low" ? _altitude : 0),_damage.Get() * _loc1_,_mc.visible);
                     }
                  }
               }
               if(_targetCreep)
               {
                  if(_creatureID == "IC7")
                  {
                     FIREBALLS.Spawn2(_tmpPoint,_targetCreep._tmpPoint,_targetCreep,10,_damage.Get() * _loc1_);
                  }
                  else
                  {
                     _targetCreep._health.Add(-(_damage.Get() * _targetCreep._damageMult));
                     if(!_targetCreep._targetCreep || !_targetCreep._atTarget)
                     {
                        _targetCreep._targetCreep = this;
                        _targetCreep._hasTarget = true;
                        _targetCreep._atTarget = true;
                        if(_targetCreep._behaviour != "defend")
                        {
                           _targetCreep._behaviour = "defend";
                        }
                     }
                  }
                  if(_behaviour == "hunt")
                  {
                     _targetCreep._venom.Add(_damage.Get() * 0.1 * 0.025 * _loc1_);
                  }
               }
               else if(_creatureID == "IC7")
               {
                  FIREBALLS.Spawn(_tmpPoint,_targetBuilding._position,_targetBuilding,10,_damage.Get() * _loc1_);
               }
               else
               {
                  _targetBuilding.Damage(_damage.Get() * _loc1_,_tmpPoint.x,_tmpPoint.y,_targetGroup);
               }
               if(!_targetCreep)
               {
                  ++_hits;
               }
               if(_hits > 20 && _goeasy)
               {
                  ModeRetreat();
                  return false;
               }
               if(!_goeasy && GLOBAL._mode == "build" && _hits > _hitLimit)
               {
                  return true;
               }
               _loc2_ = "ihit" + int(1 + Math.random() * 7);
               SOUNDS.Play(_loc2_,0.1 + Math.random() * 0.1);
            }
            else
            {
               --attackCooldown;
            }
         }
         else
         {
            _attacking = false;
            if(_movement == "fly_low")
            {
               _movement = "fly";
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
         if(_creatureID == "IC5")
         {
            _loc1_ *= 3;
         }
         if(_health.Get() <= 0)
         {
            SOUNDS.Play("monsterland" + (1 + int(Math.random() * 3)));
            if(_homeBunker)
            {
               if(Boolean(_homeBunker._monsters) && !this._defenderRemoved)
               {
                  if(BASE.isInferno())
                  {
                     _homeBunker.RemoveCreature(_creatureID);
                     this._defenderRemoved = true;
                     _behaviour = "pen";
                     return false;
                  }
                  --_homeBunker._monsters[_creatureID];
                  if(_homeBunker._monsters[_creatureID] < 0)
                  {
                     _homeBunker._monsters[_creatureID] = 0;
                  }
                  --_homeBunker._monstersDispatched[_creatureID];
                  if(_homeBunker._monstersDispatched[_creatureID] < 0)
                  {
                     _homeBunker._monstersDispatched[_creatureID] = 0;
                  }
                  --_homeBunker._monstersDispatchedTotal;
                  if(_homeBunker._monstersDispatchedTotal < 0)
                  {
                     _homeBunker._monstersDispatchedTotal = 0;
                  }
               }
            }
            return true;
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
            else if(GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < this.DEFENSE_RANGE || this.CanShootCreep())
            {
               _waypoints = [];
               _atTarget = true;
               SOUNDS.Play("imonster" + int(1 + Math.random() * 4));
            }
            else if(!_attacking && _frameNumber % 150 == 0)
            {
               this.FindDefenseTargets();
            }
            else if(_attacking && GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) > this.DEFENSE_RANGE * 2 && !this.CanShootCreep())
            {
               _attacking = false;
               _atTarget = false;
               _hasPath = false;
               this.FindDefenseTargets();
            }
         }
         if(_atTarget)
         {
            _targetPosition = _targetCreep._tmpPoint;
            _attacking = true;
            _intercepting = false;
            if(_targetCreep._behaviour != "heal" && _invisibleTime == 0 && !_targetCreep._explode && !_explode)
            {
               _waypoints = [];
               _targetCreep._targetCreep = this;
               if(_targetCreep.CanShootCreep() || GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < 50 || _targetCreep._movement == "fly")
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
               _targetCreep._hasPath = true;
            }
            if(attackCooldown <= 0)
            {
               attackCooldown += int(_attackDelay / _speedMult);
               if(_creatureID == "IC7")
               {
                  FIREBALLS.Spawn2(_tmpPoint,_targetCreep._tmpPoint,_targetCreep,10,_damage.Get() * _loc1_);
               }
               else
               {
                  ATTACK.Damage(_tmpPoint.x,_tmpPoint.y - 5 - (_movement == "fly" ? _altitude : 0),_damage.Get() * _loc1_ * _targetCreep._damageMult,_mc.visible);
                  _targetCreep._health.Add(-(_damage.Get() * _loc1_ * _targetCreep._damageMult));
               }
               if(!_explode)
               {
                  if(!_targetCreep._explode && !_targetCreep._targetCreep && _targetCreep._behaviour != "heal")
                  {
                     _waypoints = [];
                     _targetCreep._targetCreep = this;
                     if(Boolean(_targetCreep.CanShootCreep()) || GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < 50)
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
                     _targetCreep._hasPath = true;
                     _targetCreep._hasTarget = true;
                  }
                  if(_invisibleTime == 0)
                  {
                     _loc2_ = MAP.CreepCellFind(_tmpPoint,50);
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
               --attackCooldown;
            }
         }
         else
         {
            _attacking = false;
         }
         return false;
      }
      
      public function TickBDecoy() : Boolean
      {
         if(_health.Get() <= 0)
         {
            if(_homeBunker)
            {
               if(Boolean(_homeBunker._monsters) && !this._defenderRemoved)
               {
                  --_homeBunker._monsters[_creatureID];
                  if(_homeBunker._monsters[_creatureID] < 0)
                  {
                     _homeBunker._monsters[_creatureID] = 0;
                  }
                  --_homeBunker._monstersDispatched[_creatureID];
                  if(_homeBunker._monstersDispatched[_creatureID] < 0)
                  {
                     _homeBunker._monstersDispatched[_creatureID] = 0;
                  }
                  --_homeBunker._monstersDispatchedTotal;
                  if(_homeBunker._monstersDispatchedTotal < 0)
                  {
                     _homeBunker._monstersDispatchedTotal = 0;
                  }
                  this._defenderRemoved = true;
               }
            }
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
      
      public function TickBBunker() : Boolean
      {
         if(_health.Get() <= 0)
         {
            if(_homeBunker)
            {
               if(Boolean(_homeBunker._monsters) && !this._defenderRemoved)
               {
                  --_homeBunker._monsters[_creatureID];
                  if(_homeBunker._monsters[_creatureID] < 0)
                  {
                     _homeBunker._monsters[_creatureID] = 0;
                  }
                  --_homeBunker._monstersDispatched[_creatureID];
                  if(_homeBunker._monstersDispatched[_creatureID] < 0)
                  {
                     _homeBunker._monstersDispatched[_creatureID] = 0;
                  }
                  --_homeBunker._monstersDispatchedTotal;
                  if(_homeBunker._monstersDispatchedTotal < 0)
                  {
                     _homeBunker._monstersDispatchedTotal = 0;
                  }
                  this._defenderRemoved = true;
               }
            }
            return true;
         }
         if(_frameNumber % 200)
         {
            this.FindDefenseTargets();
         }
         if(_atTarget && _behaviour == "bunker")
         {
            if(_homeBunker)
            {
               try
               {
                  --_homeBunker._monstersDispatched[_creatureID];
                  if(_homeBunker._monstersDispatched[_creatureID] < 0)
                  {
                     _homeBunker._monstersDispatched[_creatureID] = 0;
                  }
                  --_homeBunker._monstersDispatchedTotal;
                  if(_homeBunker._monstersDispatchedTotal < 0)
                  {
                     _homeBunker._monstersDispatchedTotal = 0;
                  }
                  if(!BASE.isInferno())
                  {
                     return true;
                  }
               }
               catch(error:Error)
               {
               }
            }
         }
         return false;
      }
      
      override public function Tick(param1:int = 1) : Boolean
      {
         var _loc3_:Number = NaN;
         if(param1 != 1)
         {
            throw new Error("CREEP_INFERNO timePassed must always be 1");
         }
         super.Tick(param1);
         _frameNumber += 1;
         if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
         {
            if(_frameNumber % 30 == 0)
            {
               if(this._secureSpeedMult.Get() != int(_speedMult * 100))
               {
                  LOGGER.Log("hak","Regular monster speed buff incorrect");
                  GLOBAL.ErrorMessage("CREEP_INFERNO hack 4");
                  return false;
               }
               if(this._secureDamageMult.Get() != int(_damageMult * 100))
               {
                  LOGGER.Log("hak","Regular monster damage buff incorrect");
                  GLOBAL.ErrorMessage("CREEP_INFERNO hack 5");
                  return false;
               }
            }
         }
         if(_movement == "fly" && _health.Get() > 0 && _behaviour != "pen")
         {
            if(_behaviour != "juice" && _behaviour != "feed" || _altitude >= 35)
            {
               _loc3_ = Math.sin(_frameNumber / 50) * 5;
               _altitude = 40 - _loc3_;
               _graphicMC.y = -_altitude - 36 + _loc3_;
            }
         }
         if(_homeBunker && (_behaviour != "defend" && _behaviour != "bunker" && _behaviour != "juice" && _behaviour != "pen" && _behaviour != "decoy"))
         {
            _behaviour = "defend";
         }
         if((GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack") && _damage.Get() > int(CREATURES.GetProperty(_creatureID,"damage",0,_friendly)))
         {
            LOGGER.Log("log","Creep damage altered");
            GLOBAL.ErrorMessage("Creep damage altered");
            return false;
         }
         if(_venom.Get() > 0)
         {
            _health.Add(-(_venom.Get() * _damageMult));
         }
         switch(_behaviour)
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
               if(_frameNumber > 8 * 60 && !_targetCenter)
               {
                  _targetPosition = new Point(Math.random() * 200,Math.random() * 150);
               }
               break;
            case "defend":
               if(this.TickBDefend())
               {
                  return true;
               }
               break;
            case "housing":
               if(_health.Get() <= 0)
               {
                  return true;
               }
               if(_atTarget)
               {
                  _behaviour = "pen";
                  if(_movement == "fly")
                  {
                     TweenLite.to(_graphicMC,1.2,{
                        "y":_graphicMC.y + _altitude,
                        "ease":Sine.easeOut,
                        "onComplete":this.FlyerLanded
                     });
                  }
                  _waypoints[0] = HOUSING.PointInHouse(_targetCenter);
               }
               break;
            case "bunker":
               if(this.TickBBunker())
               {
                  return true;
               }
               break;
            case "pen":
               if(_health.Get() <= 0)
               {
                  return true;
               }
               if(_frameNumber > 4 * 60 && int(Math.random() * 200) == 1 && GLOBAL._fps > 25)
               {
                  _targetPosition = HOUSING.PointInHouse(_targetCenter);
                  _hasPath = true;
               }
               break;
         }
         if((_behaviour == "attack" || _behaviour == "retreat" || _behaviour == "heal" || _behaviour == "hunt") && _frameNumber % 5 == 0)
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
         if(_enraged == 0 && filters.length > 0)
         {
            this.UpdateBuffs();
         }
         this.Move();
         this.Render();
         return false;
      }
      
      public function Move() : void
      {
         var growled:Boolean = false;
         var targetDistance:Number = NaN;
         var building:BFOUNDATION = null;
         growled = false;
         _speed = _maxSpeed * 0.5 * _speedMult;
         if(_behaviour == "pen")
         {
            _speed *= 0.5;
         }
         if(_behaviour == "juice" || _behaviour == "housing" || _behaviour == "bunker")
         {
            _speed *= 1.5;
         }
         if(_behaviour == "defend")
         {
            _speed *= 1.5;
         }
         if(_behaviour == "juice" && _movement == "fly" && _altitude < 25)
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
         if(_creatureID == "IC7" && _behaviour != "juice" && _behaviour != "housing" && _behaviour != "bunker" && _behaviour != "pen" && !_atTarget && (_targetCreep && this.CanShootCreep() || this.CanShootBuilding()))
         {
            _atTarget = true;
            SOUNDS.Play("imonster" + int(1 + Math.random() * 4));
            if(_targetCreep)
            {
               _xd = _targetCreep._tmpPoint.x - _tmpPoint.x;
               _yd = _targetCreep._tmpPoint.y - _tmpPoint.y;
               _targetPosition = _targetCreep._tmpPoint;
            }
            else
            {
               _xd = _targetBuilding._position.x - _tmpPoint.x;
               _yd = _targetBuilding._position.y - _tmpPoint.y;
               _targetPosition = _targetBuilding._position;
            }
         }
         else if(_waypoints.length > 0)
         {
            if(GLOBAL.QuickDistance(_targetPosition,_tmpPoint) <= 10)
            {
               while(_waypoints.length > 0 && GLOBAL.QuickDistance(_targetPosition,_tmpPoint) <= 10)
               {
                  _waypoints.splice(0,1);
                  if(_waypoints[0])
                  {
                     _targetPosition = _waypoints[0];
                     if(_movement == "jump" && !_jumping)
                     {
                        building = PATHING.GetBuildingFromISO(_targetPosition);
                        if(building)
                        {
                           if(building._hp.Get() > 0)
                           {
                              TweenLite.to(_graphicMC,0.4,{
                                 "y":_graphicMC.y - 60,
                                 "ease":Sine.easeOut,
                                 "overwrite":false,
                                 "onComplete":function():*
                                 {
                                    _jumpingUp = false;
                                 }
                              });
                              TweenLite.to(_graphicMC,0.4,{
                                 "y":_graphicMC.y,
                                 "ease":Bounce.easeOut,
                                 "overwrite":false,
                                 "delay":0.4,
                                 "onComplete":function():*
                                 {
                                    _jumping = false;
                                 }
                              });
                              _jumping = true;
                              _jumpingUp = true;
                           }
                        }
                     }
                  }
                  else if(_behaviour == "defend")
                  {
                     if(_targetCreep)
                     {
                        targetDistance = GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint);
                        if(targetDistance < this.DEFENSE_RANGE || this.CanShootCreep())
                        {
                           _waypoints = [];
                           _atTarget = true;
                           if(!growled)
                           {
                              growled = true;
                              SOUNDS.Play("imonster" + int(1 + Math.random() * 4));
                           }
                           _targetCreep._targetCreep = this;
                           if(Boolean(_targetCreep.CanShootCreep()) || GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < 50)
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
                           return;
                        }
                     }
                  }
                  else
                  {
                     if(_behaviour != "heal")
                     {
                        if(_targetCreep)
                        {
                           if(this.CanShootCreep() || GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < 50 || _creatureID == "C14")
                           {
                              _atTarget = true;
                           }
                           else
                           {
                              _atTarget = false;
                              _waypoints = [_targetCreep._tmpPoint];
                           }
                        }
                        else
                        {
                           _atTarget = true;
                        }
                        if(_atTarget && !growled)
                        {
                           growled = true;
                           SOUNDS.Play("imonster" + int(1 + Math.random() * 4));
                        }
                        return;
                     }
                     if(_targetCreep && GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < this.HEALING_RANGE)
                     {
                        _atTarget = true;
                        return;
                     }
                  }
               }
               if(_behaviour == "defend")
               {
                  if(_targetCreep && (GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < this.DEFENSE_RANGE || this.CanShootCreep()))
                  {
                     _atTarget = true;
                     if(!growled)
                     {
                        growled = true;
                        SOUNDS.Play("imonster" + int(1 + Math.random() * 4));
                     }
                     _waypoints = [];
                     if(!_targetCreep._explode)
                     {
                        _targetCreep._targetCreep = this;
                        if(Boolean(_targetCreep.CanShootCreep()) || GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < 50)
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
                     _targetPosition = _targetCreep._tmpPoint;
                     return;
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
               else if(_behaviour == "heal")
               {
                  if(_targetCreep && GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < this.HEALING_RANGE)
                  {
                     _atTarget = true;
                     return;
                  }
                  if(_targetCreep && _waypoints.length == 0 && _hasPath)
                  {
                     _waypoints = [_targetCreep._tmpPoint];
                     WaypointTo(_targetCreep._tmpPoint,null);
                  }
               }
               else if(_waypoints.length == 0 && _hasPath && _targetCreep)
               {
                  if(this.CanShootCreep() || GLOBAL.QuickDistance(_targetCreep._tmpPoint,_tmpPoint) < 50 || _creatureID == "C14")
                  {
                     _atTarget = true;
                  }
                  else
                  {
                     _atTarget = false;
                     _waypoints = [_targetCreep._tmpPoint];
                  }
                  if(_atTarget && !growled)
                  {
                     growled = true;
                     SOUNDS.Play("imonster" + int(1 + Math.random() * 4));
                  }
                  return;
               }
            }
            if(_waypoints.length > 0 && !_atTarget)
            {
               _targetPosition = _waypoints[0];
            }
            if(_behaviour == "attack" && _targetCreep)
            {
               _xd = _targetCreep._tmpPoint.x - _tmpPoint.x;
               _yd = _targetCreep._tmpPoint.y - _tmpPoint.y;
            }
            else if(_behaviour == "defend" || _behaviour == "heal")
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
      
      public function Render() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
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
            if(_movement == "burrow" && (_behaviour == "attack" || _behaviour == "defend"))
            {
               if(_speed > 0 && (_behaviour == "attack" || _doDefenseBurrow))
               {
                  if(_phase != 1)
                  {
                     _phase = 1;
                     if(alpha)
                     {
                        alpha = 0;
                     }
                     _visible = false;
                     EFFECTS.Dig(x,y);
                     SOUNDS.Play("dig",0.5);
                  }
                  else if(_frameNumber % 5 == 0)
                  {
                     EFFECTS.Burrow(x,y);
                  }
               }
               else if(_phase == 1)
               {
                  _phase = 0;
                  this.Jump();
                  if(!alpha)
                  {
                     alpha = 1;
                  }
                  _visible = true;
                  if(_behaviour == "attack" || _doDefenseBurrow)
                  {
                     EFFECTS.Dig(x,y);
                     if(_creatureID == "IC8")
                     {
                        this.WormzerBlast();
                     }
                  }
                  SOUNDS.Play("arise",0.5);
               }
            }
            else
            {
               _visible = true;
               if(!alpha)
               {
                  alpha = 1;
               }
            }
            if(_movement == "fly" || _movement == "fly_low")
            {
               SPRITES.GetSprite(_shadow,"shadow","shadow",0);
            }
            this._lastFrame = SPRITES.GetSprite(_graphic,_creatureID,"walking",mcMarker.rotation,_frameNumber,this._lastFrame);
            _lastRotation = int(mcMarker.rotation / 12);
            if(_health.Get() < _maxHealth)
            {
               _loc5_ = 11 - int(11 / _maxHealth * _health.Get());
               _graphic.copyPixels(CREEPS._bmdHPbar,new Rectangle(0,5 * _loc5_,17,5),new Point(17,6));
            }
            _graphic.unlock();
            if(_shadow)
            {
               _shadow.unlock();
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
         TweenLite.to(_graphicMC,0.3,{
            "y":_graphicMC.y - 15,
            "ease":Sine.easeIn,
            "onComplete":Land
         });
      }
   }
}

