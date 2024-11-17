package
{
   import flash.events.MouseEvent;
   
   public class STOREPOPUP extends STOREPOPUP_CLIP
   {
      public function STOREPOPUP()
      {
         super();
      }
      
      public function Hide(param1:MouseEvent = null) : *
      {
         STORE.Hide();
      }
      
      public function Resize() : void
      {
         this.x = GLOBAL._SCREENCENTER.x;
         this.y = GLOBAL._SCREENCENTER.y;
      }
   }
}

