package
{
   import com.monsters.display.BuildingOverlay;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class INFERNOQUAKETOWER extends BTOWER
   {
      private var _shouldAnimate:Boolean;
      
      public function INFERNOQUAKETOWER()
      {
         super();
         _type = 129;
         _top = 40;
         _footprint = [new Rectangle(0,0,70,70)];
         _gridCost = [[new Rectangle(0,0,70,70),10],[new Rectangle(10,10,50,50),200]];
         SetProps();
         Props();
      }
      
      override public function PlaceB() : *
      {
         super.PlaceB();
         _origin = new Point(x,y);
      }
      
      override public function TickFast(param1:Event = null) : *
      {
         if(_shake > 0)
         {
            _mc.x = _origin.x - 2 + Math.random() * 4;
            _mc.y = _origin.y - 2 + Math.random() * 4;
            _mcBase.x = _origin.x - 1 + Math.random() * 2;
            _mcBase.y = _origin.y - 1 + Math.random() * 2;
            --_shake;
            if(_shake == 0)
            {
               _mc.x = _origin.x;
               _mc.y = _origin.y;
               _mcBase.x = _origin.x;
               _mcBase.y = _origin.y;
            }
         }
      }
      
      override public function Update(param1:Boolean = false) : *
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(GLOBAL._render || param1)
         {
            _loc4_ = [];
            if(_repairing == 1)
            {
               _loc5_ = 0;
               _loc6_ = _lvl.Get() == 0 ? 0 : _lvl.Get() - 1;
               _loc5_ = Math.ceil(_hpMax.Get() / Math.min(60 * 60,_buildingProps.repairTime[_loc6_]));
               _repairTime = int(_hpMax.Get() - _hp.Get()) / _loc5_;
               QUEUE.Update("building" + _id,KEYS.Get("ui_worker_stacktitle_repairing"),GLOBAL.ToTime(_repairTime,true));
            }
            else if(_countdownBuild.Get() > 0)
            {
               QUEUE.Update("building" + _id,KEYS.Get("ui_worker_stacktitle_building"),GLOBAL.ToTime(_countdownBuild.Get(),true));
            }
            else if(_countdownUpgrade.Get() > 0)
            {
               QUEUE.Update("building" + _id,KEYS.Get("ui_worker_stacktitle_upgrading"),GLOBAL.ToTime(_countdownUpgrade.Get(),true));
            }
            else if(_countdownFortify.Get() > 0)
            {
               QUEUE.Update("building" + _id,KEYS.Get("ui_worker_stacktitle_fortifying"),GLOBAL.ToTime(_countdownFortify.Get(),true));
            }
            if(_class != "mushroom")
            {
               BuildingOverlay.Update(this,param1);
            }
            if(_hp.Get() <= 0)
            {
               Render("destroyed");
            }
            else if(_hp.Get() < _hpMax.Get() * 0.15)
            {
               Render("damaged");
            }
            else
            {
               Render("");
            }
         }
      }
      
      override public function TickAttack() : *
      {
         if(_hp.Get() < _hpMax.Get() * 0.15)
         {
            _animTick = 0;
            return;
         }
         if(this._shouldAnimate)
         {
            ++_frameNumber;
            if(_frameNumber % 6 == 0 || _animTick >= _animFrames - 4)
            {
               AnimFrame(false);
               if(_animTick < _animFrames)
               {
                  if(_animTick == _animFrames - 6)
                  {
                     SOUNDS.Play("quake");
                  }
                  ++_animTick;
               }
               else
               {
                  this._shouldAnimate = false;
                  this.DelayedFire();
               }
            }
         }
         else
         {
            super.TickAttack();
         }
      }
      
      override public function Fire(param1:*) : *
      {
         if(_hp.Get() < _hpMax.Get() * 0.15)
         {
            return;
         }
         this._shouldAnimate = true;
         _animTick = 0;
         super.Fire(param1);
      }
      
      private function DelayedFire() : void
      {
         var _loc2_:Number = 1;
         if(Boolean(GLOBAL._towerOverdrive) && GLOBAL._towerOverdrive.Get() >= GLOBAL.Timestamp())
         {
            _loc2_ = 1.25;
         }
         this.Quake(int(_damage * 1 * _loc2_));
         var _loc3_:QuakeGraphic = new QuakeGraphic(20,_range * 2);
         _loc3_.graphic.y += _top;
         _mc.addChild(_loc3_.graphic);
         _origin = new Point(x,y);
         _shake = 10;
      }
      
      private function Quake(param1:int) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc6_:Array = this.GetCreepsInRange();
         for(_loc8_ in _loc6_)
         {
            _loc2_ = _loc6_[_loc8_];
            _loc3_ = _loc2_.creep;
            _loc4_ = int(_loc2_.dist);
            _loc5_ = param1 / _range * (_range - _loc4_);
            if(_loc5_ < param1 / 3)
            {
               _loc5_ = param1 / 3;
            }
            _loc5_ *= _loc3_._damageMult;
            if(_loc5_ > _loc3_._health.Get())
            {
               _loc5_ = int(_loc3_._health.Get());
            }
            _loc7_ += _loc5_;
            _loc3_._health.Add(-_loc5_);
         }
         ATTACK.Damage(_mc.x,_mc.y - _top,_loc7_);
      }
      
      private function GetCreepsInRange() : Array
      {
         return MAP.CreepCellFind(new Point(_mc.x,_mc.y),_range,-1);
      }
      
      override public function Setup(param1:Object) : *
      {
         param1.t = _type;
         super.Setup(param1);
         _animRandomStart = false;
      }
   }
}

import flash.display.Shape;
import flash.filters.GlowFilter;
import gs.TweenLite;

class QuakeGraphic
{
   public var graphic:Shape;
   
   public function QuakeGraphic(param1:uint, param2:uint)
   {
      super();
      this.graphic = new Shape();
      this.graphic.graphics.lineStyle(0.3,0x6666cc,0.5);
      this.graphic.graphics.drawEllipse(-param1,-param1 / 2,param1 * 2,param1);
      this.graphic.graphics.drawEllipse(-param1 * 0.8,-param1 / 2.5,param1 * 1.6,param1 * 0.8);
      this.graphic.graphics.drawEllipse(-param1 * 0.6,-param1 / 3.333333,param1 * 1.2,param1 * 0.6);
      var _loc3_:GlowFilter = new GlowFilter(3379402,1,20,20,5 + Math.random() * 5,1,false,false);
      this.graphic.filters = [_loc3_];
      TweenLite.to(this.graphic,1,{
         "width":param2 * 2,
         "height":param2,
         "alpha":0,
         "onComplete":this.onComplete
      });
   }
   
   private function onComplete() : void
   {
      this.graphic.parent.removeChild(this.graphic);
      this.graphic.filters = [];
      this.graphic = null;
   }
}
