package
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class FIREBALLS
   {
      public static var _fireballs:Object;
      
      public static var _id:int;
      
      public static var _fireballCount:int;
      
      public static const TYPE_FIREBALL:String = "fireball";
      
      public static const TYPE_MISSILE:String = "missile";
      
      public static const TYPE_MAGMA:String = "magma";
      
      public static var _type:String = FIREBALL.TYPE_FIREBALL;
      
      public static var _pool:Array = [];
      
      public function FIREBALLS()
      {
         super();
         Clear();
      }
      
      public static function Spawn(param1:Point, param2:Point, param3:BFOUNDATION, param4:Number, param5:int, param6:int = 0, param7:int = 0, param8:String = "fireball") : void
      {
         if(!param8)
         {
            param8 = FIREBALL.TYPE_FIREBALL;
         }
         _type = param8;
         var _loc9_:FIREBALL = PoolGet();
         if(param8 == TYPE_FIREBALL || param8 == TYPE_MAGMA)
         {
            if(param5 > 0)
            {
               _loc9_._graphic.gotoAndStop(1);
            }
            else
            {
               _loc9_._graphic.gotoAndStop(2);
            }
         }
         if(!GLOBAL._catchup)
         {
            MAP._FIREBALLS.addChild(_loc9_._graphic);
         }
         _loc9_._id = _id;
         _loc9_._startPoint = param1;
         _loc9_._targetType = 2;
         _loc9_._targetBuilding = param3;
         _loc9_._maxSpeed = param4;
         _loc9_._damage = param5;
         _loc9_._splash = param6;
         _loc9_._tmpX = param1.x;
         _loc9_._tmpY = param1.y;
         _loc9_._glaves = param7;
         _loc9_._speed = param4;
         _loc9_._startDistance = 0;
         if(!_fireballs)
         {
            _fireballs = {};
         }
         _fireballs[_id] = _loc9_;
         ++_id;
         ++_fireballCount;
      }
      
      public static function Spawn2(param1:Point, param2:Point, param3:*, param4:Number, param5:int, param6:int = 0, param7:String = "fireball", param8:int = 1) : FIREBALL
      {
         var _loc10_:MovieClip = null;
         if(!param7)
         {
            param7 = FIREBALL.TYPE_FIREBALL;
         }
         _type = param7;
         var _loc9_:FIREBALL = PoolGet();
         if(!GLOBAL._catchup)
         {
            MAP._FIREBALLS.addChild(_loc9_._graphic);
         }
         if(param5 > 0)
         {
            _loc9_._graphic.gotoAndStop(1);
         }
         else
         {
            _loc9_._graphic.gotoAndStop(2);
         }
         _loc9_._type = param7;
         _loc9_._id = _id;
         _loc9_._startPoint = param1;
         if(Boolean(GLOBAL._bTownhall) && GLOBAL._bTownhall is BUILDING14)
         {
            _loc10_ = BUILDING14(GLOBAL._bTownhall)._vacuum;
         }
         _loc9_._targetType = Boolean(_loc10_) && param3 == _loc10_ ? 4 : param8;
         _loc9_._targetPoint = param2;
         _loc9_._targetCreep = param3;
         _loc9_._maxSpeed = param4;
         _loc9_._damage = param5;
         _loc9_._glaves = 0;
         if(param3 && param3._movement != "fly")
         {
            _loc9_._splash = param6;
         }
         else
         {
            _loc9_._splash = 0;
         }
         _loc9_._tmpX = param1.x;
         _loc9_._tmpY = param1.y;
         _loc9_._speed = param4;
         _loc9_._startDistance = 0;
         if(!_fireballs)
         {
            _fireballs = {};
         }
         _fireballs[_id] = _loc9_;
         ++_id;
         ++_fireballCount;
         return _loc9_;
      }
      
      public static function Spawn3(param1:Point, param2:Point, param3:*, param4:Number, param5:int, param6:int = 0) : void
      {
         Spawn2(param1,param2,param3,param4,param5,param6);
      }
      
      public static function Remove(param1:int) : void
      {
         var _loc2_:FIREBALL = _fireballs[param1];
         try
         {
            _loc2_._graphic.filters = [];
            MAP._FIREBALLS.removeChild(_loc2_._graphic);
         }
         catch(e:Error)
         {
         }
         PoolSet(_loc2_);
         delete _fireballs[param1];
         --_fireballCount;
      }
      
      public static function Tick() : void
      {
         var _loc2_:FIREBALL = null;
         for each(_loc2_ in _fireballs)
         {
            _loc2_.Tick();
         }
      }
      
      public static function Clear() : void
      {
         var _loc1_:String = null;
         var _loc2_:FIREBALL = null;
         for(_loc1_ in _fireballs)
         {
            _loc2_ = _fireballs[_loc1_];
            try
            {
               MAP._FIREBALLS.removeChild(_loc2_._graphic);
            }
            catch(e:Error)
            {
            }
         }
         _fireballs = {};
         _id = 0;
         _fireballCount = 0;
      }
      
      public static function PoolSet(param1:FIREBALL) : void
      {
         _pool.push(param1);
      }
      
      public static function PoolGet() : FIREBALL
      {
         var _loc1_:FIREBALL = null;
         if(_pool.length)
         {
            _loc1_ = _pool.pop();
         }
         else
         {
            _loc1_ = new FIREBALL();
         }
         _loc1_.Setup(_type);
         return _loc1_;
      }
   }
}

