package com.monsters.effects.particles
{
   import flash.geom.Point;
   
   public class ParticleDamage
   {
      private static var _pool:Array = [];
      
      private static var _currentCount:int = 0;
      
      private static var _currentMax:int = 20;
      
      public function ParticleDamage()
      {
         super();
      }
      
      public static function Create(param1:Point, param2:int, param3:Boolean = false) : *
      {
         var _loc4_:* = undefined;
         if(!GLOBAL._catchup && _currentCount < _currentMax)
         {
            _loc4_ = PoolGet();
            _loc4_.Init(param1,param2,param3);
         }
      }
      
      private static function PoolGet() : ParticleDamageItem
      {
         var _loc1_:ParticleDamageItem = null;
         ++_currentCount;
         if(_pool.length)
         {
            _loc1_ = _pool.pop();
         }
         else
         {
            _loc1_ = new ParticleDamageItem();
         }
         return _loc1_;
      }
      
      public static function Remove(param1:ParticleDamageItem) : *
      {
         --_currentCount;
         if(_currentCount < 0)
         {
            _currentCount = 0;
         }
         PoolSet(param1);
      }
      
      private static function PoolSet(param1:ParticleDamageItem) : *
      {
         _pool.push(param1);
      }
      
      public static function Clear() : *
      {
         _pool = [];
         _currentCount = 0;
      }
   }
}

