package
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TUTORIALPOPUPMC extends TUTORIALPOPUPMC_CLIP
   {
      private var offsetX:int;
      
      private var offsetY:int;
      
      public function TUTORIALPOPUPMC()
      {
         super();
         mcButton.addEventListener(MouseEvent.CLICK,TUTORIAL.Advance);
         mcButton.Highlight = true;
         mcBlocker.mouseEnabled = true;
         mcText.autoSize = "left";
         if(GLOBAL._local)
         {
            addEventListener(MouseEvent.MOUSE_DOWN,this.DragStart);
            addEventListener(MouseEvent.MOUSE_UP,this.DragStop);
         }
      }
      
      internal function Say(param1:String, param2:Boolean, param3:Boolean) : *
      {
         mcText.htmlText = param1;
         if(TUTORIAL._stage < 200)
         {
            mcButton.SetupKey("tut_next_btn");
         }
         else
         {
            mcButton.SetupKey("tut_finish_btn");
         }
         if(param2)
         {
            mcBlocker.visible = true;
         }
         else
         {
            mcBlocker.visible = false;
         }
         mcArrow.visible = false;
         if(param3)
         {
            if(TUTORIAL._stage <= 5)
            {
               mcArrow.visible = true;
            }
            mcButton.visible = true;
            mcBubble.height = mcText.height + 55;
         }
         else
         {
            mcButton.visible = false;
            mcBubble.height = mcText.height + 15;
         }
         mcText.y = 0 - mcBubble.height + 10;
      }
      
      internal function DragStart(param1:MouseEvent) : *
      {
         this.offsetX = GLOBAL._ROOT.mouseX - x;
         this.offsetY = GLOBAL._ROOT.mouseY - y;
         addEventListener(Event.ENTER_FRAME,this.Move);
      }
      
      internal function DragStop(param1:MouseEvent) : *
      {
         removeEventListener(Event.ENTER_FRAME,this.Move);
      }
      
      internal function Move(param1:Event = null) : *
      {
         x = GLOBAL._ROOT.mouseX - this.offsetX;
         y = GLOBAL._ROOT.mouseY - this.offsetY;
      }
   }
}

