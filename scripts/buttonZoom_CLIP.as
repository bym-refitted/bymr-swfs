package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol1076")]
   public dynamic class buttonZoom_CLIP extends buttonZoom
   {
      public function buttonZoom_CLIP()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

