package
{
   import flash.events.MouseEvent;
   import gs.TweenLite;
   import gs.easing.Quad;
   
   public class HATCHERYCC
   {
      public static var _mc:*;
      
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
            _mc.x = 380;
            _mc.y = 260;
            _mc.scaleY = 0.9;
            _mc.scaleX = 0.9;
            TweenLite.to(_mc,0.2,{
               "scaleX":1,
               "scaleY":1,
               "ease":Quad.easeOut
            });
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

