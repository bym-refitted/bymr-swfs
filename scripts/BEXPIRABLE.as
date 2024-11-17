package
{
   import flash.events.MouseEvent;
   
   public class BEXPIRABLE extends BFOUNDATION
   {
      public var _lifeSpan:Number;
      
      public var _createTime:Number;
      
      public function BEXPIRABLE()
      {
         super();
      }
      
      override public function Tick() : *
      {
         super.Tick();
         if(this._buildingProps.lifespan != 0)
         {
            if(GLOBAL.Timestamp() > this._createTime + _buildingProps.lifespan)
            {
               RecycleC();
            }
         }
      }
      
      override public function Place(param1:MouseEvent = null) : *
      {
         if(!this._createTime)
         {
            this._createTime = GLOBAL.Timestamp();
         }
         super.Place(param1);
      }
      
      override public function Export() : *
      {
         var _loc1_:Object = super.Export();
         _loc1_.cT = this._createTime;
         return _loc1_;
      }
      
      override public function Setup(param1:Object) : *
      {
         super.Setup(param1);
         this._createTime = param1.cT;
      }
   }
}

