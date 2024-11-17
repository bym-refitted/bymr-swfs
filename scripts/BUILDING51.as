package
{
   import com.monsters.display.ImageCache;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class BUILDING51 extends BFOUNDATION
   {
      public function BUILDING51()
      {
         super();
         _type = 51;
         _footprint = [new Rectangle(0,0,90,90)];
         _gridCost = [[new Rectangle(0,0,90,90),10],[new Rectangle(10,10,70,70),200]];
         SetProps();
      }
      
      override public function Tick() : *
      {
         if(_countdownBuild.Get() + _countdownUpgrade.Get() == 0 && _repairing != 1)
         {
            delete BASE._buildingsCatchup["b" + _id];
         }
         if(_countdownBuild.Get() > 0 || _hp.Get() < _hpMax.Get() * 0.5)
         {
            _canFunction = false;
         }
         else
         {
            _canFunction = true;
         }
         super.Tick();
      }
      
      public function Fund() : *
      {
      }
      
      override public function Place(param1:MouseEvent = null) : *
      {
         super.Place(param1);
      }
      
      override public function Cancel() : *
      {
         GLOBAL._bCatapult = null;
         super.Cancel();
      }
      
      override public function RecycleC() : *
      {
         GLOBAL._bCatapult = null;
         super.RecycleC();
      }
      
      override public function Description() : *
      {
         super.Description();
         _upgradeDescription = KEYS.Get("bdg_catapult_upgrade");
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
         GLOBAL._bCatapult = this;
         if(GLOBAL._mode == "build" && !BASE._isOutpost)
         {
            Brag = function(param1:MouseEvent):*
            {
               GLOBAL.CallJS("sendFeed",["build-cat",KEYS.Get("pop_catapultbuilt_streamtitle"),"","build-catapult.png"]);
               POPUPS.Next();
            };
            this.LoadEffects();
            mc = new popup_building();
            mc.tA.htmlText = "<b>" + KEYS.Get("pop_catapultbuilt_title") + "</b>";
            mc.tB.htmlText = KEYS.Get("pop_catapultbuilt_body");
            mc.bPost.SetupKey("btn_brag");
            mc.bPost.addEventListener(MouseEvent.CLICK,Brag);
            mc.bPost.Highlight = true;
            POPUPS.Push(mc,null,null,null,"build.png");
         }
      }
      
      override public function Upgraded() : *
      {
         var Brag:Function;
         var mc:MovieClip = null;
         super.Upgraded();
         if(GLOBAL._mode == "build")
         {
            Brag = function(param1:MouseEvent):*
            {
               GLOBAL.CallJS("sendFeed",["upgrade-cat-" + _lvl.Get(),KEYS.Get("pop_catapultupgraded" + _lvl.Get() + "_streamtitle"),"","upgrade-catapult.png"]);
               POPUPS.Next();
            };
            mc = new popup_building();
            mc.tA.htmlText = "<b>" + KEYS.Get("pop_catapultupgraded_title") + "</b>";
            mc.tB.htmlText = KEYS.Get("pop_catapultupgraded_body",{"v1":_lvl.Get()});
            mc.bPost.SetupKey("btn_brag");
            mc.bPost.addEventListener(MouseEvent.CLICK,Brag);
            mc.bPost.Highlight = true;
            POPUPS.Push(mc,null,null,null,"build.png");
         }
      }
      
      public function LoadEffects() : *
      {
         ImageCache.GetImageWithCallBack("effects/pebble.png",null,true,6);
         ImageCache.GetImageWithCallBack("effects/pebblehit.png",null,true,6);
         ImageCache.GetImageWithCallBack("effects/twigs.png",null,true,6);
      }
      
      override public function Setup(param1:Object) : *
      {
         super.Setup(param1);
         if(_countdownBuild.Get() <= 0)
         {
            this.LoadEffects();
            GLOBAL._bCatapult = this;
         }
      }
   }
}
