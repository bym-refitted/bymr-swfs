package
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BUILDING20 extends BTOWER
   {
      public var _animMC:*;
      
      public var _animBitmap:BitmapData;
      
      public var _frameNumber:*;
      
      public function BUILDING20()
      {
         super();
         _type = 20;
         _top = -4;
         _footprint = [new Rectangle(0,0,70,70)];
         _gridCost = [[new Rectangle(0,0,70,70),10],[new Rectangle(10,10,50,50),200]];
         SetProps();
         Props();
      }
      
      override public function Fire(param1:*) : *
      {
         super.Fire(param1);
         SOUNDS.Play("splash1");
         var _loc2_:Number = 0.5 + 0.5 / _hpMax.Get() * _hp.Get();
         var _loc3_:Number = 1;
         if(Boolean(GLOBAL._towerOverdrive) && GLOBAL._towerOverdrive.Get() >= GLOBAL.Timestamp())
         {
            _loc3_ = 1.25;
         }
         PROJECTILES.Spawn(new Point(_mc.x,_mc.y + _top),null,param1,_speed,int(_damage * _loc2_ * _loc3_),false,_splash,-1);
      }
   }
}

