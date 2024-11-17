package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol965")]
   public dynamic class buildingInfo extends MovieClip
   {
      public var tInfoRight:TextField;
      
      public var tName:TextField;
      
      public var mcBG:MovieClip;
      
      public var tInfoLeft:TextField;
      
      public function buildingInfo()
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

