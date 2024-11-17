package
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BUILDING21 extends BTOWER
   {
      public var _animBitmap:BitmapData;
      
      public function BUILDING21()
      {
         super();
         _frameNumber = 0;
         _type = 21;
         _top = BASE.isInferno() ? -60 : -30;
         _footprint = [new Rectangle(0,0,70,70)];
         _gridCost = [[new Rectangle(0,0,70,70),10],[new Rectangle(10,10,50,50),200]];
         SetProps();
         this.Props();
      }
      
      override public function TickAttack() : void
      {
         super.TickAttack();
         Rotate();
      }
      
      override public function AnimFrame(param1:Boolean = true) : void
      {
         if(_animLoaded && GLOBAL._render)
         {
            _animRect.x = _animRect.width * _animTick;
            _animContainerBMD.copyPixels(_animBMD,_animRect,_nullPoint);
         }
      }
      
      override public function Fire(param1:*) : void
      {
         super.Fire(param1);
         if(BASE.isInferno())
         {
            SOUNDS.Play("isniper",!isJard ? 0.8 : 0.4);
         }
         else
         {
            SOUNDS.Play("snipe1",!isJard ? 0.8 : 0.4);
         }
         var _loc2_:Number = 0.5 + 0.5 / _hpMax.Get() * _hp.Get();
         var _loc3_:Number = 1;
         if(Boolean(GLOBAL._towerOverdrive) && GLOBAL._towerOverdrive.Get() >= GLOBAL.Timestamp())
         {
            _loc3_ = 1.25;
         }
         if(isJard)
         {
            _jarHealth.Add(-int(_damage * _loc2_ * _loc3_));
            ATTACK.Damage(_mc.x,_mc.y + _top,_damage * _loc2_ * _loc3_);
            if(_jarHealth.Get() <= 0)
            {
               KillJar();
            }
         }
         else if(_targetVacuum)
         {
            PROJECTILES.Spawn(new Point(_mc.x,_mc.y + _top),GLOBAL._bTownhall._position.add(new Point(0,-GLOBAL._bTownhall._mc.height)),null,_speed,int(_damage * _loc3_ * _loc2_),false,_splash);
         }
         else
         {
            PROJECTILES.Spawn(new Point(_mc.x,_mc.y + _top),null,param1,_speed,int(_damage * _loc2_ * _loc3_),false,_splash);
         }
      }
      
      override public function Props() : void
      {
         super.Props();
      }
      
      override public function Upgraded() : void
      {
         super.Upgraded();
      }
      
      override public function Constructed() : void
      {
         super.Constructed();
      }
   }
}

