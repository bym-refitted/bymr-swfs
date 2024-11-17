package
{
   import com.monsters.ai.WMBASE;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BUILDING112 extends BSTORAGE
   {
      public function BUILDING112()
      {
         super();
         _type = 112;
         _footprint = [new Rectangle(0,0,130,130)];
         _gridCost = [[new Rectangle(0,0,130,130),10],[new Rectangle(10,10,110,110),200]];
         _spoutPoint = new Point(0,-55);
         _spoutHeight = 115;
         SetProps();
      }
      
      override public function Repair() : *
      {
         super.Repair();
      }
      
      override public function Tick() : *
      {
         super.Tick();
         if(_countdownBuild.Get() + _countdownUpgrade.Get() == 0 && _repairing != 1)
         {
            delete BASE._buildingsCatchup["b" + _id];
         }
      }
      
      override public function Place(param1:MouseEvent = null) : *
      {
         if(!MAP._dragged)
         {
            super.Place(param1);
            _hasResources = true;
         }
      }
      
      override public function Cancel() : *
      {
         GLOBAL._bTownhall = null;
         super.Cancel();
      }
      
      override public function Recycle() : *
      {
         GLOBAL.Message("You cannot Recycle your Outpost.");
      }
      
      override public function RecycleB(param1:MouseEvent = null) : *
      {
         GLOBAL.Message("You cannot Recycle your Outpost.");
      }
      
      override public function RecycleC() : *
      {
         GLOBAL.Message("You cannot Recycle your Outpost.");
      }
      
      override public function Destroyed(param1:Boolean = true) : *
      {
         super.Destroyed(param1);
         if(GLOBAL._advancedMap == 0 && GLOBAL._mode == "wmattack")
         {
            WMBASE._destroyed = true;
         }
      }
      
      override public function Description() : *
      {
         super.Description();
         _buildingDescription = KEYS.Get("outpost_upgradedesc");
         _recycleDescription = KEYS.Get("th_recycledesc");
      }
      
      override public function Update(param1:Boolean = false) : *
      {
         super.Update(param1);
      }
      
      override public function Constructed() : *
      {
         super.Constructed();
         GLOBAL._bTownhall = this;
      }
      
      override public function Setup(param1:Object) : *
      {
         super.Setup(param1);
         GLOBAL._bTownhall = this;
      }
   }
}

