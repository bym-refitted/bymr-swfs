package
{
   import flash.display.StageDisplayState;
   import flash.events.MouseEvent;
   
   public class PLANNER
   {
      public static var _mc:*;
      
      public static var _open:Boolean = false;
      
      public static var _selected:Boolean = false;
      
      public function PLANNER()
      {
         super();
         _open = false;
      }
      
      public static function Show(param1:MouseEvent = null) : *
      {
         if(GLOBAL._selectedBuilding)
         {
            GLOBAL._selectedBuilding.StopMoveB();
         }
         if(GLOBAL._newBuilding)
         {
            GLOBAL._newBuilding.Cancel();
         }
         BASE.BuildingDeselect();
         _selected = false;
         if(!_open)
         {
            _open = true;
            SOUNDS.Play("click1");
            BASE.BuildingDeselect();
            if(GLOBAL._ROOT.stage.displayState == StageDisplayState.FULL_SCREEN)
            {
               GLOBAL._ROOT.stage.displayState = StageDisplayState.NORMAL;
            }
            GLOBAL.BlockerAdd();
            _mc = GLOBAL._layerWindows.addChild(new PLANNERPOPUP());
         }
      }
      
      public static function Hide(param1:MouseEvent = null) : *
      {
         GLOBAL.BlockerRemove();
         if(GLOBAL._selectedBuilding && GLOBAL._selectedBuilding._class != "mushroom")
         {
            GLOBAL._selectedBuilding.StopMoveB();
         }
         if(GLOBAL._newBuilding)
         {
            GLOBAL._newBuilding.Cancel();
         }
         BASE.BuildingDeselect();
         if(_open)
         {
            _mc.Remove();
            SOUNDS.Play("close");
            _open = false;
            GLOBAL._layerWindows.removeChild(_mc);
            _mc = null;
         }
      }
      
      public static function Update() : *
      {
         if(_open)
         {
            STORE.Hide();
            Hide();
            Show();
         }
      }
   }
}

