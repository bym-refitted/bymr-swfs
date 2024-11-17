package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1402")]
   public dynamic class icon_worker2 extends MovieClip
   {
      public var label_txt:TextField;
      
      public var mcIcon:MovieClip;
      
      public function icon_worker2()
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

