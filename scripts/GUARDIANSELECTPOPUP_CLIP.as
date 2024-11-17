package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1601")]
   public dynamic class GUARDIANSELECTPOPUP_CLIP extends MovieClip
   {
      public var mcMask:MovieClip;
      
      public var tTitle:TextField;
      
      public var frame:frame_CLIP;
      
      public function GUARDIANSELECTPOPUP_CLIP()
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

