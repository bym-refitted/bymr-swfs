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
      
      override public function Tick(param1:int) : void
      {
         if(_countdownBuild.Get() > 0 || _hp.Get() < _hpMax.Get() * 0.5)
         {
            _canFunction = false;
         }
         else
         {
            _canFunction = true;
         }
         super.Tick(param1);
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
         _buildingTitle = KEYS.Get("#b_generalstore#");
         _buildingDescription = KEYS.Get("building_generalstore_desc1");
         _specialDescription = KEYS.Get("building_generalstore_desc2",{"v1":GLOBAL._resourceNames[4]});
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

