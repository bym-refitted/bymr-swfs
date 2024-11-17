package
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gs.*;
   import gs.easing.*;
   
   public class TUTORIALARROWMC extends TUTORIALARROWMC_CLIP
   {
      internal var offsetX:*;
      
      internal var offsetY:*;
      
      internal var dragging:Boolean = false;
      
      internal var wobbleCountdown:int = 0;
      
      public function TUTORIALARROWMC()
      {
         super();
         if(GLOBAL._local)
         {
            this.addEventListener(MouseEvent.MOUSE_DOWN,this.DragStart);
            MAP.stage.addEventListener(MouseEvent.MOUSE_UP,this.DragStop);
         }
         else
         {
            this.mouseEnabled = false;
         }
         this.addEventListener(Event.ENTER_FRAME,this.Wobble);
      }
      
      internal function DragStart(param1:MouseEvent) : *
      {
         this.dragging = true;
         this.offsetX = GLOBAL._ROOT.mouseX - this.x;
         this.offsetY = GLOBAL._ROOT.mouseY - this.y;
         this.addEventListener(Event.ENTER_FRAME,this.Move);
      }
      
      internal function DragStop(param1:MouseEvent) : *
      {
         this.removeEventListener(Event.ENTER_FRAME,this.Move);
         if(this.dragging)
         {
         }
         this.dragging = false;
      }
      
      internal function Move(param1:Event = null) : *
      {
         this.x = GLOBAL._ROOT.mouseX - this.offsetX;
         this.y = GLOBAL._ROOT.mouseY - this.offsetY;
         this.Rotate();
      }
      
      internal function Rotate() : *
      {
         if(y < GLOBAL._ROOT.stage.stageHeight / 2)
         {
            mcArrow.rotation = this.x / (0.007894736842105263 * GLOBAL._ROOT.stage.stageWidth) + 130;
         }
         else
         {
            mcArrow.rotation = (0 - this.x) / (0.007894736842105263 * GLOBAL._ROOT.stage.stageWidth) + 45;
         }
         if(x < GLOBAL._ROOT.stage.stageWidth / 2)
         {
            mcArrow.mcArrow.gotoAndStop(1);
         }
         else
         {
            mcArrow.mcArrow.gotoAndStop(2);
         }
      }
      
      internal function Wobble(param1:Event) : *
      {
         if(this.wobbleCountdown == 0)
         {
            this.wobbleCountdown = 80;
            mcArrow.mcArrow.y = -60;
            TweenLite.to(mcArrow.mcArrow,0.6,{
               "y":-70,
               "ease":Expo.easeInOut,
               "onComplete":this.WobbleB
            });
         }
         --this.wobbleCountdown;
      }
      
      internal function WobbleB() : *
      {
         TweenLite.to(mcArrow.mcArrow,0.6,{
            "y":-60,
            "ease":Bounce.easeOut
         });
      }
   }
}

