package
{
   import com.monsters.configs.BYMConfig;
   import com.monsters.events.CreepEvent;
   import com.monsters.monsters.MonsterBase;
   import com.monsters.monsters.champions.ChampionBase;
   import com.monsters.monsters.champions.KOTHChampion;
   import com.monsters.monsters.creeps.CREEP;
   import com.monsters.monsters.creeps.CREEP_INFERNO;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class CREEPS
   {
      public static var _creeps:Object;
      
      public static var _creepID:int;
      
      public static var _creepCount:int;
      
      public static var _flungCount:int;
      
      public static var _ticks:int;
      
      private static var _creepOverlap:Object;
      
      public static var _bmdHPbar:BitmapData = new bmp_healthbarsmall(0,0);
      
      public static var _flungGuardian:Vector.<Boolean> = new Vector.<Boolean>();
      
      public static var _guardianList:Vector.<ChampionBase> = new Vector.<ChampionBase>();
      
      public function CREEPS()
      {
         super();
         _creeps = {};
         _creepID = 0;
         _flungCount = 0;
         _creepCount = 0;
         _ticks = 0;
         _creepOverlap = {};
         _flungGuardian = new Vector.<Boolean>(GLOBAL._playerGuardianData.length);
         _guardianList.length = 0;
      }
      
      public static function get krallen() : KOTHChampion
      {
         var _loc2_:ChampionBase = null;
         var _loc1_:Vector.<ChampionBase> = CREEPS._guardianList;
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_._creatureID === "G5")
            {
               return _loc2_ as KOTHChampion;
            }
         }
         return null;
      }
      
      public static function Tick() : void
      {
         var _loc2_:* = undefined;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc1_:int = getTimer();
         var _loc4_:int = 0;
         _creepOverlap = {};
         for(_loc3_ in _creeps)
         {
            _loc2_ = _creeps[_loc3_];
            _loc5_ = _loc2_._creatureID + "x" + int(_loc2_._tmpPoint.x * 0.5) + "y" + int(_loc2_._tmpPoint.y * 0.5);
            if(!_creepOverlap[_loc5_])
            {
               _creepOverlap[_loc5_] = 1;
               if(!_loc2_._mc.visible)
               {
                  _loc2_._mc.visible = true;
               }
            }
            else
            {
               _creepOverlap[_loc5_] += 1;
               if(_creepOverlap[_loc5_] > 1)
               {
                  if(_loc2_._mc.visible)
                  {
                     _loc2_._mc.visible = false;
                  }
               }
               else if(!_loc2_._mc.visible)
               {
                  _loc2_._mc.visible = true;
               }
            }
            if(_loc2_._mc.visible)
            {
               _loc4_ += 1;
            }
            if(_loc2_.Tick(1))
            {
               if(_loc2_._health.Get() <= 0)
               {
                  if(_loc2_._creatureID.substr(0,1) != "G")
                  {
                     SOUNDS.Play("splat" + (int(Math.random() * 3) + 1));
                     EFFECTS.CreepSplat(_loc2_._creatureID,_loc2_._tmpPoint.x,_loc2_._tmpPoint.y);
                  }
               }
               _loc2_.Clear();
               if(!BYMConfig.instance.RENDERER_ON)
               {
                  MAP._BUILDINGTOPS.removeChild(_loc2_);
               }
               --_creepCount;
               if(_loc2_._creatureID.substr(0,1) == "G" || (GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack") && !_loc2_.isDisposable)
               {
                  --_flungCount;
                  ATTACK._creaturesFlung.Add(-1);
               }
               delete _creeps[_loc3_];
            }
         }
         if(_creepCount <= 0)
         {
            _flungCount = _creepCount = 0;
         }
         if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
         {
            if(ATTACK._creaturesFlung.Get() < _flungCount && ATTACK._creaturesFlung.Get() > 0)
            {
               LOGGER.Log("log","More creeps than flung creatures");
               GLOBAL.ErrorMessage();
            }
         }
      }
      
      public static function Spawn(param1:String, param2:*, param3:String, param4:Point, param5:Number, param6:Number = 1, param7:Boolean = false, param8:Boolean = false) : MonsterBase
      {
         var _loc9_:MonsterBase = null;
         ++_creepID;
         if(!param8)
         {
            ++_flungCount;
         }
         ++_creepCount;
         if(param1.substr(0,1) == "I")
         {
            if(!BYMConfig.instance.RENDERER_ON)
            {
               _loc9_ = param2.addChild(new CREEP_INFERNO(param1,param3,param4,param5,null,false,null,param6,param7));
            }
            else
            {
               _loc9_ = new CREEP_INFERNO(param1,param3,param4,param5,null,false,null,param6,param7);
            }
         }
         else if(!BYMConfig.instance.RENDERER_ON)
         {
            _loc9_ = param2.addChild(new CREEP(param1,param3,param4,param5,null,false,null,param6,param7));
         }
         else
         {
            _loc9_ = new CREEP(param1,param3,param4,param5,null,false,null,param6,param7);
         }
         _loc9_.isDisposable = param8;
         _creeps[_creepID] = _loc9_;
         GLOBAL.eventDispatcher.dispatchEvent(new CreepEvent(CreepEvent.ATTACKING_CREEP_SPAWNED,_loc9_));
         return _loc9_;
      }
      
      public static function SpawnGuardian(param1:int, param2:*, param3:String, param4:int, param5:Point, param6:Number, param7:int = 20000, param8:int = 0, param9:int = 0, param10:Boolean = false) : ChampionBase
      {
         var _loc13_:int = 0;
         var _loc11_:Class = CHAMPIONCAGE.getGuardianSpawnClass(param1);
         ++_creepID;
         ++_creepCount;
         ++_flungCount;
         var _loc12_:ChampionBase = null;
         if(param10)
         {
            _loc12_ = new _loc11_(param3,param5,0,null,false,null,param4,0,0,param1,param7,param8,param9);
         }
         else
         {
            _loc13_ = GLOBAL.getPlayerGuardianIndex(param1);
            _loc12_ = new _loc11_(param3,param5,0,null,false,null,param4,GLOBAL._playerGuardianData[_loc13_].fd,GLOBAL._playerGuardianData[_loc13_].ft,param1,param7,param8,param9);
            if(_loc11_ == ChampionBase)
            {
               _guardian = _loc12_;
            }
            else if(!addGuardian(_loc12_))
            {
               _loc12_ = null;
            }
         }
         if(_loc12_)
         {
            _creeps[_creepID] = _loc12_;
            if(!BYMConfig.instance.RENDERER_ON)
            {
               param2.addChild(_loc12_);
            }
         }
         return _loc12_;
      }
      
      public static function Retreat() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in _creeps)
         {
            _loc1_.ModeRetreat();
         }
      }
      
      public static function CreepOverlap(param1:Point, param2:int) : Boolean
      {
         var _loc3_:* = undefined;
         var _loc4_:Object = null;
         var _loc5_:Point = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:int = 0;
         for each(_loc3_ in _creeps)
         {
            if(_loc3_._creatureID.substr(0,1) == "G")
            {
               _loc4_ = SPRITES._sprites[_loc3_._spriteID];
            }
            else
            {
               _loc4_ = SPRITES._sprites[_loc3_._creatureID];
            }
            _loc5_ = new Point(_loc3_.x + _loc4_.middle.x,_loc3_.y + _loc4_.middle.y);
            _loc6_ = Math.atan2(param1.y - _loc5_.y,param1.x - _loc5_.x);
            _loc7_ = BASE.EllipseEdgeDistance(_loc6_,param2,param2 * BASE._angle);
            _loc6_ = Math.atan2(_loc5_.y - param1.y,_loc5_.x - param1.x);
            _loc8_ = BASE.EllipseEdgeDistance(_loc6_,_loc4_.width * 0.5,_loc4_.width * 0.5 * BASE._angle);
            _loc9_ = param1.x - _loc5_.x;
            _loc10_ = param1.y - _loc5_.y;
            _loc11_ = int(Math.sqrt(_loc9_ * _loc9_ + _loc10_ * _loc10_));
            if(_loc11_ < _loc7_ + _loc8_)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function Clear() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         for(_loc2_ in _creeps)
         {
            _loc1_ = _creeps[_loc2_];
            _loc1_.Clear();
            if(!BYMConfig.instance.RENDERER_ON)
            {
               MAP._BUILDINGTOPS.removeChild(_loc1_);
            }
         }
         _creeps = {};
         _creepCount = _flungCount = 0;
         _loc3_ = 0;
         while(_loc3_ < _flungGuardian.length)
         {
            _flungGuardian[_loc3_] = false;
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _guardianList.length)
         {
            _guardianList[_loc3_] = null;
            _loc3_++;
         }
         _guardianList.length = 0;
      }
      
      public static function get _guardian() : ChampionBase
      {
         var _loc1_:int = 0;
         while(_loc1_ < _guardianList.length)
         {
            if(Boolean(_guardianList[_loc1_]) && CHAMPIONCAGE.isBasicGuardian(_guardianList[_loc1_]._creatureID))
            {
               return _guardianList[_loc1_];
            }
            _loc1_++;
         }
         return null;
      }
      
      public static function set _guardian(param1:ChampionBase) : void
      {
         var _loc2_:int = -1;
         var _loc3_:int = 0;
         while(_loc3_ < _guardianList.length)
         {
            if(CHAMPIONCAGE.isBasicGuardian(_guardianList[_loc3_]._creatureID))
            {
               _loc2_ = _loc3_;
            }
            _loc3_++;
         }
         if(_loc2_ == -1)
         {
            if(param1)
            {
               _guardianList.unshift(param1);
            }
         }
         else if(!param1)
         {
            _guardianList.splice(_loc2_,1);
         }
         else
         {
            _guardianList[_loc2_] = param1;
         }
      }
      
      public static function addGuardian(param1:ChampionBase) : Boolean
      {
         var _loc2_:int = -1;
         var _loc3_:int = 0;
         while(_loc3_ < _guardianList.length)
         {
            if(_guardianList[_loc3_]._creatureID == param1._creatureID)
            {
               _loc2_ = _loc3_;
            }
            _loc3_++;
         }
         if(_loc2_ == -1)
         {
            if(param1)
            {
               _guardianList.push(param1);
               return true;
            }
         }
         return false;
      }
      
      public static function getGuardianIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < _guardianList.length)
         {
            if(int(_guardianList[_loc2_]._creatureID.substr(1)) == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
   }
}

