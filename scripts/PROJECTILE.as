package
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class PROJECTILE extends PROJECTILE_CLIP
   {
      public var _startPoint:Point;
      
      public var _targetPoint:Point;
      
      public var _targetMC:MovieClip;
      
      public var _damage:Number;
      
      public var _splash:Number;
      
      public var _splashtype:int;
      
      public var _maxSpeed:Number;
      
      public var _speed:Number;
      
      public var _mc:MovieClip;
      
      public var _yd:Number;
      
      public var _xd:Number;
      
      public var _newX:int;
      
      public var _newY:int;
      
      public var _rotation:Number;
      
      public var _targetRotation:Number;
      
      public var _rotationDifference:Number;
      
      public var _rotationChange:Number;
      
      public var _rotationEasing:Number;
      
      public var _startDistance:int;
      
      public var _distance:int;
      
      public var _targetType:int;
      
      public var _rocket:Boolean;
      
      public var _id:int;
      
      public var _tmpX:Number;
      
      public var _tmpY:Number;
      
      public var _xChange:Number;
      
      public var _yChange:Number;
      
      public var _frameNumber:int = 4;
      
      public function PROJECTILE()
      {
         super();
      }
      
      public function Tick() : Boolean
      {
         ++this._frameNumber;
         if(this._targetType == 1)
         {
            if(Boolean(this._targetMC._movement) && this._targetMC._movement == "fly")
            {
               this._targetPoint = new Point(this._targetMC._tmpPoint.x,this._targetMC._tmpPoint.y - this._targetMC._altitude);
            }
            else
            {
               this._targetPoint = this._targetMC._tmpPoint;
            }
         }
         this._distance = Point.distance(this._targetPoint,new Point(this._tmpX,this._tmpY));
         if(this.Move())
         {
            return true;
         }
         this.Render();
         return false;
      }
      
      public function Move() : Boolean
      {
         var _loc1_:Number = this._maxSpeed * 0.5;
         if(this._frameNumber % 5 == 0)
         {
            this._xd = this._targetPoint.x - this._tmpX;
            this._yd = this._targetPoint.y - this._tmpY;
            this._xChange = Math.cos(Math.atan2(this._yd,this._xd)) * _loc1_;
            this._yChange = Math.sin(Math.atan2(this._yd,this._xd)) * _loc1_;
         }
         this._tmpX += this._xChange;
         this._tmpY += this._yChange;
         this._distance -= _loc1_;
         if(this._distance <= this._maxSpeed)
         {
            if(this._splash > 0)
            {
               this.Splash();
            }
            else if(this._targetType == 1)
            {
               this._targetMC._health.Add(-(this._targetMC._damageMult * this._damage));
               ATTACK.Damage(this._startPoint.x,this._startPoint.y,this._targetMC._damageMult * this._damage);
            }
            PROJECTILES.Remove(this._id);
            return true;
         }
         return false;
      }
      
      public function Render() : *
      {
         if(GLOBAL._render)
         {
            x = int(this._tmpX);
            y = int(this._tmpY);
         }
      }
      
      public function Splash() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc7_:int = 0;
         var _loc8_:* = undefined;
         _loc8_ = MAP.CreepCellFind(new Point(this._tmpX,this._tmpY),this._splash,this._splashtype);
         var _loc9_:int = 0;
         for(_loc3_ in _loc8_)
         {
            _loc1_ = _loc8_[_loc3_];
            _loc2_ = _loc1_.creep;
            if(_loc2_ == this._targetMC)
            {
               _loc9_ += this._damage;
               _loc2_._health.Add(-(_loc2_._damageMult * this._damage));
            }
            else
            {
               _loc4_ = _loc1_.dist;
               _loc5_ = _loc1_.pos;
               _loc7_ = this._damage * 0.75 / this._splash * (this._splash - _loc4_);
               _loc9_ += _loc7_;
               _loc2_._health.Add(-(_loc2_._damageMult * _loc7_));
            }
         }
         ATTACK.Damage(this._startPoint.x,this._startPoint.y,_loc9_);
      }
   }
}

