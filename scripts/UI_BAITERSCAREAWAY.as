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
   }
}

