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
   }
}

