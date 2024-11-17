package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol1089")]
   public dynamic class buttonSaving_CLIP extends buttonSaving
   {
      public function buttonSaving_CLIP()
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

