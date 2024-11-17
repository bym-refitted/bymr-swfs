package
{
   import com.monsters.pathing.PATHING;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BUILDING115 extends BTOWER
   {
      public var _animMC:*;
      
      public var _frameNumber:int;
      
      public var _animBitmap:BitmapData;
      
      public var _shotsFired:int;
      
      public var _lostCreep:Boolean = false;
      
      public var _fireStage:int = 1;
      
      public var _targetArray:Array = [4,4,6,8,10];
      
      public function BUILDING115()
      {
         super();
         this._frameNumber = 0;
         _type = 115;
         _top = -5;
         _footprint = [new Rectangle(0,0,70,70)];
         _gridCost = [[new Rectangle(0,0,70,70),10],[new Rectangle(10,10,50,50),200]];
         this._fireStage = 1;
         SetProps();
         this.Props();
      }
      
      override public function TickAttack() : *
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         var _loc5_:Point = null;
         var _loc6_:Point = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc1_:int = int(this._targetArray[_lvl.Get() - 1]);
         ++this._frameNumber;
         if(_hp.Get() > 0 && _countdownBuild.Get() + _countdownUpgrade.Get() == 0)
         {
            if(this._fireStage == 1)
            {
               --_fireTick;
               if(_fireTick <= 0)
               {
                  this._fireStage = 2;
                  this._shotsFired = 0;
                  _fireTick += _rate * 2;
               }
            }
            if(this._fireStage == 2)
            {
               if(!_hasTargets || !targetInRange())
               {
                  FindTargets(_loc1_,_priority);
                  _fireTick = 2;
               }
               else if(this._shotsFired >= _loc1_)
               {
                  this._fireStage = 1;
               }
               else if(this._frameNumber % 4 == 0)
               {
                  _loc2_ = false;
                  _loc3_ = this._shotsFired % _targetCreeps.length;
                  if(_targetCreeps[_loc3_].creep._health.Get() > 0)
                  {
                     this.Fire(_targetCreeps[_loc3_].creep);
                     ++this._shotsFired;
                  }
                  else
                  {
                     _loc2_ = true;
                  }
                  if(Boolean(_retarget) || _loc2_)
                  {
                     FindTargets(_loc1_,_priority);
                  }
               }
            }
         }
         if(_hasTargets)
         {
            _loc4_ = _targetCreeps[0].creep;
            _loc5_ = PATHING.FromISO(_loc4_._tmpPoint);
            _loc6_ = PATHING.FromISO(new Point(_mc.x,_mc.y));
            _loc6_ = _loc6_.add(new Point(35,35));
            _loc7_ = _loc5_.x - _loc6_.x;
            _loc8_ = _loc5_.y - _loc6_.y;
            _loc9_ = Math.atan2(_loc8_,_loc7_) * 57.2957795;
            if(_loc9_ < 0)
            {
               _loc9_ = 6 * 60 + _loc9_;
            }
            _loc9_ /= 12;
            _animTick = int(_loc9_);
            this.AnimFrame();
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
         PROJECTILES.Spawn(new Point(_mc.x,_mc.y + _top),null,param1,_speed,int(_damage * _loc2_ * _loc3_),false,_splash,2);
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
            if(_lvl.Get() > 1)
            {
               _upgradeDescription += "<b>Shots fired per salvo:</b> Increases from " + this._targetArray[_lvl.Get() - 1] + " to " + this._targetArray[_lvl.Get()] + "<br>";
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
         var Brag:Function;
         var mc:MovieClip = null;
         super.Constructed();
         if(GLOBAL._mode == "build" && !BASE._isOutpost)
         {
            Brag = function():*
            {
               GLOBAL.CallJS("sendFeed",["aatower-construct",KEYS.Get("pop_aabuilt_streamtitle"),KEYS.Get("pop_aabuilt_streambody"),"build-aerial.v2.png"]);
               POPUPS.Next();
            };
            mc = new popup_building();
            mc.tA.htmlText = "<b>" + KEYS.Get("pop_aabuilt_title") + "</b>";
            mc.tB.htmlText = KEYS.Get("pop_aabuilt_body");
            mc.bPost.SetupKey("btn_brag");
            mc.bPost.addEventListener(MouseEvent.CLICK,Brag);
            mc.bPost.Highlight = true;
            POPUPS.Push(mc,null,null,null,"build.png");
         }
      }
   }
}

