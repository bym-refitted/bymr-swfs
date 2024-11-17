package
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BUILDING26 extends BFOUNDATION
   {
      public var _field:BitmapData;
      
      public var _fieldBMP:Bitmap;
      
      public var _frameNumber:int;
      
      public var _animBitmap:BitmapData;
      
      public function BUILDING26()
      {
         super();
         _type = 26;
         _footprint = [new Rectangle(0,0,100,100)];
         _gridCost = [[new Rectangle(0,0,100,100),10],[new Rectangle(10,10,80,80),200]];
         SetProps();
      }
      
      override public function Click(param1:MouseEvent = null) : *
      {
         if(_upgrading && ACADEMY._upgrades[_upgrading] && ACADEMY._upgrades[_upgrading].time == null)
         {
            _upgrading = null;
         }
         ACADEMY._monsterID = _upgrading;
         super.Click(param1);
      }
      
      override public function Tick() : *
      {
         super.Tick();
         if(!_upgrading && !_repairing && _countdownBuild.Get() + _countdownUpgrade.Get() == 0)
         {
            CatchupRemove();
         }
      }
      
      override public function TickFast(param1:Event = null) : *
      {
         super.TickFast(param1);
         if(_upgrading && GLOBAL._render && _countdownBuild.Get() + _countdownUpgrade.Get() == 0)
         {
            if(GLOBAL._render && _animLoaded && _countdownBuild.Get() + _countdownUpgrade.Get() == 0)
            {
               if(GLOBAL._mode == "build" && (this._frameNumber % 3 == 0 || GLOBAL._lockerOverdrive > 0) && CREEPS._creepCount == 0)
               {
                  this.AnimFrame();
               }
               else if(this._frameNumber % 10 == 0 || GLOBAL._lockerOverdrive > 0 && this._frameNumber % 4 == 0)
               {
                  this.AnimFrame();
               }
            }
         }
         ++this._frameNumber;
      }
      
      override public function Constructed() : *
      {
         var Brag:Function;
         var mc:MovieClip = null;
         super.Constructed();
         GLOBAL._bAcademy = this;
         if(GLOBAL._mode == "build" && !BASE._isOutpost)
         {
            Brag = function():*
            {
               GLOBAL.CallJS("sendFeed",["academy-construct",KEYS.Get("pop_acadbuilt_streamtitle"),KEYS.Get("pop_acadbuilt_streambody"),"build-academy.png"]);
               POPUPS.Next();
            };
            mc = new popup_building();
            mc.tA.htmlText = "<b>" + KEYS.Get("pop_acadbuilt_title") + "</b>";
            mc.tB.htmlText = KEYS.Get("pop_acadbuilt_body");
            mc.bPost.SetupKey("btn_brag");
            mc.bPost.addEventListener(MouseEvent.CLICK,Brag);
            mc.bPost.Highlight = true;
            POPUPS.Push(mc,null,null,null,"build.png");
         }
      }
      
      override public function Description() : *
      {
         try
         {
            super.Description();
            if(_upgrading != null)
            {
               _specialDescription = "Training " + CREATURELOCKER._creatures[_upgrading].name + " - " + GLOBAL.ToTime(ACADEMY._upgrades[_upgrading].time.Get() - GLOBAL.Timestamp()) + " remaining.";
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","BUILDING26.Description _upgrading:" + _upgrading);
         }
      }
      
      override public function AnimFrame(param1:Boolean = true) : *
      {
         var increment:Boolean = param1;
         try
         {
            _animContainerBMD.copyPixels(_animBMD,new Rectangle(_animRect.width * _animTick,0,_animRect.width,_animRect.height),new Point(0,0));
            ++_animTick;
            if(_animTick == 20)
            {
               _animTick = 0;
            }
         }
         catch(e:Error)
         {
         }
      }
      
      override public function Upgrade() : *
      {
         if(_upgrading)
         {
            GLOBAL.Message(KEYS.Get("acad_err_cantupgrade"));
            return false;
         }
         return super.Upgrade();
      }
      
      override public function Recycle() : *
      {
         if(_upgrading)
         {
            GLOBAL.Message(KEYS.Get("acad_err_cantrecycle"));
         }
         else
         {
            GLOBAL._bAcademy = null;
            super.Recycle();
         }
      }
      
      override public function Setup(param1:Object) : *
      {
         super.Setup(param1);
         if(param1.upg)
         {
            _upgrading = param1.upg;
         }
         if(_upgrading == "C100")
         {
            _upgrading = "C12";
         }
         if(_countdownBuild.Get() <= 0)
         {
            GLOBAL._bAcademy = this;
         }
         if(_countdownBuild.Get() + _countdownUpgrade.Get() + _repairing == 0)
         {
            CatchupRemove();
         }
      }
      
      override public function Export() : *
      {
         var _loc1_:* = super.Export();
         if(_upgrading)
         {
            _loc1_.upg = _upgrading;
         }
         return _loc1_;
      }
   }
}

