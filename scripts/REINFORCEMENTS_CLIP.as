package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol321")]
   public dynamic class REINFORCEMENTS_CLIP extends MovieClip
   {
      public var tTitle:TextField;
      
      public var tDesc:TextField;
      
      public var mcImage:MovieClip;
      
      public var mcFrame:frame2_CLIP;
      
      public function REINFORCEMENTS_CLIP()
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

