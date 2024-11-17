package
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class FIREBALL extends FIREBALL_CLIP
   {
      public var _startPoint:Point;
      
      public var _targetPoint:Point;
      
      public var _targetMC:MovieClip;
      
      public var _damage:Number;
      
      public var _splash:Number;
      
      public var _maxSpeed:Number;
      
      public var _glaves:int = 0;
      
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
      
      public var _id:int;
      
      public var _tmpX:Number;
      
      public var _tmpY:Number;
      
      public var _xChange:Number;
      
      public var _yChange:Number;
      
      public var _targetBuilding:BFOUNDATION;
      
      public var _previousTarget:BFOUNDATION;
      
      public var _targetCreep:*;
      
      public var _frameNumber:int = 4;
      
      public function FIREBALL()
      {
         super();
      }
      
      public function Tick() : Boolean
      {
         ++this._frameNumber;
         if(this._targetType == 1)
         {
            if(!this._targetCreep)
            {
               FIREBALLS.Remove(this._id);
               return true;
            }
            if(Boolean(this._targetCreep._movement) && this._targetCreep._movement == "fly")
            {
               this._targetPoint = new Point(this._targetCreep._tmpPoint.x,this._targetCreep._tmpPoint.y - this._targetCreep._altitude);
            }
            else
            {
               this._targetPoint = this._targetCreep._tmpPoint;
            }
         }
         if(this._targetType == 2)
         {
            this._targetPoint = new Point(this._targetBuilding._mc.x,this._targetBuilding._mc.y + this._targetBuilding._footprint[0].height / 2);
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
            else
            {
               if(this._targetType == 1)
               {
                  if(this._damage > 0)
                  {
                     this._targetCreep._health.Add(-(this._targetCreep._damageMult * this._damage));
                  }
                  else
                  {
                     if(this._targetCreep._creatureID.substr(0,1) == "G")
                     {
                        this._damage *= 0.1;
                     }
                     this._targetCreep._health.Add(-this._damage);
                     if(this._targetCreep._health.Get() > this._targetCreep._maxHealth)
                     {
                        this._targetCreep._health.Set(this._targetCreep._maxHealth);
                     }
                  }
                  ATTACK.Damage(this._startPoint.x,this._startPoint.y,this._damage > 0 ? int(this._targetCreep._damageMult * this._damage) : int(this._damage));
               }
               if(this._targetType == 2)
               {
                  if(this._targetBuilding._hp.Get() > 0)
                  {
                     this._targetBuilding.Damage(this._damage,this._targetBuilding._position.x,this._targetBuilding._position.y,1,true);
                     if(this._targetBuilding._fortification.Get() > 0)
                     {
                        ATTACK.Damage(this._startPoint.x,this._startPoint.y,this._damage * ((100 - (this._targetBuilding._fortification.Get() * 10 + 10)) / 100));
                     }
                     else
                     {
                        ATTACK.Damage(this._startPoint.x,this._startPoint.y,this._damage);
                     }
                  }
               }
            }
            if(this._glaves > 0)
            {
               --this._glaves;
               this.FindGlaveTarget();
               this._damage *= 0.5;
            }
            else
            {
               this._targetBuilding = null;
            }
            if(this._targetBuilding == null)
            {
               FIREBALLS.Remove(this._id);
               return true;
            }
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
         if(this._targetCreep._movement == "fly")
         {
            _loc8_ = MAP.CreepCellFind(new Point(this._tmpX,this._tmpY),this._splash,2);
         }
         else
         {
            _loc8_ = MAP.CreepCellFind(new Point(this._tmpX,this._tmpY),this._splash);
         }
         var _loc9_:int = 0;
         for(_loc3_ in _loc8_)
         {
            _loc1_ = _loc8_[_loc3_];
            _loc2_ = _loc1_.creep;
            if(!(Boolean(_loc2_._friendly) && this._damage < 0))
            {
               if(_loc2_ == this._targetCreep)
               {
                  if(_loc2_._creatureID.substr(0,1) == "G")
                  {
                     _loc9_ += this._damage / 10;
                  }
                  else
                  {
                     _loc9_ += this._damage;
                  }
                  if(this._damage > 0)
                  {
                     _loc2_._health.Add(-(_loc2_._damageMult * this._damage));
                  }
                  else if(_loc2_._creatureID.substr(0,1) == "G")
                  {
                     _loc2_._health.Add(-this._damage / 10);
                  }
                  else
                  {
                     _loc2_._health.Add(-this._damage);
                  }
                  if(_loc2_._health.Get() > _loc2_._maxHealth)
                  {
                     _loc9_ -= _loc2_._maxHealth - _loc2_._health.Get();
                     _loc2_._health.Set(_loc2_._maxHealth);
                  }
               }
               else
               {
                  _loc4_ = _loc1_.dist;
                  _loc5_ = _loc1_.pos;
                  _loc7_ = this._damage * 0.75 / this._splash * (this._splash - _loc4_);
                  if(_loc7_ > 0)
                  {
                     _loc2_._health.Add(-(_loc2_._damageMult * _loc7_));
                     _loc9_ += _loc7_;
                  }
                  else if(_loc2_._creatureID.substr(0,1) == "G")
                  {
                     _loc2_._health.Add(-_loc7_ / 10);
                     _loc9_ += _loc7_ / 10;
                  }
                  else
                  {
                     _loc2_._health.Add(-_loc7_);
                     _loc9_ += _loc7_;
                  }
                  if(_loc2_._health.Get() > _loc2_._maxHealth)
                  {
                     _loc9_ -= _loc2_._maxHealth - _loc2_._health.Get();
                     _loc2_._health.Set(_loc2_._maxHealth);
                  }
               }
            }
         }
         ATTACK.Damage(this._startPoint.x,this._startPoint.y,_loc9_);
      }
      
      public function FindGlaveTarget() : *
      {
         var _loc1_:Point = null;
         var _loc2_:Point = null;
         var _loc3_:int = 0;
         var _loc5_:BFOUNDATION = null;
         var _loc6_:* = undefined;
         var _loc4_:Array = [];
         _loc1_ = new Point(x,y);
         for(_loc6_ in BASE._buildingsMain)
         {
            _loc5_ = BASE._buildingsMain[_loc6_];
            if(_loc5_._class != "decoration" && _loc5_._class != "immovable" && _loc5_._hp.Get() > 0 && _loc5_._class != "enemy" && _loc5_._class != "trap")
            {
               _loc2_ = new Point(_loc5_._mc.x,_loc5_._mc.y + _loc5_._footprint[0].height / 2);
               _loc3_ = Point.distance(_loc1_,_loc2_);
               if(_loc5_ != this._targetBuilding)
               {
                  _loc4_.push({
                     "building":_loc5_,
                     "distance":_loc3_,
                     "expand":true
                  });
               }
            }
         }
         _loc4_.sortOn("distance",Array.NUMERIC);
         if(_loc4_.length == 0)
         {
            this._targetBuilding = null;
            return;
         }
         if(_loc4_[0].building == this._previousTarget)
         {
            _loc4_.shift();
         }
         if(_loc4_.length > 0)
         {
            this._previousTarget = this._targetBuilding;
            this._targetBuilding = _loc4_[0].building;
            this._targetPoint = new Point(this._targetBuilding._mc.x,this._targetBuilding._mc.y + this._targetBuilding._footprint[0].height / 2);
            _loc3_ = Point.distance(_loc1_,this._targetPoint) - Math.abs(this._targetBuilding._footprint[0].height - this._previousTarget._footprint[0].height) / 2;
            if(_loc3_ > 100)
            {
               this._targetBuilding = null;
            }
         }
         else
         {
            this._targetBuilding = null;
         }
      }
   }
}

