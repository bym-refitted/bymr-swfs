package
{
   import flash.geom.Point;
   
   public class FIREBALLS
   {
      public static var _fireballs:Object;
      
      public static var _id:int;
      
      public static var _fireballCount:int;
      
      public static const TYPE_FIREBALL:String = "fireball";
      
      public static const TYPE_MISSILE:String = "missile";
      
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
         if(param8 == TYPE_FIREBALL)
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
      
      public static function Spawn2(param1:Point, param2:Point, param3:*, param4:Number, param5:int, param6:int = 0, param7:* = "fireball") : *
      {
         if(!param7)
         {
            param7 = FIREBALL.TYPE_FIREBALL;
         }
         _type = param7;
         var _loc8_:FIREBALL = PoolGet();
         if(!GLOBAL._catchup)
         {
            MAP._FIREBALLS.addChild(_loc8_._graphic);
         }
         if(param5 > 0)
         {
            _loc8_._graphic.gotoAndStop(1);
         }
         else
         {
            _loc8_._graphic.gotoAndStop(2);
         }
         _loc8_._type = param7;
         _loc8_._id = _id;
         _loc8_._startPoint = param1;
         _loc8_._targetType = 1;
         _loc8_._targetCreep = param3;
         _loc8_._maxSpeed = param4;
         _loc8_._damage = param5;
         _loc8_._glaves = 0;
         if(param3._movement != "fly")
         {
            _loc8_._splash = param6;
         }
         else
         {
            _loc8_._splash = 0;
         }
         _loc8_._tmpX = param1.x;
         _loc8_._tmpY = param1.y;
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
            MAP._FIREBALLS.removeChild(fireball._graphic);
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
               MAP._FIREBALLS.removeChild(tmpFireball._graphic);
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
         _loc1_.Setup(_type);
         return _loc1_;
      }
   }
}

