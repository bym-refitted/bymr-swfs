package
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import gs.TweenLite;
   import gs.easing.Quad;
   
   public class BUILDINGOPTIONS
   {
      public static var _do:DisplayObject;
      
      public static var _doBG:DisplayObject;
      
      public static var _building:BFOUNDATION;
      
      public static var _open:Boolean;
      
      public function BUILDINGOPTIONS()
      {
         super();
      }
      
      public static function Show(param1:BFOUNDATION, param2:String = "info") : *
      {
         if(!_open)
         {
            GLOBAL.BlockerAdd();
            SOUNDS.Play("click1");
            BASE.BuildingDeselect();
            _building = param1;
            _open = true;
            _do = GLOBAL._layerWindows.addChild(new BUILDINGOPTIONSPOPUP(param2));
            _do.x = 380;
            _do.y = 260;
            _do.scaleY = 0.9;
            _do.scaleX = 0.9;
            TweenLite.to(_do,0.2,{
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
            _open = false;
            GLOBAL._layerWindows.removeChild(_do);
            _do = null;
         }
      }
   }
}

