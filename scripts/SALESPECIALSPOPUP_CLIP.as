package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol276")]
   public dynamic class SALESPECIALSPOPUP_CLIP extends MovieClip
   {
      public var tTitle:TextField;
      
      public var tDesc:TextField;
      
      public var mcFrame:frame2_CLIP;
      
      public var bAction:Button_CLIP;
      
      public function SALESPECIALSPOPUP_CLIP()
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

