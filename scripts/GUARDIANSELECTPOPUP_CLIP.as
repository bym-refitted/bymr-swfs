package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1330")]
   public dynamic class GUARDIANSELECTPOPUP_CLIP extends MovieClip
   {
      public var bAction2:Button_CLIP;
      
      public var bAction3:Button_CLIP;
      
      public var bSelect2:MovieClip;
      
      public var bAction1:Button_CLIP;
      
      public var bSelect3:MovieClip;
      
      public var bSelect1:MovieClip;
      
      public var tTitle:TextField;
      
      public var tGuard2_desc:TextField;
      
      public var frame:frame2_CLIP;
      
      public var tGuard3_desc:TextField;
      
      public var tGuard1_desc:TextField;
      
      public var tGuard1_label:TextField;
      
      public var tGuard3_label:TextField;
      
      public var tGuard2_label:TextField;
      
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

