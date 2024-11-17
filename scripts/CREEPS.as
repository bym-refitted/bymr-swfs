package
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class CREEPS
   {
      public static var _creeps:Object;
      
      public static var _creepID:int;
      
      public static var _creepCount:int;
      
      public static var _mcBody:*;
      
      public static var _mcLegs:*;
      
      public static var _ticks:int;
      
      private static var _creepOverlap:Object;
      
      public static var _guardian:CHAMPIONMONSTER;
      
      public static var _flungGuardian:Boolean;
      
      public static var _bmdHPbar:BitmapData = new bmp_healthbarsmall(0,0);
      
      public function CREEPS()
      {
         super();
         _creeps = {};
         _creepID = 0;
         _creepCount = 0;
         _ticks = 0;
         _creepOverlap = {};
         _flungGuardian = false;
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
            if(tmpMonster.Tick())
            {
               if(tmpMonster._health.Get() <= 0)
               {
                  try
                  {
                     if(tmpMonster._creatureID.substr(0,1) != "G" || SPECIALEVENT.active)
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
               if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
               {
                  ATTACK._creaturesFlung.Add(-1);
               }
               delete _creeps[m];
            }
         }
         if(_creepCount <= 0)
         {
            _creepCount = 0;
         }
         if(GLOBAL._mode == "attack" || GLOBAL._mode == "wmattack")
         {
            if(ATTACK._creaturesFlung.Get() < _creepCount && ATTACK._creaturesFlung.Get() > 0)
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
      
      public static function SpawnGuardian(param1:int, param2:*, param3:String, param4:int, param5:Point, param6:Number, param7:int = 20000, param8:int = 0, param9:Boolean = false) : CHAMPIONMONSTER
      {
         ++_creepID;
         ++_creepCount;
         if(param9)
         {
            _guardian = new CHAMPIONMONSTER(param3,param5,0,null,false,null,param4,0,0,param1,param7,param8);
         }
         else
         {
            _guardian = new CHAMPIONMONSTER(param3,param5,0,null,false,null,param4,GLOBAL._playerGuardianData.fd,GLOBAL._playerGuardianData.ft,param1,param7,param8);
         }
         _creeps[_creepID] = _guardian;
         param2.addChild(_guardian);
         return _guardian;
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
         for(_loc2_ in _creeps)
         {
            _loc1_ = _creeps[_loc2_];
            _loc1_.Clear();
            MAP._BUILDINGTOPS.removeChild(_loc1_);
         }
         _creeps = {};
         _creepCount = 0;
         _flungGuardian = false;
         if(_guardian)
         {
            MAP._BUILDINGTOPS.removeChild(_guardian);
            _guardian.Clear();
            _guardian = null;
         }
      }
   }
}

