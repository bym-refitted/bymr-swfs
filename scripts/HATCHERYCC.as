package
{
   import flash.events.MouseEvent;
   
   public class HATCHERYCC
   {
      public static var _mc:HATCHERYCCPOPUP;
      
      public static const TYPE:int = 16;
      
      public static var _open:Boolean = false;
      
      public function HATCHERYCC()
      {
         super();
      }
      
      public static function Show() : *
      {
         if(!_open)
         {
            _open = true;
            GLOBAL.BlockerAdd();
            _mc = GLOBAL._layerWindows.addChild(new HATCHERYCCPOPUP());
            _mc.Setup();
            _mc.Center();
            _mc.ScaleUp();
         }
      }
      
      public static function Hide(param1:MouseEvent = null) : *
      {
         if(_open)
         {
            GLOBAL.BlockerRemove();
            SOUNDS.Play("close");
            BASE.BuildingDeselect();
            _open = false;
            GLOBAL._layerWindows.removeChild(_mc);
            _mc = null;
         }
      }
      
      public static function Tick() : *
      {
         try
         {
            if(_mc)
            {
               _mc.Update();
            }
         }
         catch(e:Error)
         {
            LOGGER.Log("err","Hatchery.Tick: " + e.message + " | " + e.getStackTrace());
         }
      }
   }
}

