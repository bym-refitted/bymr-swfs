package
{
   import com.cc.utils.SecNum;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BUILDING19 extends BFOUNDATION
   {
      public var _animMC:MovieClip;
      
      public var _animFrame:int = 0;
      
      public var _field:BitmapData;
      
      public var _fieldBMP:Bitmap;
      
      public var _frameNumber:int;
      
      public var _animBitmap:BitmapData;
      
      public var _blend:int;
      
      public var _blending:Boolean;
      
      public var _bank:SecNum;
      
      public function BUILDING19()
      {
         super();
         _type = 19;
         this._frameNumber = 0;
         _footprint = [new Rectangle(0,0,80,80)];
         _gridCost = [[new Rectangle(0,0,80,80),50]];
         _spoutPoint = new Point(0,0);
         _spoutHeight = 40;
         SetProps();
      }
      
      override public function TickFast(param1:Event = null) : *
      {
         if(!GLOBAL._catchup)
         {
            if(_animTick == 0 && MONSTERBAITER._attacking == 1 && _hp.Get() > 0)
            {
               SOUNDS.Play("wmbstart");
               _animTick = 1;
            }
            if(_animTick > 0 && this._frameNumber % 2 == 0)
            {
               if(_animTick > 40)
               {
                  if(MONSTERBAITER._attacking == 1 && _hp.Get() > 0)
                  {
                     _animTick = 1;
                  }
                  else
                  {
                     _animTick = 0;
                  }
               }
               AnimFrame(false);
               if(_animTick > 0)
               {
                  ++_animTick;
               }
            }
            ++this._frameNumber;
         }
         else
         {
            _animTick = 0;
         }
      }
      
      override public function Description() : *
      {
         super.Description();
         _upgradeDescription = "Increases the Musk capacity and regeneration rate, letting you attract bigger groups of Wild Monsters.";
      }
      
      override public function Update(param1:Boolean = false) : *
      {
         super.Update(param1);
      }
      
      override public function Constructed() : *
      {
         var Brag:Function;
         var mc:MovieClip = null;
         super.Constructed();
         GLOBAL._bBaiter = this;
         if(GLOBAL._mode == "build" && !BASE._isOutpost)
         {
            Brag = function(param1:MouseEvent):*
            {
               GLOBAL.CallJS("sendFeed",["build-wmb",KEYS.Get("pop_baiterbuilt_streamtitle"),KEYS.Get("pop_baiterbuilt_streambody"),"build-monsterbaiter.png"]);
               POPUPS.Next();
            };
            MONSTERBAITER.Update();
            MONSTERBAITER.Fill();
            mc = new popup_building();
            mc.tA.htmlText = "<b>" + KEYS.Get("pop_baiterbuilt_title") + "</b>";
            mc.tB.htmlText = KEYS.Get("pop_baiterbuilt_body");
            mc.bPost.SetupKey("btn_brag");
            mc.bPost.addEventListener(MouseEvent.CLICK,Brag);
            mc.bPost.Highlight = true;
            POPUPS.Push(mc,null,null,null,"build.png");
         }
      }
      
      override public function Upgraded() : *
      {
         var Brag:Function;
         var percent:int = 0;
         var mc:MovieClip = null;
         super.Upgraded();
         if(GLOBAL._mode == "build")
         {
            Brag = function(param1:MouseEvent):*
            {
               GLOBAL.CallJS("sendFeed",["upgrade-wmb-" + _lvl.Get(),KEYS.Get("pop_baitupgraded_streamtitle",{"v1":_lvl.Get()}),KEYS.Get("pop_baitupgraded_streambody"),"upgrade-monsterbaiter.png"]);
               POPUPS.Next();
            };
            MONSTERBAITER.Update();
            percent = 60;
            if(_lvl.Get() == 2)
            {
               percent = 80;
            }
            if(_lvl.Get() == 3)
            {
               percent = 100;
            }
            mc = new popup_building();
            mc.tA.htmlText = "<b>" + KEYS.Get("pop_baitupgraded_title") + "</b>";
            mc.tB.htmlText = KEYS.Get("pop_baitupgraded_body",{"v1":_lvl.Get()});
            mc.bPost.SetupKey("btn_brag");
            mc.bPost.addEventListener(MouseEvent.CLICK,Brag);
            mc.bPost.Highlight = true;
            POPUPS.Push(mc,null,null,null,"build.png");
         }
      }
      
      override public function RecycleC() : *
      {
         GLOBAL._bBaiter = null;
         super.RecycleC();
      }
      
      override public function Setup(param1:Object) : *
      {
         super.Setup(param1);
         if(_countdownBuild.Get() == 0)
         {
            GLOBAL._bBaiter = this;
         }
         if(_countdownBuild.Get() + _countdownUpgrade.Get() + _repairing == 0)
         {
            CatchupRemove();
         }
      }
      
      override public function Export() : *
      {
         return super.Export();
      }
   }
}

