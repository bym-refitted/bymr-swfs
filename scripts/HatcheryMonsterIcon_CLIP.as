package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1239")]
   public dynamic class HatcheryMonsterIcon_CLIP extends MovieClip
   {
      public var tLabel:TextField;
      
      public var mcImage:MovieClip;
      
      public var mcLoading:MovieClip;
      
      public function HatcheryMonsterIcon_CLIP()
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

