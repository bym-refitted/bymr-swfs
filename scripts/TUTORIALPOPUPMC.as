package
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TUTORIALPOPUPMC extends TUTORIALPOPUPMC_CLIP
   {
      private var offsetX:int;
      
      private var offsetY:int;
      
      public var posX:int;
      
      public var posY:int;
      
      public function TUTORIALPOPUPMC(param1:int = 0, param2:int = 0)
      {
         super();
         mcButton.addEventListener(MouseEvent.CLICK,TUTORIAL.Advance);
         mcButton.Highlight = true;
         mcBlocker.mouseEnabled = true;
         mcText.autoSize = "left";
         this.posX = param1;
         this.posY = param2;
         if(GLOBAL._local)
         {
            addEventListener(MouseEvent.MOUSE_DOWN,this.DragStart);
            addEventListener(MouseEvent.MOUSE_UP,this.DragStop);
         }
      }
      
      public function Say(param1:String, param2:Boolean, param3:Boolean) : void
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
      
      public function DragStart(param1:MouseEvent) : void
      {
         this.offsetX = GLOBAL._ROOT.mouseX - x;
         this.offsetY = GLOBAL._ROOT.mouseY - y;
         addEventListener(Event.ENTER_FRAME,this.Move);
      }
      
      public function DragStop(param1:MouseEvent) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.Move);
      }
      
      public function Move(param1:Event = null) : void
      {
         x = GLOBAL._ROOT.mouseX - this.offsetX;
         y = GLOBAL._ROOT.mouseY - this.offsetY;
      }
      
      public function SetPos(param1:int, param2:int) : void
      {
         this.posX = param1;
         this.posY = param2;
      }
      
      public function Resize() : void
      {
         x = GLOBAL._SCREEN.x + this.posX;
         y = GLOBAL._SCREEN.y + this.posY;
         var _loc1_:int = x;
         var _loc2_:int = y;
         var _loc3_:Object = mcBlocker.parent;
         if(Boolean(_loc3_) && Boolean(_loc3_.parent))
         {
            while(_loc3_.parent)
            {
               _loc1_ += _loc3_.x;
               _loc2_ += _loc3_.y;
               _loc3_ = _loc3_.parent;
            }
         }
         mcBlocker.x = -this.posX;
         mcBlocker.y = -this.posY;
         mcBlocker.width = GLOBAL._SCREEN.width;
         mcBlocker.height = GLOBAL._SCREEN.height;
      }
   }
}

