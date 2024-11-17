package com.monsters.maproom_inferno.views
{
   import com.monsters.maproom.views.ListViewArrow_CLIP;
   import flash.events.Event;
   import gs.TweenLite;
   import gs.easing.Bounce;
   import gs.easing.Expo;
   
   public class ListViewArrow extends ListViewArrow_CLIP
   {
      public var offsetX:*;
      
      public var offsetY:*;
      
      public var wobbleCountdown:int = 0;
      
      public var active:Boolean = false;
      
      public function ListViewArrow()
      {
         super();
         this.addEventListener(Event.ENTER_FRAME,this.Wobble);
      }
      
      public function Trigger(param1:Boolean = false) : *
      {
         this.active = param1;
         if(this.active)
         {
            buttonMode = true;
            mcArrow.gotoAndStop(2);
         }
         else
         {
            buttonMode = false;
            mcArrow.gotoAndStop(1);
         }
      }
      
      public function Wobble(param1:Event) : *
      {
         if(this.active)
         {
            if(this.wobbleCountdown == 0)
            {
               this.wobbleCountdown = 80;
               mcArrow.x = -15;
               TweenLite.to(mcArrow,0.6,{
                  "x":-20,
                  "ease":Expo.easeInOut,
                  "onComplete":this.WobbleB
               });
            }
            --this.wobbleCountdown;
         }
      }
      
      private function WobbleB() : *
      {
         TweenLite.to(mcArrow,0.6,{
            "x":-15,
            "ease":Bounce.easeOut
         });
      }
   }
}

