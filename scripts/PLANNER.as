package
{
   import com.monsters.baseplanner.BasePlanner;
   import flash.display.StageDisplayState;
   import flash.events.MouseEvent;
   
   public class PLANNER
   {
      public static var _mc:*;
      
      public static var basePlanner:BasePlanner;
      
      public static const TYPE:uint = 10;
      
      public static var _open:Boolean = false;
      
      public static var _selected:Boolean = false;
      
      public static var _useOldPlanner:Boolean = true;
      
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
         if(GLOBAL._flags.yp_version)
         {
            if(GLOBAL._flags.yp_version == 1)
            {
               _useOldPlanner = true;
            }
            else if(GLOBAL._flags.yp_version == 2)
            {
               _useOldPlanner = false;
            }
         }
         if(!_open)
         {
            _open = true;
            SOUNDS.Play("click1");
            BASE.BuildingDeselect();
            GLOBAL.BlockerAdd();
            if(_useOldPlanner)
            {
               if(GLOBAL._ROOT.stage.displayState == StageDisplayState.FULL_SCREEN)
               {
                  GLOBAL._ROOT.stage.displayState = StageDisplayState.NORMAL;
               }
               _mc = GLOBAL._layerWindows.addChild(new PLANNERPOPUP());
            }
            else if(basePlanner)
            {
               basePlanner.setup();
            }
            else
            {
               basePlanner = new BasePlanner();
               basePlanner.setup();
            }
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
            SOUNDS.Play("close");
            _open = false;
            if(_useOldPlanner)
            {
               _mc.Remove();
               GLOBAL._layerWindows.removeChild(_mc);
               _mc = null;
            }
            else
            {
               basePlanner.hide();
            }
         }
      }
      
      public static function Update() : *
      {
         if(_open)
         {
            if(_useOldPlanner)
            {
               STORE.Hide();
               Hide();
               Show();
            }
         }
      }
   }
}

