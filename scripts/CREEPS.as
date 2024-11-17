package
{
   import com.monsters.champions.KOTHChampion;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class CREEPS
   {
      public static var _creeps:Object;
      
      public static var _creepID:int;
      
      public static var _creepCount:int;
      
      public static var _flungCount:int;
      
      public static var _mcBody:*;
      
      public static var _mcLegs:*;
      
      public static var _ticks:int;
      
      private static var _creepOverlap:Object;
      
      public static var _bmdHPbar:BitmapData = new bmp_healthbarsmall(0,0);
      
      public static var _flungGuardian:Vector.<Boolean> = new Vector.<Boolean>();
      
      public static var _guardianList:Vector.<CHAMPIONMONSTER> = new Vector.<CHAMPIONMONSTER>();
      
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
         var _loc2_:CHAMPIONMONSTER = null;
         var _loc1_:Vector.<CHAMPIONMONSTER> = CREEPS._guardianList;
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
         var tmpMonster:* = undefined;
         var m:String = null;
         var cid:String = null;
         var t:int = getTimer();
         var c:int = 0;
         _creepOverlap = {};
         for(m in _creeps)
         {
            tmpMonster = _creeps[m];
            cid = tmpMonster._creatureID + "x" + int(tmpMonster._tmpPoint.x * 0.5) + "y" + int(tmpMonster._tmpPoint.y * 0.5);
            if(!_creepOverlap[cid])
            {
               _creepOverlap[cid] = 1;
               if(!tmpMonster._mc.visible)
               {
                  tmpMonster._mc.visible = true;
               }
            }
            else
            {
               _creepOverlap[cid] += 1;
               if(_creepOverlap[cid] > 1)
               {
                  if(tmpMonster._mc.visible)
                  {
                     tmpMonster._mc.visible = false;
                  }
               }
               else if(!tmpMonster._mc.visible)
               {
                  tmpMonster._mc.visible = true;
               }
            }
            if(tmpMonster._mc.visible)
            {
               c += 1;
            }
            if(tmpMonster.Tick(1))
            {
               if(tmpMonster._health.Get() <= 0)
               {
                  try
                  {
                     if(tmpMonster._creatureID.substr(0,1) != "G")
                     {
                        SOUNDS.Play("splat" + (int(Math.random() * 3) + 1));
                        EFFECTS.CreepSplat(tmpMonster._creatureID,tmpMonster._tmpPoint.x,tmpMonster._tmpPoint.y);
                     }
                  }
                  catch(e:Error)
                  {
                  }
               }
               tmpMonster.Clear();
               MAP._BUILDINGTOPS.removeChild(tmpMonster);
               --_creepCount;
               if(tmpMonster._creatureID.substr(0,1) == "G" || (GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack") && !CREATURELOCKER._creatures[tmpMonster._creatureID].fake)
               {
                  --_flungCount;
                  ATTACK._creaturesFlung.Add(-1);
               }
               delete _creeps[m];
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
      
      public static function Spawn(param1:String, param2:*, param3:String, param4:Point, param5:Number, param6:Number = 1, param7:Boolean = false) : *
      {
         var _loc8_:* = undefined;
         ++_creepID;
         if(!CREATURELOCKER._creatures[param1].fake)
         {
            ++_flungCount;
         }
         ++_creepCount;
         if(param1.substr(0,1) == "I")
         {
            _loc8_ = param2.addChild(new CREEP_INFERNO(param1,param3,param4,param5,null,false,null,param6,param7));
         }
         else
         {
            _loc8_ = param2.addChild(new CREEP(param1,param3,param4,param5,null,false,null,param6,param7));
         }
         _creeps[_creepID] = _loc8_;
         return _loc8_;
      }
      
      public static function SpawnGuardian(param1:int, param2:*, param3:String, param4:int, param5:Point, param6:Number, param7:int = 20000, param8:int = 0, param9:int = 0, param10:Boolean = false) : CHAMPIONMONSTER
      {
         var _loc13_:int = 0;
         var _loc11_:Class = CHAMPIONCAGE.getGuardianSpawnClass(param1);
         ++_creepID;
         ++_creepCount;
         ++_flungCount;
         var _loc12_:CHAMPIONMONSTER = null;
         if(param10)
         {
            _loc12_ = new _loc11_(param3,param5,0,null,false,null,param4,0,0,param1,param7,param8,param9);
         }
         else
         {
            _loc13_ = GLOBAL.getPlayerGuardianIndex(param1);
            _loc12_ = new _loc11_(param3,param5,0,null,false,null,param4,GLOBAL._playerGuardianData[_loc13_].fd,GLOBAL._playerGuardianData[_loc13_].ft,param1,param7,param8,param9);
         }
         if(_loc11_ == CHAMPIONMONSTER)
         {
            _guardian = _loc12_;
         }
         else if(!addGuardian(_loc12_))
         {
            _loc12_ = null;
         }
         if(_loc12_)
         {
            _creeps[_creepID] = _loc12_;
            param2.addChild(_loc12_);
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
            MAP._BUILDINGTOPS.removeChild(_loc1_);
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
      
      public static function get _guardian() : CHAMPIONMONSTER
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
      
      public static function set _guardian(param1:CHAMPIONMONSTER) : void
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
      
      public static function addGuardian(param1:CHAMPIONMONSTER) : Boolean
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

