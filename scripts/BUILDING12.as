package
{
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class BUILDING12 extends BFOUNDATION
   {
      public function BUILDING12()
      {
         super();
         _type = 12;
         _footprint = [new Rectangle(0,0,70,70)];
         _gridCost = [[new Rectangle(0,0,70,70),10],[new Rectangle(10,10,50,50),200]];
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
         GLOBAL._bStore = null;
         super.Cancel();
      }
      
      override public function RecycleC() : *
      {
         GLOBAL._bStore = null;
         super.RecycleC();
      }
      
      override public function Description() : *
      {
         super.Description();
         _buildingTitle = "General Store";
         _buildingDescription = "Used to purchase upgrades for your yard. Click on the \'Store\' button at the bottom of the screen.";
         _specialDescription = "Open the store to view all the lovely things you can buy using your " + GLOBAL._resourceNames[4];
      }
      
      override public function Update(param1:Boolean = false) : *
      {
         super.Update(param1);
      }
      
      override public function Upgraded() : *
      {
         super.Upgraded();
      }
      
      override public function Constructed() : *
      {
         GLOBAL._bStore = this;
         super.Constructed();
      }
      
      override public function Setup(param1:Object) : *
      {
         super.Setup(param1);
         if(_countdownBuild.Get() <= 0)
         {
            GLOBAL._bStore = this;
         }
      }
   }
}

