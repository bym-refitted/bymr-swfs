package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2124")]
   public dynamic class SIEGEWEAPONPOPUP_view extends MovieClip
   {
      public var _bFire:Button_CLIP;
      
      public var timeLeftMC:MovieClip;
      
      public var txtName:TextField;
      
      public var _bOpen:changeCatapultBtn;
      
      public var _image:MovieClip;
      
      public var _iconbg:MovieClip;
      
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

