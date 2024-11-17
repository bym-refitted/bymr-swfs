package com.monsters.maproom_inferno.views
{
   import gs.TweenLite;
   import gs.easing.Elastic;
   
   public class DescentBasePopup extends DescentBasePopup_CLIP
   {
      public function DescentBasePopup()
      {
         super();
      }
      
      public function initWithTitleAndButtons(param1:String, param2:Array, param3:Array) : void
      {
      }
      
      public function setHeightForButtons(param1:int) : void
      {
      }
      
      public function Show() : void
      {
         var _loc1_:int = 0;
         _loc1_ = this.x;
         this.x -= 15;
         TweenLite.to(this,0.6,{
            "x":_loc1_,
            "ease":Elastic.easeOut
         });
      }
   }
}

