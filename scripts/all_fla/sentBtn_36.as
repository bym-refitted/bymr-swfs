package all_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1985")]
   public dynamic class sentBtn_36 extends MovieClip
   {
      public var sorter_mc:MovieClip;
      
      public function sentBtn_36()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
   }
}
