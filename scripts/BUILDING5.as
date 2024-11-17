package
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class BUILDING5 extends BFOUNDATION
   {
      public function BUILDING5()
      {
         super();
         _type = 5;
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
      
      override public function PlaceB() : *
      {
         GLOBAL._bFlinger = this;
         super.PlaceB();
      }
      
      override public function Cancel() : *
      {
         GLOBAL._bFlinger = null;
         super.Cancel();
      }
      
      override public function RecycleC() : *
      {
         GLOBAL._bFlinger = null;
         super.RecycleC();
      }
      
      override public function Description() : *
      {
         super.Description();
         _upgradeDescription = KEYS.Get("building_flinger_upgrade_desc");
      }
      
      override public function Update(param1:Boolean = false) : *
      {
         super.Update(param1);
      }
      
      override public function Constructed() : *
      {
         super.Constructed();
         GLOBAL._bFlinger = this;
      }
      
      override public function Upgraded() : *
      {
         var Brag:Function;
         var mc:MovieClip = null;
         super.Upgraded();
         if(GLOBAL._mode == "build" && !BASE._isOutpost)
         {
            Brag = function(param1:MouseEvent):*
            {
               GLOBAL.CallJS("sendFeed",["upgrade-fl-" + _lvl.Get(),KEYS.Get("pop_flingerupgraded_streamtitle",{"v1":_lvl.Get()}),KEYS.Get("pop_flingerupgraded_streambody"),"upgrade-flinger.png"]);
               POPUPS.Next();
            };
            mc = new popup_building();
            mc.tA.htmlText = "<b>" + KEYS.Get("pop_flingerupgraded_title") + "</b>";
            mc.tB.htmlText = KEYS.Get("pop_flingerupgraded_body",{"v1":_lvl.Get()});
            mc.bPost.SetupKey("btn_brag");
            mc.bPost.addEventListener(MouseEvent.CLICK,Brag);
            mc.bPost.Highlight = true;
            POPUPS.Push(mc,null,null,null,"build.png");
         }
      }
      
      override public function Setup(param1:Object) : *
      {
         super.Setup(param1);
         if(_countdownBuild.Get() <= 0)
         {
            GLOBAL._bFlinger = this;
         }
      }
   }
}

