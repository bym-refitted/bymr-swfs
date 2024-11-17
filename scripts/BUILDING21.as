package
{
   import com.monsters.pathing.PATHING;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BUILDING21 extends BTOWER
   {
      public var _animMC:*;
      
      public var _frameNumber:int;
      
      public var _animBitmap:BitmapData;
      
      public function BUILDING21()
      {
         super();
         this._frameNumber = 0;
         _type = 21;
         _top = -30;
         _footprint = [new Rectangle(0,0,70,70)];
         _gridCost = [[new Rectangle(0,0,70,70),10],[new Rectangle(10,10,50,50),200]];
         SetProps();
         this.Props();
      }
      
      override public function TickAttack() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Point = null;
         var _loc3_:Point = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         super.TickAttack();
         if(_hasTargets)
         {
            _loc1_ = _targetCreeps[0].creep;
            _loc2_ = PATHING.FromISO(_loc1_._tmpPoint);
            _loc3_ = PATHING.FromISO(new Point(_mc.x,_mc.y));
            _loc3_ = _loc3_.add(new Point(35,35));
            _loc4_ = _loc2_.x - _loc3_.x;
            _loc5_ = _loc2_.y - _loc3_.y;
            _loc6_ = Math.atan2(_loc5_,_loc4_) * 57.2957795;
            if(_loc6_ < 0)
            {
               _loc6_ = 6 * 60 + _loc6_;
            }
            _loc6_ /= 12;
            _animTick = int(_loc6_);
            this.AnimFrame();
            ++this._frameNumber;
         }
      }
      
      override public function AnimFrame(param1:Boolean = true) : *
      {
         if(_animLoaded && GLOBAL._render)
         {
            _animContainerBMD.copyPixels(_animBMD,new Rectangle(_animRect.width * _animTick,0,_animRect.width,_animRect.height),new Point(0,0));
         }
      }
      
      override public function Fire(param1:*) : *
      {
         super.Fire(param1);
         SOUNDS.Play("snipe1");
         var _loc2_:Number = 0.5 + 0.5 / _hpMax.Get() * _hp.Get();
         var _loc3_:Number = 1;
         if(Boolean(GLOBAL._towerOverdrive) && GLOBAL._towerOverdrive.Get() >= GLOBAL.Timestamp())
         {
            _loc3_ = 1.25;
         }
         PROJECTILES.Spawn(new Point(_mc.x,_mc.y + _top),null,param1,_speed,int(_damage * _loc2_ * _loc3_),false,_splash);
      }
      
      override public function Props() : *
      {
         super.Props();
      }
      
      override public function Upgraded() : *
      {
         super.Upgraded();
      }
      
      override public function Constructed() : *
      {
         super.Constructed();
      }
   }
}

