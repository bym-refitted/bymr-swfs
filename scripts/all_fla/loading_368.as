package all_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol858")]
   public dynamic class loading_368 extends MovieClip
   {
      public function loading_368()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function Tick(param1:Event) : *
      {
         rotation -= 12;
      }
      
      internal function frame1() : *
      {
         addEventListener(Event.ENTER_FRAME,this.Tick);
      }
   }
}

