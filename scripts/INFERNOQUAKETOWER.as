package
{
   import com.monsters.display.BuildingOverlay;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class INFERNOQUAKETOWER extends BTOWER
   {
      public static const UNDERHALL_ID:int = 999;
      
      public static const TYPE:int = 129;
      
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
         _origin = new Point(_mc.x,_mc.y);
      }
      
      override public function FollowMouseB(param1:Event = null) : *
      {
         super.FollowMouseB(param1);
         _origin = new Point(_mc.x,_mc.y);
      }
      
      override public function StopMoveB() : *
      {
         super.StopMoveB();
         _origin = new Point(_mc.x,_mc.y);
      }
      
      override public function TickFast(param1:Event = null) : *
      {
         super.TickFast(param1);
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
               _loc6_ = _lvl.Get() == 0 ? 0 : int(_lvl.Get() - 1);
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
            else if(_hp.Get() < _hpMax.Get() * 0.5)
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
         if(_hp.Get() <= 0)
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
                     SOUNDS.Play("quake",!isJard ? 0.8 : 0.4);
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
         if(_hp.Get() <= 0)
         {
            return;
         }
         this._shouldAnimate = true;
         _animTick = 0;
         super.Fire(param1);
      }
      
      private function DelayedFire() : void
      {
         var _loc3_:QuakeGraphic = null;
         var _loc2_:Number = 1;
         if(Boolean(GLOBAL._towerOverdrive) && GLOBAL._towerOverdrive.Get() >= GLOBAL.Timestamp())
         {
            _loc2_ = 1.25;
         }
         if(isJard)
         {
            _jarHealth.Add(-int(_damage * 3 * 1 * _loc2_));
            ATTACK.Damage(_mc.x,_mc.y + _top,_damage * 3 * 1 * _loc2_);
            if(_jarHealth.Get() <= 0)
            {
               KillJar();
            }
         }
         else
         {
            this.Quake(int(_damage * 1 * _loc2_));
            _loc3_ = new QuakeGraphic(20,_range * 2);
            _loc3_.graphic.y += _top;
            _mc.addChild(_loc3_.graphic);
         }
         _origin = new Point(_mc.x,_mc.y);
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
         if(Boolean((GLOBAL._bTownhall as BUILDING14)._vacuum) && GLOBAL.QuickDistance(_position,GLOBAL._bTownhall._position) < _range)
         {
            _loc5_ = param1 / _range * (_range - GLOBAL.QuickDistance(_position,GLOBAL._bTownhall._position));
            (GLOBAL._bTownhall as BUILDING14)._vacuumHealth.Add(-_loc5_);
            _loc7_ += _loc5_;
         }
         ATTACK.Damage(_mc.x,_mc.y - _top,_loc7_);
      }
      
      private function GetCreepsInRange() : Array
      {
         return MAP.CreepCellFind(_position.add(new Point(0,_footprint[0].height / 2)),_range,-1);
      }
      
      override public function Upgraded() : *
      {
         var _loc1_:MovieClip = null;
         super.Upgraded();
         if(GLOBAL._mode == "build" && !BASE.isInferno())
         {
            _loc1_ = new popup_building();
            _loc1_.tA.htmlText = "<b>" + KEYS.Get("pop_tupgraded_title",{
               "v1":KEYS.Get(_buildingProps.name),
               "v2":_lvl.Get()
            }) + "</b>";
            _loc1_.tB.htmlText = KEYS.Get("pop_tupgraded_body",{"v1":KEYS.Get(_buildingProps.name)});
            _loc1_.bPost.SetupKey("btn_brag");
            _loc1_.bPost.addEventListener(MouseEvent.CLICK,this.UpgradedBrag);
            _loc1_.bPost.Highlight = true;
            POPUPS.Push(_loc1_,null,null,null,"build.v2.png");
         }
      }
      
      private function UpgradedBrag(param1:MouseEvent) : *
      {
         GLOBAL.CallJS("sendFeed",["build-" + String(_buildingProps.name).toLowerCase(),KEYS.Get("upgrade_quaketower_streamtitle",{"v1":_lvl.Get()}),KEYS.Get("upgrade_quaketower_streambody"),"quests/quake_tower.png"]);
         POPUPS.Next();
      }
      
      override public function Constructed() : *
      {
         var _loc1_:MovieClip = null;
         super.Constructed();
         if(GLOBAL._mode == "build" && !BASE.isInferno())
         {
            _loc1_ = new popup_building();
            _loc1_.tA.htmlText = "<b>" + KEYS.Get("pop_tupgraded_title",{
               "v1":KEYS.Get(_buildingProps.name),
               "v2":_lvl.Get()
            }) + "</b>";
            _loc1_.tB.htmlText = KEYS.Get("pop_tbuild_body",{"v1":KEYS.Get(_buildingProps.name)});
            _loc1_.bPost.SetupKey("btn_brag");
            _loc1_.bPost.addEventListener(MouseEvent.CLICK,this.ConstructedBrag);
            _loc1_.bPost.Highlight = true;
            POPUPS.Push(_loc1_,null,null,null,"build.v2.png");
         }
      }
      
      private function ConstructedBrag(param1:MouseEvent) : *
      {
         GLOBAL.CallJS("sendFeed",["build-" + String(_buildingProps.name).toLowerCase(),KEYS.Get("build_quaketower_streamtitle"),KEYS.Get("build_quaketower_streambody"),"quests/quake_tower.png"]);
         POPUPS.Next();
      }
      
      override public function Setup(param1:Object) : *
      {
         param1.t = _type;
         super.Setup(param1);
         _origin = new Point(_mc.x,_mc.y);
         _animRandomStart = false;
      }
      
      override public function Export() : *
      {
         var _loc1_:Object = super.Export();
         var _loc2_:Point = GRID.FromISO(_origin.x,_origin.y);
         _loc1_.X = _loc2_.x;
         _loc1_.Y = _loc2_.y;
         return _loc1_;
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
