package
{
   import com.monsters.display.ImageCache;
   import com.monsters.pathing.PATHING;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.*;
   import gs.*;
   import gs.easing.*;
   
   public class WORKER extends WORKER_CLIP
   {
      public var _behaviour:String;
      
      public var _middle:int;
      
      public var _speed:Number;
      
      public var _targetRotation:Number;
      
      public var _targetPosition:Point;
      
      public var _targetTask:BFOUNDATION;
      
      public var _hasPath:Boolean;
      
      public var _frameNumber:Number;
      
      public var _scale:Number;
      
      public var _targetBuilding:*;
      
      public var _id:*;
      
      public var _size:Number;
      
      public var _container:*;
      
      public var _graphic:BitmapData;
      
      public var _lastRotation:int = 400;
      
      public var _messageMC:MovieClip;
      
      internal var frameCount:int;
      
      public var showTimer:Timer;
      
      public var hideTimer:Timer;
      
      public var yd:int;
      
      public var xd:int;
      
      public var _mc:*;
      
      internal var _waypoints:Array;
      
      internal var _waypointIndex:int;
      
      private var _hasGraphic:Boolean;
      
      private var configObject:Object;
      
      private var _pathID:int = 0;
      
      private var _jumping:Boolean = false;
      
      private var _jumpingUp:Boolean = false;
      
      private var _graphicMC:DisplayObject;
      
      public function WORKER(param1:*, param2:Point, param3:Number)
      {
         super();
         this._mc = this;
         this._middle = 5;
         this.showTimer = new Timer(500);
         this.showTimer.addEventListener("timer",this.sayShow);
         this.hideTimer = new Timer(2000);
         this.hideTimer.addEventListener("timer",this.sayHide);
         this._waypoints = [];
         this._id = GLOBAL.NextCreepID();
         this._container = param1;
         this._targetPosition = param2;
         x = this._targetPosition.x;
         y = this._targetPosition.y;
         this._targetRotation = param3;
         this._speed = 0;
         this._size = 10;
         this._frameNumber = int(Math.random() * 200);
         if(!BASE.isInferno())
         {
            this._graphic = new BitmapData(52,50,true,0xffffff);
         }
         else
         {
            this._graphic = new BitmapData(64,55,true,0xffffff);
         }
         SPRITES.SetupSprite("worker");
         this._graphicMC = addChild(new Bitmap(this._graphic));
         this._graphicMC.x = -26;
         this._graphicMC.y = -36;
         this._hasGraphic = false;
         ImageCache.GetImageWithCallBack("monsters/worker.png",this.onAssetLoaded);
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      private function onAssetLoaded(param1:String, param2:BitmapData) : void
      {
         this._hasGraphic = true;
         this.Update(true);
      }
      
      public function Clear() : *
      {
      }
      
      public function Tick() : *
      {
         ++this._frameNumber;
         var _loc1_:int = Math.random() * 600;
         if(_loc1_ < 5 && !this._targetTask && this._speed == 0)
         {
            this.Wander();
         }
         this.Move();
         if(this._hasGraphic)
         {
            this.Update();
         }
      }
      
      public function Wander() : *
      {
      }
      
      public function SetWaypoints(param1:Array, param2:BFOUNDATION = null, param3:int = 0) : *
      {
         if(this._pathID == param3)
         {
            this._hasPath = true;
            this._waypoints = param1;
         }
      }
      
      public function Update(param1:Boolean = false) : *
      {
         if(param1 || this._lastRotation != int(mcMarker.rotation / 12))
         {
            this._lastRotation = int(mcMarker.rotation / 12);
            SPRITES.GetSprite(this._graphic,"worker","walking",mcMarker.rotation,this._frameNumber);
         }
      }
      
      public function Target(param1:Point, param2:BFOUNDATION = null) : *
      {
         var _loc3_:Rectangle = null;
         if(!GLOBAL._catchup)
         {
            _loc3_ = new Rectangle(param1.x,param1.y,10,10);
            if(param2)
            {
               _loc3_ = new Rectangle(param2._mc.x,param2._mc.y,param2._footprint[0].width,param2._footprint[0].height);
            }
            this._hasPath = false;
            PATHING.GetPath(new Point(x,y),_loc3_,this.SetWaypoints,true,param2);
         }
         else
         {
            this._waypoints = [new Point(x,y)];
         }
      }
      
      public function Move() : *
      {
         var newSpeed:*;
         var difference:*;
         var r:int = 0;
         var building:BFOUNDATION = null;
         var Distance:int = 0;
         if(this._waypoints.length > 0)
         {
            this._targetPosition = this._waypoints[0];
            if(!this._jumping)
            {
               building = PATHING.GetBuildingFromISO(this._targetPosition);
               if(building)
               {
                  if(building._hp.Get() > 0)
                  {
                     TweenLite.to(this._graphicMC,0.4,{
                        "y":this._graphicMC.y - 40,
                        "ease":Sine.easeOut,
                        "overwrite":false,
                        "onComplete":function():*
                        {
                           _jumpingUp = false;
                        }
                     });
                     TweenLite.to(this._graphicMC,0.4,{
                        "y":this._graphicMC.y,
                        "ease":Bounce.easeOut,
                        "overwrite":false,
                        "delay":0.4,
                        "onComplete":function():*
                        {
                           _jumping = false;
                        }
                     });
                     this._jumping = true;
                     this._jumpingUp = true;
                     if(this._messageMC)
                     {
                        this.sayHide(null);
                     }
                  }
               }
            }
         }
         if(this._hasPath)
         {
            Distance = Point.distance(this._targetPosition,new Point(x,y));
            if(Distance < 20)
            {
               if(this._waypoints.length > 0)
               {
                  this._targetPosition = this._waypoints[0];
                  this._waypoints.splice(0,1);
               }
               if(this._waypoints.length == 0)
               {
                  if(this._speed > 0)
                  {
                     this._speed -= 0.1;
                  }
                  else
                  {
                     this._speed = 0;
                  }
                  if(Boolean(this._targetTask) && !this._targetTask._hasWorker)
                  {
                     this._targetTask.HasWorker();
                  }
               }
            }
            else if(!this._targetTask)
            {
               if(this._speed < 1)
               {
                  this._speed += 0.05;
               }
               else
               {
                  this._speed -= 0.05;
               }
            }
            else if(this._speed < 2)
            {
               this._speed += 0.05;
            }
            else
            {
               this._speed -= 0.05;
            }
         }
         newSpeed = this._speed;
         if(this._jumping)
         {
            if(this._jumpingUp)
            {
               newSpeed *= 3;
            }
            else
            {
               newSpeed *= 2;
            }
         }
         y += Math.sin(mcMarker.rotation * 0.0174532925) * newSpeed;
         x += Math.cos(mcMarker.rotation * 0.0174532925) * newSpeed;
         this.yd = this._targetPosition.y - y;
         this.xd = this._targetPosition.x - x;
         this._targetRotation = Math.atan2(this.yd,this.xd) * 57.2957795 - 90;
         difference = mcMarker.rotation - this._targetRotation;
         if(difference > 3 * 60)
         {
            this._targetRotation += 6 * 60;
         }
         else if(difference < -180)
         {
            this._targetRotation -= 360;
         }
         this._targetRotation += 90;
         if(!this._targetTask)
         {
            r = (this._targetRotation - mcMarker.rotation) / 5;
         }
         else
         {
            r = (this._targetRotation - mcMarker.rotation) / 3;
         }
         if(r != 0)
         {
            mcMarker.rotation += r;
         }
         if(this._messageMC)
         {
            this._messageMC.x = x - 5;
            this._messageMC.y = y - 15;
         }
      }
      
      public function Say(param1:String, param2:int = 2000) : *
      {
         this.hideTimer.stop();
         this.hideTimer.delay = param2;
         if(this._messageMC)
         {
            MAP._PROJECTILES.removeChild(this._messageMC);
         }
         this._messageMC = MAP._PROJECTILES.addChild(new workerMessage());
         this._messageMC.visible = false;
         this._messageMC.txt.autoSize = "left";
         this._messageMC.txt.htmlText = param1;
         if(param1.length < 5)
         {
            this._messageMC.txt.width = 40;
            this._messageMC.mcBG.width = 50;
         }
         else if(param1.length < 12)
         {
            this._messageMC.txt.width = 70;
            this._messageMC.mcBG.width = 80;
         }
         else
         {
            this._messageMC.txt.width = 90;
            this._messageMC.mcBG.width = 100;
         }
         this._messageMC.mcBG.height = this._messageMC.txt.height + 17;
         this._messageMC.txt.y = 0 - this._messageMC.mcBG.height + 5;
         this.showTimer.start();
      }
      
      internal function sayShow(param1:TimerEvent = null) : *
      {
         if(this._messageMC)
         {
            this._messageMC.visible = true;
            this.hideTimer.start();
         }
         this.showTimer.stop();
      }
      
      internal function sayHide(param1:TimerEvent) : *
      {
         TweenLite.to(this._messageMC,0.5,{
            "alpha":0,
            "onComplete":this.sayHideB
         });
         this.hideTimer.stop();
      }
      
      internal function sayHideB() : *
      {
         if(Boolean(this._messageMC) && Boolean(this._messageMC.parent))
         {
            this._messageMC.parent.removeChild(this._messageMC);
            this._messageMC = null;
         }
      }
   }
}

