package
{
   import com.cc.utils.SecNum;
   import flash.events.MouseEvent;
   
   public class BTOTEM extends BDECORATION
   {
      public function BTOTEM(param1:int)
      {
         super(param1);
      }
      
      private static function RemoveAllFromStorage() : void
      {
         var _loc1_:Number = 121;
         while(_loc1_ <= 125)
         {
            if(BASE._buildingsStored["b" + _loc1_])
            {
               delete BASE._buildingsStored["b" + _loc1_];
            }
            _loc1_++;
         }
      }
      
      public static function CleanupStorage() : void
      {
         var _loc1_:int = 0;
         if(GLOBAL._bTotem)
         {
            RemoveAllFromStorage();
         }
         else
         {
            _loc1_ = SPECIALEVENT.TotemQualified(121);
            RemoveAllFromStorage();
            BASE._buildingsStored["b" + _loc1_] = new SecNum(1);
         }
      }
      
      public static function IsTotem(param1:int) : Boolean
      {
         return param1 >= 121 && param1 <= 125;
      }
      
      override public function Tick() : *
      {
         var earnedType:Number = SPECIALEVENT.TotemQualified(_type);
         var shouldChange:Boolean = earnedType != _type ? true : false;
         if(shouldChange)
         {
            _type = earnedType;
            _renderState = null;
            try
            {
               _buildingProps = GLOBAL._buildingProps[_type - 1];
               Description();
            }
            catch(e:Error)
            {
               LOGGER.Log("err","BTOTEM.SetProps:  buildingprops | " + e.message + " | " + e.getStackTrace());
               GLOBAL.ErrorMessage("BTOTEM.SetProps buildingprops");
               return;
            }
         }
         super.Tick();
      }
      
      override public function Place(param1:MouseEvent = null) : *
      {
         if(GLOBAL._bTotem)
         {
            Cancel();
            return;
         }
         super.Place(param1);
      }
      
      override public function PlaceB() : *
      {
         if(GLOBAL._bTotem)
         {
            Cancel();
            return;
         }
         super.PlaceB();
         GLOBAL._bTotem = this;
         RemoveAllFromStorage();
      }
      
      override public function Constructed() : *
      {
         GLOBAL._bTotem = this;
         super.Constructed();
         RemoveAllFromStorage();
      }
      
      override public function RecycleC() : *
      {
         GridCost(false);
         try
         {
            MAP._BUILDINGBASES.removeChild(_mcBase);
         }
         catch(e:Error)
         {
         }
         try
         {
            MAP._BUILDINGFOOTPRINTS.removeChild(_mcFootprint);
         }
         catch(e:Error)
         {
         }
         try
         {
            MAP._BUILDINGTOPS.removeChild(_mc);
         }
         catch(e:Error)
         {
         }
         GRID.Clear();
         MAP.SortDepth();
         QUEUE.Remove("building" + _id,false,this);
         BASE.BuildingDeselect();
         RemoveAllFromStorage();
         BASE.BuildingStorageAdd(_type);
         Clean();
         BASE.Save();
         return true;
      }
      
      override public function Setup(param1:Object) : *
      {
         super.Setup(param1);
         GLOBAL._bTotem = this;
         RemoveAllFromStorage();
      }
   }
}

