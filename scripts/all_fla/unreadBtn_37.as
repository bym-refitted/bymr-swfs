package all_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1987")]
   public dynamic class unreadBtn_37 extends MovieClip
   {
      public var sorter_mc:MovieClip;
      
      public function unreadBtn_37()
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

