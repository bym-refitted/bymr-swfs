package
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1234")]
   public dynamic class CATAPULTPOPUP_view extends Sprite
   {
      public var _tCost:TextField;
      
      public var _bFire:Button_CLIP;
      
      public var _tType:TextField;
      
      public var _bOpen:changeCatapultBtn;
      
      public var _image:MovieClip;
      
      public var _mc:popup_catapult_mc;
      
      public var _bar:MovieClip;
      
      public function CATAPULTPOPUP_view()
      {
         super();
      }
   }
}

