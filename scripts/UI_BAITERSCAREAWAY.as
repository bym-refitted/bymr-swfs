package
{
   import flash.events.MouseEvent;
   
   public class UI_BAITERSCAREAWAY extends UI_BAITERSCAREAWAY_CLIP
   {
      public function UI_BAITERSCAREAWAY()
      {
         super();
         bReturn.SetupKey("bait_scareaway");
         bReturn.addEventListener(MouseEvent.CLICK,this.onReturnDown);
      }
      
      private function onReturnDown(param1:MouseEvent) : void
      {
         MONSTERBAITER.End();
      }
      
      public function Resize() : void
      {
         GLOBAL.RefreshScreen();
         x = GLOBAL._SCREEN.x + GLOBAL._SCREEN.width - mcBG.width - 10;
         y = GLOBAL._SCREENHUD.y - (mcBG.height + 10);
      }
   }
}

