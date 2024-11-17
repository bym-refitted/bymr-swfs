package
{
   import flash.events.MouseEvent;
   
   public class BUILDINGS
   {
      public static var _mc:BUILDINGSPOPUP = null;
      
      public static var _open:Boolean = false;
      
      public static var _menuA:int = 1;
      
      public static var _menuB:int = 0;
      
      public static var _page:int = 0;
      
      public static var _buildingID:int = 0;
      
      public function BUILDINGS()
      {
         super();
      }
      
      public static function Reset(param1:Boolean = false) : *
      {
         if(param1)
         {
            _menuA = 1;
            _menuB = 0;
            _page = 0;
         }
         _buildingID = 0;
         Hide();
      }
      
      public static function Show(param1:MouseEvent = null) : *
      {
         GLOBAL.BlockerAdd();
         if(GLOBAL._mode == "build")
         {
            if(GLOBAL._newBuilding)
            {
               GLOBAL._newBuilding.Cancel();
            }
            if(!_open)
            {
               SOUNDS.Play("click1");
               BASE.BuildingDeselect();
               _open = true;
               _mc = GLOBAL._layerWindows.addChild(new BUILDINGSPOPUP());
            }
            if(BUILDINGS._buildingID > 0)
            {
               _mc.ShowInfo(BUILDINGS._buildingID);
            }
         }
      }
      
      public static function Hide(param1:MouseEvent = null) : *
      {
         GLOBAL.BlockerRemove();
         if(_open)
         {
            SOUNDS.Play("close");
            _open = false;
            _mc.HideInfo();
            _mc._buildingInfoMC = null;
            GLOBAL._layerWindows.removeChild(_mc);
            _mc = null;
         }
      }
   }
}

