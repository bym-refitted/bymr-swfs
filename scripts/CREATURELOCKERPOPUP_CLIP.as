package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1006")]
   public dynamic class CREATURELOCKERPOPUP_CLIP extends MovieClip
   {
      public var bNext:Button_CLIP;
      
      public var tTime:TextField;
      
      public var bSpeed:MovieClip;
      
      public var time_txt:TextField;
      
      public var bResource:MovieClip;
      
      public var bInstant:Button_CLIP;
      
      public var mcButtons:MovieClip;
      
      public var tResource:TextField;
      
      public var bDamage:MovieClip;
      
      public var title_txt:TextField;
      
      public var bPrevious:Button_CLIP;
      
      public var bContinue:Button_CLIP;
      
      public var health_txt:TextField;
      
      public var mcList:MovieClip;
      
      public var txtGuide:TextField;
      
      public var prod_label_txt:TextField;
      
      public var tSpeed:TextField;
      
      public var bTime:MovieClip;
      
      public var bStorage:MovieClip;
      
      public var tCosts:TextField;
      
      public var tHealth:TextField;
      
      public var housing_txt:TextField;
      
      public var tStorage:TextField;
      
      public var mcImage:MovieClip;
      
      public var mcFrame:frame2_CLIP;
      
      public var goo_txt:TextField;
      
      public var tDescription:TextField;
      
      public var tDamage:TextField;
      
      public var damage_txt:TextField;
      
      public var speed_txt:TextField;
      
      public var bHealth:MovieClip;
      
      public function CREATURELOCKERPOPUP_CLIP()
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

