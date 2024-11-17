package
{
   import com.monsters.interfaces.ILootable;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BUILDING2 extends BRESOURCE implements ILootable
   {
      public var _field:BitmapData;
      
      public var _fieldBMP:Bitmap;
      
      public var _frameNumber:int = Math.random() * 5;
      
      public var _animBitmap:BitmapData;
      
      public function BUILDING2()
      {
         super();
         this._frameNumber = int(Math.random() * 5);
         _type = 2;
         _footprint = [new Rectangle(0,0,70,70)];
         _gridCost = [[new Rectangle(0,0,70,70),10],[new Rectangle(10,10,50,50),200]];
         _spoutPoint = new Point(-22,-24);
         _spoutHeight = 47;
         SetProps();
      }
      
      override public function TickFast(param1:Event = null) : *
      {
         super.TickFast(param1);
         if(GLOBAL._render && _animLoaded && _countdownBuild.Get() + _countdownUpgrade.Get() + _countdownFortify.Get() == 0 && _producing && _canFunction)
         {
            if((GLOBAL._mode == "build" || GLOBAL._mode == "help" || GLOBAL._mode == "view") && this._frameNumber % 3 == 0 && CREEPS._creepCount == 0)
            {
               AnimFrame();
            }
            else if(this._frameNumber % 10 == 0)
            {
               AnimFrame();
            }
         }
         ++this._frameNumber;
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
         super.Constructed();
      }
   }
}

