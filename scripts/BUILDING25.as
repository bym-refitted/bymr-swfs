package
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BUILDING25 extends BTOWER
   {
      public var _field:BitmapData;
      
      public var _fieldBMP:Bitmap;
      
      public var _frameNumber:int;
      
      public var _animBitmap:BitmapData;
      
      public var _fireStage:int;
      
      public var _shotsFired:int;
      
      public var _target:MovieClip;
      
      public function BUILDING25()
      {
         super();
         _type = 25;
         this._frameNumber = 0;
         _animTick = 0;
         _top = -30;
         this._fireStage = 0;
         this._shotsFired = 0;
         _footprint = [new Rectangle(0,0,70,70)];
         _gridCost = [[new Rectangle(0,0,70,70),10],[new Rectangle(10,10,50,50),200]];
         SetProps();
         this.Props();
      }
      
      override public function Description() : *
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         super.Description();
         _upgradeDescription = "";
         if(_lvl.Get() > 0 && _lvl.Get() < _buildingProps.costs.length)
         {
            _loc1_ = _buildingProps.stats[_lvl.Get() - 1];
            _loc2_ = _buildingProps.stats[_lvl.Get()];
            _loc3_ = int(_loc1_.range);
            _loc4_ = int(_loc2_.range);
            if(BASE._isOutpost)
            {
               _loc3_ = BTOWER.AdjustTowerRange(GLOBAL._currentCell,_loc3_);
               _loc4_ = BTOWER.AdjustTowerRange(GLOBAL._currentCell,_loc4_);
            }
            if(_loc1_.range < _loc2_.range)
            {
               _upgradeDescription += "<b>Range:</b> Increases from " + _loc3_ + " to " + _loc4_ + "<br>";
            }
            if(_loc1_.damage < _loc2_.damage)
            {
               _upgradeDescription += "<b>Damage per shot:</b> Increases from " + _loc1_.damage + " to " + _loc2_.damage + "<br>";
            }
            if(_loc1_.rate < _loc2_.rate)
            {
               _upgradeDescription += "<b>Shots fired per charge:</b> Increases from " + _loc1_.rate + " to " + _loc2_.rate + "<br>";
            }
         }
      }
      
      override public function AnimFrame(param1:Boolean = true) : *
      {
         var increment:Boolean = param1;
         try
         {
            if(_animLoaded && !GLOBAL._catchup)
            {
               _animContainerBMD.copyPixels(_animBMD,new Rectangle(_animRect.width * _animTick,0,_animRect.width,_animRect.height),new Point(0,0));
            }
         }
         catch(e:Error)
         {
         }
      }
      
      override public function Fire(param1:*) : *
      {
         super.Fire(param1);
         this._target = param1;
         if(this._fireStage == 0)
         {
            this._fireStage = 1;
            SOUNDS.Play("lightningstart");
         }
      }
      
      override public function TickFast(param1:Event = null) : *
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         super.TickFast(param1);
         ++this._frameNumber;
         if(this._frameNumber == 40)
         {
            this._frameNumber = 4;
         }
         if(!GLOBAL._catchup)
         {
            if(this._fireStage == 1)
            {
               ++_animTick;
               if(_animTick == 32)
               {
                  this._fireStage = 2;
                  this._shotsFired = 0;
               }
            }
            else if(this._fireStage == 2)
            {
               if(_hp.Get() <= 0)
               {
                  this._fireStage = 3;
               }
               else
               {
                  ++_animTick;
                  if(_animTick == 41)
                  {
                     _animTick = 32;
                  }
                  if(this._frameNumber % 4 == 0)
                  {
                     if(_hasTargets)
                     {
                        if(this._target._movement == "fly")
                        {
                           EFFECTS.Lightning(_mc.x,_mc.y - 50,this._target.x,this._target.y - this._target._altitude);
                        }
                        else
                        {
                           EFFECTS.Lightning(_mc.x,_mc.y - 50,this._target.x,this._target.y);
                        }
                        _loc2_ = 0.5 + 0.5 / _hpMax.Get() * _hp.Get();
                        _loc3_ = 1;
                        if(Boolean(GLOBAL._towerOverdrive) && GLOBAL._towerOverdrive.Get() >= GLOBAL.Timestamp())
                        {
                           _loc3_ = 1.25;
                        }
                        this._target._health.Add(-(this._target._damageMult * int(_damage * _loc2_ * _loc3_)));
                        ATTACK.Damage(_mc.x,_mc.y - 50,int(_damage * _loc2_ * _loc3_));
                     }
                     SOUNDS.Play("lightningfire");
                     ++this._shotsFired;
                     if(this._shotsFired >= _rate)
                     {
                        this._fireStage = 3;
                        SOUNDS.Play("lightningend");
                     }
                     else if(this._target._health.Get() <= 0)
                     {
                        _hasTargets = false;
                        FindTargets(1,_priority);
                        if(!_hasTargets)
                        {
                           this._fireStage = 3;
                        }
                        SOUNDS.Play("lightningend");
                     }
                  }
               }
            }
            else if(this._fireStage == 3)
            {
               if(this._frameNumber % 2 == 0)
               {
                  ++_animTick;
                  if(_animTick == 55)
                  {
                     _animTick = 0;
                     this._fireStage = 0;
                  }
               }
            }
            if(GLOBAL._render && _animTick > 0)
            {
               this.AnimFrame();
            }
         }
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

