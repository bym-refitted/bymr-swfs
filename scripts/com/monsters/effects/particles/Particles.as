package com.monsters.effects.particles
{
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gs.*;
   import gs.easing.*;
   
   public class Particles
   {
      public static var _particles:Object = {};
      
      public static var _particleCount:int = 0;
      
      public static var _tmpParticleCount:int = 0;
      
      public static var _frame:int = 0;
      
      private static var _pool:Vector.<ParticlesObject> = new Vector.<ParticlesObject>();
      
      public function Particles()
      {
         super();
      }
      
      public static function Clear() : void
      {
         var particle:ParticlesObject = null;
         var g:String = null;
         try
         {
            for(g in _particles)
            {
               particle = _particles[g];
               if(particle.parent)
               {
                  particle.parent.removeChild(particle);
               }
               particle.Clear();
               PoolSet(particle);
               delete _particles[g];
            }
            _particles = {};
            _particleCount = 0;
            _frame = 0;
         }
         catch(e:Error)
         {
            LOGGER.Log("err","Particles Clear " + e.getStackTrace());
         }
      }
      
      public static function PoolGet(param1:int, param2:Point, param3:Point, param4:int, param5:Number, param6:Number) : ParticlesObject
      {
         var _loc7_:ParticlesObject = null;
         if(_pool.length)
         {
            _loc7_ = _pool.pop();
         }
         else
         {
            _loc7_ = new ParticlesObject();
            _loc7_.gotoAndStop(int(Math.random() * 3) + 1);
         }
         _loc7_.init(param1,param2,param3,param4,param5,param6);
         return _loc7_;
      }
      
      public static function PoolSet(param1:ParticlesObject) : void
      {
         _pool.push(param1);
      }
      
      public static function Create(param1:Point, param2:Number, param3:int, param4:int, param5:int = 0) : void
      {
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         if(!GLOBAL._catchup)
         {
            if(_tmpParticleCount < 80)
            {
               _loc6_ = 0;
               while(_loc6_ < param4)
               {
                  _tmpParticleCount += 1;
                  _loc7_ = param3 * 0.2 + Math.random() * (param3 * 0.8);
                  if(Math.random() <= 0.3)
                  {
                     _loc7_ *= 1.5;
                  }
                  Spawn(param1.add(new Point(-3 + Math.random() * 6,-2 + Math.random() * 4)),param2,_loc7_,_loc6_ / 100,param5);
                  _loc6_++;
               }
            }
         }
      }
      
      public static function Spawn(param1:Point, param2:Number, param3:int, param4:Number, param5:int) : void
      {
         var _loc6_:Number = Math.random() * 360;
         var _loc7_:Point = GRID.FromISO(param1.x,param1.y);
         var _loc8_:Number = _loc7_.x + Math.cos(_loc6_) * param3;
         var _loc9_:Number = _loc7_.y + Math.sin(_loc6_) * param3;
         var _loc10_:Point = GRID.ToISO(_loc8_,_loc9_,0).add(new Point(0,param5));
         _particles[_particleCount] = MAP._GROUND.addChild(PoolGet(_particleCount,param1,_loc10_,param3,param4,param2));
         _particleCount += 1;
      }
      
      public static function Remove(param1:*) : void
      {
         var id:* = param1;
         var particle:ParticlesObject = _particles[id];
         --_tmpParticleCount;
         try
         {
            MAP._GROUND.removeChild(particle);
            particle.Clear();
            PoolSet(particle);
            delete _particles[id];
         }
         catch(e:Error)
         {
         }
      }
      
      public static function SnapShot(param1:int, param2:int, param3:Number, param4:ParticlesObject) : void
      {
         var b:BitmapData = null;
         var m:Matrix = null;
         var p:* = undefined;
         var width:int = 0;
         var height:int = 0;
         var x:int = param1;
         var y:int = param2;
         var scale:Number = param3;
         var object:ParticlesObject = param4;
         try
         {
            m = new Matrix();
            width = 26;
            height = 26;
            b = new BitmapData(width,height,true,0);
            m.scale(scale,scale);
            m.tx = width * 0.5;
            m.ty = height * 0.5;
            b.draw(object,m);
            MAP._EFFECTSBMP.copyPixels(b,new Rectangle(0,0,width,height),new Point(x + MAP._EFFECTSBMP.width * 0.5 - width / 2,y + MAP._EFFECTSBMP.height * 0.5 - height * 0.5),null,null,true);
         }
         catch(e:Error)
         {
         }
      }
   }
}

