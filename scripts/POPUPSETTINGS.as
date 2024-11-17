package
{
   import flash.display.DisplayObject;
   import gs.TweenLite;
   import gs.easing.Quad;
   
   public class POPUPSETTINGS
   {
      private static const _BOTTOM_PADDING:int = 100;
      
      public function POPUPSETTINGS()
      {
         super();
      }
      
      public static function AlignToCenter(param1:DisplayObject) : *
      {
         param1.x = GLOBAL._SCREENCENTER.x;
         param1.y = GLOBAL._SCREENCENTER.y - _BOTTOM_PADDING;
         if(GAME._isSmallSize)
         {
            param1.y = GLOBAL._SCREENCENTER.y - _BOTTOM_PADDING / 2;
         }
      }
      
      public static function AlignToUpperLeft(param1:DisplayObject) : *
      {
         param1.x = GLOBAL._SCREENCENTER.x - param1.width * 0.5;
         param1.y = GLOBAL._SCREENCENTER.y - _BOTTOM_PADDING - param1.height * 0.5;
      }
      
      public static function ScaleUp(param1:DisplayObject) : *
      {
         param1.scaleX = 0.9;
         param1.scaleY = 0.9;
         TweenLite.to(param1,0.2,{
            "scaleX":1,
            "scaleY":1,
            "ease":Quad.easeOut
         });
      }
   }
}

