package
{
   import flash.geom.Point;
   
   public class FIREBALLS
   {
      public static var _fireballs:Object;
      
      public static var _id:int;
      
      public static var _fireballCount:int;
      
      public static var _pool:Array = [];
      
      public function FIREBALLS()
      {
         super();
         Clear();
      }
      
      public static function Spawn(param1:Point, param2:Point, param3:BFOUNDATION, param4:Number, param5:int, param6:int = 0, param7:int = 0) : *
      {
         var _loc8_:* = PoolGet();
         if(param5 > 0)
         {
            _loc8_.gotoAndStop(1);
         }
         else
         {
            _loc8_.gotoAndStop(2);
         }
         if(!GLOBAL._catchup)
         {
            MAP._FIREBALLS.addChild(_loc8_);
         }
         _loc8_._id = _id;
         _loc8_._startPoint = param1;
         _loc8_._targetType = 2;
         _loc8_._targetBuilding = param3;
         _loc8_._maxSpeed = param4;
         _loc8_._damage = param5;
         _loc8_._splash = param6;
         _loc8_._tmpX = param1.x;
         _loc8_._tmpY = param1.y;
         _loc8_._glaves = param7;
         _loc8_._speed = param4;
         _loc8_._startDistance = 0;
         if(!_fireballs)
         {
            _fireballs = {};
         }
         _fireballs[_id] = _loc8_;
         ++_id;
         ++_fireballCount;
      }
      
      public static function Spawn2(param1:Point, param2:Point, param3:*, param4:Number, param5:int, param6:int = 0) : *
      {
         var _loc7_:* = PoolGet();
         if(!GLOBAL._catchup)
         {
            MAP._FIREBALLS.addChild(_loc7_);
         }
         if(param5 > 0)
         {
            _loc7_.gotoAndStop(1);
         }
         else
         {
            _loc7_.gotoAndStop(2);
         }
         _loc7_._id = _id;
         _loc7_._startPoint = param1;
         _loc7_._targetType = 1;
         _loc7_._targetCreep = param3;
         _loc7_._maxSpeed = param4;
         _loc7_._damage = param5;
         _loc7_._glaves = 0;
         if(param3._movement != "fly")
         {
            _loc7_._splash = param6;
         }
         else
         {
            _loc7_._splash = 0;
         }
         _loc7_._tmpX = param1.x;
         _loc7_._tmpY = param1.y;
         _loc7_._speed = param4;
         _loc7_._startDistance = 0;
         if(!_fireballs)
         {
            _fireballs = {};
         }
         _fireballs[_id] = _loc7_;
         ++_id;
         ++_fireballCount;
      }
      
      public static function Spawn3(param1:Point, param2:Point, param3:*, param4:Number, param5:int, param6:int = 0) : *
      {
         Spawn2(param1,param2,param3,param4,param5,param6);
      }
      
      public static function Remove(param1:int) : *
      {
         var id:int = param1;
         var fireball:FIREBALL = _fireballs[id];
         try
         {
            MAP._FIREBALLS.removeChild(fireball);
         }
         catch(e:Error)
         {
         }
         PoolSet(fireball);
         delete _fireballs[id];
         --_fireballCount;
      }
      
      public static function Tick() : *
      {
         var _loc2_:FIREBALL = null;
         for each(_loc2_ in _fireballs)
         {
            _loc2_.Tick();
         }
      }
      
      public static function Clear() : *
      {
         var p:String = null;
         var tmpFireball:FIREBALL = null;
         for(p in _fireballs)
         {
            tmpFireball = _fireballs[p];
            try
            {
               MAP._FIREBALLS.removeChild(tmpFireball);
            }
            catch(e:Error)
            {
            }
         }
         _fireballs = {};
         _id = 0;
         _fireballCount = 0;
      }
      
      public static function PoolSet(param1:FIREBALL) : *
      {
         _pool.push(param1);
      }
      
      public static function PoolGet() : *
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
         return _loc1_;
      }
   }
}

