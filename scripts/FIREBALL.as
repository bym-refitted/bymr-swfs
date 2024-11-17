package
{
   import com.monsters.display.SpriteData;
   import com.monsters.monsters.MonsterBase;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   
   public class FIREBALL extends EventDispatcher
   {
      public static const TYPE_FIREBALL:String = "fireball";
      
      public static const TYPE_MISSILE:String = "missile";
      
      public static const TYPE_MAGMA:String = "magma";
      
      public static const TYPE_SPURTZ:String = "spurtz";
      
      public static const COLLIDED:String = "fireballCollided";
      
      public static const ROCKET_GRAPHIC_NAME:String = "rocket";
      
      public static const SPRUTZ_GRAPHIC_NAME:String = "IC1";
      
      private const DO_ROCKETS_ACCELERATE:Boolean = false;
      
      public var _startPoint:Point;
      
      public var _targetPoint:Point;
      
      public var _targetMC:MovieClip;
      
      public var _damage:Number;
      
      public var _splash:Number;
      
      public var _maxSpeed:Number;
      
      public var _glaves:int = 0;
      
      public var _speed:Number;
      
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
      
      public var _graphic:MovieClip;
      
      public var _type:String;
      
      public var _bitmapData:BitmapData;
      
      private var _acceleration:Number;
      
      private var _graphicName:String;
      
      public function FIREBALL()
      {
         super();
      }
      
      public function Setup(param1:String = "fireball") : void
      {
         var _loc2_:SpriteData = null;
         var _loc3_:Bitmap = null;
         if(this._graphic)
         {
            if(this._graphic.numChildren > 0)
            {
               this._graphic.removeChildAt(0);
            }
            this._graphic = null;
         }
         this._type = param1;
         this._acceleration = 0.5;
         if(this._type == TYPE_FIREBALL || this._type == TYPE_MAGMA)
         {
            this._graphic = new FIREBALL_CLIP();
            if(this._type == TYPE_MAGMA)
            {
               this._graphic.filters = [new GlowFilter(0xff9000,1,12,12,6,1,false,false)];
            }
         }
         else
         {
            switch(this._type)
            {
               case TYPE_MISSILE:
                  this._graphicName = ROCKET_GRAPHIC_NAME;
                  break;
               case TYPE_SPURTZ:
                  this._graphicName = SpurtzCannon.SPURTZ_PROJECTILE;
                  this._targetType = 3;
            }
            this._graphic = new MovieClip();
            if(this.DO_ROCKETS_ACCELERATE)
            {
               this._acceleration = 0.05;
            }
            _loc2_ = SPRITES.GetSpriteDescriptor(this._graphicName) as SpriteData;
            this._bitmapData = new BitmapData(_loc2_.width,_loc2_.height,true,0xffffff);
            _loc3_ = new Bitmap(this._bitmapData);
            _loc3_.x = -(_loc2_.width * 0.5);
            _loc3_.y = -(_loc2_.height * 0.5);
            this._graphic.addChild(_loc3_);
         }
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
         else if(this._targetType == 2)
         {
            this._targetPoint = new Point(this._targetBuilding._mc.x,this._targetBuilding._mc.y + this._targetBuilding._footprint[0].height / 2);
         }
         else if(this._targetType != 3)
         {
            if(this._targetType == 4)
            {
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
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         if(this._type == TYPE_MISSILE && this.DO_ROCKETS_ACCELERATE)
         {
            this._acceleration += 0.025;
         }
         var _loc1_:Number = this._maxSpeed * this._acceleration;
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
            dispatchEvent(new Event(COLLIDED));
            if(this._splash > 0)
            {
               this.Splash();
            }
            else if(this._targetType == 1)
            {
               if(this._damage > 0)
               {
                  _loc2_ = this._targetCreep._damageMult * this._damage;
                  this._targetCreep._health.Add(-(this._targetCreep._damageMult * this._damage));
               }
               else
               {
                  if(this._targetCreep._creatureID.substr(0,1) == "G")
                  {
                     this._damage *= 0.1;
                  }
                  _loc2_ = this._damage;
                  if(this._targetCreep._health.Get() - _loc2_ >= this._targetCreep._maxHealth)
                  {
                     _loc2_ = -(this._targetCreep._maxHealth - this._targetCreep._health.Get());
                     this._targetCreep._health.Set(this._targetCreep._maxHealth);
                  }
                  else
                  {
                     this._targetCreep._health.Add(-_loc2_);
                  }
               }
               ATTACK.Damage(this._startPoint.x,this._startPoint.y,_loc2_);
            }
            else if(this._targetType == 2)
            {
               if(this._targetBuilding._hp.Get() > 0)
               {
                  _loc3_ = this._targetBuilding.Damage(this._damage,this._targetBuilding._position.x,this._targetBuilding._position.y,1,true);
                  ATTACK.Damage(this._startPoint.x,this._startPoint.y,_loc3_);
               }
            }
            else if(this._targetType != 3)
            {
               if(this._targetType == 4)
               {
                  _loc4_ = BUILDING14(GLOBAL._bTownhall)._vacuum;
                  if((Boolean(_loc4_)) && this._targetCreep == _loc4_)
                  {
                     BUILDING14(GLOBAL._bTownhall)._vacuumHealth.Add(-this._damage);
                     ATTACK.Damage(this._startPoint.x,this._startPoint.y,this._damage);
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
      
      public function Render() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(GLOBAL._render)
         {
            this._graphic.x = int(this._tmpX);
            this._graphic.y = int(this._tmpY);
         }
         if(this._graphicName)
         {
            _loc1_ = Math.atan2(this._targetPoint.y - this._tmpY,this._targetPoint.x - this._tmpX);
            _loc2_ = _loc1_ * (180 / Math.PI);
            SPRITES.GetSprite(this._bitmapData,this._graphicName,"",_loc2_,this._frameNumber);
         }
      }
      
      public function Splash() : void
      {
         var _loc1_:Object = null;
         var _loc2_:MonsterBase = null;
         var _loc3_:Number = NaN;
         var _loc4_:Point = null;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         if(this._targetCreep._movement == "fly")
         {
            _loc6_ = MAP.CreepCellFind(new Point(this._tmpX,this._tmpY),this._splash,2);
         }
         else
         {
            _loc6_ = MAP.CreepCellFind(new Point(this._tmpX,this._tmpY),this._splash);
         }
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         while(_loc8_ < _loc6_.length)
         {
            _loc1_ = _loc6_[_loc8_];
            _loc2_ = _loc1_.creep;
            if(!(_loc2_._friendly && this._damage < 0))
            {
               if(_loc2_ == this._targetCreep)
               {
                  if(this._damage > 0)
                  {
                     _loc2_._health.Add(-(_loc2_._damageMult * this._damage));
                     _loc7_ += _loc2_._damageMult * this._damage;
                  }
                  else if(_loc2_._creatureID.substr(0,1) == "G")
                  {
                     _loc2_._health.Add(-this._damage / 10);
                     _loc7_ += this._damage / 10;
                  }
                  else
                  {
                     _loc2_._health.Add(-this._damage);
                     _loc7_ += this._damage;
                  }
                  if(_loc2_._health.Get() > _loc2_._maxHealth)
                  {
                     _loc7_ -= _loc2_._maxHealth - _loc2_._health.Get();
                     _loc2_._health.Set(_loc2_._maxHealth);
                  }
               }
               else
               {
                  _loc3_ = Number(_loc1_.dist);
                  _loc4_ = _loc1_.pos;
                  _loc5_ = this._damage * 0.75 / this._splash * (this._splash - _loc3_);
                  if(_loc5_ > 0)
                  {
                     _loc2_._health.Add(-(_loc2_._damageMult * _loc5_));
                     _loc7_ += _loc2_._damageMult * _loc5_;
                  }
                  else if(_loc2_._creatureID.substr(0,1) == "G")
                  {
                     _loc2_._health.Add(-_loc5_ / 10);
                     _loc7_ += _loc5_ / 10;
                  }
                  else
                  {
                     _loc2_._health.Add(-_loc5_);
                     _loc7_ += _loc5_;
                  }
                  if(_loc2_._health.Get() > _loc2_._maxHealth)
                  {
                     _loc7_ -= _loc2_._maxHealth - _loc2_._health.Get();
                     _loc2_._health.Set(_loc2_._maxHealth);
                  }
               }
            }
            _loc8_++;
         }
         ATTACK.Damage(this._startPoint.x,this._startPoint.y,_loc7_);
      }
      
      public function FindGlaveTarget() : void
      {
         var _loc1_:Point = null;
         var _loc2_:Point = null;
         var _loc3_:int = 0;
         var _loc5_:BFOUNDATION = null;
         var _loc6_:String = null;
         var _loc4_:Array = [];
         _loc1_ = new Point(this._graphic.x,this._graphic.y);
         for(_loc6_ in BASE._buildingsMain)
         {
            _loc5_ = BASE._buildingsMain[_loc6_];
            if(_loc5_._class != "decoration" && _loc5_._class != "immovable" && _loc5_._hp.Get() > 0 && _loc5_._class != "enemy" && _loc5_._class != "trap" && !(_loc5_ is BTOWER && (_loc5_ as BTOWER).isJard))
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

