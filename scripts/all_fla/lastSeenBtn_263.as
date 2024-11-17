package all_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1800")]
   public dynamic class lastSeenBtn_263 extends MovieClip
   {
      public var sorter_mc:MovieClip;
      
      public function lastSeenBtn_263()
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

