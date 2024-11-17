package com.monsters.effects.particles
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import gs.TweenLite;
   import gs.easing.Sine;
   
   public class ParticlesObject extends ParticlesObject_CLIP
   {
      internal var _frame:int = 0;
      
      internal var _id:int;
      
      internal var _targetPoint:Point;
      
      internal var _target:MovieClip;
      
      public var _cleared:Boolean;
      
      internal var xd:*;
      
      internal var yd:*;
      
      internal var _targetRotation:*;
      
      internal var _speed:Number;
      
      public function ParticlesObject()
      {
         super();
      }
      
      internal function init(param1:int, param2:Point, param3:Point, param4:Number, param5:Number, param6:Number) : *
      {
         this._id = param1;
         visible = false;
         this._cleared = false;
         x = param2.x;
         y = param2.y;
         scaleX = scaleY = param6;
         var _loc7_:Number = Math.sqrt(param4 * 0.3) * 0.2;
         if(_loc7_ < 0.3)
         {
            _loc7_ = 0.3;
         }
         TweenLite.to(this,_loc7_,{
            "x":param3.x,
            "y":param3.y,
            "visible":true,
            "ease":Sine.easeInOut,
            "delay":param5,
            "onComplete":this.Arrived,
            "overwrite":false
         });
         TweenLite.to(mcDot,_loc7_ / 2,{
            "y":-(_loc7_ * 50),
            "ease":Sine.easeOut,
            "delay":param5,
            "overwrite":0
         });
         TweenLite.to(mcDot,_loc7_ / 2,{
            "y":0,
            "ease":Sine.easeIn,
            "delay":_loc7_ / 2 + param5,
            "overwrite":0
         });
         cacheAsBitmap = true;
      }
      
      internal function Arrived() : *
      {
         if(!this._cleared)
         {
            Particles.SnapShot(x,y,scaleX,this);
            Particles.Remove(this._id);
         }
      }
      
      public function Clear() : *
      {
         this._cleared = true;
      }
   }
}
