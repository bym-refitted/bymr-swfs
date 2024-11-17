package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2017")]
   public dynamic class SIEGEWEAPONPOPUP_view extends MovieClip
   {
      public var _bFire:Button_CLIP;
      
      public var timeLeftMC:MovieClip;
      
      public var bg:MovieClip;
      
      public var _bOpen:changeCatapultBtn;
      
      public var _image:MovieClip;
      
      public var _mc:popup_catapult_mc;
      
      public var _bar:MovieClip;
      
      public function SIEGEWEAPONPOPUP_view()
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

