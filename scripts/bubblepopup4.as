package
{
   import gs.TweenLite;
   import gs.easing.Elastic;
   
   public class bubblepopup4 extends bubblepopup4_CLIP
   {
      public function bubblepopup4()
      {
         super();
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      public function Wobble() : *
      {
         alpha = 1;
         TweenLite.to(this,0.6,{
            "x":125,
            "ease":Elastic.easeOut,
            "onComplete":this.Delay
         });
      }
      
      public function Delay() : *
      {
         TweenLite.to(this,0.5,{
            "alpha":0,
            "delay":4,
            "onComplete":this.Remove
         });
      }
      
      public function Remove() : *
      {
         try
         {
            UI2._top.OverchargeHide();
         }
         catch(e:Error)
         {
         }
      }
   }
}

