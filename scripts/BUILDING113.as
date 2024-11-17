package
{
   import com.monsters.radio.RADIO;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BUILDING113 extends BFOUNDATION
   {
      public function BUILDING113()
      {
         super();
         _type = 113;
         _footprint = [new Rectangle(0,0,80,80)];
         _gridCost = [[new Rectangle(0,0,80,80),200]];
         _spoutPoint = new Point(0,-80);
         _spoutHeight = 100;
         SetProps();
      }
      
      override public function Description() : *
      {
         super.Description();
         _buildingDescription = KEYS.Get("radio_upgradedesc");
         _recycleDescription = KEYS.Get("radio_recycledesc");
      }
      
      override public function Update(param1:Boolean = false) : *
      {
         super.Update(param1);
      }
      
      override public function Recycle() : *
      {
         super.Recycle();
      }
      
      override public function RecycleC() : *
      {
         super.RecycleC();
         RADIO.TwitterRemoveName();
         RADIO.RemoveName();
         GLOBAL._bRadio = null;
      }
      
      override public function Upgraded() : *
      {
         super.Upgraded();
         GLOBAL._bRadio = this;
      }
      
      override public function Setup(param1:Object) : *
      {
         super.Setup(param1);
         if(_countdownBuild.Get() == 0)
         {
            GLOBAL._bRadio = this;
         }
      }
   }
}

