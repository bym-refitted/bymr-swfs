package
{
   import com.monsters.pathing.PATHING;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BUILDING118 extends BTOWER
   {
      public var _animMC:*;
      
      public var _frameNumber:int;
      
      public var _animBitmap:BitmapData;
      
      private var _gunballs:Array = [];
      
      private var _trail:Array = [];
      
      private var _spawnCount:int = 0;
      
      private var _segment:Point;
      
      private var _spot:Point;
      
      private var _fireCount:int;
      
      public function BUILDING118()
      {
         super();
         this._frameNumber = 0;
         _type = 118;
         _top = 15;
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
            _loc6_ = Math.atan2(_loc5_,_loc4_) * 57.2957795 + 30;
            if(_loc6_ < 0)
            {
               _loc6_ = 6 * 60 + _loc6_;
            }
            if(_loc6_ > 6 * 60)
            {
               _loc6_ -= 360;
            }
            _loc6_ /= 12;
            _animTick = int(_loc6_);
            this.AnimFrame();
            ++this._frameNumber;
         }
      }
      
      override public function TickFast(param1:Event = null) : *
      {
         var length:int = 0;
         var i:int = 0;
         var da:Number = NaN;
         var e:Event = param1;
         super.TickFast();
         if(this._gunballs.length > 0)
         {
            ++this._fireCount;
            if(this._fireCount > 10)
            {
               try
               {
                  length = int(this._gunballs.length);
                  i = 0;
                  while(i < length)
                  {
                     if(this._fireCount > 15)
                     {
                        MAP._PROJECTILES.removeChild(this._gunballs[i]);
                        MAP._PROJECTILES.removeChild(this._trail[i]);
                     }
                     else
                     {
                        da = 1 - (this._fireCount - 10) * 0.2;
                        this._gunballs[i].alpha = da;
                        this._trail[i].alpha = da;
                     }
                     i++;
                  }
               }
               catch(e:Error)
               {
               }
            }
         }
         if(this._fireCount > 15)
         {
            this._gunballs = [];
            this._trail = [];
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
         var damagepenalty:Number;
         var damagebuff:Number;
         var origin:Point;
         var yd:Number;
         var xd:Number;
         var i:int;
         var creeps:Array;
         var length:int;
         var totalDamage:int;
         var finishPoint:Point;
         var j:int;
         var c:* = undefined;
         var target:* = param1;
         super.Fire(target);
         SOUNDS.Play("railgun1");
         damagepenalty = 0.5 + 0.5 / _hpMax.Get() * _hp.Get();
         damagebuff = 1;
         if(Boolean(GLOBAL._towerOverdrive) && GLOBAL._towerOverdrive.Get() >= GLOBAL.Timestamp())
         {
            damagebuff = 1.25;
         }
         origin = new Point(_mc.x,_mc.y + _top);
         this._spot = new Point(origin.x,origin.y);
         yd = target._tmpPoint.y - origin.y;
         xd = target._tmpPoint.x - origin.x;
         this._segment = new Point(Math.cos(Math.atan2(yd,xd)) * 32,Math.sin(Math.atan2(yd,xd)) * 32);
         while(this._gunballs.length > 0)
         {
            try
            {
               MAP._PROJECTILES.removeChild(this._gunballs[0]);
               MAP._PROJECTILES.removeChild(this._trail[0]);
            }
            catch(e:Error)
            {
            }
            this._gunballs.shift();
            this._trail.shift();
         }
         this._spawnCount = 0;
         this._fireCount = 0;
         i = 0;
         while(i < 50)
         {
            this._gunballs[i] = new RAILGUNPROJECTILE_CLIP();
            this._gunballs[i].x = this._spot.x + this._segment.x;
            this._gunballs[i].y = this._spot.y + this._segment.y;
            this._trail[i] = new Shape();
            this._trail[i].graphics.lineStyle(1,0xffffff,1);
            this._trail[i].graphics.moveTo(this._spot.x,this._spot.y);
            this._trail[i].graphics.lineTo(this._spot.x + this._segment.x,this._spot.y + this._segment.y);
            this._trail[i].filters = [new GlowFilter(0x88bb,1,5 + Math.random() * 2,5 + Math.random() * 2,4,1,false,false)];
            this._spot = this._spot.add(this._segment);
            MAP._PROJECTILES.addChild(this._trail[i]);
            MAP._PROJECTILES.addChild(this._gunballs[i]);
            ++this._spawnCount;
            i++;
         }
         creeps = MAP.CreepCellFind(origin,1600,-1);
         length = int(creeps.length);
         totalDamage = 0;
         finishPoint = origin.add(new Point(this._segment.x * 50,this._segment.y * 50));
         j = 0;
         while(j < length)
         {
            c = creeps[j].creep;
            if(this.lineIntersectCircle(origin,finishPoint,c._tmpPoint))
            {
               totalDamage += _damage * damagebuff * damagepenalty * c._damageMult;
               c._health.Add(-(_damage * damagebuff * damagepenalty * c._damageMult));
            }
            j++;
         }
         ATTACK.Damage(_mc.x,_mc.y + _top,totalDamage);
      }
      
      private function lineIntersectCircle(param1:Point, param2:Point, param3:Point, param4:Number = 20) : Boolean
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc5_:Number = (param2.x - param1.x) * (param2.x - param1.x) + (param2.y - param1.y) * (param2.y - param1.y);
         var _loc6_:Number = 2 * ((param2.x - param1.x) * (param1.x - param3.x) + (param2.y - param1.y) * (param1.y - param3.y));
         var _loc7_:Number = param3.x * param3.x + param3.y * param3.y + param1.x * param1.x + param1.y * param1.y - 2 * (param3.x * param1.x + param3.y * param1.y) - param4 * param4;
         var _loc8_:Number = _loc6_ * _loc6_ - 4 * _loc5_ * _loc7_;
         if(_loc8_ <= 0)
         {
            return false;
         }
         _loc9_ = Math.sqrt(_loc8_);
         _loc10_ = (-_loc6_ + _loc9_) / (2 * _loc5_);
         _loc11_ = (-_loc6_ - _loc9_) / (2 * _loc5_);
         if((_loc10_ < 0 || _loc10_ > 1) && (_loc11_ < 0 || _loc11_ > 1))
         {
            return false;
         }
         return true;
      }
      
      override public function Props() : *
      {
         super.Props();
      }
      
      override public function Upgraded() : *
      {
         super.Upgraded();
      }
      
      override public function Destroyed(param1:Boolean = true) : *
      {
         var loot:Boolean = param1;
         super.Destroyed(loot);
         while(this._gunballs.length > 0)
         {
            try
            {
               MAP._PROJECTILES.removeChild(this._gunballs[0]);
               MAP._PROJECTILES.removeChild(this._trail[0]);
            }
            catch(e:Error)
            {
            }
            this._gunballs.shift();
            this._trail.shift();
         }
         this._spawnCount = 0;
         this._fireCount = 0;
      }
      
      override public function Constructed() : *
      {
         var Brag:Function;
         var mc:MovieClip = null;
         super.Constructed();
         if(GLOBAL._mode == "build" && !BASE._isOutpost)
         {
            Brag = function(param1:MouseEvent):*
            {
               GLOBAL.CallJS("sendFeed",["build-wmb",KEYS.Get("pop_railgunbuilt_streamtitle"),KEYS.Get("pop_railgunbuilt_streambody"),"build_railgun.png"]);
               POPUPS.Next();
            };
            mc = new popup_building();
            mc.tA.htmlText = "<b>" + KEYS.Get("pop_railgunbuilt_title") + "</b>";
            mc.tB.htmlText = KEYS.Get("pop_railgunbuilt_body");
            mc.bPost.SetupKey("btn_brag");
            mc.bPost.addEventListener(MouseEvent.CLICK,Brag);
            mc.bPost.Highlight = true;
            POPUPS.Push(mc,null,null,null,"build.png");
         }
      }
   }
}

